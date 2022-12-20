#include <gb/gb.h>
#include <rand.h>

#include "adrianJGClockwiseMicrogame.h"

#include "../structs/adrianJGClockwiseLevel.h"

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../res/tiles/adrianJGClockwiseCharacterTiles.h"
#include "../res/tiles/adrianJGClockwiseUIYouTiles.h"
#include "../res/tiles/adrianJGClockwiseArmsTiles.h"

#include "../enums.h"

#define SPRTILE_ARMS_HORIZONTAL 0x00U  // The location in the sprite tile memory where the horizontal arms sprite tiles will be written to
#define SPRTILE_ARMS_VERTICAL 0x01U  // The location in the sprite tile memory where the vertical arms sprite tiles will be written to
#define BKGTILE_CHARACTER 0x40U  // The location in the bkg tile memory where the character tiles will be written to
#define BKGTILE_UI_YOU 0x46U  // The location in the bkg tile memory where the UI 'YOU' tiles will be written to


#define N_CHARACTERS_DIFFICULTY_0 4
#define N_CHARACTERS_DIFFICULTY_1 6
#define N_CHARACTERS_DIFFICULTY_2 8

extern const hUGESong_t adrianJGClockwiseSong;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;

extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used for whatever
extern UINT8 k;  // Used for timer

static UINT8 currentCharacter;
static DIRECTIONS initialDirection;
static DIRECTIONS currentDirection;
static BOOLEAN playerHasMadeAction;

static const UINT8 adrianJGClockwiseCharacterMap[6] = { 0x40U, 0x41U, 0x42U, 0x43U, 0x44U, 0x45U };
static const UINT8 adrianJGClockwiseUIYouMap[4] = { 0x46U, 0x47, 0x48U, 0x49U };
static const UINT8 adrianJGClockwiseBlankMap[4] = { 0xFFU, 0xFFU, 0xFFU, 0xFFU };

static const AdrianJGClockwiseLevel level[3] = {
    { 
        .numberCharacters = N_CHARACTERS_DIFFICULTY_0,
        .characters = { { 3, 7 }, { 7, 7 }, { 11, 7 }, { 15, 7 } }         
    },
    { 
        .numberCharacters = N_CHARACTERS_DIFFICULTY_1,
        .characters = { { 6, 2 }, { 12, 2 }, { 15, 7 }, { 12, 12 }, { 6, 12 }, { 3, 7 } }         
    },
    { 
        .numberCharacters = N_CHARACTERS_DIFFICULTY_2,
        .characters = { { 6, 2 }, { 12, 2 }, { 15, 5 }, { 15, 9 }, { 12, 12 }, { 6, 12 }, { 3, 9 }, { 3, 5 } }         
    }
};


/* SUBSTATE METHODS */
static void phaseClockwiseInit();
static void phaseClockwiseLoop();

/* HELPER METHODS */
static void spawnCharacters();
static void moveArms(UINT8 characterIndex, DIRECTIONS direction);
static void playerControl(DIRECTIONS direction);

void adrianJGClockwiseMicrogameMain() {

    switch (substate)
    {
        case SUB_INIT:
            phaseClockwiseInit();
            break;
        case SUB_LOOP:
            phaseClockwiseLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }

}

/******************************** SUBSTATE METHODS *******************************/
static void phaseClockwiseInit()
{
    // Initializations
    init_bkg(0xFFU);
    currentCharacter = 0;
    i = 0;
    k = 0;
    j = 0;
    initialDirection = getRandUint8(4);
    currentDirection = initialDirection;
    playerHasMadeAction = FALSE;

    // Load graphics
    set_bkg_data(BKGTILE_CHARACTER, 6U, adrianJGClockwiseCharacterTiles);
    set_bkg_data(BKGTILE_UI_YOU, 4U, adrianJGClockwiseUIYouTiles);
    set_sprite_data(SPRTILE_ARMS_HORIZONTAL, 2U, adrianJGClockwiseArmsTiles);

    spawnCharacters();

    substate = SUB_LOOP;
    fadein();
    playSong(&adrianJGClockwiseSong);
}

