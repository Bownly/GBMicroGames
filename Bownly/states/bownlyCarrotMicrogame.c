#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../sfx.h"
#include "../res/sprites/bownlySprRabbit.h"
#include "../res/sprites/bownlySprCarrot.h"
#include "../res/tiles/bownlyGrassBkgTiles.h"

extern const hUGESong_t bownlyKnotAnywhere1Song;

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

extern UINT8 animTick;
extern UINT8 animFrame;

static UINT8 rabbitX;
static UINT8 rabbitY;
static UINT8 eatCount;
static UINT8 eatGoal;

#define CARROT_Y 2U


/* SUBSTATE METHODS */
static void phaseCarrotInit();
static void phaseCarrotLoop();

/* INPUT METHODS */
static void inputsEat();

/* HELPER METHODS */

/* DISPLAY METHODS */
static void drawGrass();
static void updateCarrots();

/* SFX METHODS */
static void sfxNibble();


void bownlyCarrotMicrogameMain()
{
    switch (substate)
    {
        case SUB_INIT:
            phaseCarrotInit();
            break;
        case SUB_LOOP:
            phaseCarrotLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseCarrotInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;

    rabbitX = 150U;
    rabbitY = 50U;
    eatCount = 0U;

    // Setting up the sprites
    set_bkg_data(0x30U, bownlySprRabbit_TILE_COUNT, bownlySprRabbit_tiles);
    set_bkg_data(0xA0U, bownlySprCarrot_TILE_COUNT, bownlySprCarrot_tiles);
    set_bkg_data(0x70U, 5U, bownlyGrassBkgTiles);
    set_bkg_tiles(8U, 8U, 4U, 4U, bownlySprRabbit_map + 16U);

    drawGrass();

    // Setup carrots
    switch (mgDifficulty)
    {
        default:
        case 0U:
            m = 2U;
            n = 17U;
            eatGoal = 5U;
            break;
        case 1U:
            m = 4U;
            n = 16U;
            eatGoal = 8U;
            break;
        case 2U:
            m = 5U;
            n = 14U;
            eatGoal = 12U;
            break;
    }

    for (i = m; i != n; i += 3U)
        set_bkg_tiles(i, CARROT_Y, 3U, 3U, bownlySprCarrot_map);

    substate = SUB_LOOP;

    fadein();
    playSong(&bownlyKnotAnywhere1Song);

    // fadein() sets the sprites to a palette that I don't want to use here
    OBP0_REG = 0xE4;  // 11 10 01 00
}

static void phaseCarrotLoop()
{
    ++animTick;
    if (mgStatus == PLAYING)
        inputsEat();
    else if (mgStatus == WON)
    {
        animFrame = (animTick >> 5U) % 2U;
        set_bkg_tiles(8U, 8U, 4U, 4U, bownlySprRabbit_map + ((animFrame + 3U) << 4U));
    }
}


/******************************** INPUT METHODS *********************************/
static void inputsEat()
{
    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        updateCarrots();  // Updating these before updating eatCount because it simplifies the math

        ++eatCount;
        animFrame = eatCount % 2U;
        if (animFrame == 1U)
            animFrame = 2U;

        sfxNibble();

        set_bkg_tiles(8U, 8U, 4U, 4U, bownlySprRabbit_map + (animFrame << 4U));

        if (eatCount == eatGoal)
        {
            mgStatus = WON;
            animTick = 0U;
        }
    }
}


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
static void drawGrass()
{
    // Manually placed in aesprite, so enjoy all of these magic numbers
    if (getRandUint8(2U) == 0U)
        set_bkg_tile_xy(13U,11U, 0x70U);
    if (getRandUint8(2U) == 0U)
        set_bkg_tile_xy(5U, 12U, 0x70U);
    if (getRandUint8(2U) == 0U)
        set_bkg_tile_xy(8U, 12U, 0x70U);
    if (getRandUint8(2U) == 0U)
        set_bkg_tile_xy(9U, 14U, 0x70U);

    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy( 4U, 10U, 0x71U);
        set_bkg_tile_xy( 5U, 10U, 0x72U);
    }
    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy(10U, 13U, 0x71U);
        set_bkg_tile_xy(11U, 13U, 0x72U);
    }
    
    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy( 6U, 11U, 0x73U);
        set_bkg_tile_xy( 7U, 11U, 0x74U);
    }
    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy(11U, 12U, 0x73U);
        set_bkg_tile_xy(12U, 12U, 0x74U);
    }
    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy( 7U, 13U, 0x73U);
        set_bkg_tile_xy( 8U, 13U, 0x74U);
    }
    if (getRandUint8(2U) == 0U)
    {
        set_bkg_tile_xy(13U, 13U, 0x73U);
        set_bkg_tile_xy(14U, 13U, 0x74U);
    }
}

static void updateCarrots()
{
    switch (mgDifficulty)
    {
        default:
        case 0U:
            set_bkg_tiles(2U + (eatCount * 3U), CARROT_Y, 3U, 3U, bownlySprCarrot_map + 36U);  // Empty map
            break;
        case 1U:
            set_bkg_tiles(4U + ((eatCount / 2U) * 3U), CARROT_Y, 3U, 3U, bownlySprCarrot_map + 18U + (18U * (eatCount % 2U)));
            break;
        case 2U:
            set_bkg_tiles(5U + ((eatCount / 4U) * 3U), CARROT_Y, 3U, 3U, bownlySprCarrot_map + 9U + (9U * (eatCount % 4U)));
            break;
    }
}


/********************************** SFX METHODS **********************************/
static void sfxNibble()
{
    NR41_REG = 0x1FU;
    NR42_REG = 0xF1U;
    NR43_REG = 0x20U;
    NR44_REG = 0xC0U;
}
