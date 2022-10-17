#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../database/mgInstructionData.h"

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
extern UINT8 currentScore;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;
extern UINT8 mgCurrentMG;

extern UINT8 animTick;
extern UINT8 animFrame;


/* SUBSTATE METHODS */
void phaseInitMicrogameManager();
void phaseMicrogameManagerLoop();

/* HELPER METHODS */

/* INPUT METHODS */

/* DISPLAY METHODS */


void microgameManagerStateMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseInitMicrogameManager();
            break;
        case SUB_LOOP:
            phaseMicrogameManagerLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
}


/******************************** SUBSTATE METHODS *******************************/
void phaseInitMicrogameManager()
{
    // Initializations
    animTick = 0U;
    mgStatus = 0U;

    // Reload graphics
    
    setBlankBkg();
    // Set themed bkg
    // Update score val
    
    // Select new microgame
    // mgCurrentMG = MG_BOWNLY_BOW;

    substate = SUB_LOOP;


        // TEMP STUFF TODO Delete me
        unsigned char scoreString[] = "SCORE:";
        printLine(7U, 8U, scoreString, FALSE);

    fadein();
}

void phaseMicrogameManagerLoop()
{
    ++animTick;

    // Animate score increase visuals
    if (animTick < 60U)
    {
        set_bkg_tile_xy(8, 9, currentScore/100U);
        set_bkg_tile_xy(9, 9, (currentScore/10U)%10U);
        set_bkg_tile_xy(10, 9, currentScore%10U);
    }
    else if (animTick == 60U)
    {
        k = 0U;
        while (mgInstructionDex[mgCurrentMG][k] != 0U)
            ++k;

        l = (20U - k) >> 1U;
        // When done, show new instructions
        drawWindow(l-1U, 7U, k+1U, 2U);
        printLine(l, 8U, mgInstructionDex[mgCurrentMG], FALSE);
    }
    else if (animTick == 120U)
    {
        // Start new microgame
        setBlankBkg();
        gamestate = STATE_MICROGAME;
        substate = SUB_INIT;
        mgStatus = PLAYING;
    }

}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
