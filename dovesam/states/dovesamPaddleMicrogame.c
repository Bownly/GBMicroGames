/* Juggle the ball and don't let it drop!
// Left and right to move the paddle
// The ball bounces off the top, left and right walls
// Lose if the ball makes it past the paddle
*/

#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../res/assets/dovesamPaddleSprite.h"
#include "../res/assets/dovesamBallSprite.h"
#include "../res/maps/dovesamPaddleArena.h"

//extern const hUGESong_t dovesamTwilightDriveSong;

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

/* Use uint16_t for sub-pixel accuracy - scale factor is 16 */
static UINT16 paddleX;
static UINT16 paddleY;
static UINT16 paddleSpeed;

static UINT16 ballX;
static UINT16 ballY;
static INT16 bspeedX;
static INT16 bspeedY;

#define VRAM_SAFE_START 0x30

#define SPRID_PADDLE 0U
#define SPRID_BALL 5U

#define SPRTILE_PADDLE 0x00U
#define SPRTILE_BALL SPRTILE_PADDLE + dovesamPaddleSprite_TILE_COUNT

#define SPRTILE_CURSOR 0x00U  // The location in the sprite tile memory where the cursor sprite tiles will be written to
#define BKGTILE_TestS 0x40U  // The location in the bkg tile memory where the Test tiles will be written to
#define TestsXAnchor 3U  // The bkg tile index of the leftmost Test(s)
#define TestsYAnchor 3U  // The bkg tile index of the topmost Test(s)

#define PADDLE_LEFT_LIMIT 24U
#define PADDLE_RIGHT_LIMIT 148U

#define SUBPIXEL_DRAW( x ) ( x >> 4 )

#define COLLISION_TOP (28U << 4)
#define COLLISION_BOTTOM (126U << 4) //130 - (paddleHeight / 2)
#define COLLISION_LOSE (150U << 4)
#define COLLISION_LEFT (18U << 4)
#define COLLISION_RIGHT (156U << 4)
#define PADDLE_WIDTH ( 20U << 4 )

/* SUBSTATE METHODS */
static void phaseTestInit();
static void phaseTestLoop();

/* INPUT METHODS */
static void inputsTest();

/* HELPER METHODS */
static void updateBall();

/* DISPLAY METHODS */
static void updatePaddlePos();


void dovesamPaddleMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseTestInit();
            break;
        case SUB_LOOP:
            phaseTestLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
static void phaseTestInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;

    paddleX = 75U << 4;
    paddleY = 130U << 4;
    paddleSpeed = 24U;//2U << 4;

    //ballX = 50U << 4;
    ballX = ( 20U + getRandUint8(50U) ) << 4;
    ballY = 50U << 4;
    bspeedX = getRandUint8(16U);
    bspeedX = ( getRandUint8(10U) % 2 == 0 ) ? bspeedX : bspeedX * -1;
    //bspeedY = ( -20 + getRandUint8(6U) );
    bspeedY = -20U - ( 3 * mgSpeed);

    /* Start out winning, lose if we drop the ball */
    mgStatus = WON;

    // Set background tiles
    set_bkg_data( VRAM_SAFE_START, dovesamPaddleArena_TILE_COUNT, dovesamPaddleArena_tiles );
    set_bkg_based_tiles( 0, 0, dovesamPaddleArena_WIDTH >> 3, dovesamPaddleArena_HEIGHT >> 3, 
        dovesamPaddleArena_map, VRAM_SAFE_START );

    // Setting up the sprites
    set_sprite_data(SPRTILE_PADDLE, dovesamPaddleSprite_TILE_COUNT, dovesamPaddleSprite_tiles );
    set_sprite_data(SPRTILE_BALL, dovesamBallSprite_TILE_COUNT, dovesamBallSprite_tiles );

    move_metasprite(dovesamPaddleSprite_metasprites[0U], SPRTILE_PADDLE, SPRID_PADDLE,
        SUBPIXEL_DRAW(paddleX), SUBPIXEL_DRAW(paddleY) );
    move_metasprite(dovesamBallSprite_metasprites[0U], SPRTILE_BALL, SPRID_BALL, 
        SUBPIXEL_DRAW(ballX), SUBPIXEL_DRAW(ballY) );

    // Integrate mgDifficulty into the game
    
    // This particular microgame doesn't impement mgSpeed. Not all microgames necessarily need to.
    // (But every microgame DOES need to account for all 3 levels of mgDifficulty.)
    // The timer moves faster with each level of mgSpeed by default, so even microgames like this one will speed up.
    // If you want to see an example of mgSpeed integration, check out the Bownly/Bow microgame.

    // Play music
    //playSong(&dovesamTwilightDriveSong);

    fadein();
    substate = SUB_LOOP;
}

static void phaseTestLoop()
{
    ++animTick;

    if (mgStatus == PLAYING || mgStatus == WON )
    {
        inputsTest();
        updateBall();  
    }
}

/******************************** INPUT METHODS *********************************/
static void inputsTest()
{
    if( (curJoypad & J_LEFT) && (SUBPIXEL_DRAW(paddleX) > PADDLE_LEFT_LIMIT ) )
    {
        paddleX -= paddleSpeed;
        updatePaddlePos();
    }
    else if( (curJoypad & J_RIGHT) && ( SUBPIXEL_DRAW(paddleX) < PADDLE_RIGHT_LIMIT ) )
    {
        paddleX += paddleSpeed;
        updatePaddlePos();
    }
}


/******************************** HELPER METHODS *********************************/
static void updateBall()
{
    /* Collision checks */
    #define HBW (4U << 4) 
    #define HPW (10U << 4)

    //Top of screen
    if( ballY <= COLLISION_TOP )
        bspeedY *= (-1);
    else if( ballY >= COLLISION_BOTTOM &&
            ( (ballX + HBW) >= (paddleX - HPW) ) &&
            ( (ballX - HBW) <= (paddleX + HPW) ) )
    {
        bspeedY *= (-1);
    }
    else if( ballY >= COLLISION_LOSE )
    {
        /* Lost! Set speed to 0 and wait for timeout */
        bspeedX = 0;
        bspeedY = 0;
        mgStatus = LOST;
    }
    
    if( ballX <= COLLISION_LEFT || ballX >= COLLISION_RIGHT )
        bspeedX *= (-1);

    /* Update ball position */
    ballX += bspeedX;
    ballY += bspeedY;

    move_metasprite( dovesamBallSprite_metasprites[0U], SPRTILE_BALL, SPRID_BALL, 
        SUBPIXEL_DRAW(ballX), SUBPIXEL_DRAW(ballY) );

    
}

/******************************** DISPLAY METHODS ********************************/
static void updatePaddlePos()
{
    move_metasprite(dovesamPaddleSprite_metasprites[0U], SPRTILE_PADDLE, SPRID_PADDLE, 
        SUBPIXEL_DRAW(paddleX), SUBPIXEL_DRAW(paddleY) );
}