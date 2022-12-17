#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../res/maps/bownlyPastelCloud1Map.h"
#include "../res/sprites/bownlySprBee.h"
#include "../res/sprites/bownlySprJumppuff.h"
#include "../res/sprites/bownlySprPastel.h"
#include "../res/tiles/bownlyPastelBkg2Tiles.h"

extern const hUGESong_t bownlyTenseBossBattleSong;

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
static UINT16 pastelX;
static UINT16 pastelY;
static INT8 pastelXVel;
static INT8 pastelYVel;
static PASTELSTATE pastelState;
static UINT8 heartCount = 0U;
static UINT8 pastelFlipX = FALSE;
static UINT8 xSpeedWalking;
static UINT8 xSpeedInAir;
static UINT8 ySpeedJumping;
static UINT8 jumpTimer;
static UINT8 JUMP_DURATION = 8U;

static INT8 pastelBottomBound;
static INT8 pastelLeftBound;
static INT8 pastelRightBound;
#define LEFT_BOUND 48U
#define RIGHT_BOUND 652U
#define PASTEL_TOP_OFFSET 0U
#define PASTEL_BOTTOM_OFFSET 48U
#define PASTEL_LEFT_OFFSET 12U
#define PASTEL_RIGHT_OFFSET 12U
#define PASTEL_MAX_YVEL 32U
static UINT8 deadTimer;

static UINT8 jumppuffX;
static UINT8 jumppuffY;
static UINT8 jumppuffTimer = 7U;
#define JUMPPUFF_DURATION 7U

static UINT16 bee1X;
static UINT16 bee1Y;
static UINT16 bee2X;
static UINT16 bee2Y;
static UINT8 bee1Speed;
static UINT8 bee2Speed;
static UINT8 bee1StartTimer;
static UINT8 bee2StartTimer;
// static const INT8 beeYSin[12U] = {0,1,2,3,2,1,0,-1,-2,-3,-2,-1};

#define SPRID_PASTEL 0U
#define SPRID_JUPMPUFF 10U
#define SPRID_BEE1 12U
#define SPRID_BEE2 16U
#define SPRTILE_PASTEL 0U
#define SPRTILE_JUMPPUFF SPRTILE_PASTEL + bownlySprPastel_TILE_COUNT
#define SPRTILE_BEE SPRTILE_PASTEL + bownlySprPastel_TILE_COUNT + bownlySprJumppuff_TILE_COUNT
#define BKGID_HEART 0x60U


/* SUBSTATE METHODS */
static void phasePastelInit();
static void phasePastelLoop();

/* INPUT METHODS */
static void inputsPastel();

/* HELPER METHODS */
static void moveBees();
static void calcPhysics();
static UINT8 checkIsGrounded();
static UINT8 checkBeeCollision();
static UINT8 checkHeartCollision();

/* DISPLAY METHODS */
static void animateBees();
static void animatePastel();

/* SFX METHODS */
static void sfxDing();
static void sfxBleep();
static void sfxHurt();


