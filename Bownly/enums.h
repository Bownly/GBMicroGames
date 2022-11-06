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

extern ARROWSTATE arrowstate;
extern PASTELSTATE pastelstate;
 
#endif