#include <gb/gb.h>
#include <rand.h>

#include "../../Shared/common.h"
#include "../../Shared/enums.h"
#include "../../Shared/fade.h"
#include "../../Shared/songPlayer.h"

#include "../enums.h"
#include "../sfx.h"
#include "../res/maps/bownlyPastelBkg1Map.h"
#include "../res/maps/bownlyPastelBkg2Map.h"
#include "../res/maps/bownlyPastelBkg3Map.h"
#include "../res/maps/bownlyPastelTreeMap.h"
#include "../res/sprites/bownlySprJumppuff.h"
#include "../res/sprites/bownlySprPastel.h"
#include "../res/tiles/bownlyPastelBkgTiles.h"
#include "../res/tiles/bownlyPastelHeartTiles.h"
#include "../res/tiles/bownlyPastelTreeTiles.h"

extern const hUGESong_t bownlyVictoryLapSong;

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

UINT16 x;
UINT16 y;
UINT16 pastelX;
UINT16 pastelY;
INT8 pastelXVel;
INT8 pastelYVel;
PASTELSTATE pastelstate;
UINT8 heartCount = 0U;
UINT8 pastelFlipX = FALSE;
UINT8 xSpeedWalking;
UINT8 xSpeedInAir;
UINT8 ySpeedJumping;
UINT8 jumpTimer;
UINT8 JUMP_DURATION = 8U;

UINT8 jumppuffX;
UINT8 jumppuffY;
UINT8 jumppuffTimer = 7U;
#define JUMPPUFF_DURATION 7U

#define SPRID_PASTEL 0U
#define SPRID_JUPMPUFF 10U
#define SPRTILE_PASTEL 0U
#define SPRTILE_JUMPPUFF SPRTILE_PASTEL + bownlySprPastel_TILE_COUNT
#define BKGID_HEART 0x60U

#define LEFT_BOUND 48U
#define RIGHT_BOUND 652U
#define PASTEL_TOP_OFFSET 0U
#define PASTEL_BOTTOM_OFFSET 48U
#define PASTEL_LEFT_OFFSET 12U
#define PASTEL_RIGHT_OFFSET 12U
#define PASTEL_MAX_YVEL 32U


/* SUBSTATE METHODS */
void phasePastelInit();
void phasePastelLoop();

/* INPUT METHODS */
void inputsPastel();

/* HELPER METHODS */
void calcPhysics();
UINT8 checkIsGrounded();
UINT8 checkHeartCollision();

/* DISPLAY METHODS */
void animateHearts();
void animatePastel();


