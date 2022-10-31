#ifndef MICROGAME_MANAGER_STATE_H
#define MICROGAME_MANAGER_STATE_H

#include <gb/gb.h>
#include <rand.h>

void microgameManagerStateMain();  // Handles mostly lobby stuff
void microgameManagerGameLoop();  // Handles the microgame logic like checking if WON, etc

#endif