#include <gb/gb.h>

#include "../enums.h"
#include "../structs/Microgame.h"

const Microgame microgameDex[100U] =
{
#define MICROGAME(game, gameFunction, _bankId, _duration, name, author, instructions) \
    { \
        .id = (game), \
        .bankId = (_bankId), \
        .duration = (_duration), \
        .namePtr = (name), \
        .bylinePtr = (author), \
        .instructionsPtr = (instructions) \
    },
#include "microgameList.h"
#undef MICROGAME
};
