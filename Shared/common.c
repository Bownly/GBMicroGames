#include <gb/gb.h>
#include <rand.h>


extern UINT8 i;
extern UINT8 j;
extern UINT8 r;

UINT8 getRandUint(UINT8 modulo)
{
    r = 201U;
    while (r >= 200U) {
        r = rand() % modulo;
    }
    return r;
}

void drawWindow(UINT8 xCoord, UINT8 yCoord, UINT8 xDim, UINT8 yDim)
{
    // Draw corners
    set_bkg_tile_xy(xCoord, yCoord, 0xF7);
    set_bkg_tile_xy(xCoord + xDim, yCoord, 0xF9);
    set_bkg_tile_xy(xCoord, yCoord + yDim, 0xFC);
    set_bkg_tile_xy(xCoord + xDim, yCoord + yDim, 0xFE);

    // Draw walls
    for (i = 1U; i != xDim; ++i)
    {
        set_bkg_tile_xy(xCoord + i, yCoord, 0xF8);
        set_bkg_tile_xy(xCoord + i, yCoord + yDim, 0xFD);

        // Fill center
        for (j = 1U; j != yDim; j++)
        {
            set_bkg_tile_xy(xCoord + i, yCoord + j, 0xFF);
        }
    }
    for (j = 1U; j != yDim; ++j)
    {
        set_bkg_tile_xy(xCoord, yCoord + j, 0xFA);
        set_bkg_tile_xy(xCoord + xDim, yCoord + j, 0xFB);
    }
}

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

void setBlankBkg()
{
    for (i = 0U; i != 21U; i++)
    {
        for (j = 0U; j != 18U; j++)
        {
            set_bkg_tile_xy(i, j, 0xFF);
        }
    }
}

void setBlankWin()
{
    for (i = 0U; i != 21U; i++)
    {
        for (j = 0U; j != 18U; j++)
        {
            set_win_tile_xy(i, j, 0xFF);
        }
    }
}

