#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../res/tiles/bownlyThingyWallTiles.h"
#include "../res/sprites/bownlySprBanana.h"
#include "../res/sprites/bownlySprThingy.h"

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

static UINT16 x;
static UINT16 y;
static UINT16 thingyX;
static UINT16 thingyY;
static INT8 thingyXVel;
static INT8 thingyYVel;
static UINT8 xSpeed;
static UINT8 ySpeed;
static INT8 thingyTopBound;
static INT8 thingyBottomBound;
static INT8 thingyLeftBound;
static INT8 thingyRightBound;

static UINT16 bananaX;
static UINT16 bananaY;

#define SPRID_THINGY 0U
#define SPRID_BANANA 10U
#define SPRTILE_THINGY 0U
#define SPRTILE_BANANA bownlySprThingy_TILE_COUNT

#define LEFT_BOUND 48U
#define RIGHT_BOUND 652U
#define THINGY_TOP_OFFSET 40U
#define THINGY_BOTTOM_OFFSET 16U
#define THINGY_LEFT_OFFSET 12U
#define THINGY_RIGHT_OFFSET 12U


/* SUBSTATE METHODS */
static void phaseThingyInit();
static void phaseThingyLoop();

/* INPUT METHODS */
static void inputsThingy();

/* HELPER METHODS */
static void calcPhysics();
static UINT8 checkBananaCollision();

/* DISPLAY METHODS */
static void animateThingy();

/* SFX METHODS */
static void playCollisionSfx();


void bownlyThingyMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseThingyInit();
            break;
        case SUB_LOOP:
            phaseThingyLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseThingyInit()
{
    // Initializations
    animTick = 0U;
    xSpeed = 6U ;
    ySpeed = 6U + (mgSpeed << 1U);
    thingyXVel = 0U;
    thingyYVel = ySpeed;

    // Bkg setup
    init_bkg(0xFFU);
    set_bkg_data(0x40U, 1U, bownlyThingyWallTiles);

    // Borders
    for (i = 0U; i != 20U; ++i)
    {
        set_bkg_tile_xy(i, 0U, 0x40U);
        set_bkg_tile_xy(i, 16U, 0x40U);
    }
    for (j = 0U; j != 17U; ++j)
    {
        set_bkg_tile_xy(0U, j, 0x40U);
        set_bkg_tile_xy(19U, j, 0x40U);
    }

    // Sprite data setup
    set_sprite_data(SPRTILE_THINGY, bownlySprThingy_TILE_COUNT, bownlySprThingy_tiles);
    set_sprite_data(SPRTILE_BANANA, bownlySprBanana_TILE_COUNT, bownlySprBanana_tiles);


    i = getRandUint8(2U);
    j = getRandUint8(2U);
    r = getRandUint8(2U);

    // Vertical walls
    for (k = 0U; k != 9U; ++k)
    {
        set_bkg_tile_xy(9U, k + (8U * j), 0x40U);
        set_bkg_tile_xy(10U, k + (8U * j), 0x40U);
    }

    switch (mgDifficulty)
    {
        default:
        case 0U:
            break;
        case 1U:
            // Horizontal bar
            for (k = 11U; k != 16U + l; ++k)
            {
                set_bkg_tile_xy(k - (i * 10U), 8U, 0x40U);
            }

            // Hole in horizontal bar
            l = getRandUint8(6U);
            for (k = 11U; k != 14U; ++k)
            {
                set_bkg_tile_xy(k - (i * 10U) + l, 8U, 0xFFU);
            }
            break;
        case 2U:
            // Horizontal bars
            for (k = 11U; k != 16U + l; ++k)
            {
                set_bkg_tile_xy(k - (i * 10U), 8U, 0x40U);
                set_bkg_tile_xy(k - 10U + (i * 10U), 8U, 0x40U);
            }

            // Hole in horizontal bar
            l = getRandUint8(6U);
            for (k = 1U; k != 4U - i; ++k)
            {
                set_bkg_tile_xy(k + l, 8U, 0xFFU);
            }
            // Other hole in other horizontal bar
            l = getRandUint8(6U);
            for (k = 12U - i; k != 14U; ++k)
            {
                set_bkg_tile_xy(k + l, 8U, 0xFFU);
            }
            break;
    }

    // Thingy
    thingyX = 192U + (i * 320U);
    thingyY = 100U + (j * 400U);

    // Banana
    bananaX = 504U - (i * 320U);
    bananaY = 100U + (j * 400U);
    move_metasprite(bownlySprBanana_metasprites[0U], SPRTILE_BANANA, SPRID_BANANA, bananaX >> 2U, bananaY >> 2U);

    // playSong(&bownlyVictoryLapSong);

    fadein();
    OBP0_REG = 0xE4;  // 11 10 01 00

    substate = SUB_LOOP;
}

