#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../sfx.h"
#include "../res/tiles/synchingFeelingGhostTiles.h"
#include "../res/maps/synchingFeelingGhostMaps.h"
#include "../res/sprites/synchingFeelingEyeSpr.h"
#include "../res/sprites/synchingFeelingGhostSpr.h"

extern const hUGESong_t sloopyGoopSingingMushroomSong;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;    // Used for tracking previous rand
extern UINT8 i;  // Used for loops
extern UINT8 j;  // Used for itemsSpawned
extern UINT8 k;  // Used for ghostHoverDelay
extern INT8 l;   // Used for ghostDirection
extern UINT8 m;  // Used for ghostsSpotted
extern UINT8 n;  // Used for ghostSpawnDelay
extern UINT8 r;  // Used for randomization

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;  // readonly
extern UINT8 mgSpeed;       // readonly
extern UINT8 mgStatus;

extern UINT8 animTick;      // Used for ghostFrameDelay
extern UINT8 animFrame;     // Used for eyeFrame

#define ghostFrameMaxDelay 20U
#define ghostHoverEyesOpenMaxDelay 15U
#define ghostHoverEyesClosedMaxDelay 5U
#define ghostIdleLastFrames 1U
#define ghostEyesClosedFrame 8U
#define eyeCenterX 88U
#define eyeOffsetX 8U
#define ghostOffsetX 48U
#define ghostOffsetY 48U
#define eyeLeftX eyeCenterX - eyeOffsetX
#define eyeRightX eyeCenterX + eyeOffsetX
#define eyesY 80U
#define ghostMaxSpawnDelay 100U
#define ghostMaxCount 3U

static EYESTATE eyeState;
//static UINT8 eyeFrame;        // using animFrame
//static UINT8 ghostFrameDelay; // using animTick
//static UINT8 ghostSpawnDelay; // using n
//static UINT8 ghostHoverDelay; // using k
static UINT8 ghostFrameOffset[ghostMaxCount];
static UINT8 ghostFrame[ghostMaxCount];
static UINT8 ghostX[ghostMaxCount];
static UINT8 ghostY[ghostMaxCount];
static UINT8 ghostsSpawned;
//static UINT8 itemsSpawned;    // using j
//static UINT8 ghostsSpotted;   // using m
static UINT8 ghostsToSpawn;
static EYESTATE ghostSpotState[ghostMaxCount]; // Which 'eye state' matches the ghost spot state

#define SPRID_GHOST 0U
#define SPRID_GHOST2 4U
#define SPRID_GHOST3 8U
#define SPRID_EYELEFT 12U
#define SPRID_EYERIGHT 16U
#define BKGTILE_GHOST 0x30U

#define SPRTILE_GHOST 0x00U
#define SPRTILE_EYE SPRTILE_GHOST + synchingFeelingGhostSpr_TILE_COUNT

/* SUBSTATE METHODS */
static void phaseGhostInit();
static void phaseGhostLoop();

/* INPUT METHODS */
static void inputEyes();

/* HELPER METHODS */
static void respawnGhost();

/* DISPLAY METHODS */

