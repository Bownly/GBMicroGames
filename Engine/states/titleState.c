#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../database/microgameData.h"

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
    init_bkg(0xFFU);
    animTick = 0U;
    HIDE_WIN;
    mgCurrentMG.id = 0xFF;
  
    scroll_bkg(-4, 0U);  // For centering the text

    printLine(2U, 3U, "LEGALLY DISTINCT", FALSE);
    printLine(4U, 4U, "TOTALLY NOT", FALSE);
    printLine(5U, 6U, "WARIOWARE", FALSE);
    printLine(1U, 8U, "COMMUNITY EDITION", FALSE);
    printLine(4U, 13U, "PRESS START", FALSE);

    substate = SUB_LOOP;
    // fadein();
}

void phaseTitleLoop()
{
    ++animTick;
    
    if ((animTick % 64U) / 48U == 0U)
    {
        printLine(4U, 13U, "PRESS START", FALSE);
    }
    else
    {
        for (i = 4U; i != 15U; ++i)
            set_bkg_tile_xy(i, 13U, 0xFFU);
    }

    if (curJoypad & J_START && !(prevJoypad & J_START))
    {
        fadeout();
        initrand(DIV_REG);
        move_bkg(0U, 0U);

        gamestate = STATE_MICROGAME_MANAGER;
        substate = MGM_INIT_ALL;
        mgStatus = PLAYING;
    }  
    // TODO DELETE ME TEMP TEST STUFF
    else if (curJoypad & J_SELECT && curJoypad & J_B)
    {
        fadeout();
        gamestate = STATE_DELETE_SAVE;
        substate = SUB_INIT;
    }
    else if (curJoypad & J_SELECT && !(prevJoypad & J_SELECT))
    {
        fadeout();
        move_bkg(0U, 0U);

        gamestate = STATE_REMIX;
        substate = SUB_INIT;
    }

}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
