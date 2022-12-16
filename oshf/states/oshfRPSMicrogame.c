#pragma bank 10

/* This microgame features a ninja with a random Rock, Paper, or Scissors pose.
// The player moves the D-Pad left or right to scroll through Rock/Paper/Scissors.
// The game is won if the correct option is selected when the player presses A.
// The game is lost if an incorrect option is selected or time expires.
*/

#include <gb/gb.h>
#include <rand.h>
#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../res/tiles/oshfRPSTiles.h"
#include "../res/maps/oshfRPSMap.h"
#include "../res/maps/oshfRPSR.h"
#include "../res/maps/oshfRPSP.h"
#include "../res/maps/oshfRPSS.h"
#include "../res/tiles/oshfRPSArrow.h"
#include "../res/tiles/oshfRPSLCloud.h"
#include "../res/tiles/oshfRPSRCloud.h"
#include "../res/tiles/oshfRPSNinjaR.h"
#include "../res/tiles/oshfRPSNinjaP.h"
#include "../res/tiles/oshfRPSNinjaS.h"
#include "../res/tiles/oshfRPSNinjaDefeat.h"
#include "../res/tiles/oshfRPSNinjaWin.h"

extern const hUGESong_t oshfTwilightDriveSong;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i; // Used mostly for loops
extern UINT8 j; // Used mostly for loops
extern UINT8 k; // Used for whatever
extern INT8 l; // Used for whatever
extern UINT8 m; // Used for menus generally
extern UINT8 n; // Used for menus generally
extern UINT8 r; // Used for randomization stuff

extern UINT8 substate;
extern UINT8 mgDifficulty; // Readonly!
extern UINT8 mgSpeed; // Readonly!
extern UINT8 mgStatus;

static UINT8 current;
static UINT8 clouds;
static UINT8 rX;
static UINT8 maxRX = 99U;
static UINT8 lX;
static UINT8 maxLX = 51U;

/* SUBSTATE METHODS */
static void phaseRPSInit();
static void phaseRPSLoop();

/* INPUT METHODS */
static void inputsRPS();

/* HELPER METHODS */

/* DISPLAY METHODS */
static void moveClouds();
static void animateArrow();
static void updateRPS();

void oshfRPSMicrogameMain() {
  switch (substate) {
  case SUB_INIT:
    phaseRPSInit();
    break;
  case SUB_LOOP:
    phaseRPSLoop();
    break;
  default: // Abort to title in the event of unexpected state
    gamestate = STATE_TITLE;
    substate = SUB_INIT;
    break;
  }
}

/******************************** SUBSTATE METHODS *******************************/
static void phaseRPSInit() {

  current = 0U;
  clouds = 0U;
  rX = 76U; // Coords of right cloud
  lX = 67U; // Coords of left cloud

  set_bkg_data(40U, 16U, oshfRPSTiles);
  set_bkg_tiles(0U, 0U, 20U, 18U, oshfRPSMap);

  set_bkg_tiles(9U, 14U, 2U, 2U, oshfRPSR); // Setup initial choice as rock

  r = getRandUint8(3U);

  set_sprite_data(0U, 2U, oshfRPSArrow);
  set_sprite_data(2U, 6U, oshfRPSRCloud);
  set_sprite_data(8U, 6U, oshfRPSLCloud);

  switch (r) {
  case 0U:
    set_sprite_data(15U, 9U, oshfRPSNinjaR); // Rock
    break;
  case 1U:
    set_sprite_data(15U, 9U, oshfRPSNinjaP); // Paper
    break;
  case 2U:
    set_sprite_data(15U, 9U, oshfRPSNinjaS); // Scissors
    break;
  }

  set_sprite_tile(14U, 15U); // Ninja
  set_sprite_tile(15U, 16U);
  set_sprite_tile(16U, 17U);
  set_sprite_tile(17U, 18U);
  set_sprite_tile(18U, 19U);
  set_sprite_tile(19U, 20U);
  set_sprite_tile(20U, 21U);
  set_sprite_tile(21U, 22U);
  set_sprite_tile(22U, 23U);

  move_sprite(14U, 76U, 64U); //Ninja
  move_sprite(15U, 76U + 8U, 64U);
  move_sprite(16U, 76U + 16U, 64U);
  move_sprite(17U, 76U, 64U + 8U);
  move_sprite(18U, 76U + 8U, 64U + 8U);
  move_sprite(19U, 76U + 16U, 64U + 8U);
  move_sprite(20U, 76U, 64U + 16U);
  move_sprite(21U, 76U + 8U, 64U + 16U);
  move_sprite(22U, 76U + 16U, 64U + 16U);

  set_sprite_tile(0U, 0U); // Left Arrow
  set_sprite_tile(1U, 0U); // Right Arrow

  move_sprite(0U, 64U, 132U);
  move_sprite(1U, 104U, 132U);

  set_sprite_prop(1U, S_FLIPX);

  if (mgDifficulty > 0U) { // If difficulty increases, add clouds to obfuscate
    clouds = 1U;

    set_sprite_tile(2U, 2U); // R. Cloud
    set_sprite_tile(3U, 3U);
    set_sprite_tile(4U, 4U);
    set_sprite_tile(5U, 5U);
    set_sprite_tile(6U, 6U);
    set_sprite_tile(7U, 7U);

    move_sprite(2U, rX, 71U);
    move_sprite(3U, rX + 8U, 71U);
    move_sprite(4U, rX + 16U, 71U);
    move_sprite(5U, rX, 71U + 8U);
    move_sprite(6U, rX + 8U, 71U + 8U);
    move_sprite(7U, rX + 16U, 71U + 8U);
  }
  if (mgDifficulty > 1U) {
    clouds = 2U;

    set_sprite_tile(8U, 8U); // L. Cloud
    set_sprite_tile(9U, 9U);
    set_sprite_tile(10U, 10U);
    set_sprite_tile(11U, 11U);
    set_sprite_tile(12U, 12U);
    set_sprite_tile(13U, 13U);

    move_sprite(8U, lX, 66U);
    move_sprite(9U, lX + 8U, 66U);
    move_sprite(10U, lX + 16U, 66U);
    move_sprite(11U, lX, 66U + 8U);
    move_sprite(12U, lX + 8U, 66U + 8U);
    move_sprite(13U, lX + 16U, 66U + 8U);
  }

  k = 0U;

  playSong(&oshfTwilightDriveSong);

  fadein();
  substate = SUB_LOOP;

}

