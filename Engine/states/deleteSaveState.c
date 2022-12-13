#include <gb/gb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../ram.h"

#include "../res/tiles/engineCursorTiles.h"

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

static UINT8 screenShakeTick;
static UINT8 messageTick;
#define MESSAGE_DURATION 90U


/* SUBSTATE METHODS */
static void phaseDeleteSaveInit();
static void phaseDeleteSaveLoop();
static void phaseDeleteSaveMessageLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */
static void animateCursor();
static void tryShakeScreen();
static void updateCursorLocation();

/* SFX METHODS */
static void sfxDeleted();


void deleteSaveStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseDeleteSaveInit();
            break;
        case SUB_LOOP:
            phaseDeleteSaveLoop();
            break;
        case DS_MESSAGE_LOOP:
            phaseDeleteSaveMessageLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseDeleteSaveInit()
{
    // Initializations
    init_bkg(BKGTILE_SCROLL);
    move_bkg(0U, 0U);

    animTick = 0U;
    HIDE_WIN;
    m = 1U;
    messageTick = 0U;
    screenShakeTick = 0U;

    animateBkg();

    // Cursor setup
    set_sprite_data(0U, 6U, engineCursorTiles);
    set_sprite_tile(0U, 0U);
    animateCursor();
    updateCursorLocation();

    drawPopupWindow(4U, 5U, 11U, 5U);

    printLine(5U, 6U, "DELETE ALL", FALSE);
    printLine(5U, 7U, "SAVE DATA?", FALSE);
    printLine(6U, 9U, "YES", FALSE);
    printLine(13U, 9U, "NO", FALSE);

    substate = SUB_LOOP;
    fadein();
}

static void phaseDeleteSaveLoop()
{
    ++animTick;
    animateCursor();
    animateBkg();
    
    if ((curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT))
        || (curJoypad & J_LEFT && !(prevJoypad & J_LEFT)))
    {
        m = (m + 1U) % 2U;
        updateCursorLocation();
    }

    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        if (m == 1U)  // No
        {
            fadeout();
            init_bkg(0xFFU);
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            fadein();
        }
        else
        {
            ENABLE_RAM;
            wipeHighScore();
            wipeAllMGScores();
            wipeAllMGToggles();
            DISABLE_RAM;

            substate = DS_MESSAGE_LOOP;
            screenShakeTick = 1U;
            sfxDeleted();

            // Setup inital graphics for the message loop
            move_sprite(0U, 0U, 0U);
            fill_bkg_rect(4U, 5U, 12U, 6U, BKGTILE_SCROLL);  // Cover up old window
            drawPopupWindow(4U, 6U, 11U, 3U);  // Draw new window
            printLine(5U, 7U, "SAVE  DATA", FALSE);
            printLine(6U, 8U, "DELETED!", FALSE);
        }
    }
    else if (curJoypad & J_B && !(prevJoypad & J_B))
    {
        fadeout();
        init_bkg(0xFFU);
        gamestate = STATE_TITLE;
        substate = SUB_INIT;
        fadein();
    }
}

static void phaseDeleteSaveMessageLoop()
{
    ++animTick;

    tryShakeScreen();
    animateCursor();
    animateBkg();

    if (messageTick++ == MESSAGE_DURATION)
    {
        fadeout();
        init_bkg(0xFFU);
        gamestate = STATE_TITLE;
        substate = SUB_INIT;
        fadein();
    }
}


/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
static void animateCursor()
{
    animFrame = (animTick >> 4U) % 4U;
    if (animFrame == 3U)
        animFrame = 1U;

    set_sprite_tile(0U, animFrame + 3U);
    // set_sprite_tile(0U, animFrame);
}

static void tryShakeScreen()
{
    if (screenShakeTick != 0U)
    {
        if (screenShakeTick != 26U)
        {
            ++screenShakeTick;
            switch (screenShakeTick)
            {
                case 5U:
                    scroll_bkg(1, 0);
                    break;
                case 10U:
                    scroll_bkg(-2, 0);
                    break;
                case 15U:
                    scroll_bkg(0, 1);
                    break;
                case 20U:
                    scroll_bkg(0, -2);
                    break;
                case 25U:
                    move_bkg(0, 0);
                    screenShakeTick = 0U;
                    break;
            }
        }
    }
}

static void updateCursorLocation()
{
    move_sprite(0U, 48U + (56U * m), 88U);
}


/********************************** SFX METHODS **********************************/
static void sfxDeleted()
{
    NR41_REG = 0x03U;
    NR42_REG = 0xF0U;
    NR43_REG = 0x5FU;
    NR44_REG = 0xC0U;
}