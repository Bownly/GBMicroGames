#include <gb/gb.h>
#include <rand.h>
#include <string.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../ram.h"
#include "../songPlayer.h"

#include "../database/microgameData.h"
#include "../res/sprites/engineCartArts.h"
#include "../res/tiles/engineCursorTiles.h"
#include "../res/tiles/engineMixBorderTiles.h"
#include "../res/tiles/engineScrollBkgTiles.h"
#include "../res/tiles/fontTiles.h"

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
#define BKGTILE_CARTS 0x40U
#define BKGTILE_SCROLL 0xF9U
#define SPRTILE_MIX_BORDER 0x10U

unsigned char bkgTile[16U];


/* SUBSTATE METHODS */
void phaseRemixInit();
void phaseRemixLoop();

/* INPUT METHODS */
static void inputsRemix();

/* HELPER METHODS */

/* DISPLAY METHODS */
static void animateCursor();
static void drawPlayMixButton();
static void scrollBkg();
static void setVisualToggleStatus(UINT8, UINT8);
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
    init_bkg(BKGTILE_SCROLL);
    animTick = 0U;
    HIDE_WIN;
    mgCurrentMG.id = 0x00;
    m = 0U;
    n = 0U;
    highlightedMG = 0U;

    // Cursor setup
    set_sprite_data(0U, 3U, engineCursorTiles);
    set_sprite_tile(0U, 0U);
    set_sprite_prop(0U, 0b00010000);
    animateCursor();
    updateCursorLocation();

    // Scrolling background setup
    set_bkg_data(BKGTILE_SCROLL, 4U, engineScrollBkgTiles);

    // Play remix button border sprites setup
    set_sprite_data(SPRTILE_MIX_BORDER, 16U, engineMixBorderTiles);
    drawPlayMixButton();

    // Outlines
    drawPopupWindow(2U, 0U, 15U, 12U);
    for (i = 0U; i != 20U; ++i)
    {
        set_bkg_tile_xy(i, 13U, 0xF1U);
    }
    fill_bkg_rect(0U, 14U, 20U, 5U, 0xFFU);

    // Grid
    set_bkg_data(BKGTILE_CARTS, engineCartArts_TILE_COUNT, engineCartArts_tiles);
    k = 0;
    for (j = 0U; j != 4U; ++j)
    {
        for (i = 0U; i != 5U; ++i)
        {
            set_bkg_tiles(CARTS_X_ANCHOR + i * 3U, CARTS_Y_ANCHOR + j * 3U, 2U, 2U, engineCartArts_map + (k << 2U));
            
            // Cart toggled status
            ENABLE_RAM;
            l = loadMGToggle(k);
            DISABLE_RAM;
            setVisualToggleStatus(k, l);

            ++k;
        }
    }

    updateMicrogameText();

    substate = SUB_LOOP;
        
    fadein();
    OBP0_REG = 0x81;  // Light-ish

    playOutsideSong(BOOGIE_WOOGIE);
}

void phaseRemixLoop()
{
    ++animTick;
    
    animateCursor();
    scrollBkg();
    inputsRemix();
}

