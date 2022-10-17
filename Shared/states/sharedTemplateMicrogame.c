#include <gb/gb.h>
#include <rand.h>

#include "../../Shared/common.h"
#include "../../Shared/enums.h"
#include "../../Shared/fade.h"

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


/* SUBSTATE METHODS */
void phaseTemplateInit();
void phaseTemplateLoop();

/* HELPER METHODS */

/* INPUT METHODS */

/* DISPLAY METHODS */


void sharedTemplateMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseTemplateInit();
            break;
        case SUB_LOOP:
            phaseTemplateLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseTemplateInit()
{
    // Initializations
    setBlankBkg();
    animTick = 0U;

    if (mgDifficulty == 0U)
    {
        printLine(3,5,"YOUR", FALSE);
        printLine(5,7,"MICROGAME", FALSE);
        printLine(11,9,"HERE!", FALSE);
    }
    else if (mgDifficulty == 1U)
    {
        printLine(2,5,"JOIN THIS FIRST", FALSE);
        printLine(4,7,"OF ITS KIND", FALSE);
        printLine(3,9,"COLLABORATION!", FALSE);
    }

    fadein();
    substate = SUB_LOOP;
}

void phaseTemplateLoop()
{
    if (++animTick == 90U)  // 1.5s pause
    {
        mgStatus = WON;
    }
  
}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
