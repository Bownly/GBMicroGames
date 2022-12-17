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
extern UINT8 shouldRestartSong;

extern UINT8 animTick;
extern UINT8 animFrame;

static UINT8 screenShakeTick;
static UINT8 messageTick;
#define MESSAGE_DURATION 90U

#define CONTRIBUTOR_COUNT 10U
static UINT8 indices[] = { 0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U, 8U, 9U };
static const unsigned char contributors[10U][18U] = {
    "BOWNLY",
    "ADRIANJG",
    "DOVESAM",
    "TEAAA",
    "OSHF",
    "JOAOMAKESGAMES",
    "SYNCHINGFEELING",
    "BBBBBR",
    "SLOOPYGOOP",
    "DANIELIVANESCU1" 
};



/* SUBSTATE METHODS */
static void phaseCreditsInit();
static void phaseCreditsLoop();
static void phaseDeleteSaveMessageLoop();

/* INPUT METHODS */
static void inputsCredits();

/* HELPER METHODS */

/* DISPLAY METHODS */

/* SFX METHODS */


void creditsStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseCreditsInit();
            break;
        case SUB_LOOP:
            phaseCreditsLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseCreditsInit()
{
    // Initializations
    init_bkg(BKGTILE_SCROLL);
    move_bkg(0U, 0U);

    animTick = 0U;
    HIDE_WIN;

    animateBkg();

    // Cursor setup
    set_sprite_data(0U, 6U, engineCursorTiles);
    set_sprite_tile(0U, 0U);

    drawBkgWindow(1U, 1U, 17U, 15U);
    drawBkgWindow(3U, 0U, 13U, 2U);

    // Randomize contributors
    for (k = 32U; k != 0U; --k)
    {
        r = getRandUint8(CONTRIBUTOR_COUNT);
        i = k % CONTRIBUTOR_COUNT;

        j = indices[i];
        indices[i] = indices[r];
        indices[r] = j;
    }

    printLine(4U,  1U, "CONTRIBUTORS", FALSE);
    for (i = 0U; i != CONTRIBUTOR_COUNT; ++i)
    {
        printLine(3U, i + 5U, contributors[indices[i]], FALSE);
    }

    substate = SUB_LOOP;
    fadein();
}

static void phaseCreditsLoop()
{
    ++animTick;
    inputsCredits();
    animateBkg();
}


/******************************** INPUT METHODS *********************************/
static void inputsCredits()
{
    if (curJoypad & J_B && !(prevJoypad & J_B))
    {
        fadeout();
        gamestate = STATE_MAIN_MENU;
        substate = SUB_INIT;
        shouldRestartSong = FALSE;
    }
}


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/


/********************************** SFX METHODS **********************************/
