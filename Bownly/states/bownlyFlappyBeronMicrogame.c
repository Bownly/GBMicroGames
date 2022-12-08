#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../sfx.h"
#include "../res/sprites/bownlySprBeron.h"
#include "../res/tiles/bownlyBeronCrownTiles.h"
#include "../res/tiles/bownlyBeronMushTiles.h"
#include "../res/maps/bownlyBeronCapUpMap.h"
#include "../res/maps/bownlyBeronCapDownMap.h"
#include "../res/maps/bownlyBeronStalkUpMap.h"
#include "../res/maps/bownlyBeronStalkDownMap.h"

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

static UINT8 gameTick;
static UINT8 gameTickTarget;
static UINT8 flapAnimTick;

BERONSTATE beronState;
#define BERON_X 40U
static UINT16 beronY;
static INT8 beronYVel;
#define GRAVITY 1U
#define MAX_Y_VEL 24U

UINT8 beronUpperBound;
UINT8 beronLowerBound;
UINT16 beronLeftBound;
UINT16 beronRightBound;
#define BERON_LEFT_PAD 5U
#define BERON_WIDTH 7U
#define BERON_TOP_PAD 5U
#define BERON_HEIGHT 8U

#define SPRID_BERON 0U
#define SPRTILE_BERON 0U

/* SUBSTATE METHODS */
static void phaseFlappyBeronInit();
static void phaseFlappyBeronLoop();

/* INPUT METHODS */
static void inputsFlappyBeron();

/* HELPER METHODS */
UINT8 checkBeronCollided();

/* DISPLAY METHODS */   
static void drawBeronSprites();

/* SFX METHODS */
// static void sfxNibble();


void bownlyFlappyBeronMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseFlappyBeronInit();
            break;
        case SUB_LOOP:
            phaseFlappyBeronLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseFlappyBeronInit()
{
    // Initializations
    mgStatus = WON;
    init_bkg(0x64U);
    animTick = 0U;
    beronState = FALLING;
    beronYVel = 0U;
    beronUpperBound = 0U;
    beronLowerBound = 0U;
    beronLeftBound = 0U;
    beronRightBound = 0U;
    flapAnimTick = 0U;
    gameTick = 0U;
    gameTickTarget = 60U + (mgSpeed * 30U);

    // Spikes
    for (i = 0U; i != 32U; ++i)
    {
        set_bkg_tile_xy(i, 0U, 99U);
        set_bkg_tile_xy(i, 17U, 98U);
    }

    beronY = 72U;

    // Setting up the sprites
    set_sprite_data(SPRTILE_BERON, bownlySprBeron_TILE_COUNT, bownlySprBeron_tiles);

    // Setting up the Mushrooms
    set_bkg_data(0x30U, 53U, bownlyBeronMushTiles);
    r = getRandUint8(2U);
    j = getRandUint8(9U);

    switch (mgDifficulty)
    {
        case 2U:
            // First mushroom
            if (r == 0U)
            {
                set_bkg_tiles(14U, 8U, 4U, 3U, bownlyBeronCapUpMap);
                set_bkg_tiles(15U, 11U, 2U, 9U, bownlyBeronStalkUpMap);

            }
            else
            {
                set_bkg_tiles(14U, 6U, 4U, 3U, bownlyBeronCapDownMap);
                set_bkg_tiles(15U, 29U, 2U, 9U, bownlyBeronStalkDownMap);
            }

            // Second (set of) mushroom(s)
            set_bkg_tiles(27U, j + 8U, 4U, 3U, bownlyBeronCapUpMap);
            set_bkg_tiles(28U, j + 11U, 2U, 9U, bownlyBeronStalkUpMap);
            set_bkg_tiles(27U, j, 4U, 3U, bownlyBeronCapDownMap);
            set_bkg_tiles(28U, j - 9U, 2U, 9U, bownlyBeronStalkDownMap);

            break;
        case 1U:
            if (r == 1U)
            {
                set_bkg_tiles(27U, 8U, 4U, 3U, bownlyBeronCapUpMap);
                set_bkg_tiles(28U, 11U, 2U, 9U, bownlyBeronStalkUpMap);
            }
            else
            {
                set_bkg_tiles(27U, 8U, 4U, 3U, bownlyBeronCapDownMap);
                set_bkg_tiles(28U, 31U, 2U, 9U, bownlyBeronStalkDownMap);
            }
        case 0U:
            if (r == 0U)
            {
                set_bkg_tiles(14U, 8U, 4U, 3U, bownlyBeronCapUpMap);
                set_bkg_tiles(15U, 11U, 2U, 9U, bownlyBeronStalkUpMap);
            }
            else
            {
                set_bkg_tiles(14U, 8U, 4U, 3U, bownlyBeronCapDownMap);
                set_bkg_tiles(15U, 31U, 2U, 9U, bownlyBeronStalkDownMap);
            }

        default:
    
            break;
    }

    substate = SUB_LOOP;

    // playSong(&bownlyKnotAnywhere1Song);

    fadein();
    // fadein() sets the sprites to a palette that I don't want to use here
    // OBP0_REG = 0xE4;  // 11 10 01 00
}

