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
#include "../res/tiles/engineDMGTiles.h"
#include "../res/maps/engineDMGBat0Map.h"
#include "../res/maps/engineDMGBat1Map.h"
#include "../res/maps/engineDMGBat2Map.h"
#include "../res/maps/engineDMGBat3Map.h"
#include "../res/maps/engineDMGBat4Map.h"
#include "../res/sprites/engineGBCart.h"
#include "../res/sprites/engineDMGBezel.h"

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
extern UINT8 oldBank;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;
extern Microgame mgCurrentMG;

extern UINT8 animTick;
extern UINT8 animFrame;

UINT8 lobbyDurationStats = 90U;
UINT8 lobbyDurationInstructions = 90U;

UINT8 currentLives;
UINT8 currentScore;
UINT16 mgTimeRemaining;  // 160px * 16 (big number)
UINT8 mgTimerTickSpeed;

UINT8 transitionTimer;
#define TRANSITION_DURATION 60U

MGPOOLTYPE mgPoolType;
UINT8 mgPoolSize;
UINT8 mgPool[MICROGAME_COUNT];
UINT8 mgHistoryLog[MICROGAME_COUNT];
UINT8 mgHistoryLogSize;

/* SUBSTATE METHODS */
void phaseInitMicrogameManager();
void phaseMicrogameManagerInitLobby();
void phaseMicrogameManagerLobbyLoop();

/* INPUT METHODS */

/* HELPER METHODS */
void callMicrogameFunction();
void mgHistoryLogInit();
void mgHistoryLogPush(UINT8);
void loadNewMG();
void startMG();

/* DISPLAY METHODS */
void drawBattery(UINT8);
void drawTimer();
void updateTimer();


/******************************** PUBLIC METHODS *********************************/
void microgameManagerStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
        case MGM_INIT_SINGLE:
        case MGM_INIT_ALL:
        case MGM_INIT_REMIX:
             phaseInitMicrogameManager();
            break;
        case MGM_INIT_LOBBY:
            phaseMicrogameManagerInitLobby();
        case SUB_LOOP:
            phaseMicrogameManagerLobbyLoop();
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
    if (mgTimeRemaining <= mgTimerTickSpeed)
    {
        stopSong();
        if (mgStatus != WON)
            mgStatus = LOST;

        if (mgStatus == LOST)
        {
            --currentLives;
        }

        if (currentLives == 0U)
        {
            k = currentScore;  // Using k for this because I am irresponsible and reckless
            gamestate = STATE_GAMEOVER;
            substate = SUB_INIT;
            fadeout();
        }
        else
        {
            ++currentScore;
            gamestate = STATE_MICROGAME_MANAGER;
            substate = MGM_INIT_LOBBY;
            fadeout();

            // TEST stuff
            // Level up
            if (currentScore % 8U == 0U)
            {
                r = getRandUint8(2U);
                if (r == 0U)
                {
                    if (++mgDifficulty == 3U)
                        mgDifficulty = 2U;
                }
                else
                {
                    if (++mgSpeed == 3U)
                        mgSpeed = 2U;
                }
            }

            // mgDifficulty = currentScore % 3U;
            // mgDifficulty = (currentScore / 3U) % 3U;
            // mgSpeed = (currentScore / 3U) % 3U;
            // mgSpeed = currentScore % 3U;

            loadNewMG();
        }
    }
    else
        callMicrogameFunction();
}


/******************************** SUBSTATE METHODS *******************************/
void phaseInitMicrogameManager()
{
    // Initializations
    currentLives = 4U;
    currentScore = 0U;
    mgDifficulty = 0U;
    mgSpeed = 0U;

    switch (substate)
    {
        default:
        case MGM_INIT_SINGLE:
            mgPoolType = SINGLE;
            break;
        case MGM_INIT_ALL:
            mgPoolType = ALL;
            break;
        case MGM_INIT_REMIX:
            mgPoolType = REMIX;
            break;
    }

    switch (mgPoolType)
    {
        default:
        case ALL:
            mgHistoryLogSize = MICROGAME_COUNT >> 1U;
            mgPoolSize = MICROGAME_COUNT;
            for (i = 0U; i != MICROGAME_COUNT; ++i)
                mgPool[i] = i;
            break;
        case SINGLE:
            mgHistoryLogSize = 1U;
            mgPoolSize = 1U;
            mgPool[0U] = mgCurrentMG.id;
            break;
        // case CUSTOM:
        //     mgHistoryLogSize = get val from RAM >> 1U;
        //     break;
    }
    mgHistoryLogInit();


    stopSong();

    loadNewMG();  // Edit this line with your MG's enum for testing purposes
    
    substate = MGM_INIT_LOBBY;
}