void bownlyPastelMicrogameMain()
{
    curJoypad = joypad();

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
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phasePastelInit()
{
    // Initializations
    animTick = 0U;
    pastelX = 336U;
    pastelY = 320U;
    pastelXVel = 0U;
    pastelYVel = 0U;
    ySpeedJumping = 12U;
    jumpTimer = 0U;

    pastelstate = IDLE;
    pastelstate = AIRBORNE;
    pastelFlipX = FALSE;
    heartCount = 0U;

    jumppuffX = 0U;
    jumppuffY = 0U;
    jumppuffTimer = 0U;

    xSpeedWalking = 6U + (mgSpeed << 1U);
    xSpeedInAir = 6U + (mgSpeed << 1U);


    // Bkg setup
    set_bkg_data(0x3FU, 30U, bownlyPastelBkgTiles);
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
    set_bkg_data(BKGID_HEART, 1U, &bownlyPastelHeartTiles[0U]);
    set_bkg_data(0x70U, 42U, bownlyPastelTreeTiles);

    switch (mgDifficulty)
    {
        default:
        case 0U:
            // Map
            set_bkg_tiles(0U, 13U, 20U, 5U, bownlyPastelBkg1Map);

            // Tree(s)
            set_bkg_tiles(0U, 3U, 6U, 10U, bownlyPastelTreeMap);

            // Hearts
            set_bkg_tile_xy(6U, 8U + getRandUint8(5U), BKGID_HEART);
            set_bkg_tile_xy(12U, 6U + getRandUint8(6U), BKGID_HEART);
            set_bkg_tile_xy(17U, 9U + getRandUint8(4U), BKGID_HEART);
            break;
        case 1U:
            // Map
            set_bkg_tiles(0U, 10U, 20U, 8U, bownlyPastelBkg2Map);

            // Tree(s)
            set_bkg_tiles(3U, 3U, 6U, 10U, bownlyPastelTreeMap);

            // Hearts
            set_bkg_tile_xy(1U, 8U + getRandUint8(5U), BKGID_HEART);
            set_bkg_tile_xy(9U, 5U + getRandUint8(4U), BKGID_HEART);
            set_bkg_tile_xy(14U, 6U + getRandUint8(4U), BKGID_HEART);
            set_bkg_tile_xy(18U, 9U + getRandUint8(4U), BKGID_HEART);
            break;
        case 2U:
            // Map
            set_bkg_tiles(0U, 6U, 20U, 11U, bownlyPastelBkg3Map);

            // Tree(s)
            set_bkg_tiles(30U, 2U, 6U, 10U, bownlyPastelTreeMap);
            set_bkg_tiles(17U, 2U, 6U, 10U, bownlyPastelTreeMap);

            // Hearts
            set_bkg_tile_xy(2U, 0U + getRandUint8(5U), BKGID_HEART);
            set_bkg_tile_xy(6U, 1U + getRandUint8(5U), BKGID_HEART);
            set_bkg_tile_xy(9U, 2U + getRandUint8(6U), BKGID_HEART);
            set_bkg_tile_xy(14U, 3U + getRandUint8(6U), BKGID_HEART);
            set_bkg_tile_xy(17U, 5U + getRandUint8(4U), BKGID_HEART);
            break;
    }

    playSong(&bownlyVictoryLapSong);

    fadein();
    substate = SUB_LOOP;
}

void phasePastelLoop()
{
    hide_metasprite(bownlySprPastel_metasprites[animFrame % 16U], SPRTILE_PASTEL);
    ++animTick;

    inputsPastel();
    calcPhysics();
    if (checkHeartCollision() == TRUE)
    {
        ++heartCount;
        if (heartCount == mgDifficulty + 3U)
            mgStatus = WON;
        playDingSfx();
    }
    
    animatePastel();
    animateHearts();

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
void inputsPastel()
{
    // Movement
    if (curJoypad & J_LEFT)
    {
        if (pastelX != LEFT_BOUND)
        {
            switch (pastelstate)
            {
                case IDLE:
                case WALKING:
                    pastelstate = WALKING;
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
            switch (pastelstate)
            {
                case IDLE:
                case WALKING:
                    pastelstate = WALKING;
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
        if (pastelstate == WALKING)
            pastelstate = IDLE;
        pastelXVel = 0;
    }

    // Jumping
    if (curJoypad & J_A)
    {
        if ((pastelstate == IDLE || pastelstate == WALKING) && !(prevJoypad & J_A))  // Start jump
        {
            ++jumpTimer;
            pastelYVel = -ySpeedJumping;
            pastelstate = AIRBORNE;
            jumppuffTimer = 0U;
            jumppuffX = pastelX >> 2U;
            jumppuffY = ((pastelY + PASTEL_BOTTOM_OFFSET + 4U) >> 2U) + 10U;
            playBleepSfx();
        }
        else if (pastelstate == AIRBORNE && jumpTimer != JUMP_DURATION)  // Continue jump
        {
            ++jumpTimer;
            pastelYVel = -ySpeedJumping;
        }
    }
    else if (pastelstate == AIRBORNE)
    {
        jumpTimer = JUMP_DURATION;
    }
}


/******************************** HELPER METHODS *********************************/
void calcPhysics()
{
    // Hypothetical coords that include velocity changes
    x = pastelX + pastelXVel;
    y = pastelY + pastelYVel;

    INT8 pastelBottomBound = (pastelY + PASTEL_BOTTOM_OFFSET) >> 5U;
    INT8 pastelLeftBound = (x - 32U - PASTEL_LEFT_OFFSET) >> 5U;
    INT8 pastelRightBound = (x - 32U + PASTEL_RIGHT_OFFSET) >> 5U;

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
    if (pastelstate == AIRBORNE)
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
            pastelstate = IDLE;
            jumpTimer = 0U;
            pastelXVel = 0U;
            pastelY = ((pastelBottomBound << 5U) - PASTEL_BOTTOM_OFFSET - 12U);
        }
    }
    else if (pastelstate == WALKING)
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
                pastelstate = AIRBORNE;
                pastelYVel = 0;
            }
        }
    }
}

UINT8 checkHeartCollision()
{
    y = (pastelY >> 5U) - 1U;  // Her top tiles
    INT8 pastelLeftBound = (pastelX - 32U - PASTEL_LEFT_OFFSET) >> 5U;
    INT8 pastelRightBound = (pastelX - 32U + PASTEL_RIGHT_OFFSET) >> 5U;

    for (j = 0U; j != 3U; ++j)
    {
        l = get_bkg_tile_xy(pastelRightBound, y + j);
        if (l == BKGID_HEART)
        {
            set_bkg_tile_xy(pastelRightBound, y + j, 0x3FU);
            return TRUE;
        }
        l = get_bkg_tile_xy(pastelLeftBound, y + j);
        if (l == BKGID_HEART)
        {
            set_bkg_tile_xy(pastelLeftBound, y + j, 0x3FU);
            return TRUE;
        }
    }
    return FALSE;
}


/******************************** DISPLAY METHODS ********************************/
void animateHearts()
{
    set_bkg_data(BKGID_HEART, 1U, &bownlyPastelHeartTiles[((animTick >> 3U) % 2U) << 4U]);
}

void animatePastel()
{
    switch (pastelstate)
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
    }
    if (pastelFlipX == TRUE)
        move_metasprite_vflip(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
    else
        move_metasprite(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
}
