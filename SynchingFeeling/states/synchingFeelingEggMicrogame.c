#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../sfx.h"
#include "../res/tiles/synchingFeelingEggTiles.h"
#include "../res/maps/synchingFeelingEggMaps.h"
#include "../res/sprites/synchingFeelingBlockSpr.h"
#include "../res/sprites/synchingFeelingCoinSpr.h"
#include "../res/sprites/synchingFeelingEggSpr.h"

extern const hUGESong_t synchingFeelingHumptyDumptySong;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i;  // Used for loop
extern UINT8 j;  // Used for coinY
extern UINT8 k;  // Used for blockFrameDelay
extern INT8 l;   
extern UINT8 m;  // Used for coinX
extern UINT8 n;  // Used for blockHitsLeft
extern UINT8 r;  // Used for randomization of blocks

extern UINT8 gamestate;
extern UINT8 substate;
extern UINT8 mgDifficulty;  // readonly
extern UINT8 mgSpeed;       // readonly
extern UINT8 mgStatus;

extern UINT8 animTick;      // Used for coinFrameDelay
extern UINT8 animFrame;     // Used for coinFrame

// Eggs (2 max), we only have 2 buttons to use.
#define eggMinYPos 82U
#define eggMaxYPos eggMinYPos + 30U
#define eggCrackFrames 5U
#define eggSmashFrame eggCrackFrames * 2U
static UINT8 eggX[2U];
static UINT8 eggY[2U];
static INT8 eggSpeed[2U];
static UINT8 eggFrame[2U];
static UINT8 eggMoodFrameMod[2U];
static EGGSTATE eggState[2U];
static UINT8 eggHitStamina[2U];

// Blocks (matches number of eggs)
#define blockYPos (eggMinYPos - 16U)
#define blockFrameMaxDelay 2U
static UINT8 blockFrame[2U];
static BLOCKSTATE blockState[2U];
//static UINT8 blockFrameDelay;     // using k
//static UINT8 blockHitsLeft;       // using n

// Coin
#define coinFrameMaxDelay 5U
#define coinMaxYPos blockYPos
#define coinMinYPos (blockYPos - 16U)
//static UINT8 coinX;               // using m
//static UINT8 coinY;               // using j
//static UINT8 coinFrameDelay;      // using animTick
//static UINT8 coinFrame;           // using animFrame

#define SPRID_EGG 0U
#define SPRID_BLOCK 4U
#define SPRID_COIN 8U
#define SPRID_EGG2 12U
#define SPRID_BLOCK2 16U
#define BKGTILE_EGG 0x30U

#define SPRTILE_COIN 0x00U
#define SPRTILE_BLOCK SPRTILE_COIN + synchingFeelingCoinSpr_TILE_COUNT
#define SPRTILE_EGG SPRTILE_BLOCK + synchingFeelingBlockSpr_TILE_COUNT

/* SUBSTATE METHODS */
static void phaseEggInit();
static void phaseEggLoop();

/* INPUT METHODS */
static void inputsEggJump(const UINT8 eggIndex);

/* HELPER METHODS */
static void updateEggState(const UINT8 eggIndex);
static void updateEggIdle(const UINT8 eggIndex);
static void updateEggJump(const UINT8 eggIndex);
static void updateEggSmashed(const UINT8 eggIndex);

static void updateBlockState(const UINT8 eggIndex);
static void updateDoHitBlockState(const UINT8 eggIndex);
static void updateDoNotHitBlockState(const UINT8 eggIndex);
static void updateProbablyDoNotHitBlockState(const UINT8 eggIndex);
static void updateHitBlockState(const UINT8 eggIndex);

/* DISPLAY METHODS */

void synchingFeelingEggMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseEggInit();            
            break;
        case SUB_LOOP:
            phaseEggLoop();            
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseEggInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;

    // At difficulty > 0, we have 2 eggs
    eggY[0U] = eggMaxYPos;
    eggY[1U] = eggMaxYPos;
    if (mgDifficulty == 0U)
    {
        eggX[0U] = 88U;
        eggX[1U] = 190U;
    }
    else
    {
        eggX[0U] = 72U;
        eggX[1U] = 104U;
    }

    m = eggX[0U];
    j = coinMaxYPos;
    eggSpeed[0U] = -3 - mgSpeed;
    eggSpeed[1U] = -3 - mgSpeed;
    eggFrame[0U] = 0U;
    eggFrame[1U] = 0U;
    eggMoodFrameMod[0U] = 0U;
    eggMoodFrameMod[1U] = 0U;
    eggState[0U] = IDLE;
    eggState[1U] = IDLE;
    eggHitStamina[0U] = mgSpeed;                    // Base hit stamina on speed, then have this influence the number of hits for the level
    eggHitStamina[1U] = mgSpeed;
    n = (mgDifficulty == 0U) ? 1U : (2U + mgSpeed); // Can take 4 hits before cracking with 0 stamina, difficulty influences blocks and egg count
    blockFrame[0U] = 4U;
    blockFrame[1U] = 4U;
    animTick = coinFrameMaxDelay;
    k = blockFrameMaxDelay;
    animFrame = 0U;
    blockState[0U] = THINKING;
    blockState[1U] = THINKING;
        
    // Setting up the background eggcup(s)
    set_bkg_data(BKGTILE_EGG, 13U, synchingFeelEggTiles);
    if (mgDifficulty == 0U)
    {
        set_bkg_tiles(8U, 13U, 4U, 4U, synchingFeelingEggMaps);
    }
    else
    {
        set_bkg_tiles(6U, 13U, 4U, 4U, synchingFeelingEggMaps);
        set_bkg_tiles(10U, 13U, 4U, 4U, synchingFeelingEggMaps);
    }


    
    // Setting up the sprites
    set_sprite_data(SPRTILE_EGG, synchingFeelingEggSpr_TILE_COUNT, synchingFeelingEggSpr_tiles);
    set_sprite_data(SPRTILE_BLOCK, synchingFeelingBlockSpr_TILE_COUNT, synchingFeelingBlockSpr_tiles);
    set_sprite_data(SPRTILE_COIN, synchingFeelingCoinSpr_TILE_COUNT, synchingFeelingCoinSpr_tiles);
    
    move_metasprite(synchingFeelingEggSpr_metasprites[eggFrame[0U]], SPRTILE_EGG, SPRID_EGG, eggX[0U], eggY[0U]);
    move_metasprite(synchingFeelingBlockSpr_metasprites[blockFrame[0U]], SPRTILE_BLOCK, SPRID_BLOCK, eggX[0U], blockYPos);
    move_metasprite(synchingFeelingEggSpr_metasprites[eggFrame[1U]], SPRTILE_EGG, SPRID_EGG2, eggX[1U], eggY[1U]);
    move_metasprite(synchingFeelingBlockSpr_metasprites[blockFrame[1U]], SPRTILE_BLOCK, SPRID_BLOCK2, eggX[1U], blockYPos);

    substate = SUB_LOOP;

    playSong(&synchingFeelingHumptyDumptySong);

    fadein();
    // fadein() sets the sprites to a palette that I don't want to use here
    OBP0_REG = 0xE4;  // 11 10 01 00
}

static void phaseEggLoop()
{
    // Animate a coin to be shown at the end
    if (animTick == 0U)
    {
        if (animFrame == 3U)
        {
            animFrame = 0U;
        }
        else
        {
            ++animFrame;
        }
        animTick = coinFrameMaxDelay;
    }
    else
    {
        --animTick;
    }

    // Update 2 eggs and 2 blocks on higher difficulties.
    // Where the logic affects both, ensure that first one acts as the arbiter.
    updateEggState(0U);    
    updateEggState(1U);    
    updateBlockState(0U);
    updateBlockState(1U);

    // If either block is thinking, we need to distribute the block types
    if (blockState[0U] == THINKING || blockState[1U] == THINKING)
    {
        if (k == 0U)
        {
            k = blockFrameMaxDelay;

            // Difficulty 0: No bad blocks
            // Difficulty 1: Blocks that start to smash eggs, no insta-fail
            // Difficulty 2: Blocks that smash eggs immediately, insta-fail
            r = getRandUint8(2U);
            if (mgDifficulty == 0U)
            {
                blockState[0U] = DOHIT;
                blockFrame[0U] = 0U;
            }
            else if (mgDifficulty == 1U)
            {
                blockState[0U] = ((r == 1U) ? DOHIT : PROBABLYDONOTHIT);
                blockState[1U] = ((r == 1U) ? PROBABLYDONOTHIT : DOHIT);
                blockFrame[0U] = 4U;
                blockFrame[1U] = 4U;
            }
            else if (mgDifficulty == 2U)
            {
                blockState[0U] = ((r == 1U) ? DOHIT : DONOTHIT);
                blockState[1U] = ((r == 1U) ? DONOTHIT : DOHIT);
                blockFrame[0U] = 4U;
                blockFrame[1U] = 4U;
            }
        }
        else
        {
            --k;
        }
    }

    // If we stopped play, give some feedback to the player
    switch (mgStatus)
    {
    case WON:
        // Force eggs to be happy
        eggMoodFrameMod[0U] = 0U;
        eggMoodFrameMod[1U] = 0U;

        // Force blocks to be happy
        blockFrame[0U] = 1U;
        blockFrame[1U] = 1U;

        // Make a coin rise from the last hit block        
        if (j > coinMinYPos)
        {
            --j;
        }
        break;

    case LOST:    
        // Force eggs to be sad
        eggMoodFrameMod[0U] = 1U;
        eggMoodFrameMod[1U] = 1U;

        // Force blocks to be sad
        blockFrame[0U] = 3U;
        blockFrame[1U] = 3U;
        break;
    }

    move_metasprite(synchingFeelingCoinSpr_metasprites[animFrame], SPRTILE_COIN, SPRID_COIN, m, j);
    move_metasprite(synchingFeelingEggSpr_metasprites[(eggFrame[0U] == eggSmashFrame ? eggFrame[0U] : (eggFrame[0U] + (eggCrackFrames * eggMoodFrameMod[0U])))], SPRTILE_EGG, SPRID_EGG, eggX[0U], eggY[0U]);
    move_metasprite(synchingFeelingBlockSpr_metasprites[blockFrame[0U]], SPRTILE_BLOCK, SPRID_BLOCK, eggX[0U], blockYPos);
    move_metasprite(synchingFeelingEggSpr_metasprites[(eggFrame[1U] == eggSmashFrame ? eggFrame[1U] : (eggFrame[1U] + (eggCrackFrames * eggMoodFrameMod[1U])))], SPRTILE_EGG, SPRID_EGG2, eggX[1U], eggY[1U]);
    move_metasprite(synchingFeelingBlockSpr_metasprites[blockFrame[1U]], SPRTILE_BLOCK, SPRID_BLOCK2, eggX[1U], blockYPos);
}


