/* Crack the code!

*/

#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../res/assets/dovesamButtons.h"
#include "../enums.h"

//extern const hUGESong_t dovesamTwilightDriveSong;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used mostly for loops
extern UINT8 k;  // Used for whatever
extern INT8 l;  // Used for whatever
extern UINT8 m;  // Used for menus generally
extern UINT8 n;  // Used for menus generally
extern UINT8 r;  // Used for randomization stuff

extern UINT8 substate;
extern UINT8 mgDifficulty;  // Readonly!
extern UINT8 mgSpeed;  // Readonly!
extern UINT8 mgStatus;

extern UINT8 animTick;
extern UINT8 animFrame;

//Some constants
static const unsigned char LEFT_MAP[4]  = { 0x00, 0x01, 0x04, 0x05 };
static const unsigned char DOWN_MAP[4]  = { 0x02, 0x03, 0x06, 0x07 };
static const unsigned char RIGHT_MAP[4] = { 0x08, 0x09, 0x0c, 0x0d };
static const unsigned char UP_MAP[4]    = { 0x0a, 0x0b, 0x0e, 0x0f };
static const unsigned char A_MAP[4]     = { 0x10, 0x11, 0x14, 0x15 };
static const unsigned char B_MAP[4]     = { 0x12, 0x13, 0x16, 0x17 };

#define MAX_CODE_INPUTS 8
BUTTONS code[ MAX_CODE_INPUTS ];

#define VRAM_SAFE_START 0x30

#define SPRTILE_CURSOR 0x00U  // The location in the sprite tile memory where the cursor sprite tiles will be written to
#define BKGTILE_TestS 0x40U  // The location in the bkg tile memory where the Test tiles will be written to
#define TestsXAnchor 3U  // The bkg tile index of the leftmost Test(s)
#define TestsYAnchor 3U  // The bkg tile index of the topmost Test(s)

/* SUBSTATE METHODS */
static void phaseTestInit();
static void phaseTestLoop();

/* INPUT METHODS */
static void inputsTest();

/* HELPER METHODS */
static void buttonDraw( UINT8 x, UINT8 y, BUTTONS b );

/* DISPLAY METHODS */



void dovesamCodeCrackMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseTestInit();
            break;
        case SUB_LOOP:
            phaseTestLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseTestInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;

    // Set background tile data
    set_bkg_data( VRAM_SAFE_START, dovesamButtons_TILE_COUNT, dovesamButtons_tiles );

    /* Generate the code to crack */
    for( i = 0; i < MAX_CODE_INPUTS; i++ )
    {
        code[i] = getRandUint8( NO_OF_BUTTONS );
    }

    /* Draw the code on the screen */
    for( i = 0; i < MAX_CODE_INPUTS; i++ )
        buttonDraw( 2U + (2 * i), 5U, code[i] );

    // Play music
    //playSong(&dovesamTwilightDriveSong);

    fadein();
    substate = SUB_LOOP;
}

static void phaseTestLoop()
{
    ++animTick;

    if (mgStatus == PLAYING)
    {
        inputsTest(); 
    }
}

/******************************** INPUT METHODS *********************************/
static void inputsTest()
{
    
}


/******************************** HELPER METHODS *********************************/
static void buttonDraw( UINT8 x, UINT8 y, BUTTONS b )
{
    const unsigned char *my_map;

    switch( b )
    {
        case BUTTON_LEFT:
            my_map = LEFT_MAP;
            break;
        case BUTTON_DOWN:
            my_map = DOWN_MAP;
            break;
        case BUTTON_RIGHT:
            my_map = RIGHT_MAP;
            break;
        case BUTTON_UP:
            my_map = UP_MAP;
            break;
        case BUTTON_A:
            my_map = A_MAP;
            break;
        case BUTTON_B:
            my_map = B_MAP;
            break;
        default: 
            my_map = LEFT_MAP;
            break;
    }

    set_bkg_based_tiles( x, y, 2, 2, my_map, VRAM_SAFE_START );
}

/******************************** DISPLAY METHODS ********************************/
