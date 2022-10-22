#include <gb/gb.h>
#include <gb/cgb.h>
#include <rand.h>

#include "../common.h"
#include "../enums.h"
#include "../fade.h"
#include "../structs/Microgame.h"

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
extern UINT8 currentLives;
extern UINT8 mgDifficulty;
extern UINT8 mgSpeed;
extern UINT8 mgStatus;
extern Microgame mgCurrentMG;

extern UINT8 animTick;
extern UINT8 animFrame;


/* SUBSTATE METHODS */
void phaseInitMicrogameManager();
void phaseMicrogameManagerLoop();

/* INPUT METHODS */

/* HELPER METHODS */

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
    mgStatus = PLAYING;

    // Reload graphics
    
    setBlankBkg();
    // Set themed bkg
    // Update score val
    
    // Select new microgame
    // mgCurrentMG = MG_BOWNLY_BOW;

    substate = SUB_LOOP;


        // TEMP STUFF TODO: delete me
        printLine(6U, 8U, "SCORE:", FALSE);
        printLine(6U, 9U, "LIVES:", FALSE);

    fadein();
}

void phaseMicrogameManagerLoop()
{
    ++animTick;

    // Animate score increase visuals
    if (animTick < 60U)
    {
        set_bkg_tile_xy(12U, 8U, currentScore/100U);
        set_bkg_tile_xy(13U, 8U, (currentScore/10U)%10U);
        set_bkg_tile_xy(14U, 8U, currentScore%10U);
        set_bkg_tile_xy(12U, 9U, currentLives);
    }
    else if (animTick == 60U)
    {
        // Erase score and lives text
        for (i = 6U; i != 15U; ++i)
        {
            set_bkg_tile_xy(i, 8U, 0xFFU);
            set_bkg_tile_xy(i, 9U, 0xFFU);
        }

        k = 0U;
        while (mgCurrentMG.instructionsPtr[k] != 0U)
            ++k;

        l = (20U - k) >> 1U;
        // When done, show new instructions
        drawWindow(l-1U, 7U, k+1U, 2U);
        printLine(l, 8U, mgCurrentMG.instructionsPtr, FALSE);
    }
    else if (animTick == 120U)
    {
        // Start new microgame
        fadeout();
        gamestate = STATE_MICROGAME;
        substate = SUB_INIT;
        mgStatus = PLAYING;
    }

}

/******************************** INPUT METHODS *********************************/


/******************************** HELPER METHODS *********************************/


/******************************** DISPLAY METHODS ********************************/
