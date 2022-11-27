#include <gb/gb.h>
#include <rand.h>

#include "adrianJGClockwiseMicrogame.h"

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"

#include "../res/tiles/adrianJGHitTheNoteTiles.h"
#include "../res/backgrounds/adrianJGHitTheNoteBackground.h"

#define SPRTILE_MOUTH_1 0x00U  // The location in the sprite tile memory where the mouth 1 sprite tile will be written to
#define SPRTILE_MOUTH_2 0x01U  // The location in the sprite tile memory where the mouth 2 sprite tile will be written to
#define SPRTILE_MOUTH_3 0x02U  // The location in the sprite tile memory where the mouth 3 sprite tile will be written to
#define SPRTILE_MOUTH_4 0x03U  // The location in the sprite tile memory where the mouth 4 sprite tile will be written to
#define SPRTILE_MOUTH_5 0x04U  // The location in the sprite tile memory where the mouth 5 sprite tile will be written to
#define SPRTILE_CURSOR 0x05U  // The location in the sprite tile memory where the cursor sprite tile will be written to
#define SPRTILE_NOTE 0x06U  // The location in the sprite tile memory where the note sprite tile will be written to


#define SPRTILE_ARMS_VERTICAL 0x01U  // The location in the sprite tile memory where the vertical arms sprite tiles will be written to
#define BKGTILES 0x40  // The location in the bkg tile memory where the background tiles will be written to
#define BKGTILE_UI_YOU 0x46U  // The location in the bkg tile memory where the UI 'YOU' tiles will be written to


extern UINT8 curJoypad;
extern UINT8 prevJoypad;

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;

extern UINT8 i;  // Used for storing de note value. 255 for winning.
extern UINT8 j;  // Used for timer

/* SUBSTATE METHODS */
static void phaseHitTheNoteInit();
static void phaseHitTheNoteLoop();

void adrianJGHitTheNoteMicrogameMain() {
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseHitTheNoteInit();
            break;
        case SUB_LOOP:
            phaseHitTheNoteLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }

    prevJoypad = curJoypad;
}

/******************************** SUBSTATE METHODS *******************************/
static void phaseHitTheNoteInit()
{
    // Initializations
    init_bkg(0xFFU);
    i = 0;
    j = 0;

    // Load graphics
    set_bkg_data(BKGTILES, sizeof(adrianJGHitTheNoteBackground_tile_data) / 16, adrianJGHitTheNoteBackground_tile_data);
    set_bkg_tiles(0, 0, 20, 18, adrianJGHitTheNoteBackground_map_data);
    set_sprite_data(0, 7U, adrianJGHitTheNoteTiles);

    //Set cursor sprites
    set_sprite_tile(0, SPRTILE_CURSOR);
    set_sprite_tile(1, SPRTILE_CURSOR);
    set_sprite_prop(1, S_FLIPX);

    //Set mouth sprite
    set_sprite_tile(2, SPRTILE_MOUTH_1);
    move_sprite(2, 66, 84);

    //Set notes sprites
    set_sprite_tile(3, SPRTILE_NOTE);
    set_sprite_tile(4, SPRTILE_NOTE);
    set_sprite_tile(5, SPRTILE_NOTE);

    substate = SUB_LOOP;
    fadein();
}

static void phaseHitTheNoteLoop()
{

    if (mgStatus == PLAYING) {
        //Player input logic
        if (curJoypad & J_A && !(prevJoypad & J_A)) {
            if (i < 255 - 40) {
                i += 40 - 5*mgDifficulty;
            } else {
                i = 255;
            }
        }

        //Check note hit for win condition, else decrease value
        if (i == 255) {
            mgStatus = WON;
        } else if (i != 0) {
            i--;
        }
    } else if (mgStatus == WON) {
        //Notes win animation
        move_sprite(3, 48, 64 - (j + 8)%16);
        move_sprite(4, 64, 64 - (j + 4)%16);
        move_sprite(5, 80, 64 - j%16);
    }

    //Move cursors
    move_sprite(0, 130, 117 - i/4);
    move_sprite(1, 142, 117 - i/4);

    //Make note sound
    if (j % 16 == 0) {
        NR21_REG = 0xC1;
        NR22_REG = 0x84;
        if (i < 201) {
            NR23_REG = 0xD7 + i/5;
            NR24_REG = 0x86;
        } else {
            NR23_REG = 0x00 + i/5;
            NR24_REG = 0x87;
        }
    }

    //Mouth animation
    set_sprite_tile(2, (j/8) % 5);

    //Timer increase
    j++;    
}

