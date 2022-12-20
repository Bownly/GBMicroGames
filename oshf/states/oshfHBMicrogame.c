#pragma bank 10

/*This microgame features a bird that spits out a worm to a chick.
// The player presses A or UP button to make the chick jump.
// The game is won if the player collides with a worm.
// The game is lost if the player missed the worm or time expires.
*/

#include <gb/gb.h>
#include <rand.h>
#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../res/tiles/oshfHBTiles.h"
#include "../res/tiles/oshfHBBird.h"
#include "../res/tiles/oshfHBJump.h"
#include "../res/tiles/oshfHBHappy.h"
#include "../res/tiles/oshfHBSad.h"
#include "../res/tiles/oshfHBWorm.h"
#include "../res/maps/oshfHBMap.h"

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

static UINT8 bX;
static UINT8 bY;
static UINT8 wX;
static UINT8 wY;
static UINT8 launched;
static UINT8 canJump;
static UINT8 top;
static UINT8 tReached;

/*SUBSTATE METHODS */
static void phaseHBInit();
static void phaseHBLoop();

/*INPUT METHODS */
static void inputsHB();

/*HELPER METHODS */
static void jump();
static void launch();
static void updateWorm();
static void checkCollision();

/*DISPLAY METHODS */

void oshfHBMicrogameMain() {
  switch (substate) {
  case SUB_INIT:
    phaseHBInit();
    break;
  case SUB_LOOP:
    phaseHBLoop();
    break;
  default: // Abort to title in the event of unexpected state
    gamestate = STATE_TITLE;
    substate = SUB_INIT;
    break;
  }
}

/********************************SUBSTATE METHODS *******************************/
static void phaseHBInit() {
  canJump = 0U;
  launched = 0U;
  tReached = 0U;
  top = 0U;

  bX = 38U;
  bY = 119U;

  wX = 160U;
  wY = 108U;

  set_bkg_data(40U, 30U, oshfHBTiles);
  set_bkg_tiles(0U, 0U, 20U, 18U, oshfHBMap);

  set_sprite_data(0U, 4U, oshfHBBird);
  set_sprite_data(4U, 4U, oshfHBJump);
  set_sprite_data(8U, 4U, oshfHBWorm);
  set_sprite_data(16U, 4U, oshfHBHappy);

  set_sprite_tile(0U, 0U); // Bird
  set_sprite_tile(1U, 1U);
  set_sprite_tile(2U, 2U);
  set_sprite_tile(3U, 3U);

  set_sprite_tile(4U, 8U); // Worm
  set_sprite_tile(5U, 9U);
  set_sprite_tile(6U, 10U);
  set_sprite_tile(7U, 11U);

  move_sprite(0U, bX, bY); // Bird
  move_sprite(1U, bX + 8U, bY);
  move_sprite(2U, bX, bY + 8U);
  move_sprite(3U, bX + 8U, bY + 8U);

  fadein();
  playSong(&oshfTwilightDriveSong);

  substate = SUB_LOOP;
}

static void phaseHBLoop() {
  if (mgStatus == PLAYING) {
    if (launched == 0U && k == 25U) {
      launch();
    }

    if (launched == 1U && mgStatus != WON) {
      updateWorm();
    }

    checkCollision();
    if (wX < bX) {
      canJump = 2U;
    }

    inputsHB();
    if (canJump == 1U || canJump == 2U) {
      jump();
    }

    if (k < 25U) {
      k++;
    }
  }
}

/********************************INPUT METHODS *********************************/
static void inputsHB() {
  if ((curJoypad & J_A && !(prevJoypad & J_A)) || (curJoypad & J_UP && !(prevJoypad & J_UP))) {
    if (canJump == 0U) {
      canJump = 1U;
      set_sprite_tile(0U, 4U); // Bird
      set_sprite_tile(1U, 5U);
      set_sprite_tile(2U, 6U);
      set_sprite_tile(3U, 7U);
      NR10_REG = 0x17;
      NR11_REG = 0x3F;
      NR12_REG = 0xF3;
      NR13_REG = 0xFF;
      NR14_REG = 0x85;
    }
  }
}

/********************************HELPER METHODS ********************************/
static void jump() {
  if (bY == 119U && canJump == 2U) {
    set_sprite_data(0U, 4U, oshfHBSad);
    top = 2U;
  }

  if (top == 0U) {
    if (bY == 59U) {
      top = 1U;
    } else {
      bY -= 2U;
    }
  }

  if (top == 1U) {
    bY += 2U;
  }

  move_sprite(0U, bX, bY);
  move_sprite(1U, bX + 8U, bY);
  move_sprite(2U, bX, bY + 8U);
  move_sprite(3U, bX + 8U, bY + 8U);

  if (bY == 119U && top == 1U) {
    set_sprite_tile(0U, 0U); // Bird
    set_sprite_tile(1U, 1U);
    set_sprite_tile(2U, 2U);
    set_sprite_tile(3U, 3U);
    top = 0U;
    canJump = 0U;
  }
}

static void launch() {
  move_sprite(4U, wX, wY); // Worm
  move_sprite(5U, wX + 8U, wY);
  move_sprite(6U, wX, wY + 8U);
  move_sprite(7U, wX + 8U, wY + 8U);

  launched = 1U;
}

static void updateWorm() {
  if (wX >= 2U) {
    if (mgDifficulty == 2U) {
      wX -= 4U;

      if (wY > 40U && tReached == 0U) {
        wY -= 2U;
        if (wY <= 59U)
          tReached = 1U;
      }

      if (tReached == 1U) {
        wY += 2U;
      }
    } else if (mgDifficulty == 1U) {
      wX -= 3U;

      if (wY > 40U && tReached == 0U) {
        wY -= 2U;
        if (wY <= 50U)
          tReached = 1U;
      }

      if (tReached == 1U) {
        wY += 2U;
      }
    } else {
      wX -= 2U;

      if (wY > 40U && tReached == 0U) {
        wY--;
        if (wY <= 59U)
          tReached = 1U;
      }

      if (tReached == 1U) {
        wY++;
      }
    }

    move_sprite(4U, wX, wY); // Worm
    move_sprite(5U, wX + 8U, wY);
    move_sprite(6U, wX, wY + 8U);
    move_sprite(7U, wX + 8U, wY + 8U);
  } else {
    move_sprite(4U, 200, 200); // Worm
    move_sprite(5U, 200, 200);
    move_sprite(6U, 200, 200);
    move_sprite(7U, 200, 200);
  }
}

static void checkCollision() {
  if ((bX < (wX + 8U)) && ((bX + 8U) > wX) && (bY < (8U + wY)) && ((bY + 8U) > wY)) {
    move_sprite(4U, 200, 200); // Worm
    move_sprite(5U, 200, 200);
    move_sprite(6U, 200, 200);
    move_sprite(7U, 200, 200);

    set_sprite_tile(0U, 16U); // Bird
    set_sprite_tile(1U, 17U);
    set_sprite_tile(2U, 18U);
    set_sprite_tile(3U, 19U);

    mgStatus = WON;
  }
}