#include <gb/gb.h>

#include "../enums.h"
#include "../structs/Microgame.h"

const Microgame microgameDex[100U] =
{
#define MICROGAME(game, gameFunction, _bankId, _duration, _namePtr, _bylinePtr, _instructionsPtr) \
    { \
        .id = (game), \
        .bankId = (_bankId), \
        .duration = (_duration), \
        .namePtr = (_namePtr), \
        .bylinePtr = (_bylinePtr), \
        .instructionsPtr = (_instructionsPtr) \
    },
#include "microgameList.h"
#undef MICROGAME
};
