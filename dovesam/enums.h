#ifndef DOVESAM_ENUMS_H
#define DOVESAM_ENUMS_H

typedef enum {
    HAPPY,
    SAD
} FACE_VALS;

typedef enum {
    BUTTON_LEFT,
    BUTTON_DOWN,
    BUTTON_RIGHT,
    BUTTON_UP,
    BUTTON_A,
    BUTTON_B,
    NO_OF_BUTTONS
} BUTTONS;

extern FACE_VALS face_vals;
extern BUTTONS buttons;
 
#endif