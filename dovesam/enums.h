#ifndef DOVESAM_ENUMS_H
#define DOVESAM_ENUMS_H

typedef enum {
    BUTTON_LEFT,
    BUTTON_DOWN,
    BUTTON_RIGHT,
    BUTTON_UP,
    BUTTON_A,
    BUTTON_B,
    BUTTON_EMPTY,
    BUTTON_SUCCESS,
    BUTTON_SMALL_EMPTY,
    BUTTON_SMALL_FAIL,
    NO_OF_BUTTONS
} BUTTONS;

extern BUTTONS buttons;
 
#endif