#ifndef RAM_H
#define RAM_H

#define RAM_SIG_ADDR   0x00U
#define RAM_HIGHSCORE_ADDR   0x0FU
#define RAM_MG_HIGHSCORE_ADDR   0x10U
#define RAM_MG_TOGGLED_ADDR   0x80U

extern UBYTE ram_data[];

void saveHighScore(UINT8);
UINT8 loadHighScore();
void wipeHighScore();

void saveMGScore(UINT8, UINT8);
UINT8 loadMGScore(UINT8);
void wipeAllMGScores();

void saveMGToggle(UINT8, UINT8);
UINT8 loadMGToggle(UINT8);
void wipeAllMGToggles();

#endif