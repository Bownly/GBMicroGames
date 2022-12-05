#include <gb/gb.h>

#ifndef MICROGAME_H
#define MICROGAME_H
 
typedef struct Microgame {
    UINT8 id;
    UINT8 bankId;
    UINT8 duration;
    char* namePtr;
    char* bylinePtr;
    char* instructionsPtr;
} Microgame;

#endif