void phaseMicrogameManagerInitLobby()
{
    SWITCH_ROM(1U);

    // Reload graphics
    move_bkg(0U, 0U);
    set_bkg_data(0U, 46U, fontTiles);
    set_bkg_data(0xF0U, 8U, borderTiles);
    set_bkg_data(0xFCU, 3U, timerTiles);

    // Draw dmg bezel
    // init_bkg(0xFFU);
    set_bkg_data(0x30, 7U, engineDMGTiles);
    set_bkg_data(0x90, engineDMGBezel_TILE_COUNT, engineDMGBezel_tiles);
    set_bkg_tiles(0U, 0U, 20U, 18U, engineDMGBezel_map);

    // Play appropriate jingle(s)
    switch (mgStatus)
    {
        default:
            break;
        case WON:
            printLine(6U, 4U, "NICE ONE!", FALSE);
            playOutsideSong(WON_JINGLE_1);
            break;
        case LOST:
            printLine(6U, 4U, "BUMMER!", FALSE);
            playOutsideSong(LOST_JINGLE_1);
            break;
    }

    // Initializations
    animTick = 0U;
    mgTimeRemaining = 2560U;  // 2560 = 160px * 16
    mgTimerTickSpeed = mgTimeRemaining / mgCurrentMG.duration / (60U - mgSpeed * 9U);

    lobbyDurationStats = 100U - mgSpeed * 9U;
    lobbyDurationInstructions = 95U - mgSpeed * 9U;
    
    HIDE_WIN;
    
    substate = SUB_LOOP;

    drawBattery(currentLives);

    // TEMP STUFF TODO: delete me
    printLine(6U, 7U, "SCORE:", FALSE);
    printLine(6U, 8U, "SPEED:", FALSE);
    printLine(6U, 9U, "LEVEL:", FALSE);

    fadein();
}

void phaseMicrogameManagerLobbyLoop()
{
    ++animTick;

    // TODO: Animate score increase visuals
    if (animTick < lobbyDurationStats)
    {
        if (mgStatus == LOST)
        {
            // Make the battery LED blink
            if (animTick % 8U == 0U)
            {
                if (animTick % 16U == 0U)
                    drawBattery(currentLives);
                else
                    drawBattery(currentLives + 1U);
            }
        }

        set_bkg_tile_xy(12U, 7U, currentScore/100U);
        set_bkg_tile_xy(13U, 7U, (currentScore/10U)%10U);
        set_bkg_tile_xy(14U, 7U, currentScore%10U);

        set_bkg_tile_xy(12U, 8U, mgSpeed + 1U);
        set_bkg_tile_xy(12U, 9U, mgDifficulty + 1U);

    }
    else if (animTick == lobbyDurationStats)
    {
        if (currentLives == 0U)  // If we need to gameover
        {
            k = currentScore;  // Using k for this because I am irresponsible and reckless
            gamestate = STATE_GAMEOVER;
            substate = SUB_INIT;
            fadeout();
        }
        else
        {
            // Audio
            stopSong();
            // playOutsideSong(PRE_MG_JINGLE_1);

            // Erase stats text
            init_bkg(0xFFU);

            // Draw gb cart
            oldBank = CURRENT_BANK;
            SWITCH_ROM(1U);
            set_bkg_data(0x40, engineGBCart_TILE_COUNT, engineGBCart_tiles);
            set_bkg_tiles(2U, 0U, 16U, 18U, engineGBCart_map);
            SWITCH_ROM(oldBank);

            // Show new instructions
            k = 0U;
            while (mgCurrentMG.instructionsPtr[k] != 0U)
                ++k;
            l = (20U - k) >> 1U;
            printLine(l, 10U, mgCurrentMG.instructionsPtr, FALSE);
        }
    }
    else if (animTick == (lobbyDurationStats + lobbyDurationInstructions))
    {
        startMG();
    }

}


