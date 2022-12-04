#ifndef SYNCHINGFEELING_ENUMS_H
#define SYNCHINGFEELING_ENUMS_H

// Egg
typedef enum {
    IDLE,          // Ready to jump
    JUMPING,       // Jumping
    SMASHED        // Smashed, game is over
} EGGSTATE;

extern EGGSTATE eggstate;

typedef enum {
    DOHIT,              // Need to hit this enough times to finish
    PROBABLYDONOTHIT,   // This will start to smash your egg
    DONOTHIT,           // One hit will completely crack your egg
    HIT,                // Has been hit
    THINKING,           // Calculating new state
    DONE                // Done, no further state
} BLOCKSTATE;

extern BLOCKSTATE blockstate;

// Ghost
typedef enum {
    EYE_CENTER,
    EYE_UP,
    EYE_DOWN,
    EYE_LEFT,
    EYE_RIGHT,
    BLINK
} EYESTATE;

extern EYESTATE eyestate;
 
#endif