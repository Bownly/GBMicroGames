#ifndef ENUMS_H
#define ENUMS_H

typedef enum {
    STATE_TITLE,
    STATE_MAIN_MENU,
    STATE_MICROGAME_MANAGER,
    STATE_MICROGAME,
    STATE_GAMEOVER
} GAMESTATE;

typedef enum {
#define MICROGAME(game, a, b, c, d, e, f) game,
#include "database/microgameList.h"
#undef MICROGAME
} MICROGAME;

typedef enum {
    SUB_INIT,
    SUB_LOOP,
    MGM_INIT_LOBBY  // The transition screen between microgames
} SUBSTATE;

typedef enum {
    EMPTY,
    PLAYING,
    WON,
    LOST
} MGSTATUS;

extern GAMESTATE gamestate;
extern SUBSTATE substate;
extern MICROGAME microgame;
extern MGSTATUS mgstatus;
 
#endif