void bownlyPastelDodgeMicrogameMain()
{
    switch (substate)
    {
        case SUB_INIT:
            phasePastelInit();
            break;
        case SUB_LOOP:
            phasePastelLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
}


/******************************** SUBSTATE METHODS *******************************/
static void phasePastelInit()
{
    // Initializations
    mgStatus = WON;
    animTick = 0U;
    pastelX = 168U;
    pastelY = 288U;
    pastelXVel = 0U;
    pastelYVel = 0U;
    ySpeedJumping = 12U;
    jumpTimer = 0U;
    deadTimer = 0U;

    pastelState = AIRBORNE;
    pastelFlipX = FALSE;
    heartCount = 0U;

    jumppuffX = 0U;
    jumppuffY = 0U;
    jumppuffTimer = 0U;

    bee1X = 720U;
    bee2X = 720U;
    bee1Speed = 7U + (mgSpeed << 2U);
    bee2Speed = 6U + (mgSpeed << 1U);

    xSpeedWalking = 6U + (mgSpeed << 1U);
    xSpeedInAir = 6U + (mgSpeed << 1U);


    // Bkg setup
    set_bkg_data(0x3FU, 30U, bownlyPastelBkg2Tiles);
    for (i = 0U; i != 20U; ++i)
    {
        for (j = 0U; j != 18U; ++j)
        {
            set_bkg_tile_xy(i, j, 0x3FU);  // Full black tile
        }
    }

    // Sprite setup
    set_sprite_data(SPRTILE_PASTEL, bownlySprPastel_TILE_COUNT, bownlySprPastel_tiles);
    set_sprite_data(SPRTILE_JUMPPUFF, bownlySprJumppuff_TILE_COUNT, bownlySprJumppuff_tiles);
    set_sprite_data(SPRTILE_BEE, bownlySprBee_TILE_COUNT, bownlySprBee_tiles);

    // Map
    set_bkg_tiles(0U, 10U, 10U, 3U, bownlyPastelCloud1Map);
    set_bkg_tiles(10U, 10U, 10U, 3U, bownlyPastelCloud1Map);
    // Pillars
    for (j = 12U; j != 18U; ++j)
    {
        set_bkg_tile_xy(0, j, 0x54U);
        set_bkg_tile_xy(1, j, 0x55U);
        set_bkg_tile_xy(8, j, 0x54U);
        set_bkg_tile_xy(9, j, 0x55U);
        set_bkg_tile_xy(10, j, 0x54U);
        set_bkg_tile_xy(11, j, 0x55U);
        set_bkg_tile_xy(18, j, 0x54U);
        set_bkg_tile_xy(19, j, 0x55U);
    }

    switch (mgDifficulty)
    {
        default:
        case 0U:
            // Bee
            bee1Y = 296U;
            bee1StartTimer = getRandUint8(15U);
            break;
        case 1U:
            // Bees
            bee1Y = 296U;
            bee2Y = 264U;
            bee1StartTimer = getRandUint8(15U);
            bee2StartTimer = bee1StartTimer + 15U + getRandUint8(30U);
            break;
        case 2U:
            // Bees
            bee2StartTimer = 0U;
            bee1StartTimer = 25U + getRandUint8(40U);

            bee1Y = 288U;
            bee2Y = 288U;
            break;
    }

    playSong(&bownlyTenseBossBattleSong);

    fadein();
    substate = SUB_LOOP;
}

static void phasePastelLoop()
{
    hide_metasprite(bownlySprPastel_metasprites[animFrame % 16U], SPRTILE_PASTEL);
    ++animTick;

    moveBees();

    if (pastelState != DEAD)
    {
        inputsPastel();
        calcPhysics();

        if (checkBeeCollision() == TRUE)
        {
            mgStatus = LOST;
            pastelState = DEAD;
            sfxHurt();
        }
    }

    animateBees();
    animatePastel();

    // Jumppuff logic
    if (jumppuffTimer == JUMPPUFF_DURATION)
        hide_metasprite(bownlySprJumppuff_metasprites[0U], SPRID_JUPMPUFF);
    else
    {
        move_metasprite(bownlySprJumppuff_metasprites[jumppuffTimer], SPRTILE_JUMPPUFF, SPRID_JUPMPUFF, jumppuffX, jumppuffY);
        ++jumppuffTimer;
    }
}


/******************************** INPUT METHODS *********************************/
static void inputsPastel()
{
    // Movement
    if (curJoypad & J_LEFT)
    {
        if (pastelX != LEFT_BOUND)
        {
            switch (pastelState)
            {
                case IDLE:
                case WALKING:
                    pastelState = WALKING;
                    pastelXVel = -xSpeedWalking;
                    break;
                case AIRBORNE:
                    pastelXVel = -xSpeedInAir;
                    break;
            }
            pastelFlipX = TRUE;
        }
    }
    else if (curJoypad & J_RIGHT)
    {
        if (pastelX != RIGHT_BOUND)
        {
            switch (pastelState)
            {
                case IDLE:
                case WALKING:
                    pastelState = WALKING;
                    pastelXVel = xSpeedWalking;
                    break;
                case AIRBORNE:
                    pastelXVel = xSpeedInAir;
                    break;
            }
            pastelFlipX = FALSE;
        }
    }
    else if (!(curJoypad & J_RIGHT) && !(curJoypad & J_RIGHT))
    {
        if (pastelState == WALKING)
            pastelState = IDLE;
        pastelXVel = 0;
    }

    // Jumping
    if (curJoypad & J_A)
    {
        if ((pastelState == IDLE || pastelState == WALKING) && !(prevJoypad & J_A))  // Start jump
        {
            ++jumpTimer;
            pastelYVel = -ySpeedJumping;
            pastelState = AIRBORNE;
            jumppuffTimer = 0U;
            jumppuffX = pastelX >> 2U;
            jumppuffY = ((pastelY + PASTEL_BOTTOM_OFFSET + 4U) >> 2U) + 10U;
            sfxBleep();
        }
        else if (pastelState == AIRBORNE && jumpTimer != JUMP_DURATION)  // Continue jump
        {
            ++jumpTimer;
            pastelYVel = -ySpeedJumping;
        }
    }
    else if (pastelState == AIRBORNE)
    {
        jumpTimer = JUMP_DURATION;
    }
}


/******************************** HELPER METHODS *********************************/
static void moveBees()
{
    if (bee1StartTimer != 0U)
        --bee1StartTimer;
    if (bee2StartTimer != 0U)
        --bee2StartTimer;

    switch (mgDifficulty)
    {
        default:
        case 0U:
            // Straight line
            if (bee1StartTimer == 0U)
                bee1X -= bee1Speed;
            break;
        case 1U:
            // Straight line
            if (bee1StartTimer == 0U)
                bee1X -= bee1Speed;
            if (bee2StartTimer == 0U)
                bee2X -= bee2Speed;
            break;
        case 2U:
            // Straight line
            if (bee1StartTimer == 0U)
                bee1X -= bee1Speed;
            // Sinusoidal
            if (bee2StartTimer == 0U)
            {
                bee2X -= bee2Speed;
                if ((animTick % 32U) >> 4U == 1U)
                    bee2Y += 8U;
                else
                    bee2Y -= 8U;
            }
            break;
    }

    if (bee1X > 720U)
        bee1X = 750U;
    if (bee2X > 720U)
        bee2X = 750U;
}

static void calcPhysics()
{
    // Hypothetical coords that include velocity changes
    x = pastelX + pastelXVel;
    y = pastelY + pastelYVel;

    pastelBottomBound = (pastelY + PASTEL_BOTTOM_OFFSET) >> 5U;
    pastelLeftBound = (x - 32U - PASTEL_LEFT_OFFSET) >> 5U;
    pastelRightBound = (x - 32U + PASTEL_RIGHT_OFFSET) >> 5U;

    UINT8 collided = TRUE;
    if (x < LEFT_BOUND)
    {
        x = LEFT_BOUND;
        collided = TRUE;
    }
    else
    {
        // Check for left wall collisions
        l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
        l >>= 4U;
        if (l != 4U && l != 5U)  // ~Top left pixel can move left
        {
            l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
            l >>= 4U;
            if (l != 4U && l != 5U)  // ~Bottom left pixel can move left
            {
                collided = FALSE;
            }
        }
    }
    if (collided == TRUE)
    {
        pastelXVel = 0U;
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
        l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
        l >>= 4U;
        if (l != 4U && l != 5U)  // ~Top right pixel can move right
        {
            l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
            l >>= 4U;
            if (l != 4U && l != 5U)  // ~Bottom right pixel can move right
            {
                collided = FALSE;
                pastelX += pastelXVel;
            }
        }
    }
    if (collided == TRUE)
    {
        pastelXVel = 0U;
    }

    x = pastelX;
    pastelLeftBound = (x - 32U - (PASTEL_LEFT_OFFSET >> 1U)) >> 5U;
    pastelRightBound = (x - 32U + (PASTEL_RIGHT_OFFSET >> 1U)) >> 5U;
    if (pastelState == AIRBORNE)
    {
        // Check for floor collisions
        collided = TRUE;
        l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
        l >>= 4U;
        if (l != 4U && l != 5U)  // Right foot can move down
        {
            l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
            l >>= 4U;
            if (l != 4U && l != 5U)  // Left foot can move down
            {
                pastelY = y;
                collided = FALSE;
                // Apply accelerations
                pastelYVel += 1;  // Gravity
                if (pastelYVel > PASTEL_MAX_YVEL)
                    pastelYVel = PASTEL_MAX_YVEL;
            }
        }
        if (collided == TRUE)
        {
            pastelState = IDLE;
            jumpTimer = 0U;
            pastelXVel = 0U;
            pastelY = ((pastelBottomBound << 5U) - PASTEL_BOTTOM_OFFSET - 12U);
        }
    }
    else if (pastelState == WALKING)
    {
        // Apply gravity if needed
        l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound + 1U);
        l >>= 4U;
        if (l != 4U && l != 5U)  // Right foot can move down
        {
            l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound + 1U);
            l >>= 4U;
            if (l != 4U && l != 5U)  // Left foot can move down
            {
                pastelState = AIRBORNE;
                pastelYVel = 0;
            }
        }
    }
}