/******************************** INPUT METHODS *********************************/
static void inputsRemix()
{
    if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT))
    {
        if (m-- == 0U)
            m = 5U;
        updateCursorLocation();
    }
    else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT))
    {
        if (++m == 6U)
            m = 0U;
        updateCursorLocation();
    }
    
    if (curJoypad & J_UP && !(prevJoypad & J_UP))
    {
        if (n-- == 0U)
            n = 3U;
        updateCursorLocation();
    }
    else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN))
    {
        if (++n == 4U)
            n = 0U;
        updateCursorLocation();
    }

    if (curJoypad & (0b00001111))  // Any dpad direction
    {
        if (m == 5U)
        {
            OBP0_REG = 0xD2;  // 11 10 01 00
        }
        else
        {
            OBP0_REG = 0x81;  // Light-ish
            highlightedMG = n * 5U + m;
        }
        updateMicrogameText();
    }

    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        if (m == 5U)  // Play mix
        {
            fadeout();
            initrand(DIV_REG);
            gamestate = STATE_MICROGAME_MANAGER;
            substate = MGM_INIT_REMIX;
            mgStatus = PLAYING;
            stopSong();
        }
        else
        {
            if (highlightedMG == 19U)
            {
                highlightedMG = getRandUint8(19U);
            }

            fadeout();
            initrand(DIV_REG);

            mgCurrentMG.id = highlightedMG;
            mgCurrentMG.bankId = microgameDex[highlightedMG].bankId;
            mgCurrentMG.namePtr = microgameDex[highlightedMG].namePtr;
            mgCurrentMG.bylinePtr = microgameDex[highlightedMG].bylinePtr;
            mgCurrentMG.instructionsPtr = microgameDex[highlightedMG].instructionsPtr;
            mgCurrentMG.duration = microgameDex[highlightedMG].duration;
            
            gamestate = STATE_MICROGAME_MANAGER;
            substate = MGM_INIT_SINGLE;
            mgStatus = PLAYING;
            stopSong();
        }
    }

    if (curJoypad & J_SELECT && !(prevJoypad & J_SELECT))
    {
        if (highlightedMG == 19U) {} // Instructions cart
        else if (m == 5U) {} // Play mix button        
        else
        {
            // Read value from SRAM
            ENABLE_RAM;
            k = loadMGToggle(highlightedMG);

            // Toggle and save
            k = (k + 1U) % 2U;
            saveMGToggle(highlightedMG, k);  // Write to SRAM
            DISABLE_RAM;

            setVisualToggleStatus(highlightedMG, k);
        }
    }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        fadeout();
        initrand(DIV_REG);

        gamestate = STATE_MICROGAME_MANAGER;
        substate = SUB_INIT;
        mgStatus = PLAYING;
        stopSong();
    }
}


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
static void animateCursor()
{
    animFrame = (animTick >> 4U) % 4U;
    if (animFrame == 3U)
        animFrame = 1U;  // We want the pattern to be 0, 1, 2, 1, ad infinitum

    set_sprite_tile(0U, animFrame);
}

static void drawPlayMixButton()
{
    #define BUTTON_X_COORD 144U
    #define BUTTON_Y_COORD 32U

    // Draw top row
    set_sprite_tile(1U, SPRTILE_MIX_BORDER);
    set_sprite_tile(2U, SPRTILE_MIX_BORDER + 1U);
    set_sprite_tile(3U, SPRTILE_MIX_BORDER + 2U);
    move_sprite(1U, BUTTON_X_COORD, BUTTON_Y_COORD - 8U);
    move_sprite(2U, BUTTON_X_COORD + 8U, BUTTON_Y_COORD - 8U);
    move_sprite(3U, BUTTON_X_COORD + 16U, BUTTON_Y_COORD - 8U);

    // Draw walls
    for (j = 0U; j != 8U; ++j)
    {
        set_sprite_tile(4U + j, SPRTILE_MIX_BORDER + 3U);
        set_sprite_tile(12U + j, SPRTILE_MIX_BORDER + 4U);
        move_sprite(4U + j, BUTTON_X_COORD, BUTTON_Y_COORD + (j << 3U));
        move_sprite(12U + j, BUTTON_X_COORD + 16U, BUTTON_Y_COORD + (j << 3U));
    }

    // Draw bottom row
    set_sprite_tile(20U, SPRTILE_MIX_BORDER + 5);
    set_sprite_tile(21U, SPRTILE_MIX_BORDER + 6U);
    set_sprite_tile(22U, SPRTILE_MIX_BORDER + 7U);
    move_sprite(20U, BUTTON_X_COORD, BUTTON_Y_COORD + 64U);
    move_sprite(21U, BUTTON_X_COORD + 8U, BUTTON_Y_COORD + 64U);
    move_sprite(22U, BUTTON_X_COORD + 16U, BUTTON_Y_COORD + 64U);

    // Text
    for (j = 0U; j != 9; ++j)
    {
        set_sprite_tile(23U + j, SPRTILE_MIX_BORDER + 8U + j);
        move_sprite(23U + j, BUTTON_X_COORD + 8U, BUTTON_Y_COORD + (j << 3U));
    }
}


