#ifndef ENUMS_H
#define ENUMS_H

typedef enum {
    STATE_TITLE,
    STATE_DELETE_SAVE,
    STATE_MAIN_MENU,
    STATE_MICROGAME_MANAGER,
    STATE_MICROGAME,
    STATE_REMIX,
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
    DS_MESSAGE_LOOP,
    MGM_INIT_SINGLE,
    MGM_INIT_ALL,
    MGM_INIT_REMIX,
    MGM_INIT_LOBBY,  // The transition screen between microgames
    MGM_LOBBY_LOOP,
    MGM_LOBBY_LOOP_LEVELUP,
    MGM_LOBBY_LOOP_INSTRUCTIONS
} SUBSTATE;

typedef enum {
    EMPTY,
    PLAYING,
    WON,
    LOST
} MGSTATUS;

typedef enum {
    BOOGIE_WOOGIE,
    WON_JINGLE_1,
    LOST_JINGLE_1,
    PRE_MG_JINGLE_1
} SONGNAME;

typedef enum {
    ALL,
    SINGLE,
    REMIX
} MGPOOLTYPE;

extern GAMESTATE gamestate;
extern SUBSTATE substate;
extern MICROGAME microgame;
extern MGSTATUS mgstatus;
extern SONGNAME songname;
extern MGPOOLTYPE mgpooltype;
 
#endif