#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
// #include "../res/tiles/bownlyThingyWallTiles.h"
#include "../res/sprites/bownlyBkgEarth.h"
#include "../res/sprites/bownlySprSophie.h"
#include "../res/sprites/bownlySprDrill.h"
#include "../res/sprites/bownlySprLizard.h"

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

static UINT8 sophieLocId;
static const UINT8 locToSprId[] = {0U, 1U, 2U, 3U, 4U, 3U, 2U, 1U, 0U, 1U, 2U, 3U, 4U, 3U, 2U, 1U};
static const UINT8 sophieLocsX[] = {76U, 102U, 119U, 129U, 138U,   129U, 119U, 102U,  76U,      74U,  57U,  47U,  38U,    47U,  57U,  74U};
static const UINT8 sophieLocsY[] = {15U,  23U,  37U,  50U,  75U,   124U, 140U, 153U, 161U,     153U, 140U, 124U,  75U,    50U,  37U,  23U};

static UINT8 drillFacingId;
static UINT16 drillX;
static UINT16 drillY;
static const UINT16 drillLocsX[]  = {21760U, 27904U, 32000U, 34304U, 35584U,   34304U, 32000U, 27904U, 21760U,   17152U, 13056U, 10752U,  9472U,   10752U, 13056U, 17152U};
static const UINT16 drillLocsY[]  = { 7680U,  8960U, 12032U, 15104U, 21504U,   29440U, 33280U, 36096U, 37376U,   36096U, 33280U, 29184U, 21504U,   15104U, 12032U,  8960U};
static const INT16 drillSpeedsX[]  = {  0U, -191U, -354U, -462U, -500U,  -462U, -354U, -191U,   0U,    191U,  354U,  462U, 500U,  465U, 354U, 191U};
static const INT16 drillSpeedsY[]  = {500U,  462U,  354U,  191U,    0U,  -191U, -354U, -462U, -500U,  -462U, -354U, -191U,   0U,  191U, 354U, 465U};

static UINT8 lizard1FacingId;
static UINT8 lizard2FacingId;
static UINT16 lizard1X;
static UINT16 lizard1Y;
static UINT16 lizard2X;
static UINT16 lizard2Y;
static const INT16 lizardSpeedsX[]  = {  0U, -191U, -354U, -462U, -500U,  -462U, -354U, -191U,   0U,    191U,  354U,  462U, 500U,  465U, 354U, 191U};
static const INT16 lizardSpeedsY[]  = {500U,  462U,  354U,  191U,    0U,  -191U, -354U, -462U, -500U,  -462U, -354U, -191U,   0U,  191U, 354U, 465U};

static UINT8 buttonHoldTick;
static DRILLSTATE drillState;

#define SPRID_SOPHIE 0U
#define SPRID_DRILL 10U
#define SPRID_LIZARD 11U
#define SPRTILE_SOPHIE 0U
#define SPRTILE_DRILL bownlySprSophie_TILE_COUNT
#define SPRTILE_LIZARD bownlySprSophie_TILE_COUNT + bownlySprDrill_TILE_COUNT

/* SUBSTATE METHODS */
static void phaseKillerDrillerInit();
static void phaseKillerDrillerLoop();

/* INPUT METHODS */
static void inputsKillerDriller();

/* HELPER METHODS */
static void drillPhysics();
// static UINT8 checkBananaCollision();

/* DISPLAY METHODS */
static void displayDrill();
static void displaySophie();

/* SFX METHODS */
static void playCollisionSfx();


void bownlyKillerDrillerMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseKillerDrillerInit();
            break;
        case SUB_LOOP:
            phaseKillerDrillerLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseKillerDrillerInit()
{
    // Initializations
    animTick = 0U;
    buttonHoldTick = 0U;
    sophieLocId = 0U;
    drillFacingId = 0U;
    drillState = FILLING;
    // xSpeed = 6U ;
    // ySpeed = 6U + (mgSpeed << 1U);
    // thingyXVel = 0U;
    // thingyYVel = ySpeed;

    // Bkg setup
    init_bkg(0xFFU);
    // set_bkg_data(0x40U, 1U, bownlyThingyWallTiles);
    move_bkg(-4, -4);

    // Draw earth
    set_bkg_data(0x30, bownlyBkgEarth_TILE_COUNT, bownlyBkgEarth_tiles);
    set_bkg_tiles(3U, 2U, 13U, 13U, bownlyBkgEarth_map);

    // Sprite data setup
    set_sprite_data(SPRTILE_SOPHIE, bownlySprSophie_TILE_COUNT, bownlySprSophie_tiles);
    set_sprite_data(SPRTILE_DRILL, bownlySprDrill_TILE_COUNT, bownlySprDrill_tiles);
    set_sprite_data(SPRTILE_LIZARD, bownlySprLizard_TILE_COUNT, bownlySprLizard_tiles);
    displaySophie();


    // Banana
    // bananaX = 504U - (i * 320U);
    // bananaY = 100U + (j * 400U);

    // playSong(&bownlyVictoryLapSong);

    fadein();
    // OBP0_REG = 0xE4;  // 11 10 01 00



    lizard1X = 22528U;
    lizard1Y = 22528U;
    lizard1FacingId = getRandUint8(16U);
    move_metasprite(bownlySprLizard_metasprites[animFrame], SPRTILE_LIZARD, SPRID_LIZARD, lizard1X >> 8U, lizard1Y >> 8U);

    substate = SUB_LOOP;
}