static void scrollBkg()
{
    set_bkg_data(BKGTILE_SCROLL, 1U, engineScrollBkgTiles + ((animTick % 32U) >> 3U) * 16);
}

static void setVisualToggleStatus(UINT8 cartId, UINT8 status)
{
    // Blacken or whiten as approriate
    if (status == 0U)  // Whiten
    {
        get_bkg_data(BKGTILE_CARTS + (cartId << 2U), 1U, bkgTile);
        bkgTile[3U] = 0x80U;
        bkgTile[5U] = 0x80U;
        set_bkg_data(BKGTILE_CARTS + (cartId << 2U), 1U, bkgTile);
        get_bkg_data(BKGTILE_CARTS + (cartId << 2U) + 1U, 1U, bkgTile);
        bkgTile[3U] = 0x03U;
        bkgTile[5U] = 0x01U;
        set_bkg_data(BKGTILE_CARTS + (cartId << 2U) + 1U, 1U, bkgTile);
    }
    else  // Blacken
    {
        get_bkg_data(BKGTILE_CARTS + (cartId << 2U), 1U, bkgTile);
        bkgTile[3U] = 0xFFU;
        bkgTile[5U] = 0xFFU;
        set_bkg_data(BKGTILE_CARTS + (cartId << 2U), 1U, bkgTile);
        get_bkg_data(BKGTILE_CARTS + (cartId << 2U) + 1U, 1U, bkgTile);
        bkgTile[3U] = 0xFFU;
        bkgTile[5U] = 0xFFU;
        set_bkg_data(BKGTILE_CARTS + (cartId << 2U) + 1U, 1U, bkgTile);
    }
}

static void updateCursorLocation()
{
    if (m != 5U)
    {
        // CARTS_X_ANCHOR's unit of measurement is tiles, sprites operate on the unit of pixels
        // The "<< 3U" is there to convert from tiles to pixels
        // The "+ 13U" and "+ 9U" are to center the cursor over the carts
        i = ((CARTS_X_ANCHOR + (m * 3U)) << 3U) + 13U;
        j = ((CARTS_Y_ANCHOR + (n * 3U)) << 3U) + 9U;        
    }
    else 
    {
        i = 0U;
        j = 0U;
    }
    move_sprite(0U, i, j);
}

static void updateMicrogameText()
{
    fill_bkg_rect(2U, 14U, 18U, 4U, 0xFF);

    if (highlightedMG == 19U)  // Instructions cart
    {
        printLine(2U, 14U, "INSTRUCTIONS", FALSE);
        printLine(2U, 15U, "A: PLAY MICROGAME", FALSE);
        printLine(2U, 16U, "SELECT: TOGGLE A", FALSE);
        printLine(2U, 17U, " MICROGAME ON/OFF", FALSE);
    }
    else if (m == 5U)  // Play mix button
    {
        printLine(2U, 15U, "PLAY YOUR OWN", FALSE);
        printLine(2U, 16U, "CUSTOM MIX", FALSE);
    }
    else
    {
        printLine(2U, 14U, "HIGH SCORE:", FALSE);

        printLine(2U, 15U, microgameDex[highlightedMG].namePtr, FALSE);
        printLine(2U, 16U, microgameDex[highlightedMG].bylinePtr, FALSE);

        // Fetch high score data
        ENABLE_RAM;
        k = loadMGScore(highlightedMG);
        DISABLE_RAM;

        // Update high score text
        set_bkg_tile_xy(13U, 14U, k / 100U);
        set_bkg_tile_xy(14U, 14U, (k / 10U) % 10U);
        set_bkg_tile_xy(15U, 14U, k % 10U);
    }
}