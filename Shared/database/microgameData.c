#include <gb/gb.h>

#include "../enums.h"
#include "../structs/Microgame.h"

const char bylineBownly[] = "BOWNLY";
const char bownlyBowName[] = "BOW";
const char bownlyBowInstructions[] = "SHOOT!";
const char bownlyMP5Name[] = "MAGIPANELS";
const char bownlyMP5Instructions[] = "INCREASE TO 5";
const char bownlyPastelName[] = "PASTEL";
const char bownlyPastelInstructions[] = "COLLECT HEARTS!";

const char bylineTemplate[] = "TEMPLATE DEV";
const char templateFaceName[] = "TEMPLATE NAME";
const char templateFaceInstructions[] = "MAKE HAPPY!";



const Microgame microgameDex[100U] =
{
    {
        .id = MG_BOWNLY_BOW,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyBowName,
        .bylinePtr = bylineBownly,
        .instructionsPtr = bownlyBowInstructions
    },
    {
        .id = MG_BOWNLY_MAGIPANELS5,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyMP5Name,
        .bylinePtr = bylineBownly,
        .instructionsPtr = bownlyMP5Instructions
    },
    {
        .id = MG_BOWNLY_PASTEL,
        .bankId = 2U,
        .duration = 4U,
        .namePtr = bownlyPastelName,
        .bylinePtr = bylineBownly,
        .instructionsPtr = bownlyPastelInstructions
    },
    {
        .id = MG_TEMPLATE_FACE,
        .bankId = 1U,
        .duration = 2U,
        .namePtr = templateFaceName,
        .bylinePtr = bylineTemplate,
        .instructionsPtr = templateFaceInstructions
    }
};