static void phaseThingyLoop()
{
    ++animTick;

    if (mgStatus == PLAYING)
    {
        inputsThingy();
        calcPhysics();
        if (checkBananaCollision() == TRUE)
        {
            mgStatus = WON;
            NR21_REG = 0x80U;
            NR22_REG = 0x73U;
            NR23_REG = 0x9FU;
            NR24_REG = 0xC7U;
            hide_metasprite(bownlySprBanana_metasprites[0U], SPRID_BANANA);
        }
    }
    
    animateThingy();
}


/******************************** INPUT METHODS *********************************/
static void inputsThingy()
{
    // Movement
    if (curJoypad & J_LEFT)
    {
        thingyXVel = -xSpeed;
    }
    else if (curJoypad & J_RIGHT)
    {
        thingyXVel = xSpeed;
    }
    else if (!(curJoypad & J_RIGHT) && !(curJoypad & J_RIGHT))
    {
        thingyXVel = 0;
    }
}


/******************************** HELPER METHODS *********************************/
static void calcPhysics()
{
    // Hypothetical coords that include velocity changes
    x = thingyX + thingyXVel;
    y = thingyY + thingyYVel;

    thingyTopBound = (thingyY - THINGY_TOP_OFFSET) >> 5U;
    thingyBottomBound = (thingyY + THINGY_BOTTOM_OFFSET) >> 5U;
    thingyLeftBound = (x - 32U - THINGY_LEFT_OFFSET) >> 5U;
    thingyRightBound = (x - 32U + THINGY_RIGHT_OFFSET) >> 5U;

    UINT8 collided = TRUE;
    if (x < LEFT_BOUND)
    {
        x = LEFT_BOUND;
        collided = TRUE;
    }
    else
    {
        // Check for left wall collisions
        l = get_bkg_tile_xy(thingyLeftBound, thingyBottomBound);
        l >>= 4U;
        if (l != 40U)  // ~Top left pixel can move left
        {
            l = get_bkg_tile_xy(thingyLeftBound, thingyBottomBound);
            l >>= 4U;
            if (l != 4U)  // ~Bottom left pixel can move left
            {
                collided = FALSE;
            }
        }
    }
    if (collided == TRUE)
    {
        thingyXVel = 0U;
    }
    else if (x > RIGHT_BOUND)
    {
        x = RIGHT_BOUND;
        collided = TRUE;
    }
    else
    {
        collided = TRUE;
        // Check for right wall collision
        l = get_bkg_tile_xy(thingyRightBound, thingyBottomBound);
        l >>= 4U;
        if (l != 4U)  // ~Top right pixel can move right
        {
            l = get_bkg_tile_xy(thingyRightBound, thingyBottomBound);
            l >>= 4U;
            if (l != 4U)  // ~Bottom right pixel can move right
            {
                collided = FALSE;
                thingyX += thingyXVel;
            }
        }
    }
    if (collided == TRUE)
    {
        thingyXVel = 0U;
    }

    x = thingyX;
    thingyLeftBound = (x - 32U - (THINGY_LEFT_OFFSET >> 1U)) >> 5U;
    thingyRightBound = (x - 32U + (THINGY_RIGHT_OFFSET >> 1U)) >> 5U;

    // Check for floor collisions
    if (thingyYVel > 0U)
    {
        collided = TRUE;
        l = get_bkg_tile_xy(thingyRightBound, thingyBottomBound);
        l >>= 4U;
        if (l != 4U)  // Right foot can move down
        {
            l = get_bkg_tile_xy(thingyLeftBound, thingyBottomBound);
            l >>= 4U;
            if (l != 4U)  // Left foot can move down
            {
                thingyY += thingyYVel;
                collided = FALSE;
            }
        }
        if (collided == TRUE)
        {
            playCollisionSfx();
            thingyYVel = -thingyYVel;
            thingyY -= 24U;
        }
    }
    else
    {
        // Check for ceiling collisions
        collided = TRUE;
        l = get_bkg_tile_xy(thingyRightBound, thingyTopBound);
        l >>= 4U;
        if (l != 4U)  // Right foot can move up
        {
            l = get_bkg_tile_xy(thingyLeftBound, thingyTopBound);
            l >>= 4U;
            if (l != 4U)  // Left foot can move up
            {
                thingyY += thingyYVel;
                collided = FALSE;
            }
        }
        if (collided == TRUE)
        {
            playCollisionSfx();
            thingyYVel = -thingyYVel;
            thingyY += 16U;
        }
    }
}

static UINT8 checkBananaCollision()
{
    // Would && all of these together, but I don't trust the compiler to use lazy evaluation
    if (thingyX < bananaX + 64U)
    {
        if (thingyX + 96U > bananaX)
        {
            if (thingyY < bananaY + 64U)
            {
                if (thingyY + 96U > bananaY)
                {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}


/******************************** DISPLAY METHODS ********************************/
static void animateThingy()
{
    if (mgStatus == PLAYING)
    {
        if (thingyYVel > 0)
            animFrame = 1U;
        else
            animFrame = 0U;
    }
    else
    {
        animFrame = 2U;
    }
    move_metasprite(bownlySprThingy_metasprites[animFrame], SPRTILE_THINGY, SPRID_THINGY, thingyX >> 2U, thingyY >> 2U);
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