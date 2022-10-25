#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../songPlayer.h"
#include "../database/microgameData.h"
#include "../structs/Microgame.h"
#include "../res/tiles/borderTiles.h"
#include "../res/tiles/fontTiles.h"
#include "../res/tiles/timerTiles.h"

#include "../../Bownly/states/bownlyBowMicrogame.h"
#include "../../Bownly/states/bownlyPastelMicrogame.h"
#include "../../Bownly/states/bownlyMP5Microgame.h"
#include "../../Template/states/templateFaceMicrogame.h"

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used mostly for loops
extern UINT8 k;  // Used for whatever
extern INT8 l;  // Used for whatever
extern UINT8 m;  // Used for menus generally
extern UINT8 n;  // Used for menus generally
extern UINT8 r;  // Used for randomization stuff

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;
extern Microgame mgCurrentMG;

extern UINT8 animTick;
extern UINT8 animFrame;

UINT8 mgVar;
UINT8 currentLives;
UINT8 currentScore;
UINT16 timeRemaining;  // 160px * 16 (big number)
UINT8 timerTickSpeed;


/* SUBSTATE METHODS */
void phaseInitMicrogameManager();
void phaseInitMicrogameLobby();
void phaseMicrogameManagerLoop();

/* INPUT METHODS */

/* HELPER METHODS */
void loadNewMG(MICROGAME);

/* DISPLAY METHODS */
void drawTimer();
void updateTimer();


/******************************** PUBLIC METHODS *********************************/
void microgameManagerStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseInitMicrogameManager();
            break;
        case MGM_INIT_LOBBY:
            phaseInitMicrogameLobby();
        case SUB_LOOP:
            phaseMicrogameManagerLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}

void microgameManagerGameLoop()
{
    updateTimer();

    if (timeRemaining <= timerTickSpeed)
        mgStatus = LOST;

    switch (mgStatus)
    {
        case LOST:
            if (--currentLives == 0U)
            {
                gamestate = STATE_TITLE;
                substate = SUB_INIT;
                break;
            }
        case WON:
            ++currentScore;
            gamestate = STATE_MICROGAME_MANAGER;
            substate = MGM_INIT_LOBBY;
            fadeout();

            // TEST stuff
            mgDifficulty = currentScore % 3U;
            mgSpeed = (currentScore / 3U) % 3U;
            loadNewMG(getRandUint(4U));
            // mgDifficulty = (currentScore / 3U) % 3U;

            break;
        default:  // AKA, we're actually playing the game
            SWITCH_ROM_MBC1(mgCurrentMG.bankId);
            switch (mgCurrentMG.id)
            {
                #define MICROGAME(game, gameFunction, a, b, c, d, e) \
                    case game: \
                        gameFunction(); \
                        break;
                #include "../database/microgameList.h"
                #undef MICROGAME

                default:
                    SWITCH_ROM_MBC1(1U);
                    templateFaceMicrogameMain();
                    break;
            }
            break;
    }
}


/******************************** SUBSTATE METHODS *******************************/
void phaseInitMicrogameManager()
{
    // Initializations
    currentLives = 4U;
    currentScore = 0U;
    mgDifficulty = 0U;
    mgSpeed = 0U;

    loadNewMG(MG_TEMPLATE_FACE);  // Edit this line with your MG's enum for testing purposes
    
    substate = MGM_INIT_LOBBY;
}

void phaseInitMicrogameLobby()
{
    // Initializations
    animTick = 0U;
    mgStatus = PLAYING;
    timeRemaining = 2560U;  // 2560 = 160px * 16
    timerTickSpeed = timeRemaining / mgCurrentMG.duration / 60U;

    HIDE_WIN;

    // Temp stuff to mute audio and stop playing song
    // TODO: replace with a call to play lobby music
    stopSong();

    // Reload graphics
    set_bkg_data(0U, 46U, fontTiles);
    set_bkg_data(0xF0U, 8U, borderTiles);
    set_bkg_data(0xFCU, 3U, timerTiles);

    setBlankBkg();
    
    // Set themed bkg
    
    substate = SUB_LOOP;

    // TEMP STUFF TODO: delete me
    printLine(6U, 8U, "SCORE:", FALSE);
    printLine(6U, 9U, "LIVES:", FALSE);

    fadein();
}

void phaseMicrogameManagerLoop()
{
    ++animTick;

    // Animate score increase visuals
    if (animTick < 60U)
    {
        set_bkg_tile_xy(12U, 8U, currentScore/100U);
        set_bkg_tile_xy(13U, 8U, (currentScore/10U)%10U);
        set_bkg_tile_xy(14U, 8U, currentScore%10U);
        set_bkg_tile_xy(12U, 9U, currentLives);
    }
    else if (animTick == 60U)
    {
        // Erase score and lives text
        for (i = 6U; i != 15U; ++i)
        {
            set_bkg_tile_xy(i, 8U, 0xFFU);
            set_bkg_tile_xy(i, 9U, 0xFFU);
        }

        k = 0U;
        while (mgCurrentMG.instructionsPtr[k] != 0U)
            ++k;

        l = (20U - k) >> 1U;
        // When done, show new instructions
        drawPopupWindow(l-1U, 7U, k+1U, 2U);
        printLine(l, 8U, mgCurrentMG.instructionsPtr, FALSE);
    }
    else if (animTick == 120U)
    {
        // Start new microgame
        fadeout();
        stopSong();
        SHOW_WIN;
        drawTimer();
        gamestate = STATE_MICROGAME;
        substate = SUB_INIT;
        mgStatus = PLAYING;
    }

}


/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/
void loadNewMG(MICROGAME newMicrogame)
{
    mgCurrentMG.id = newMicrogame;
    mgCurrentMG.bankId = microgameDex[newMicrogame].bankId;
    mgCurrentMG.namePtr = microgameDex[newMicrogame].namePtr;
    mgCurrentMG.bylinePtr = microgameDex[newMicrogame].bylinePtr;
    mgCurrentMG.instructionsPtr = microgameDex[newMicrogame].instructionsPtr;
    mgCurrentMG.duration = microgameDex[newMicrogame].duration;
}


/******************************** DISPLAY METHODS ********************************/
void drawTimer()
{
    set_win_tile_xy(0U, 0U, 0xFCU);  // Left end
    for (mgVar = 1U; mgVar != 21U; ++mgVar)
        set_win_tile_xy(mgVar, 0U, 0xFDU);  // Body
    set_sprite_tile(39U, 0xFEU);  // Right end
    move_sprite(39U, 160U, 152U);  // Right end
    move_win(0U, 136U);
}

void updateTimer()
{
    timeRemaining -= timerTickSpeed;
    move_win((160U - (timeRemaining >> 4U)), 136U);
}
