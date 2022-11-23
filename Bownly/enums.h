#ifndef BOWNLY_ENUMS_H
#define BOWNLY_ENUMS_H

typedef enum {
    NOCKED,
    FLYING,
    HIT
} ARROWSTATE;

typedef enum {
    IDLE,
    WALKING,
    AIRBORNE,
    DEAD
} PASTELSTATE;

typedef enum {
    // Sacrificing comprehension for funny names here
    FILLING, // FILLING = able to be shot
    DRILLING
} DRILLSTATE;

extern ARROWSTATE arrowstate;
extern PASTELSTATE pastelstate;
extern DRILLSTATE drillstate;
 
#endif