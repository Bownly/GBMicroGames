#include <gb/gb.h>
#include <rand.h>

#include "Shared/common.h"
#include "Shared/enums.h"
#include "Shared/fade.h"
#include "Shared/ram.h"
#include "Shared/songPlayer.h"

#include "Shared/database/microgameData.h"
#include "Shared/structs/Microgame.h"
#include "Shared/states/microgameManagerState.h"
#include "Shared/states/sharedTemplateMicrogame.h"
#include "Shared/states/titleState.h"

#include "Bownly/states/bownlyBowMicrogame.h"
#include "Bownly/states/bownlyPastelMicrogame.h"
#include "Bownly/states/bownlyMP5Microgame.h"

extern const unsigned char borderTiles[];
extern const unsigned char fontTiles[];

// Save data stuff
const UBYTE RAM_SIG[4U] = {'G','B','M','G'};
UBYTE *data;

UINT8 vbl_count;
UINT8 curJoypad;
UINT8 prevJoypad;
UINT8 i;  // Used mostly for loops
UINT8 j;  // Used mostly for loops
UINT8 k;  // Used for whatever
UINT8 l;  // Used for whatever
UINT8 m;  // Used for menus generally
UINT8 n;  // Used for menus generally
UINT8 r;  // Used for randomization stuff

UINT8 gamestate = STATE_TITLE;
UINT8 substate;
UINT8 currentScore = 0U;
UINT8 mgDifficulty = 0U;
UINT8 mgSpeed = 0U;
UINT8 mgStatus;
Microgame mgCurrentMG;

UINT8 animFrame = 0U;
UINT8 animTick = 0U;


void initRAM(UBYTE);
void setNewMG(MICROGAME);


void vbl_update() {
	++vbl_count;
}

void main()
{
 	initRAM(0U);

    // Sound stuff
    NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
    NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
    NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels
	vbl_count = 0U;
    add_VBL(vbl_update);
    set_interrupts(TIM_IFLAG | VBL_IFLAG);

    set_bkg_data(0xF7U, 8U, borderTiles);
    set_bkg_data(0U, 46U, fontTiles);

    setBlankBkg();
    DISPLAY_ON;
    SHOW_BKG;
    HIDE_WIN;
    SHOW_SPRITES;

    gamestate = STATE_TITLE;
    // gamestate = STATE_MICROGAME;
    setNewMG(MG_BOWNLY_BOW);  // Edit this line with your MG's enum for testing purposes

    substate = SUB_INIT;

    while(1U)
    {
        if(!vbl_count)
            wait_vbl_done();
        vbl_count = 0U;

        switch(gamestate)
        {
            case STATE_TITLE:
                SWITCH_ROM_MBC1(1U);
                titleStateMain();
                break;
            case STATE_MAIN_MENU:
                break;
            case STATE_MICROGAME_MANAGER:
                microgameManagerStateMain();
                break;
            case STATE_MICROGAME:
                switch (mgStatus)
                {
                    case WON:
                        ++currentScore;
                        gamestate = STATE_MICROGAME_MANAGER;
                        substate = SUB_INIT;
                        fadeout();

                        // TEST stuff
                        mgDifficulty = (currentScore >> 1U) % 3U;
                        mgSpeed = (currentScore / 3U) % 3U;
                        // setNewMG(currentScore % 3U);
                        // mgDifficulty = (currentScore / 3U) % 3U;

                        switch (currentScore)
                        {
                            default:
                            case 1U:
                            case 3U:
                            case 5U:
                                setNewMG(MG_TEMPLATE);
                                break;
                            case 2U:
                                setNewMG(MG_BOWNLY_PASTEL);
                                break;
                            case 4U:
                                setNewMG(MG_BOWNLY_MAGIPANELS5);
                                break;
                        }

                        break;
                    case LOST:
                        // Lose a heart, etc.
                        break;
                    default:
                        SWITCH_ROM_MBC1(mgCurrentMG.bankId);
                        switch (mgCurrentMG.id)
                        {
                            case MG_BOWNLY_BOW:
                                bownlyBowMicrogameMain();
                                break;
                            case MG_BOWNLY_PASTEL:
                                bownlyPastelMicrogameMain();
                                break;
                            case MG_BOWNLY_MAGIPANELS5:
                                bownlyMP5MicrogameMain();
                                break;
                            case MG_TEMPLATE:
                                sharedTemplateMicrogameMain();
                                break;
                            default:
                                SWITCH_ROM_MBC1(2U);
                                sharedTemplateMicrogameMain();
                                break;
                        }
                        break;
                }
                break;
        }
        // Music stuff
        songPlayerUpdate();
    }
}

void initRAM(UBYTE force_clear)
{
    UBYTE initialized;

    ENABLE_RAM_MBC1;
    SWITCH_RAM_MBC1(0U);

    // Check for signature
    initialized = 1U;
    for (i = 0U; i != 4U; ++i)
    {
        if (ram_data[RAM_SIG_ADDR + i] != RAM_SIG[i])
        {
            initialized = 0U;
            break;
        }
    }

    // Initialize memory
    if (initialized == 0U || force_clear)
    {
        for(i = 0U; i != 255U; ++i) {
            ram_data[i] = 0U;
        }

        for (i = 0U; i != 7U; ++i) {
            ram_data[RAM_SIG_ADDR + i] = RAM_SIG[i];
        }
    }

    DISABLE_RAM_MBC1;
}

void setNewMG(MICROGAME newMicrogame)
{
    mgCurrentMG.id = newMicrogame;
    mgCurrentMG.bankId = microgameDex[newMicrogame].bankId;
    mgCurrentMG.namePtr = microgameDex[newMicrogame].namePtr;
    mgCurrentMG.bylinePtr = microgameDex[newMicrogame].bylinePtr;
    mgCurrentMG.instructionsPtr = microgameDex[newMicrogame].instructionsPtr;
}
