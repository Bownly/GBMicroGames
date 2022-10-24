/* This microgame features a grid of faces. Some faces are sad, and the rest are happy.
// The player controls a cursor and has to select the sad faces.
// Pressing A on a sad face will turn it into a happy faces.
// The game is won when all sad faces are turned happy.
// The game is lost if the player turns a happy face into a sad face.
*/

#include <gb/gb.h>
#include <rand.h>

#include "../../Shared/common.h"
#include "../../Shared/enums.h"
#include "../../Shared/fade.h"

#include "../enums.h"
#include "../res/tiles/templateCursorTiles.h"
#include "../res/tiles/templateFaceTiles.h"
#include "../res/maps/templateFace1Map.h"
#include "../res/maps/templateFace2Map.h"

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

static UINT8 facesGrid[4U][5U];
static UINT8 sadCount;  // The number of currently sad faces
static UINT8 buttonHoldTick;  // How long a dpad button has been held down for
static UINT8 buttonHoldThreshold;  // How long a dpad button has to be held down for to auto scroll

#define SPRTILE_CURSOR 0x00U  // The location in the sprite tile memory where the cursor sprite tiles will be written to
#define BKGTILE_FACES 0x40U  // The location in the bkg tile memory where the face tiles will be written to
#define facesXAnchor 3U  // The bkg tile index of the leftmost face(s)
#define facesYAnchor 3U  // The bkg tile index of the topmost face(s)

/* SUBSTATE METHODS */
void phaseFaceInit();
void phaseFaceLoop();

/* INPUT METHODS */
void inputsFace();

/* HELPER METHODS */

/* DISPLAY METHODS */
void animateCursor();
void updateCursorLocation();


void templateFaceMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseFaceInit();
            break;
        case SUB_LOOP:
            phaseFaceLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseFaceInit()
{
    // Initializations
    setBlankBkg();
    animTick = 0U;
    m = 0U;  // Used as the X index for the cursor, uses faces as the unit of measurement
    n = 0U;  // Used as the Y index for the cursor, uses faces as the unit of measurement
    sadCount = mgDifficulty + 2U;  // Range of 2, 3 or 4
    buttonHoldThreshold = 12U - mgSpeed;

    // Load graphics
    set_bkg_data(BKGTILE_FACES, 8U, templateFaceTiles);
    set_sprite_data(SPRTILE_CURSOR, 3U, templateCursorTiles);

    // Setup cursor sprite
    set_sprite_tile(0U, SPRTILE_CURSOR);
    animateCursor();
    updateCursorLocation();

    // Draw the grid of faces
    for (i = 0U; i != 5U; ++i)
    {
        for (j = 0U; j != 4U; ++j)
        {
            facesGrid[j][i] = HAPPY;
            set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace1Map);
        }
    }

    // Set some faces to sad faces
    k = 0U;
    while (k != sadCount)
    {
        i = getRandUint(5U);  // Number of columns
        j = getRandUint(4U);  // Number of rows

        // Checking the randomly selected face to ensure that it isn't already a sad face
        if (facesGrid[j][i] == HAPPY)
        {
            facesGrid[j][i] = SAD;
            set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace2Map);
            ++k;  // Increase the count to prevent an infinite loop
        }
    }

    // Play music

    fadein();
    substate = SUB_LOOP;
}

void phaseFaceLoop()
{
    ++animTick;

    inputsFace();
    animateCursor();  
}

/******************************** INPUT METHODS *********************************/
void inputsFace()
{
    if (!curJoypad & (J_UP | J_DOWN | J_LEFT | J_RIGHT))
    {
        buttonHoldTick = 0U;
    }

    if(curJoypad & J_LEFT)
    {
        ++buttonHoldTick;
        if (!(prevJoypad & J_LEFT) || (buttonHoldTick % buttonHoldThreshold == 0U))
        {
            // Decrement m by 1, and wrap it around to the far right if it dips below 0
            if (m-- == 0U)
                m = 4U;
            updateCursorLocation();
        }
    }
    else if(curJoypad & J_RIGHT)
    {
        ++buttonHoldTick;
        if (!(prevJoypad & J_RIGHT) || (buttonHoldTick % buttonHoldThreshold == 0U))
        {
            // Increment m by 1, and wrap it around to the far left if it exceeds 4
            if (++m == 5U)
                m = 0U;
            updateCursorLocation();
        }
    }
    else if(curJoypad & J_UP)
    {
        ++buttonHoldTick;
        if (!(prevJoypad & J_UP) || (buttonHoldTick % buttonHoldThreshold == 0U))
        {
            // Decrement n by 1, and wrap it around to the bottom if it dips below 0
            if (n-- == 0U)
                n = 3U;
            updateCursorLocation();
        }
    }
    else if(curJoypad & J_DOWN)
    {
        ++buttonHoldTick;
        if (!(prevJoypad & J_DOWN) || (buttonHoldTick % buttonHoldThreshold == 0U))
        {
            // Increment n by 1, and wrap it around to the top if it exceeds 3
            if (++n == 4U)
                n = 0U;
            updateCursorLocation();
        }
    }

    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        if (facesGrid[n][m] == HAPPY)
        {
            mgStatus = LOST;
            // Play sad fx/music

            // Make all faces sad
            for (i = 0U; i != 5U; ++i)
            {
                for (j = 0U; j != 4U; ++j)
                {
                    facesGrid[j][i] = SAD;
                    set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace2Map);
                }
            }
        }
        else  // If face is a sad face
        {
            facesGrid[n][m] = HAPPY;
            set_bkg_tiles(facesXAnchor + (m * 3U), facesYAnchor + (n * 3U), 2U, 2U, templateFace1Map);

            if (--sadCount == 0U)
            {
                mgStatus = WON;
                // Play happy sfx/music
            }
        }
    }
}


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
void animateCursor()
{
    animFrame = (animTick >> 4U) % 4U;
    if (animFrame == 3U)
        animFrame = 1U;  // We want the pattern to be 0, 1, 2, 1, ad infinitum

    // If SPRTILE_CURSOR weren't 0, we'd add it to animFrame here
    set_sprite_tile(0U, animFrame);
}

void updateCursorLocation()
{
    // facesXAnchor's unit of measurement is tiles, sprites operate on the unit of pixels
    // The "<< 3U" is there to convert from tiles to pixels
    // The "+ 13U" and "+ 9U" are to center the cursor over the faces
    i = ((facesXAnchor + (m * 3U)) << 3U) + 13U;
    j = ((facesYAnchor + (n * 3U)) << 3U) + 9U;

    move_sprite(0U, i, j);
}
