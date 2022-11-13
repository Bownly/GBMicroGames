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

#include "../res/assets/dovesamPaddleSpriteSheet.h"
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
static UINT16 paddleWidth;

static UINT16 ballX;
static UINT16 ballY;
static INT16 bspeedX;
static INT16 bspeedY;


#define VRAM_SAFE_START 0x30

#define SPRID_PADDLE 0U
#define SPRID_BALL 5U

#define SPRTILE_PADDLE 0x00U
#define SPRTILE_BALL SPRTILE_PADDLE + dovesamPaddleSpriteSheet_TILE_COUNT

#define SPRTILE_CURSOR 0x00U  // The location in the sprite tile memory where the cursor sprite tiles will be written to
#define BKGTILE_TestS 0x40U  // The location in the bkg tile memory where the Test tiles will be written to
#define TestsXAnchor 3U  // The bkg tile index of the leftmost Test(s)
#define TestsYAnchor 3U  // The bkg tile index of the topmost Test(s)

#define PADDLE_LEFT_LIMIT ( 8U + 7U ) << 4
#define PADDLE_RIGHT_LIMIT ( 160U - 7U + 8U ) << 4

#define SUBPIXEL_DRAW( x ) ( x >> 4 )

#define COLLISION_TOP (28U << 4)
#define COLLISION_BOTTOM (126U << 4) //130 - (paddleHeight / 2)
#define COLLISION_LOSE (150U << 4)
#define COLLISION_LEFT (18U << 4)
#define COLLISION_RIGHT (156U << 4)
#define PADDLE_WIDTH ( 20U << 4 )

#define HPW ( paddleWidth >> 1 ) /* Half paddle width in subpixels, uint16 */
#define HBW ( 4U << 4 ) /* Half ball width, in sub-pixels */

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
    paddleSpeed = 24U;

    //ballX = 50U << 4;
    ballX = ( 20U + getRandUint8(50U) ) << 4;
    ballY = 50U << 4;
    bspeedX = 10U + getRandUint8(6U);
    bspeedX = ( getRandUint8(10U) % 2 == 0 ) ? bspeedX : bspeedX * -1;
    //bspeedY = ( -20 + getRandUint8(6U) );
    bspeedY = -25U - ( 10 * mgSpeed);

    /* Start out winning, lose if we drop the ball */
    mgStatus = WON;

    // Set background tiles
    set_bkg_data( VRAM_SAFE_START, dovesamPaddleArena_TILE_COUNT, dovesamPaddleArena_tiles );
    set_bkg_based_tiles( 0, 0, dovesamPaddleArena_WIDTH >> 3, dovesamPaddleArena_HEIGHT >> 3, 
        dovesamPaddleArena_map, VRAM_SAFE_START );

    // Setting up the sprites
    set_sprite_data(SPRTILE_PADDLE, dovesamPaddleSpriteSheet_TILE_COUNT, dovesamPaddleSpriteSheet_tiles );
    set_sprite_data(SPRTILE_BALL, dovesamBallSprite_TILE_COUNT, dovesamBallSprite_tiles );

    move_metasprite(dovesamPaddleSpriteSheet_metasprites[mgDifficulty], SPRTILE_PADDLE, SPRID_PADDLE,
        SUBPIXEL_DRAW(paddleX), SUBPIXEL_DRAW(paddleY) );
    move_metasprite(dovesamBallSprite_metasprites[0U], SPRTILE_BALL, SPRID_BALL, 
        SUBPIXEL_DRAW(ballX), SUBPIXEL_DRAW(ballY) );

    // The paddle gets smaller as mgDifficulty increases. Set paddleWidth here for collision checks etc
    switch( mgDifficulty )
    {
        case 0: paddleWidth = 30U << 4; break;
        case 1: paddleWidth = 22U << 4; break;
        case 2: paddleWidth = 14U << 4; break;
    }

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
    if( (curJoypad & J_LEFT) && //(SUBPIXEL_DRAW(paddleX) > PADDLE_LEFT_LIMIT ) )
        ( paddleX - HPW ) > PADDLE_LEFT_LIMIT )
    {
        paddleX -= paddleSpeed;
        updatePaddlePos();
    }
    else if( (curJoypad & J_RIGHT) && //( SUBPIXEL_DRAW(paddleX) < PADDLE_RIGHT_LIMIT ) )
        ( paddleX + HPW ) < PADDLE_RIGHT_LIMIT )
    {
        paddleX += paddleSpeed;
        updatePaddlePos();
    }
}


/******************************** HELPER METHODS *********************************/
static void updateBall()
{
    /* Collision checks */
//    #define HBW (4U << 4) 
//    #define HPW (10U << 4)

    //Top of screen
    if( ballY <= COLLISION_TOP )
        bspeedY *= (-1);
    // Paddle
    else if(( ballY >= COLLISION_BOTTOM ) &&
            ( ballY <= ( COLLISION_BOTTOM + (2 << 4) ) ) &&
            ( (ballX + HBW) >= (paddleX - HPW) ) &&
            ( (ballX - HBW) <= (paddleX + HPW) ) )
    {
        bspeedY *= (-1);
        /* Move the ball up a pixel, to make sure the ball is out of the collision box of
           the paddle */
        ballY -= ( 1 << 4 );
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
    move_metasprite(dovesamPaddleSpriteSheet_metasprites[mgDifficulty], SPRTILE_PADDLE, SPRID_PADDLE, 
        SUBPIXEL_DRAW(paddleX), SUBPIXEL_DRAW(paddleY) );
}