/******************************** INPUT METHODS *********************************/
static void inputsEggJump(const UINT8 eggIndex)
{
    // Higher difficulties mean two eggs, one button for each.
    // At lower difficulty, allow both inputs to control the single egg.
    if (mgStatus == PLAYING)
    {
        if (eggIndex == 0U)
        {
            if ((curJoypad & J_B) || ((curJoypad & J_A) && mgDifficulty == 0U))
            if (eggState[eggIndex] == IDLE)
            {
                eggState[eggIndex] = JUMPING;
            }
        }
        else
        {
            if (curJoypad & J_A)
            {
                if (eggState[eggIndex] == IDLE)
                {
                    eggState[eggIndex] = JUMPING;
                }
            }
        }
    }
}

/******************************** HELPER METHODS *********************************/
static void updateEggState(const UINT8 eggIndex)
{
    switch (eggState[eggIndex])
    {
    case IDLE:
        updateEggIdle(eggIndex);
        break;

    case JUMPING:
        updateEggJump(eggIndex);
        break;

    case SMASHED:
        updateEggSmashed(eggIndex);
        break;
    }
}

static void updateEggIdle(const UINT8 eggIndex)
{
    inputsEggJump(eggIndex);
    eggY[eggIndex] = eggMaxYPos;
}

static void updateEggJump(const UINT8 eggIndex)
{
    if (eggY[eggIndex] > eggMaxYPos || eggY[eggIndex] < eggMinYPos)
    {
        eggSpeed[eggIndex] *= -1;

        if (eggSpeed[eggIndex] < 0)
        {
            if (eggFrame[eggIndex] == eggCrackFrames)
            {
                eggState[eggIndex] = SMASHED;
            }
            else
            {
                eggState[eggIndex] = IDLE;
            }
        }
        else
        {
            // Egg could have stamina per hit, based on speed as this allows us to increase the target hits.
            if (eggHitStamina[eggIndex] == 0U)
            {
                ++eggFrame[eggIndex];
            }
            else
            {
                --eggHitStamina[eggIndex];
            }
            
            // Egg starts to look unhappy when cracking a bit
            if (eggFrame[eggIndex] >= 2)
            {
                eggMoodFrameMod[eggIndex] = 1U;
            }

            switch (blockState[eggIndex])
            {
            // Reduce blocks left and reroll
            case DOHIT:
                --n;
                blockState[eggIndex] = HIT;
                playGoodHitSfx();
                break;

            // Reroll blocks
            case PROBABLYDONOTHIT:
                blockState[eggIndex] = HIT;
                playGoodHitSfx();
                break;

            // End game
            case DONOTHIT:
                blockState[eggIndex] = DONE;
                playBadHitSfx();
                mgStatus = LOST;
                break;
            }
        }
    }
    eggY[eggIndex] += eggSpeed[eggIndex];
}

static void updateEggSmashed(const UINT8 eggIndex)
{
    // Force real smashed frame and position
    eggFrame[eggIndex] = eggSmashFrame;
    eggMoodFrameMod[eggIndex] = 0U;
    eggY[eggIndex] = eggMaxYPos;

    // And absolutely lose
    mgStatus = LOST;
}

static void updateBlockState(const UINT8 eggIndex)
{
    switch (blockState[eggIndex])
    {
    case DOHIT:
        updateDoHitBlockState(eggIndex);
        break;

    case DONOTHIT:
        updateDoNotHitBlockState(eggIndex);
        break;

    case PROBABLYDONOTHIT:
        updateProbablyDoNotHitBlockState(eggIndex);
        break;

    case HIT:
        updateHitBlockState(eggIndex);
        break;

    case THINKING:
        break;
    }
}

static void updateDoHitBlockState(const UINT8 eggIndex)
{
    blockFrame[eggIndex] = 0U;
}

static void updateDoNotHitBlockState(const UINT8 eggIndex)
{
    blockFrame[eggIndex] = 2U;
}

static void updateProbablyDoNotHitBlockState(const UINT8 eggIndex)
{
    blockFrame[eggIndex] = 4U;
}

static void updateHitBlockState(const UINT8 eggIndex)
{
    if (n == 0U)
    {
        blockState[eggIndex] = DONE;
        mgStatus = WON;

        // coin should rise from the last hit block
        m = eggX[eggIndex];
    }
    else
    {        
        blockState[eggIndex] = THINKING;
    }
}

/******************************** DISPLAY METHODS ********************************/