static void phaseFlappyBeronLoop()
{
    ++animTick;

    // Downward accelerative force
    beronYVel += GRAVITY;
    if (beronYVel == MAX_Y_VEL)
        --beronYVel;
    beronY += (beronYVel >> 3U);

    if (beronY > 160U)
        beronY = 160U;

    ++gameTick;
    if (mgSpeed != 0U)
    {
        if (gameTick % (2U - mgSpeed) == 0U)
        {
            scroll_bkg(1, 0U);
        }
    }

    if (mgStatus != LOST)
    {
        inputsFlappyBeron();
        
        if (beronYVel > 0)
            beronState = FALLING;

        scroll_bkg(1, 0U);
    
        // Collision check
        if (checkBeronCollided() == TRUE)
        {
            mgStatus = LOST;
            beronState = DYING;
            // you died sfx
        }

    }
    else
    {
        // Animate falling crown
    }

    drawBeronSprites();
}


/******************************** INPUT METHODS *********************************/
static void inputsFlappyBeron()
{
    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        beronYVel = -16;
        flapAnimTick = 0U;
        beronState = FLAPPING;
//         sfxNibble();
    }
}


/******************************** HELPER METHODS *********************************/
UINT8 checkBeronCollided()
{
    beronUpperBound = (beronY + BERON_TOP_PAD - 16U) >> 3U;
    beronLowerBound = (beronY + BERON_TOP_PAD - 16U + BERON_HEIGHT) >> 3U;
    beronLeftBound = (BERON_X + BERON_LEFT_PAD + SCX_REG - 8U) >> 3U;
    beronRightBound = (BERON_X + BERON_LEFT_PAD + SCX_REG - 8U + BERON_WIDTH) >> 3U;

    beronLeftBound %= 0x1FU;
    beronRightBound %= 0x1FU;

    // set_bkg_tile_xy(3,0,SCX_REG/100);
    // set_bkg_tile_xy(4,0,(SCX_REG/10)%10);
    // set_bkg_tile_xy(5,0,SCX_REG%10);

    // set_bkg_tile_xy(3,2,beronLeftBound/100);
    // set_bkg_tile_xy(4,2,(beronLeftBound/0x10)%0x10);
    // set_bkg_tile_xy(5,2,beronLeftBound%0x10);

    // set_bkg_tile_xy(3,3,beronUpperBound/100);
    // set_bkg_tile_xy(4,3,(beronUpperBound/10)%10);
    // set_bkg_tile_xy(5,3,beronUpperBound%10);

    l = get_bkg_tile_xy(beronLeftBound, beronUpperBound);
    if (l != 0x64U)  // 0x64U is the full light grey tile
        return TRUE;
    l = get_bkg_tile_xy(beronLeftBound, beronLowerBound);
    if (l != 0x64U)  // 0x64U is the full light grey tile
        return TRUE;
    l = get_bkg_tile_xy(beronRightBound, beronUpperBound);
    if (l != 0x64U)  // 0x64U is the full light grey tile
        return TRUE;
    l = get_bkg_tile_xy(beronRightBound, beronLowerBound);
    if (l != 0x64U)  // 0x64U is the full light grey tile
        return TRUE;
    
    return FALSE;
}

/******************************** DISPLAY METHODS ********************************/
static void drawBeronSprites()
{
    switch (beronState)
    {
        default:
        case FALLING:
            animFrame = (animTick >> 4U) % 4U;
            if (animFrame == 3U)
                animFrame = 1U;
            break;
        case FLAPPING:
            if (flapAnimTick == 0U || flapAnimTick == 2U || flapAnimTick == 3U)
            {
                // set_win_tile_xy(0,0,0x0A);
                animFrame = 4U;
            }
            // else if (flapAnimTick == 4U || flapAnimTick == 5U || flapAnimTick == 6U)
            // {
            //     // set_win_tile_xy(0,0,0x0B);
            //     animFrame = 4U;
            // }
            else
            {
                // set_win_tile_xy(0,0,0x0C);
                animFrame = 5U;
            }
            ++flapAnimTick;
            break;
        case DYING:
            animFrame = 6U;
            break;
    }

    move_metasprite(bownlySprBeron_metasprites[animFrame], SPRTILE_BERON, SPRID_BERON, BERON_X, beronY);
}



/********************************** SFX METHODS **********************************/
// static void sfxNibble()
// {
//     NR41_REG = 0x1FU;
//     NR42_REG = 0xF1U;
//     NR43_REG = 0x20U;
//     NR44_REG = 0xC0U;
// }
