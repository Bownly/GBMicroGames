#include <gb/gb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../ram.h"
#include "../songPlayer.h"

#include "../database/microgameData.h"
#include "../res/tiles/borderTiles.h"
#include "../res/tiles/fontTiles.h"
#include "../res/tiles/alBhedFontTiles.h"
#include "../res/sprites/engineTitleLogo.h"
#include "../res/sprites/engineTitleCornerGarnish.h"

extern const hUGESong_t engineSloopygoopPartyTheme;

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
extern UINT8 language;
extern UINT8 shouldRestartSong;

extern UINT8 animTick;
extern UINT8 animFrame;


/* SUBSTATE METHODS */
void phaseTitleInit();
void phaseTitleLoop();

/* INPUT METHODS */

/* HELPER METHODS */

/* DISPLAY METHODS */


void titleStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseTitleInit();
            break;
        case SUB_LOOP:
            phaseTitleLoop();
            break;
        default:  // Abort to... uh, itself in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseTitleInit()
{
    // Initializations
    stopSong();
    init_bkg(0xFFU);
    animTick = 0U;
    HIDE_WIN;
    mgCurrentMG.id = 0xFF;

    scroll_bkg(4, 0U);  // For centering the screen

    set_bkg_data(0x30U, engineTitleLogo_TILE_COUNT, engineTitleLogo_tiles);
    set_bkg_tiles(0U, 5U, 21U, 6U, engineTitleLogo_map);
    set_bkg_data(0xF0U, 8U, borderTiles);

    // Corners
    set_sprite_data(0U, engineTitleCornerGarnish_TILE_COUNT, engineTitleCornerGarnish_tiles);
    move_metasprite(       engineTitleCornerGarnish_metasprites[0U], 0U,  0U,   8U,  16U);
    move_metasprite_hflip( engineTitleCornerGarnish_metasprites[0U], 0U, 10U,   8U, 160U);
    move_metasprite_vflip( engineTitleCornerGarnish_metasprites[0U], 0U, 20U, 168U,  16U);
    move_metasprite_hvflip(engineTitleCornerGarnish_metasprites[0U], 0U, 30U, 168U, 160U);
    for (i = 0U; i != 40U; ++i)
    {
        set_sprite_prop(i, get_sprite_prop(i) | 0b00010000);
    }

    substate = SUB_LOOP;

    OBP1_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
    playSong(&engineSloopygoopPartyTheme);
}

void phaseTitleLoop()
{
    ++animTick;
    
    if ((animTick % 64U) / 48U == 0U)
    {
        printLine(5U, 13U, "PRESS START", FALSE);
    }
    else
    {
        for (i = 5U; i != 16U; ++i)
            set_bkg_tile_xy(i, 13U, 0xFFU);
    }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        fadeout();
        initrand(DIV_REG);
        move_bkg(0U, 0U);

        gamestate = STATE_MAIN_MENU;
        substate = SUB_INIT;
        shouldRestartSong = FALSE;
    }
    else if (curJoypad & J_SELECT && curJoypad & J_B)
    {
        fadeout();
        gamestate = STATE_DELETE_SAVE;
        substate = SUB_INIT;
    }
    else if (curJoypad & J_SELECT && curJoypad & J_A)
    {
        fadeout();
        ENABLE_RAM;
        // language = loadLanguageSetting();
        language = (language + 1U) % 2U;
        saveLanguageSetting(language);
        if (language == 1U)
            set_bkg_data(0U, 46U, alBhedFontTiles);
        else
            set_bkg_data(0U, 46U, fontTiles);
        DISABLE_RAM;
        fadein();

        
    }
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