static void phaseKillerDrillerLoop()
{
    ++animTick;

    if (mgStatus == PLAYING)
    {
        inputsKillerDriller();
        if (drillState == DRILLING)
        {
            drillPhysics();
            displayDrill();
        }
    }

    // Lizard stuff to refactor
    animFrame = (animTick >> 2U) % 2U;
    lizard1X += lizardSpeedsX[lizard1FacingId] >> 2U;
    lizard1Y += lizardSpeedsY[lizard1FacingId] >> 2U;
    move_metasprite(bownlySprLizard_metasprites[animFrame], SPRTILE_LIZARD, SPRID_LIZARD, lizard1X >> 8U, lizard1Y >> 8U);
}


/******************************** INPUT METHODS *********************************/
static void inputsKillerDriller()
{
    if (!curJoypad & (J_LEFT | J_RIGHT))
    {
        buttonHoldTick = 0U;
    }

    if (mgStatus != LOST)
    {
        if(curJoypad & J_LEFT)
        {
            ++buttonHoldTick;
            if (!(prevJoypad & J_LEFT) || (buttonHoldTick % 8U == 0U))
            {
                hide_metasprite(bownlySprSophie_metasprites[locToSprId[sophieLocId]], SPRID_SOPHIE);
                if (sophieLocId-- == 0U)
                    sophieLocId = 15U;
                displaySophie();
                // playMoveSfx();
            }
        }
        else if(curJoypad & J_RIGHT)
        {
            ++buttonHoldTick;
            if (!(prevJoypad & J_RIGHT) || (buttonHoldTick % 8U == 0U))
            {
                hide_metasprite(bownlySprSophie_metasprites[locToSprId[sophieLocId]], SPRID_SOPHIE);
                if (++sophieLocId == 16U)
                    sophieLocId = 0U;
                displaySophie();
                // playMoveSfx();
            }
       }

        if (drillState == FILLING)
        {
            if (curJoypad & J_A && !(prevJoypad & J_A))
            {
                // playCollisionSfx();
                drillState = DRILLING;
            }
        }

        if (drillState == DRILLING)
        {
            if (curJoypad & J_B && !(prevJoypad & J_B))
            {
                // playCollisionSfx();
                drillState = FILLING;
            }
        }

    }
}


/******************************** HELPER METHODS *********************************/
static void drillPhysics()
{
    drillX += drillSpeedsX[drillFacingId];
    drillY += drillSpeedsY[drillFacingId];
}

/******************************** DISPLAY METHODS ********************************/
static void displayDrill()
{
    animFrame = locToSprId[drillFacingId];
    move_metasprite(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);

    switch (drillFacingId)
    {
        default:
            move_metasprite(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 5U:
            move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 6U:
            move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 7U:
            move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 8U:
            move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 9U:
            move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 10U:
            move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 11U:
            move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 12U:
            move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 13U:
            move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 14U:
            move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 15U:
            move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
    }

}

static void displaySophie()
{
    animFrame = locToSprId[sophieLocId];
    if (drillState == FILLING)
    {
        drillFacingId = sophieLocId;
        drillX = drillLocsX[drillFacingId];
        drillY = drillLocsY[drillFacingId];
    }

    switch (sophieLocId)
    {
        default:
            move_metasprite(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 5U:
            move_metasprite_hflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 6U:
            move_metasprite_hflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 7U:
            move_metasprite_hflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 8U:
            move_metasprite_hflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 9U:
            move_metasprite_hvflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 10U:
            move_metasprite_hvflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 11U:
            move_metasprite_hvflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_hvflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 12U:
            move_metasprite_vflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 13U:
            move_metasprite_vflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 14U:
            move_metasprite_vflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
        case 15U:
            move_metasprite_vflip(bownlySprSophie_metasprites[animFrame], SPRTILE_SOPHIE, SPRID_SOPHIE, sophieLocsX[sophieLocId], sophieLocsY[sophieLocId]);
            if (drillState == FILLING)
                move_metasprite_vflip(bownlySprDrill_metasprites[animFrame], SPRTILE_DRILL, SPRID_DRILL, drillX >> 8U, drillY >> 8U);
            break;
    }
}


/********************************** SFX METHODS **********************************/
static void playCollisionSfx()
{
    NR10_REG = 0x34U;
    NR11_REG = 0x70U;
    NR12_REG = 0xF0U;
    NR13_REG = 0xBAU;
    NR14_REG = 0xC6U;
}