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


extern UINT8 curJoypad;
extern UINT8 prevJoypad;

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;

extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used mostly for loops
extern UINT8 k;  // Used for whatever

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
    set_bkg_data(64, sizeof(adrianJGHitTheNoteBackground_tile_data) / 16, adrianJGHitTheNoteBackground_tile_data);
    set_bkg_tiles(0, 0, 20, 18, adrianJGHitTheNoteBackground_map_data);
    set_sprite_data(0, 7U, adrianJGHitTheNoteTiles);

    set_sprite_tile(0, 5);
    set_sprite_tile(1, 5);
    set_sprite_prop(1, S_FLIPX);

    set_sprite_tile(2, 0);
    move_sprite(2, 66, 84);

    set_sprite_tile(3, 6);
    set_sprite_tile(4, 6);
    set_sprite_tile(5, 6);

    substate = SUB_LOOP;
    fadein();
}

static void phaseHitTheNoteLoop()
{

    if (mgStatus == PLAYING) {
        if (curJoypad & J_A && !(prevJoypad & J_A)) {
            if (i < 255 - 40) {
                i += 40 - 5*mgDifficulty;
            } else {
                i = 255;
            }
        }

        if (i == 255) {
            mgStatus = WON;
        } else if (i != 0) {
            i--;
        }
    } else if (mgStatus == WON) {
        move_sprite(3, 48, 64 - (j + 8)%16);
        move_sprite(4, 64, 64 - (j + 4)%16);
        move_sprite(5, 80, 64 - j%16);
    }



    move_sprite(0, 130, 117 - i/4);
    move_sprite(1, 142, 117 - i/4);


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

    set_sprite_tile(2, (j/8) % 5);

    j++;
    
}

