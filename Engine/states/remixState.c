#include <gb/gb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"

#include "../database/microgameData.h"
#include "../res/sprites/engineCartArts.h"
#include "../res/tiles/engineCursorTiles.h"

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
extern Microgame mgCurrentMG;

extern UINT8 animTick;
extern UINT8 animFrame;

UINT8 highlightedMG;
#define CARTS_X_ANCHOR 3U  // The bkg tile index of the leftmost cart
#define CARTS_Y_ANCHOR 1U  // The bkg tile index of the topmost cart


/* SUBSTATE METHODS */
void phaseRemixInit();
void phaseRemixLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */
static void animateCursor();
static void updateCursorLocation();
static void updateMicrogameText();


void remixStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseRemixInit();
            break;
        case SUB_LOOP:
            phaseRemixLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseRemixInit()
{
    // Initializations
    init_bkg(0xFFU);
    animTick = 0U;
    HIDE_WIN;
    mgCurrentMG.id = 0xFF;
    m = 0U;
    n = 0U;
    highlightedMG = 0U;

    // Cursor setup
    set_sprite_data(0U, 3U, engineCursorTiles);
    set_sprite_tile(0U, 0U);
    animateCursor();
    updateCursorLocation();

    // Outlines
    drawPopupWindow(2U, 0U, 15U, 12U);
    for (i = 0U; i != 20U; ++i)
    {
        set_bkg_tile_xy(i, 13U, 0xF1U);
        // set_bkg_tile_xy(i, 12, 0xF6U);
    }

    // Grid
    set_bkg_data(0x40, engineCartArts_TILE_COUNT, engineCartArts_tiles);
    for (i = 0U; i != 5U; ++i)
    {
        for (j = 0U; j != 4U; ++j)
            set_bkg_tiles(3U + i * 3U, 1U + j * 3U, 2U, 2U, engineCartArts_map + (i+j*5U) *4U);
    }

    updateMicrogameText();

    substate = SUB_LOOP;
    fadein();
}

void phaseRemixLoop()
{
    ++animTick;
    
    // if ((animTick % 64U) / 48U == 0U)
    // {
    //     printLine(4U, 13U, "PRESS START", FALSE);
    // }
    // else
    // {
    //     for (i = 4U; i != 15U; ++i)
    //         set_bkg_tile_xy(i, 13U, 0xFFU);
    // }

    // inputsRemix();
    animateCursor();

    if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT))
    {
        if (m-- == 0U)
            m = 4U;
        // highlightedMG += 19U;
        // highlightedMG %= 20U;
        updateCursorLocation();
    }
    else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT))
    {
        if (++m == 5U)
            m = 0U;
        // highlightedMG += 1U;
        // highlightedMG %= 20U;
        updateCursorLocation();
    }
    
    if (curJoypad & J_UP && !(prevJoypad & J_UP))
    {
        if (n-- == 0U)
            n = 3U;
        // highlightedMG += 15U;
        // highlightedMG %= 20U;
        updateCursorLocation();
    }
    else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN))
    {
        if (++n == 4U)
            n = 0U;
        // highlightedMG += 5U;
        // highlightedMG %= 20U;
        updateCursorLocation();
    }

    if (curJoypad & (0b00001111))  // And dpad direction
    {
        highlightedMG = n * 5U + m;
        updateMicrogameText();
    }



    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        if (highlightedMG != 19U)
        {
            fadeout();
            initrand(DIV_REG);

            mgCurrentMG.id = highlightedMG;
            mgCurrentMG.bankId = microgameDex[r].bankId;
            mgCurrentMG.namePtr = microgameDex[r].namePtr;
            mgCurrentMG.bylinePtr = microgameDex[r].bylinePtr;
            mgCurrentMG.instructionsPtr = microgameDex[r].instructionsPtr;
            mgCurrentMG.duration = microgameDex[r].duration;
            
            gamestate = STATE_MICROGAME_MANAGER;
            substate = MGM_INIT_SINGLE;
            mgStatus = PLAYING;
        }
    }

    if (curJoypad & J_SELECT && !(prevJoypad & J_SELECT))
    {
        // Read value from SRAM
        // if white, blacken
        // else whiten
        // Write to SRAM
    }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        fadeout();
        initrand(DIV_REG);
        // move_bkg(0U, 0U);

        gamestate = STATE_MICROGAME_MANAGER;
        substate = SUB_INIT;
        mgStatus = PLAYING;
    }
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
static void animateCursor()
{
    animFrame = (animTick >> 4U) % 4U;
    if (animFrame == 3U)
        animFrame = 1U;  // We want the pattern to be 0, 1, 2, 1, ad infinitum

    set_sprite_tile(0U, animFrame);
}

static void updateCursorLocation()
{
    // CARTS_X_ANCHOR's unit of measurement is tiles, sprites operate on the unit of pixels
    // The "<< 3U" is there to convert from tiles to pixels
    // The "+ 13U" and "+ 9U" are to center the cursor over the carts
    i = ((CARTS_X_ANCHOR + (m * 3U)) << 3U) + 13U;
    j = ((CARTS_Y_ANCHOR + (n * 3U)) << 3U) + 9U;

    move_sprite(0U, i, j);
}

static void updateMicrogameText()
{
    fill_bkg_rect(2U, 14U, 18U, 4U, 0xFF);

    if (highlightedMG == 19U)  // Instructions cart
    {
        printLine(2U, 14U, "INSTRUCTIONS", FALSE);
        printLine(2U, 15U, "A: PLAY MICROGAME", FALSE);
        printLine(2U, 16U, "SELECT: TOGGLE MG", FALSE);
        printLine(2U, 17U, "HAVE FUN!", FALSE);
    }
    else
    {
        printLine(2U, 14U, "HIGH SCORE:", FALSE);

        printLine(2U, 15U, microgameDex[highlightedMG].namePtr, FALSE);
        printLine(2U, 16U, microgameDex[highlightedMG].bylinePtr, FALSE);
        // mgCurrentMG.bylinePtr = microgameDex[r].bylinePtr;

        // Fetch high score data
        // Update high score text
    }
}