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
#include "../../Shared/songPlayer.h"

#include "../enums.h"
#include "../res/tiles/templateCursorTiles.h"
#include "../res/tiles/templateFaceTiles.h"
#include "../res/maps/templateFace1Map.h"
#include "../res/maps/templateFace2Map.h"

extern const hUGESong_t songblah;

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
    init_bkg(0xFFU);
    animTick = 0U;
    m = 0U;  // Used as the X index for the cursor, uses faces as the unit of measurement
    n = 0U;  // Used as the Y index for the cursor, uses faces as the unit of measurement

    // Integrate mgDifficulty into the game
    sadCount = mgDifficulty + 2U;  // Range of 2, 3 or 4
    // This particular microgame doesn't impement mgSpeed. Not all microgames necessarily need to.
    // (But every microgame DOES need to account for all 3 levels of mgDifficulty.)
    // The timer moves faster with each level of mgSpeed by default, so even microgames like this one will speed up.
    // If you want to see an example of mgSpeed integration, check out the Bownly/Bow microgame.

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
        i = getRandUint8(5U);  // Number of columns
        j = getRandUint8(4U);  // Number of rows

        // Checking the randomly selected face to ensure that it isn't already a sad face
        if (facesGrid[j][i] == HAPPY)
        {
            facesGrid[j][i] = SAD;
            set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace2Map);
            ++k;  // Increase the count to prevent an infinite loop
        }
    }

    // Play music
    playSong(&songblah);

    fadein();
    substate = SUB_LOOP;
}

void phaseFaceLoop()
{
    ++animTick;

    if (mgStatus == PLAYING)
    {
        inputsFace();
        animateCursor();  
    }
}

/******************************** INPUT METHODS *********************************/
void inputsFace()
{
    if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT))
    {
        // Decrement m by 1, and wrap it around to the far right if it dips below 0
        if (m-- == 0U)
            m = 4U;
        updateCursorLocation();
    }
    else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT))
    {
        // Increment m by 1, and wrap it around to the far left if it exceeds 4
        if (++m == 5U)
            m = 0U;
        updateCursorLocation();
    }
    
    if (curJoypad & J_UP && !(prevJoypad & J_UP))
    {
        // Decrement n by 1, and wrap it around to the bottom if it dips below 0
        if (n-- == 0U)
            n = 3U;
        updateCursorLocation();
    }
    else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN))
    {
        // Increment n by 1, and wrap it around to the top if it exceeds 3
        if (++n == 4U)
            n = 0U;
        updateCursorLocation();
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
    i = ((facesXAnchor + (m * 3U)) << 3U) + 12U;
    j = ((facesYAnchor + (n * 3U)) << 3U) + 9U;

    move_sprite(0U, i, j);
}
