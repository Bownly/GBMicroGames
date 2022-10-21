#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../../Shared/common.h"
#include "../../Shared/enums.h"
#include "../../Shared/fade.h"
#include "../enums.h"

#include "../res/tiles/bowBkgTiles.h"
#include "../res/sprites/bownlySprArrow.h"
#include "../res/sprites/bownlySprBow.h"
#include "../res/sprites/bownlySprTarget.h"

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

UINT8 bowX;
UINT8 bowY;
UINT8 arrowX;
UINT8 arrowY;
UINT8 targetX;
UINT8 targetY;
INT8 bowSpeed;
UINT8 arrowSpeed;
INT8 targetSpeed;
UINT8 targetsLeft;
UINT8 bowFrame;
ARROWSTATE arrowstate;

#define SPRID_BOW 0U
#define SPRID_ARROW 10U
#define SPRID_TARGET 15U

#define SPRTILE_BOW 0x00U
#define SPRTILE_ARROW SPRTILE_BOW + bownlySprBow_TILE_COUNT
#define SPRTILE_TARGET SPRTILE_ARROW + bownlySprArrow_TILE_COUNT

#define BKGTILE_GRASS 0x60U

/* SUBSTATE METHODS */
void phaseBowInit();
void phaseBowLoop();

/* INPUT METHODS */
void inputsShoot();

/* HELPER METHODS */
void spawnTarget();

/* DISPLAY METHODS */


void bownlyBowMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseBowInit();
            break;
        case SUB_LOOP:
            phaseBowLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseBowInit()
{
    // Initializations
    setBlankBkg();
    animTick = 0U;

    bowX = 150U;
    bowY = 50U;
    arrowX = 150U;
    arrowY = 49U;
    targetX = 24U;
    targetY = 80U;
    bowSpeed = 2U + mgSpeed;
    arrowSpeed = 4U + mgSpeed;
    targetSpeed = -1 - mgSpeed;
    targetsLeft = 1U;
    bowFrame = 1U;
    arrowstate = NOCKED;
    
    // Setting up the background
    set_bkg_data(BKGTILE_GRASS, 6U, bowBkgTiles);
    for (i = 0U; i != 20U; ++i)
    {
        set_bkg_tile_xy(i, 16U, BKGTILE_GRASS);
        set_bkg_tile_xy(i, 17U, BKGTILE_GRASS + 1U);
    }

    // Setting up the sprites
    set_sprite_data(SPRTILE_BOW, bownlySprBow_TILE_COUNT, bownlySprBow_tiles);
    set_sprite_data(SPRTILE_ARROW, bownlySprArrow_TILE_COUNT, bownlySprArrow_tiles);
    set_sprite_data(SPRTILE_TARGET, bownlySprTarget_TILE_COUNT, bownlySprTarget_tiles);

    spawnTarget();
    move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, bowX, bowY);
    move_metasprite(bownlySprArrow_metasprites[0U], SPRTILE_BOW + bownlySprBow_TILE_COUNT, SPRID_ARROW, arrowX, arrowY);
    move_metasprite(bownlySprTarget_metasprites[0U], SPRTILE_TARGET, SPRID_TARGET, targetX, targetY);

    // Initializing stuff based on difficulty level
    if (mgDifficulty == 2U)
        targetsLeft = 2U;
    else
        targetsLeft = 1U;

    substate = SUB_LOOP;

    fadein();
    // fadein() sets the sprites to a palette that I don't want to use here
    OBP0_REG = 0xE4;  // 11 10 01 00
}

void phaseBowLoop()
{
    ++animTick;
    if (bowY >= 130U || bowY <= 40U)
        bowSpeed *= -1;
    bowY += bowSpeed;

    switch (arrowstate)
    {
        case NOCKED:
            inputsShoot();

            if (mgDifficulty != 0U)
            {
                // Target moves up and down on higher difficulties
                if (targetY >= 130U || targetY <= 40U)
                    targetSpeed *= -1;
                targetY += targetSpeed;
            }

            arrowY += bowSpeed;
            break;
        case FLYING:
            if (mgDifficulty != 0U)
            {
                // Target moves up and down on higher difficulties
                if (targetY >= 130U || targetY <= 40U)
                    targetSpeed *= -1;
                targetY += targetSpeed;
            }

            if (arrowX == 30U)
            {
                if (arrowY <= targetY + 15U && arrowY >= targetY - 15U)
                    arrowstate = HIT;
                else
                {
                    arrowX -= 1;
                    // mgStatus = LOST;
                }
            }
            else if (arrowX >= 200U)
            {
                arrowstate = NOCKED;
                bowFrame = 1U;
                arrowX = bowX;
                arrowY = bowY;
            }
            else
                arrowX -= arrowSpeed;
            break;
        case HIT:
            if (arrowX >= 200U)  // Offscreen, or close enough
            {
                if (--targetsLeft == 0U)  // End game if no more targets
                {
                    mgStatus = WON;
                
                    // Hide arrow and target
                    arrowSpeed = 0U;
                    arrowX = 190U;
                    targetX = 190U;
                }
                else // Spawn next target otherwise
                {
                    spawnTarget();
                    arrowstate = NOCKED;
                    bowFrame = 1U;
                    arrowX = bowX;
                    arrowY = bowY;
                }
            }
            else
            {
                arrowX -= arrowSpeed;
                targetX -= arrowSpeed;
            }
            break;
    }

    // Replace arrow with bow
    if (mgDifficulty == 2U && targetsLeft == 1U)
        move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, arrowX, arrowY);
    else
        move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, bowX, bowY);

    move_metasprite(bownlySprArrow_metasprites[0U], SPRTILE_ARROW, SPRID_ARROW, arrowX, arrowY);
    move_metasprite(bownlySprTarget_metasprites[0U], SPRTILE_TARGET, SPRID_TARGET, targetX, targetY);
}


/******************************** INPUT METHODS *********************************/
void inputsShoot()
{
    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        arrowstate = FLYING;
        bowFrame = 0U;
    }
}


/******************************** HELPER METHODS *********************************/
void spawnTarget()
{
    targetX = 24U;
    targetY = getRandUint(90U);  // Range of 40-130
    targetY += 40U;
}


/******************************** DISPLAY METHODS ********************************/
