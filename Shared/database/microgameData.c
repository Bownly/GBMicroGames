#include <gb/gb.h>

#include "../enums.h"
#include "../structs/Microgame.h"

const char bownlyBowInstructions[] = "SHOOT!";
const char bownlyMP5Instructions[] = "INCREASE TO 5";
const char bownlyPastelInstructions[] = "COLLECT HEARTS!";
const char templateInstructions[] = "MAKE A GAME!";


const Microgame microgameDex[100U] =
{
    {
        .id = MG_BOWNLY_BOW,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyBowInstructions,
        .bylinePtr = bownlyBowInstructions,
        .instructionsPtr = bownlyBowInstructions
    },
    {
        .id = MG_BOWNLY_MAGIPANELS5,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyMP5Instructions,
        .bylinePtr = bownlyMP5Instructions,
        .instructionsPtr = bownlyMP5Instructions
    },
    {
        .id = MG_BOWNLY_PASTEL,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyPastelInstructions,
        .bylinePtr = bownlyPastelInstructions,
        .instructionsPtr = bownlyPastelInstructions
    },
    {
        .id = MG_TEMPLATE,
        .bankId = 2U,
        .duration = 5U,
        .namePtr = bownlyBowInstructions,
        .bylinePtr = bownlyBowInstructions,
        .instructionsPtr = templateInstructions
    }
};