/******************************** INPUT METHODS *********************************/
static void inputsGameLoop()
{
    // If pressed start
    //   Redraw top row of window
    //   Write "Paused\nContinue\nExit"
    //   Show full window
    //   Enter paused substate
}

static void inputsPaused()
{
    // Up/Down to select menu options
    // If continue or start
    // //   Redraw timer line, move window to appropriate position (handled by below line?)
    //   state = STATE_MICROGAME
    // If exit
    //   state = main menu
}

/******************************** HELPER METHODS *********************************/
void callMicrogameFunction()
{
    SWITCH_ROM(mgCurrentMG.bankId);
    switch (mgCurrentMG.id)
    {
        #define MICROGAME(game, gameFunction, a, b, c, d, e) \
            case game: \
                gameFunction(); \
                break;
        #include "../database/microgameList.h"
        #undef MICROGAME

        default:
            SWITCH_ROM(1U);
            templateFaceMicrogameMain();
            break;
    }
}

void mgHistoryLogInit()
{
    for (i = 0U; i != mgHistoryLogSize; ++i)
    {
        mgHistoryLog[i] = 0xFF;
    }
}

void mgHistoryLogPush(UINT8 mgId)
{
    // Shift existing entries to the right
    for (i = 0U; i != mgHistoryLogSize - 1U; ++i)
    {
        mgHistoryLog[i] = mgHistoryLog[i + 1U];
    }

    // Add new entry
    mgHistoryLog[mgHistoryLogSize - 1U] = mgId;
}

void loadNewMG()
{
    if (mgPoolSize != 1U)
    {
        l = FALSE;
        while (l == FALSE)
        {
            r = getRandUint8(mgPoolSize);
            r = mgPool[r];

            l = TRUE;
            for (i = 0U; i != mgHistoryLogSize; ++i)
            {
                if (mgHistoryLog[i] == r)
                    l = FALSE;
            }
        }
        mgHistoryLogPush(r);
    }
    else
        r = mgCurrentMG.id;

    mgCurrentMG.id = r;
    mgCurrentMG.bankId = microgameDex[r].bankId;
    mgCurrentMG.namePtr = microgameDex[r].namePtr;
    mgCurrentMG.bylinePtr = microgameDex[r].bylinePtr;
    mgCurrentMG.instructionsPtr = microgameDex[r].instructionsPtr;
    mgCurrentMG.duration = microgameDex[r].duration;
}

void startMG()
{
    fadeout();
    stopSong();
    SHOW_WIN;
    drawTimer();
    transitionTimer = 0U;
    gamestate = STATE_MICROGAME;
    substate = SUB_INIT;
    mgStatus = PLAYING;
}


/******************************** DISPLAY METHODS ********************************/
void drawBattery(UINT8 lives)
{
    oldBank = CURRENT_BANK;
    SWITCH_ROM(1U);

    switch (lives)
    {
        default:
        case 0U:
            set_bkg_tiles(1U, 4U, 1U, 5U, engineDMGBat0Map);
            break;
        case 1U:
            set_bkg_tiles(1U, 4U, 1U, 5U, engineDMGBat1Map);
            break;
        case 2U:
            set_bkg_tiles(1U, 4U, 1U, 5U, engineDMGBat2Map);
            break;
        case 3U:
            set_bkg_tiles(1U, 4U, 1U, 5U, engineDMGBat3Map);
            break;
        case 4U:
            set_bkg_tiles(1U, 4U, 1U, 5U, engineDMGBat4Map);
            break;
    }
    
    SWITCH_ROM(oldBank);

}

void drawTimer()
{
    set_win_tile_xy(0U, 0U, 0xFCU);  // Left end
    for (i = 1U; i != 21U; ++i)
        set_win_tile_xy(i, 0U, 0xFDU);  // Body
    set_sprite_tile(39U, 0xFEU);  // Right end
    move_sprite(39U, 160U, 152U);  // Right end
    move_win(0U, 136U);
}

void updateTimer()
{
    mgTimeRemaining -= mgTimerTickSpeed;
    move_win((160U - (mgTimeRemaining >> 4U)), 136U);
}
