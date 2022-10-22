#ifndef ENUMS_H
#define ENUMS_H

typedef enum {
    STATE_TITLE,
    STATE_MAIN_MENU,
    STATE_MICROGAME_MANAGER,
    STATE_MICROGAME
} GAMESTATE;

typedef enum {
    MG_BOWNLY_BOW,
    MG_BOWNLY_MAGIPANELS5,
    MG_BOWNLY_PASTEL,
    MG_TEMPLATE
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