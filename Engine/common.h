#ifndef COMMON_H
#define COMMON_H

UINT8 getRandUint8(UINT8);
void drawPopupWindow(UINT8, UINT8, UINT8, UINT8);
void printLine(UINT8, UINT8, unsigned char *, UINT8);  // Only works if you haven't written over the first ~40 tiles of bkg data!

#endif
