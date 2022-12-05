#ifndef RAM_H
#define RAM_H

#define RAM_SIG_ADDR   0x00U

extern UBYTE ram_data[];

void saveGameData();
void loadGameData();

#endif