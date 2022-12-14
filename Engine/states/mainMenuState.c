#include <gb/gb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../ram.h"
#include "../songPlayer.h"

#include "../res/tiles/borderTiles.h"
#include "../res/tiles/darkBorderTiles.h"
#include "../res/tiles/engineCursorTiles.h"
#include "../res/sprites/engineWordPlay.h"
#include "../res/sprites/engineWordRemix.h"
#include "../res/sprites/engineWordCredits.h"

extern const hUGESong_t engineSloopygoopPartyTheme;

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

static UINT8 messageTick;
#define MESSAGE_DURATION 90U

static const UINT8 greySquare[16] = { 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00 };

#define BKGTILE_PLAY 0x30U
#define BKGTILE_REMIX 0x50U
#define BKGTILE_CREDITS 0x80U


/* SUBSTATE METHODS */
static void phaseMainMenuInit();
static void phaseMainMenuLoop();

/* INPUT METHODS */
static void inputsMainMenu();

/* HELPER METHODS */

/* DISPLAY METHODS */
static void deselectButton();
static void selectButton();

/* SFX METHODS */


void mainMenuStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseMainMenuInit();
            break;
        case SUB_LOOP:
            phaseMainMenuLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseMainMenuInit()
{
    // Initializations
    stopSong();
    init_bkg(BKGTILE_SCROLL);
    move_bkg(0U, 0U);
    animTick = 0U;
    HIDE_WIN;
    n = 0U;

    // Menu buttons setup
    drawPopupWindow(2U,  2U, 13U, 3U);
    drawPopupWindow(2U,  7U, 13U, 3U);
    drawPopupWindow(2U, 12U, 13U, 3U);
    set_bkg_data(0xE0U, 9U, darkBorderTiles);
    set_bkg_data(BKGTILE_PLAY, engineWordPlay_TILE_COUNT, engineWordPlay_tiles);
    set_bkg_data(BKGTILE_REMIX, engineWordRemix_TILE_COUNT, engineWordRemix_tiles);
    set_bkg_data(BKGTILE_CREDITS, engineWordCredits_TILE_COUNT, engineWordCredits_tiles);
    set_bkg_tiles(5U,  3U,  8U, 2U, engineWordPlay_map);
    set_bkg_tiles(4U,  8U, 10U, 2U, engineWordRemix_map);
    set_bkg_tiles(3U, 13U, 12U, 2U, engineWordCredits_map);

    animateBkg();
    selectButton();

    substate = SUB_LOOP;
    fadein();

    playSong(&engineSloopygoopPartyTheme);
}

static void phaseMainMenuLoop()
{
    ++animTick;
    animateBkg();
    
    inputsMainMenu();
}


/******************************** INPUT METHODS *********************************/
static void inputsMainMenu()
{
    if (curJoypad & J_UP && !(prevJoypad & J_UP))
    {
        deselectButton();
        n = (n + 2U) % 3U;
        selectButton();
    }
    else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN))
    {
        deselectButton();
        n = (n + 1U) % 3U;
        selectButton();
    }

    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        switch (n)
        {
            case 0U:  // Play
                stopSong();
                fadeout();
                initrand(DIV_REG);
                gamestate = STATE_MICROGAME_MANAGER;
                substate = MGM_INIT_ALL;
                mgStatus = PLAYING;
                break;
            case 1U:  // Remix
                stopSong();
                fadeout();
                gamestate = STATE_REMIX;
                substate = SUB_INIT;
                break;
            case 2U:  // Credits
                fadeout();
                break;
        }
    }
}


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
static void deselectButton()
{
    j = (n * 5U) + 2U;
    k = j + 4U;

    // Shift tiles left
    for (i = 0U; i != 18U; ++i)
    {
        for (j = (n * 5U) + 2U; j != k; ++j)
        {
            m = get_bkg_tile_xy(i+2U, j);
            if ((m == 0xE8U) || (m >> 3U) == 0x1CU)  // 1C = E0-E7
                set_bkg_tile_xy(i, j, m + 16U);
            else
                set_bkg_tile_xy(i, j, m);
        }
    }

    // Redraw words
    switch (n)
    {
        case 0U:
            set_bkg_tiles(5U,  3U,  8U, 2U, engineWordPlay_map);
            break;
        case 1U:
            set_bkg_tiles(4U,  8U, 10U, 2U, engineWordRemix_map);
            break;
        case 2U:
            set_bkg_tiles(3U, 13U, 12U, 2U, engineWordCredits_map);
            break;
    }

}

static void selectButton()
{
    j = (n * 5U) + 2U;
    k = j + 4U;

    // Shift tiles right
    for (i = 18U; i != 1U; --i)
    {
        for (j = (n * 5U) + 2U; j != k; ++j)
        {
            m = get_bkg_tile_xy(i-2U, j);
            if ((m == 0xF8U) || (m >> 3U) == 0x1E)  // 1E = F0-F7
                set_bkg_tile_xy(i, j, m - 16U);
            else
                set_bkg_tile_xy(i, j, m);
        }
    }

    // Redraw words
    switch (n)
    {
        case 0U:
            set_bkg_tiles(7U,  3U,  8U, 2U, engineWordPlay_map + 16U);
            break;
        case 1U:
            set_bkg_tiles(6U,  8U, 10U, 2U, engineWordRemix_map + 20U);
            break;
        case 2U:
            set_bkg_tiles(5U, 13U, 12U, 2U, engineWordCredits_map + 24U);
            break;
    }
}


/********************************** SFX METHODS **********************************/
