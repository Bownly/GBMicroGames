#include <gb/gb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../ram.h"
#include "../songPlayer.h"

#include "../res/tiles/fontTiles.h"
#include "../res/tiles/alBhedFontTiles.h"
#include "../res/sprites/engineGBPrinter.h"
#include "../res/sprites/engineGBPrintout.h"

#include "../structs/Microgame.h"

extern const hUGESong_t engineSloopygoopResults;

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
extern Microgame mgCurrentMG;
extern MGPOOLTYPE mgPoolType;
extern UINT8 language;

extern UINT8 animTick;
extern UINT8 animFrame;

static UINT8 scrollTimer;
#define SCROLL_DURATION 128U


/* SUBSTATE METHODS */
static void phaseGameoverInit();
static void phaseGameoverLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */

/* SFX METHODS */
static void sfxPrint();


void gameoverStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseGameoverInit();
            break;
        case SUB_LOOP:
            phaseGameoverLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseGameoverInit()
{
    stopSong();
    // Initializations
    animTick = 0U;
    scrollTimer = 0U;
  
    SHOW_WIN;
    init_win(0xFFU);
    if (language == 1U)
        set_bkg_data(0U, 46U, alBhedFontTiles);
    else
        set_bkg_data(0U, 46U, fontTiles);

    set_bkg_data(0x40, engineGBPrinter_TILE_COUNT, engineGBPrinter_tiles);
    set_win_tiles(0U, 0U, 20U, 4U, engineGBPrinter_map);
    move_win(7U, 112U);

    move_bkg(4U, 0U);  // For centering purposes
    set_bkg_data(0x90, engineGBPrintout_TILE_COUNT, engineGBPrintout_tiles);
    set_bkg_tiles(0U, 0U, 21U, 32U, engineGBPrintout_map);

    printLine(6U, 19U, "GAME OVER", FALSE);

    if (mgPoolType != REMIX)
    {
        printLine(6U, 21U, "HIGH", FALSE);
        printLine(6U, 22U, "SCORE:", FALSE);

        // Check for new high score
        ENABLE_RAM;
        if (mgPoolType == ALL)
        {
            i = loadHighScore();
            if (k > i)
            {
                saveHighScore(k);
                i = k;
            }
        }
        else
        {
            i = loadMGScore(mgCurrentMG.id);
            if (k > i)
            {
                saveMGScore(mgCurrentMG.id, k);
                i = k;
            }
        }
        DISABLE_RAM;

        // High score
        set_bkg_tile_xy(12U, 22U, i/100U);
        set_bkg_tile_xy(13U, 22U, (i/10U)%10U);
        set_bkg_tile_xy(14U, 22U, i%10U);

        j = 24U;
    }
    else
        j = 23U;

    printLine(6U, j, "SCORE:", FALSE);

    // k is a stand-in for the score
    set_bkg_tile_xy(12U, j, k/100U);
    set_bkg_tile_xy(13U, j, (k/10U)%10U);
    set_bkg_tile_xy(14U, j, k%10U);
    
    substate = SUB_LOOP;
    fadein();
}

void phaseGameoverLoop()
{
    ++animTick;

    if (scrollTimer < SCROLL_DURATION)
    {
        if (scrollTimer++ % 8U == 0U)  // Scroll every 8 frames
        {
            scroll_bkg(0U, 8U);
            sfxPrint();
        }
    }
    else if (scrollTimer == SCROLL_DURATION)
    {
        ++scrollTimer;
        playSong(&engineSloopygoopResults);
    }
    else
    {
        if ((animTick % 64U) / 48U == 0U)
        {
            printLine(5U, 27U, "PRESS START", FALSE);
        }
        else
        {
            for (i = 5U; i != 16U; ++i)
                set_bkg_tile_xy(i, 27U, 0xFFU);
        }

        if (curJoypad & J_START && !(prevJoypad & J_START))
        {
            // fadeout();
            init_bkg(0xFFU);
            
            move_bkg(0U, 0U);

            gamestate = STATE_TITLE;
            substate = SUB_INIT;
        }  
    }

    
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/


/********************************** SFX METHODS **********************************/
static void sfxPrint()
{
    NR41_REG = 0x1FU;
    NR42_REG = 0xF1U;
    NR43_REG = 0x20U;
    NR44_REG = 0xC0U;
}