static void phaseClockwiseLoop()
{
    //Move non-playable character arms
    if (k == 1 && currentCharacter < level[mgDifficulty].numberCharacters - 1) {        
        moveArms(currentCharacter, currentDirection);        
    }
    
    //Change character
    if (k == 40 - (mgDifficulty * 5) - (mgSpeed * 5) && currentCharacter < level[mgDifficulty].numberCharacters - 1) {
        k = 0;
        currentCharacter++;
        currentDirection = (currentDirection + 1) % 4;
    }

    //Timer increase
    k++;
    
    //Player action
    if (!playerHasMadeAction) {
        if (curJoypad & J_UP && !(prevJoypad & J_UP)) {
            playerControl(UP);           
        } else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT)) {
            playerControl(RIGHT);   
        } else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN)) {
            playerControl(DOWN);  
        } else if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT)) {
            playerControl(LEFT);   
        }
    }

    //Win animation logic
    if (mgStatus == WON && currentCharacter == level[mgDifficulty].numberCharacters - 1) {        
        j++;
        if (j % 32 == 0) {
            currentDirection = (currentDirection + 1) % 4;
            for (i = 0; i < level[mgDifficulty].numberCharacters; i++) {
                moveArms(i, currentDirection);
            } 
        }        
    }    
}

static void spawnCharacters() {
    for (i = 0; i < level[mgDifficulty].numberCharacters; i++) {
        set_bkg_tiles(level[mgDifficulty].characters[i].x, level[mgDifficulty].characters[i].y, 2, 3, adrianJGClockwiseCharacterMap);
        if (i == level[mgDifficulty].numberCharacters - 1) {
            set_bkg_tiles(level[mgDifficulty].characters[i].x, level[mgDifficulty].characters[i].y - 3, 2, 2, adrianJGClockwiseUIYouMap);
        }
    }
    
}

static void moveArms(UINT8 characterIndex, DIRECTIONS direction) {
    //Make sound
    NR10_REG = 0x24;
    NR11_REG = 0x00;
    NR12_REG = 0xA0;
    NR13_REG = 0x73;
    NR14_REG = 0x86;

    //Draw the character arms
    switch (direction)
    {
        case UP:
            set_sprite_tile(characterIndex, SPRTILE_ARMS_VERTICAL);
            move_sprite(characterIndex, (level[mgDifficulty].characters[characterIndex].x * 8) + 12, (level[mgDifficulty].characters[characterIndex].y * 8) + 12);
        break;

        case RIGHT:
            set_sprite_tile(characterIndex, SPRTILE_ARMS_HORIZONTAL);
            move_sprite(characterIndex, (level[mgDifficulty].characters[characterIndex].x * 8) + 21, (level[mgDifficulty].characters[characterIndex].y * 8) + 22);
        break;

        case DOWN:
            set_sprite_tile(characterIndex, SPRTILE_ARMS_VERTICAL);
            move_sprite(characterIndex, (level[mgDifficulty].characters[characterIndex].x * 8) + 12, (level[mgDifficulty].characters[characterIndex].y * 8) + 30);
        break;

        case LEFT:
            set_sprite_tile(characterIndex, SPRTILE_ARMS_HORIZONTAL);
            move_sprite(characterIndex, (level[mgDifficulty].characters[characterIndex].x * 8) + 3, (level[mgDifficulty].characters[characterIndex].y * 8) + 22);
        break;
    }
}

static void playerControl(DIRECTIONS direction) {
    j = level[mgDifficulty].numberCharacters - 1;
    moveArms(j, direction);
    playerHasMadeAction = TRUE;

    //Check win condition
    mgStatus = (initialDirection + j) % 4 == direction ? WON : LOST;

    //Remove "You" tiles
    set_bkg_tiles(level[mgDifficulty].characters[j].x, level[mgDifficulty].characters[j].y - 3, 2, 2, adrianJGClockwiseBlankMap);
}