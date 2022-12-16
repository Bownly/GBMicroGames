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
static const unsigned char LEFT_MAP[4]      = { 0x00, 0x01, 0x04, 0x05 };
static const unsigned char DOWN_MAP[4]      = { 0x02, 0x03, 0x06, 0x07 };
static const unsigned char RIGHT_MAP[4]     = { 0x08, 0x09, 0x0c, 0x0d };
static const unsigned char UP_MAP[4]        = { 0x0a, 0x0b, 0x0e, 0x0f };
static const unsigned char A_MAP[4]         = { 0x10, 0x11, 0x14, 0x15 };
static const unsigned char B_MAP[4]         = { 0x12, 0x13, 0x16, 0x17 };
static const unsigned char EMPTY_MAP[4]     = { 0x18, 0x19, 0x1c, 0x1d };
static const unsigned char SUCCESS_MAP[4]   = { 0x1a, 0x1b, 0x1e, 0x1f };
static const unsigned char SMALL_EMPTY_MAP[4] = { 0x20, 0x21, 0x24, 0x25 };
static const unsigned char SMALL_FAIL_MAP[4] = { 0x22, 0x23, 0x26, 0x27 };
#define MAX_CODE_INPUTS 8
BUTTONS code[ MAX_CODE_INPUTS ];

#define VRAM_SAFE_START 0x30

#define SPRTILE_CURSOR 0x00U  // The location in the sprite tile memory where the cursor sprite tiles will be written to
#define BKGTILE_TestS 0x40U  // The location in the bkg tile memory where the Test tiles will be written to
#define TestsXAnchor 3U  // The bkg tile index of the leftmost Test(s)
#define TestsYAnchor 3U  // The bkg tile index of the topmost Test(s)

/* SUBSTATE METHODS */
static void phaseTestInit();
static void phaseCodeLoop();

/* INPUT METHODS */
static void inputsCode();

/* HELPER METHODS */
static void buttonDraw( UINT8 x, UINT8 y, BUTTONS b );
static UINT8 buttonToJoypad( BUTTONS b );

/* DISPLAY METHODS */



void dovesamCodeCrackMicrogameMain()
{
    switch (substate)
    {
        case SUB_INIT:
            phaseTestInit();
            break;
        case SUB_LOOP:
            phaseCodeLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
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
        code[i] = getRandUint8( BUTTON_EMPTY );
    }

    /* Draw the code on the screen */
    for( i = 0; i < MAX_CODE_INPUTS; i++ )
        buttonDraw( 2U + (2 * i), 5U, code[i] );

    /* Draw the empty progress boxes */
    for( i = 0; i < MAX_CODE_INPUTS; i++ )
        buttonDraw( 2U + (2 * i ), 8U, BUTTON_EMPTY );

    /* Store how many fails are allowed in m */
    switch( mgDifficulty )
    {
        case 0: m = 2; break;
        case 1: m = 1; break;
        case 2: m = 0; break;
    }

    /* n is number of mistakes made so far */
    n = 0;

    printLine( 2U, 12U, "ATTEMPTS", FALSE );

    /* Draw the "lives" boxes, depending on the difficulty */
    for( i = 0; i < m + 1; i++ )
        buttonDraw( 12U + ( 2 * i ), 12U, BUTTON_SMALL_EMPTY );

    /* Use k to track current index in the code */
    k = 0;

    // Play music
    //playSong(&dovesamTwilightDriveSong);

    fadein();
    substate = SUB_LOOP;
}

static void phaseCodeLoop()
{
    ++animTick;

    if (mgStatus == PLAYING)
    {
        inputsCode(); 
    }
}

/******************************** INPUT METHODS *********************************/
static void inputsCode()
{
    #define GET_CODE  buttonToJoypad( code[k] )

    /* Check if we have pressed the button we are looking for */
    if( (curJoypad & GET_CODE ) && !( prevJoypad & GET_CODE ) )
    {
        /* Fill in the progress box */
        buttonDraw( 2U + (2 * k ), 8U, BUTTON_SUCCESS );

        /* Increment our position in the code, check if we have won */
        k++;

        if( k == MAX_CODE_INPUTS )
        {
            mgStatus = WON;
            printLine( 2U, 12U, "UNLOCKED", FALSE );
        }
    }
    else if( ( curJoypad > 0 ) && ( curJoypad != prevJoypad ) && !( curJoypad & GET_CODE ) 
            && (!(curJoypad & J_START)))
    {
        /* Fill in an attempt, then check if we have lost */
        buttonDraw( 12U + ( 2 * n ), 12U, BUTTON_SMALL_FAIL );
        n++;

        if( n >= m + 1 )
        {
            mgStatus = LOST;
            printLine( 2U, 12U, "LOCKED  ", FALSE );
        }
    }

    #undef GET_CODE
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
        case BUTTON_EMPTY:
            my_map = EMPTY_MAP;
            break;
        case BUTTON_SUCCESS:
            my_map = SUCCESS_MAP;
            break;
        case BUTTON_SMALL_EMPTY:
            my_map = SMALL_EMPTY_MAP;
            break;
        case BUTTON_SMALL_FAIL:
            my_map = SMALL_FAIL_MAP;
            break;
        default: 
            my_map = LEFT_MAP;
            break;
    }

    set_bkg_based_tiles( x, y, 2, 2, my_map, VRAM_SAFE_START );
} /* buttonDraw */

static UINT8 buttonToJoypad( BUTTONS b )
{
    switch( b )
    {
        case BUTTON_LEFT: return J_LEFT;
        case BUTTON_DOWN: return J_DOWN;
        case BUTTON_RIGHT: return J_RIGHT;
        case BUTTON_UP: return J_UP;
        case BUTTON_A: return J_A;
        case BUTTON_B: return J_B;
        default: return 0;
    }
} /* buttonToJoypad */

/******************************** DISPLAY METHODS ********************************/
