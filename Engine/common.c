#include <gb/gb.h>
#include <rand.h>


extern UINT8 i;
extern UINT8 j;
extern UINT8 r;

UINT8 getRandUint8(UINT8 modulo)
{
    r = rand() % modulo;
    return r;
}

void drawPopupWindow(UINT8 xCoord, UINT8 yCoord, UINT8 xDim, UINT8 yDim)
{
    // Draw corners
    set_bkg_tile_xy(xCoord, yCoord, 0xF0U);
    set_bkg_tile_xy(xCoord + xDim, yCoord, 0xF2U);
    set_bkg_tile_xy(xCoord, yCoord + yDim, 0xF5U);
    set_bkg_tile_xy(xCoord + xDim, yCoord + yDim, 0xF7U);

    // Draw walls
    for (i = 1U; i != xDim; ++i)
    {
        set_bkg_tile_xy(xCoord + i, yCoord, 0xF1U);
        set_bkg_tile_xy(xCoord + i, yCoord + yDim, 0xF6U);

        // Fill center
        for (j = 1U; j != yDim; j++)
        {
            set_bkg_tile_xy(xCoord + i, yCoord + j, 0xF8U);
        }
    }
    for (j = 1U; j != yDim; ++j)
    {
        set_bkg_tile_xy(xCoord, yCoord + j, 0xF3U);
        set_bkg_tile_xy(xCoord + xDim, yCoord + j, 0xF4U);
    }
}

// Only works if you haven't written over the first ~40 tiles of bkg data
void printLine(UINT8 xCoord, UINT8 yCoord, unsigned char* line, UINT8 printToWindow)
{
    unsigned char tempLine[18U];
    unsigned char* tempLinePtr = tempLine;
    UINT8 size = 0U;
    UINT8 diff = 0x37;
    while (*line)
    {
        if (*line == ' ')
            diff = 0x21;
        else if (*line == '.')
            diff = 0x0A;
        else if (*line == ',')
            diff = 0x06;
        else if (*line == '?')
            diff = 0x1A;
        else if (*line == ':')
            diff = 0x0F;
        else if (*line == '!')
            diff = 0xF9;
        else if (*line <= 0x39)  // 0-9... and anything lower in index than 0
            diff = 0x30;
        else  // A-Z
            diff = 0x37;

        *tempLinePtr = *line - diff;
        tempLinePtr++;
        line++;
        size++;
    }
    
    if (printToWindow == FALSE)
        set_bkg_tiles(xCoord, yCoord, size, 1U, tempLinePtr-size);
    else
        set_win_tiles(xCoord, yCoord, size, 1U, tempLinePtr-size);
}