static UINT8 checkBeeCollision()
{
    // Would && all of these together, but I don't trust the compiler to use lazy evaluation
    if (pastelX - 16U < bee1X + 28U)
    {
        if (pastelX + 16U > bee1X - 28U)
        {
            if (pastelY + 40U < bee1Y + 44U)
            {
                if (pastelY + 120U > bee1Y + 20U)
                {
                    return TRUE;
                }
            }
        }
    }
    if (pastelX - 16U < bee2X + 28U)
    {
        if (pastelX + 16U > bee2X - 28U)
        {
            if (pastelY + 40U < bee2Y + 44U)
            {
                if (pastelY + 120U > bee2Y + 20U)
                {
                    return TRUE;
                }
            }
        }
    }

    return FALSE;
}


/******************************** DISPLAY METHODS ********************************/
static void animateBees()
{
    animFrame = (animTick >> 3U) % 2U;

    move_metasprite(bownlySprBee_metasprites[animFrame], SPRTILE_BEE, SPRID_BEE1, bee1X >> 2U, bee1Y >> 2U);
    move_metasprite(bownlySprBee_metasprites[animFrame], SPRTILE_BEE, SPRID_BEE2, bee2X >> 2U, bee2Y >> 2U);
}

static void animatePastel()
{
    switch (pastelState)
    {
        case IDLE:
        default:
            animFrame = (animTick >> 4U) % 2U;
            break;
        case WALKING:
            animFrame = ((animTick >> 3U) % 4U) + 3U;
            if (animFrame == 6U)
                animFrame = 4U;
            break;
        case AIRBORNE:
            if (pastelYVel < 0)
                animFrame = 10U;
            else
                animFrame = 11U;
            break;
        case DEAD:
            if (++deadTimer < 7U)
                animFrame = 14U;
            else if (++deadTimer < 21U)
                animFrame = 15U;
            else
                animFrame = 0xFFU;
            break;
    }
    if (animFrame == 0xFFU)  // Yeah, this is sloppy. Whatever
    {
        hide_metasprite(bownlySprPastel_metasprites[0U], SPRTILE_PASTEL);
    }
    else
    {
        if (pastelFlipX == TRUE)
            move_metasprite_vflip(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
        else
            move_metasprite(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
    }
}


/********************************** SFX METHODS **********************************/
static void sfxBleep()
{
    NR10_REG = 0x34U;
    NR11_REG = 0x70U;
    NR12_REG = 0xF0U;
    NR13_REG = 0xBAU;
    NR14_REG = 0xC6U;
}

static void sfxDing()
{
    NR21_REG = 0x80U;
    NR22_REG = 0x73U;
    NR23_REG = 0x9FU;
    NR24_REG = 0xC7U;
}

static void sfxHurt()
{
    NR41_REG = 0x03U;
    NR42_REG = 0xF0U;
    NR43_REG = 0x5FU;
    NR44_REG = 0xC0U;
}
