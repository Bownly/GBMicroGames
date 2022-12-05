#include <gb/gb.h>

UINT8 isFadedOut;

UINT8 getIsFadedOut()
{
    return isFadedOut;
}


void performantdelay(UINT8 numloops)
{
    UINT8 j;
    for (j = 0U; j != numloops; j++)
    {
        wait_vbl_done();
    }     
}

void fadein() 
{
    UINT8 i;
    for (i = 0U; i != 3U; i++) 
    {
        switch(i) 
        {
            case 0U:
                // OBP0_REG = 0x40;  // Sprites
                OBP0_REG = 0x40;  // Dark grey as transparent
                OBP1_REG = 0x40;
                BGP_REG = 0x40;  // Bkg
                break;
            case 1U:
                // OBP0_REG = 0x90;
                OBP0_REG = 0x81;  // Dark grey as transparent
                OBP1_REG = 0x81;
                BGP_REG = 0x90;
                break;
            case 2U:
                // OBP0_REG = 0xE4;  // White as transparent
                // OBP0_REG = 0xE1;  // Light grey as transparent
                OBP0_REG = 0xD2;  // Dark grey as transparent  11010010
                OBP1_REG = 0xD2;
                BGP_REG = 0xE4;
                break;
        }
        performantdelay(1U);
    }
    isFadedOut = 0U;
    // pauseSong(0U);
}

void fadeout() 
{
    UINT8 i;
    // pauseSong(1U);
    for (i = 0U; i != 4U; i++) 
    {
        switch(i) 
        {
            case 0U:
                // OBP0_REG = 0xE4;
                OBP0_REG = 0xD2;  // Dark grey as transparent  11010010
                OBP1_REG = 0xD2;
                BGP_REG = 0xE4;
                break;
            case 1U:
                // OBP0_REG = 0x90;
                OBP0_REG = 0x81;  // Dark grey as transparent
                OBP1_REG = 0x81;
                BGP_REG = 0x90;
                break;
            case 2U:
                // OBP0_REG = 0x40;
                OBP0_REG = 0x40;  // Dark grey as transparent
                OBP1_REG = 0x40;
                BGP_REG = 0x40;
                break;
            case 3U:
                OBP0_REG = 0x00;
                OBP1_REG = 0x00;
                BGP_REG = 0x00;
                break;
        }
        performantdelay(1U);
    }

    // I'm sure there's a better way to remove/reset sprites
    for (i = 0U; i != 40U; i++)
    {
        move_sprite(i, 0U, 0U);
        set_sprite_prop(i, 0b00000000U);
    }

    isFadedOut = 1U;
}