static void phaseRPSLoop() {
  if (mgStatus == PLAYING) {
    if (clouds != 0U) {
      moveClouds();
    }
    animateArrow();
    k++; // for arrow delay
    inputsRPS();
  }
}

/******************************** INPUT METHODS *********************************/

static void inputsRPS() {
  if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT)) {
    if (current == 0U) {
      current = 2U;
    } // Change from Rock to Scissors
    else {
      current--;
    } // Change from Scissors to Paper
    updateRPS(); // Change hand bkg
  } else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT)) {
    if (current == 2U) {
      current = 0U;
    } // Change from Scissors to Rock
    else {
      current++;
    } // Change from Rock to Paper
    updateRPS(); // Change hand bkg
  }

  if (curJoypad & J_A && !(prevJoypad & J_A)) // Check if Won/Lost
  {
    if (r == 0U && current == 1U) {
      set_sprite_data(15U, 9U, oshfRPSNinjaDefeat);
      mgStatus = WON;
    } else if (r == 1U && current == 2U) {
      set_sprite_data(15U, 9U, oshfRPSNinjaDefeat);
      mgStatus = WON;
    } else if (r == 2U && current == 0U) {
      set_sprite_data(15U, 9U, oshfRPSNinjaDefeat);
      mgStatus = WON;
    } else {
      set_sprite_data(15U, 9U, oshfRPSNinjaWin);
      mgStatus = LOST;
    }
  }
}

/******************************** DISPLAY METHODS ********************************/

static void updateRPS() { // Update bkg for user hand
  switch (current) {
  case 0U:
    set_bkg_tiles(9U, 14U, 2U, 2U, oshfRPSR); // Rock
    break;
  case 1U:
    set_bkg_tiles(9U, 14U, 2U, 2U, oshfRPSP); // Paper
    break;
  case 2U:
    set_bkg_tiles(9U, 14U, 2U, 2U, oshfRPSS); // Scissors
    break;
  }
}

static void moveClouds() {

  if (mgDifficulty > 0U) { // If difficulty 1 or more move right cloud
    if (rX < maxRX) {
      rX++;
    } // While cloud X is less than the max

    move_sprite(2U, rX, 71U);
    move_sprite(3U, rX + 8U, 71U);
    move_sprite(4U, rX + 16U, 71U);
    move_sprite(5U, rX, 71U + 8U);
    move_sprite(6U, rX + 8U, 71U + 8U);
    move_sprite(7U, rX + 16U, 71U + 8U);
  }
  if (mgDifficulty > 1U) { // Move second cloud if difficulty is 2
    if (lX > maxLX) {
      lX--;
    } // While cloud X is less than the max

    move_sprite(8U, lX, 66U);
    move_sprite(9U, lX + 8U, 66U);
    move_sprite(10U, lX + 16U, 66U);
    move_sprite(11U, lX, 66U + 8U);
    move_sprite(12U, lX + 8U, 66U + 8U);
    move_sprite(13U, lX + 16U, 66U + 8U);
  }
  if (rX == maxRX) {
    clouds = 0U;
  } // Stop moving if right cloud has reached maxRx

}

static void animateArrow() { // Flash arrow color
  if (k > 10U) {
    set_sprite_tile(0U, 1U);
    set_sprite_tile(1U, 1U);
    if (k == 20U) k = 0U;
  }
  if (k < 10U) {
    set_sprite_tile(0U, 0U);
    set_sprite_tile(1U, 0U);
  }

}