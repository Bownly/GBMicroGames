#include <gb/gb.h>

typedef struct BownlyPanel {
    UINT8 panelId;
    UINT8 panelValue;
    UINT8 xIndex;
    UINT8 yIndex;
    UINT8 isWinner;
    UINT8 isFlipping;
} BownlyPanel;