void synchingFeelingGhostMicrogameMain()
{
    switch (substate)
    {
        case SUB_INIT:
            phaseGhostInit();
            break;
        case SUB_LOOP:
            phaseGhostLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseGhostInit()
{
    // Initializations
    init_bkg(0xFFU);

    eyeState = EYE_CENTER;
    animFrame = 0U;

    // LVL 1: One ghost
    // LVL 2: Two ghosts
    // LVL 3: Three ghosts
    ghostsToSpawn = mgDifficulty + 1;

    for (i = 0U; i != ghostsToSpawn; ++i)
    {
        ghostFrameOffset[i] = 0U;
        ghostFrame[i] = 0U;
        ghostSpotState[i] = EYE_CENTER;
    }

    animTick = (ghostFrameMaxDelay * ghostsToSpawn);
    k = (ghostHoverEyesOpenMaxDelay - (mgSpeed * 2U) * ghostsToSpawn);
    l = -1;
    n = ghostMaxSpawnDelay - (mgSpeed * 10U);
    ghostsSpawned = 0U;
    j = 0U;
    m = 0U;
    prevJoypad = 10U;
                
    // Setting up the background person, for the eyes
    set_bkg_data(BKGTILE_GHOST, 62U, synchingFeeGhostTile);
    set_bkg_tiles(6U, 5U, 8U, 13U, synchingFeelingGhostMaps);

    respawnGhost();

    // Setting up the sprites
    set_sprite_data(SPRTILE_EYE, synchingFeelingEyeSpr_TILE_COUNT, synchingFeelingEyeSpr_tiles);
    set_sprite_data(SPRTILE_GHOST, synchingFeelingGhostSpr_TILE_COUNT, synchingFeelingGhostSpr_tiles);
    
    move_metasprite(synchingFeelingEyeSpr_metasprites[0U], SPRTILE_EYE, SPRID_EYELEFT, eyeLeftX, eyesY);
    move_metasprite(synchingFeelingEyeSpr_metasprites[0U], SPRTILE_EYE, SPRID_EYERIGHT, eyeRightX, eyesY);
    
    for (i = 0U; i != ghostsToSpawn; ++i)
    {
        move_metasprite(synchingFeelingGhostSpr_metasprites[ghostFrame[i]], SPRTILE_GHOST, (SPRID_GHOST + (i * 4U)), ghostX[i], ghostY[i]);
    }

    substate = SUB_LOOP;

    // Song by SloopyGoop - "Singing Mushroom"
    playSong(&sloopyGoopSingingMushroomSong);

    fadein();
    // fadein() sets the sprites to a palette that I don't want to use here
    OBP0_REG = 0xE4;  // 11 10 01 00
}

static void phaseGhostLoop()
{
    inputEyes();

    // Eye animation
    switch (eyeState)
    {
    case EYE_CENTER:
        animFrame = 0U;
        break;
    case EYE_UP:
        animFrame = 3U;
        break;
    case EYE_DOWN:
        animFrame = 4U;
        break;
    case EYE_LEFT:
        animFrame = 2U;
        break;
    case EYE_RIGHT:
        animFrame = 1U;
        break;
    case BLINK:
        animFrame = 5U;
        break;
    }

    // Ghost animation - if player is facing the same direction then we play ghost 'hide' anim
    // This will register a ghost spotted mark
    // l
    for (i = 0U; i != ghostsToSpawn; ++i)
    {
        if (ghostSpotState[i] != EYE_CENTER)
        {
            if (ghostSpotState[i] == eyeState)
            {
                if (ghostSpotState[i] != BLINK)
                {
                    // Bad spot, only failure case for look
                    if (ghostFrame[i] == 9U || ghostFrame[i] == 11U)
                    {
                        playGhostFailSfx();
                        mgStatus = LOST;
                        eyeState = BLINK;
                    }
                    // Good, necessary spot
                    else
                    {
                        ghostFrame[i] = ghostEyesClosedFrame;
                        ghostSpotState[i] = BLINK;
                        ++m;
                        playGhostSpotSfx();
                    }
                }
            }
            // Otherwise animate normally, if eyes aren't closed and it isn't an insta-fail ghost
            else if (ghostSpotState[i] != BLINK && ghostFrame[i] != 9U && ghostFrame[i] != 11U)
            {
                if (animTick == 0U)
                {
                    if (ghostFrame[i] < (ghostFrameOffset[i] + ghostIdleLastFrames))
                    {
                        ++ghostFrame[i];
                    }
                    else
                    {
                        ghostFrame[i] = ghostFrameOffset[i];
                    }
                    animTick = ghostFrameMaxDelay * ghostsToSpawn;
                }
                else
                {
                    --animTick;
                }
            }
        }

        // Ghost hover    
        if (k == 0U)
        {
            l *= -1;
            k = (ghostHoverEyesOpenMaxDelay - (mgSpeed * 2U) * ghostsToSpawn);
        }
        else
        {
            --k;
        }

        // hover direction
        r = getRandUint8(2U);

        // l/r
        if (r == 0U)
        {
            ghostY[i] += l;
        }
        // u/d
        else
        {
            ghostX[i] += l;
        }
    }

    // Respawn ghosts
    if (n == 0U)
    {
        respawnGhost();
        n = ghostMaxSpawnDelay - (mgSpeed * 10U);
    }
    else
    {
        --n;
    }
    
    move_metasprite(synchingFeelingEyeSpr_metasprites[animFrame], SPRTILE_EYE, SPRID_EYELEFT, eyeLeftX, eyesY);
    move_metasprite(synchingFeelingEyeSpr_metasprites[animFrame], SPRTILE_EYE, SPRID_EYERIGHT, eyeRightX, eyesY);
    for (i = 0U; i != ghostsToSpawn; ++i)
    {
        move_metasprite(synchingFeelingGhostSpr_metasprites[ghostFrame[i]], SPRTILE_GHOST, (SPRID_GHOST + (i * 4U)), ghostX[i], ghostY[i]);
    }
}

/******************************** INPUT METHODS *********************************/
static void inputEyes()
{
    if (eyeState != BLINK)
    {        
        if (curJoypad & J_LEFT)
        {
            eyeState = EYE_LEFT;
        }
        else if (curJoypad & J_RIGHT)
        {
            eyeState = EYE_RIGHT;
        }
        else if (curJoypad & J_UP)
        {
            eyeState = EYE_UP;
        }
        else if (curJoypad & J_DOWN)
        {
            eyeState = EYE_DOWN;
        }
        else
        {
            eyeState = EYE_CENTER;
        }
    }
}

/******************************** HELPER METHODS *********************************/

/******************************** DISPLAY METHODS ********************************/
static void respawnGhost()
{
    // You have to spot each ghost to pass.
    if (m >= ghostsSpawned)
    {
        if (m != 0U || j)
        {            
            if (mgStatus != LOST)
            {
                mgStatus = WON;
            }
        }
    }
    // If you fail, your eyes close
    else
    {
        playGhostFailSfx();
        mgStatus = LOST;
        eyeState = BLINK;
    }    

    ghostsSpawned = 0U;
    j = 0U;
    m = 0U;
            
    for(i = 0U; i != ghostsToSpawn; ++i)
    {
        // Ghost locations
        // roll for position
        r = getRandUint8(4U);

        // init for new spawn
        ghostFrame[i] = 0U;

        // handle collision for 2 ghosts, just don't choose same as previous
        if (ghostsToSpawn == 2U)
        {
            if (r == prevJoypad)
            {
                if (r >= 3U)
                {
                    r = 0U;
                }
                else
                {
                    ++r;
                }
            }
        }
        // handle collision for 3 ghosts - r indicates the position to not spawn at so cycle past that
        else if (ghostsToSpawn == 3U)
        {
            if (prevJoypad <= 3U)
            {
                r = prevJoypad;
            }

            if (r >= 3U)
            {
                r = 0U;
            }
            else
            {
                ++r;
            }
        }

        // Ghost Left
        if (r == 0U)
        {
            ghostX[i] = eyeCenterX - ghostOffsetX;
            ghostY[i] = eyesY;
            ghostFrameOffset[i] = 2U;
            ghostSpotState[i] = EYE_LEFT;
        }
        // Ghost Right
        else if (r == 1U)
        {
            ghostX[i] = eyeCenterX + ghostOffsetX;
            ghostY[i] = eyesY;
            ghostFrameOffset[i] = 0U;
            ghostSpotState[i] = EYE_RIGHT;
        }
        // Ghost Top
        else if (r == 2U)
        {
            ghostX[i] = eyeCenterX;
            ghostY[i] = eyesY - ghostOffsetY;
            ghostFrameOffset[i] = 6U;
            ghostSpotState[i] = EYE_UP;
        }
        // Ghost Bottom
        else if (r == 3U)
        {
            ghostX[i] = eyeCenterX;
            ghostY[i] = eyesY + ghostOffsetY;
            ghostFrameOffset[i] = 4U;
            ghostSpotState[i] = EYE_DOWN;
        }

        // Cache last choice
        prevJoypad = r;

        // Sometimes, spawn things that aren't ghosts for variety.
        // EYE_CENTER really just means 'item' here.
        // Some items are harmless, some are insta-fail (the ghost-like things with x eyes)
        // Don't do any of this at level one, teach people they need to spot ghosts as the main mechanic
        if (mgDifficulty != 0U)
        {
            r = getRandUint8(12U);
            if (r == 1U)
            {
                ghostFrame[i] = 9U;
            }
            else if (r == 2U)
            {
                ghostFrame[i] = 10U;
                ghostSpotState[i] = EYE_CENTER;
            }
            else if (r == 3U)
            {
                ghostFrame[i] = 11U;
            }
            else if (r == 4U)
            {
                ghostFrame[i] = 12U;
                ghostSpotState[i] = EYE_CENTER;
            }
        }

        if (ghostSpotState[i] != EYE_CENTER && ghostFrame[i] != 9U && ghostFrame[i] != 11U)
        {
            ++ghostsSpawned;
        }
        else
        {
            ++j;
        }
    }
}
