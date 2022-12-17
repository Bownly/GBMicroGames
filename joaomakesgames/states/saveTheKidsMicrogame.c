/* 
* In this this microgame you have to pop the balloons to save the kids.
*/

#include <gb/gb.h>
#include <stdbool.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../resources/sprites/Aim.h"
#include "../resources/sprites/Balloons.h"
#include "../resources/sprites/BalloonsPopping.h"
#include "../resources/sprites/Ui.h"
#include "../resources/sprites/ThumbsUp.h"
#include "../resources/background/Background.h"
#include "../resources/background/BackgroundTiles.h"
#include "../sound.h"

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 l; // Used for whatever
extern UINT8 k;  // Used for whatever
extern UINT8 m;  // Tracks kids on the ground
extern UINT8 substate;
extern UINT8 mgDifficulty;  // Readonly! 0, 1 or 2
extern UINT8 mgSpeed;  // Readonly! 0, 1 or 2
extern UINT8 mgStatus; // WON or LOST enum

struct J_Aim {
   UINT8 x;
   UINT8 y; 
} j_aim;

struct J_Balloon {
   UINT8 x;
   UINT8 y;
   UINT8 anim;
   UINT8 animCounter;
   UINT8 thumbsAnim;
   UINT8 thumbsAnimCounter;
   UINT8 kid;
   bool done;
   bool hit;
   bool thumbs;
   bool playedDong;
   bool playedPopAnim;
} j_balloons[3];

struct J_UiKid {
    UINT8 s;
    UINT8 x;
    UINT8 y;
} j_uiKids[3];

#define SPRTILE_J_AIM 0x00U  
#define SPRTILE_J_BALLOON 0x01U
#define SPRTILE_J_UI_KID 0x11U
#define SPRTILE_J_THUMBS_UP 0x12U
#define SPRTILE_J_BALLOON_POP 0x15U

static void j_updateAimLocation();
static void j_init();
static void j_loop();
static void j_initAim();
static void j_initBalloons();
static void j_initUI();
static void j_updateBalloons();
static bool j_hasWon();
static UINT8 j_randomBetween(UINT8 min, UINT8 max);
static void j_moveBalloon(UINT8 i);
static void j_removeBalloon(UINT8 i);
static void spawnThumbsUp(UINT8 i);
static void j_animateThumbs(UINT8 i);

void joaoSaveTheKidsMicrogameMain()
{
    switch (substate)
    {
        case SUB_INIT:
            j_init();
            break;
        case SUB_LOOP:
            j_loop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
}


static void j_loop()
{
    j_updateBalloons();

    if (curJoypad & J_LEFT)
    {
        j_aim.x--;
        j_updateAimLocation();
    }
    else if (curJoypad & J_RIGHT)
    {
        j_aim.x++;
        j_updateAimLocation();
    }
    
    if (curJoypad & J_UP)
    {
        j_aim.y--;
        j_updateAimLocation();
    }
    else if (curJoypad & J_DOWN)
    {
        j_aim.y++;
        j_updateAimLocation();
    }

    if (curJoypad & J_A && !(prevJoypad & J_A))
    {
        bool won = j_hasWon();

        if (won == true)
        {
            mgStatus = WON;
        }
    }
}

static void j_init()
{
    init_bkg(0xFFU);
    set_bkg_data(0x40U, 16U, JBackgroundTiles);
    set_bkg_tiles(0, 0, 20, 18, JBackground);
    j_initAim();
    j_initBalloons();
    j_initUI();
    fadein();
    substate = SUB_LOOP;
}

static void j_initAim() 
{
    set_sprite_data(SPRTILE_J_AIM, 1U, aim);
    set_sprite_tile(0U, SPRTILE_J_AIM);
    j_aim.x = 84;
    j_aim.y = 76;
    j_updateAimLocation();
}

static void j_initUI() 
{
    set_sprite_data(SPRTILE_J_UI_KID, 1U, Ui);

    for (int i = 0; i < mgDifficulty + 1; i++)
    {
        j_uiKids[i].x = 8*i + 10;
        j_uiKids[i].y = 18;
        j_uiKids[i].s = 25U + i;

        set_sprite_tile(j_uiKids[i].s, SPRTILE_J_UI_KID);
        move_sprite(j_uiKids[i].s, j_uiKids[i].x, j_uiKids[i].y);
    }

    k = mgDifficulty;
    m = 0;
}

static void j_initBalloons() 
{
    set_sprite_data(SPRTILE_J_BALLOON, 16U, Balloons);
    set_sprite_data(SPRTILE_J_THUMBS_UP, 3U, ThumbsUp);
    set_sprite_data(SPRTILE_J_BALLOON_POP, 16U, BalloonsPopping);

    for (int i = 0; i < mgDifficulty + 1; i++)
    {
        j_balloons[i].y = j_randomBetween(90, 102);

        if (i == 0) {
            j_balloons[i].x = j_randomBetween(10, 54);
        }
        else if (i == 1) {
            j_balloons[i].x = j_randomBetween(70, 116);
        }
        else {
            j_balloons[i].x = j_randomBetween(130, 144);
        }
        
        j_balloons[i].hit = false;
        j_balloons[i].done = false;
        j_balloons[i].thumbsAnim = 0;
        j_balloons[i].thumbsAnimCounter = 0;
        j_balloons[i].thumbs = true;
        j_balloons[i].kid = 0;
        j_balloons[i].playedDong = false;
        j_balloons[i].playedPopAnim = false;

        for (UINT8 j = 0; j < 8; j++) 
        {
            set_sprite_tile(1U + (i*8) + j, SPRTILE_J_BALLOON + j);
        }

        set_sprite_tile(28U + i, SPRTILE_J_THUMBS_UP);
        j_moveBalloon(i);
    }

    for (int i = 0; i < 4; i++) {
        set_sprite_tile(30U + i, SPRTILE_J_BALLOON + i);
    }
}

static void j_updateBalloons()
{
    for (int i = 0; i < mgDifficulty + 1; i++)
    {
        j_balloons[i].animCounter++;

        if (j_balloons[i].animCounter > 12) 
        {
            j_balloons[i].animCounter = 0;
            if (j_balloons[i].anim == 1) 
            { 
                for (UINT8 j = 8; j < 16; j++) 
                {
                    set_sprite_tile(1U + (i*8) + j - 8, SPRTILE_J_BALLOON + j);
                }
                j_balloons[i].anim = 0;
            }
            else {
                for (UINT8 j = 0; j < 8; j++) 
                {
                    set_sprite_tile(1U + (i*8) + j, SPRTILE_J_BALLOON + j);
                }
                j_balloons[i].anim = 1;
            }
        }

        if (j_balloons[i].hit == false) {
            if (j_balloons[i].animCounter % (5 - (mgSpeed + 1)) == 0)
            {
                j_balloons[i].y--;
                j_moveBalloon(i);
            }
        }
        else if (j_balloons[i].y < 110) {
            j_balloons[i].y+=2;
            j_moveBalloon(i);
        }
        else if (j_balloons[i].done == false){
            j_removeBalloon(i);
        }
        else if (j_balloons[i].done == true) {
            j_animateThumbs(i);
        }
    }
}

static void j_updateAimLocation()
{
    move_sprite(0U, j_aim.x, j_aim.y);
}

static bool j_hasWon()
{
    bool won = true;

    for (int i = 0; i < mgDifficulty + 1; i++)
    {
        if (j_aim.x + 4 >= j_balloons[i].x && j_aim.x + 4 <= j_balloons[i].x + 16 && j_aim.y + 4 >= j_balloons[i].y && j_aim.y + 4 <= j_balloons[i].y + 16) {
            j_balloons[i].hit = true;
            move_sprite(j_uiKids[k].s, 0, 0);
            k--;
            j_playBalloonPop();
        }

        if (j_balloons[i].hit == false) {
            won = false;
        }
    }

    return won;
}

static UINT8 j_randomBetween(UINT8 min, UINT8 max)
{
    return rand() % (max + 1 - min) + min;
}

static void j_moveBalloon(UINT8 i) 
{
    if (j_balloons[i].done != true) {
        if (j_balloons[i].hit == false) {
            move_sprite(1U + (i*8), j_balloons[i].x, j_balloons[i].y);
            move_sprite(2U + (i*8), j_balloons[i].x, j_balloons[i].y + 8);
            move_sprite(3U + (i*8), j_balloons[i].x + 8, j_balloons[i].y);
            move_sprite(4U + (i*8), j_balloons[i].x + 8, j_balloons[i].y + 8);
        }
        else {
            for (int j = 0; j < 4; j++) {
                move_sprite(1U + j + (i*8), 0, 0);
            }

            if (j_balloons[i].playedPopAnim == false) {
                move_sprite(30U, j_balloons[i].x, j_balloons[i].y);
                move_sprite(31U, j_balloons[i].x, j_balloons[i].y + 8);
                move_sprite(32U, j_balloons[i].x + 8, j_balloons[i].y);
                move_sprite(33U, j_balloons[i].x + 8, j_balloons[i].y + 8);

                for (int j = 0; j < 4; j++) {
                    for (int z = 0; z < 4; z++) {
                        set_sprite_tile(30U + z, SPRTILE_J_BALLOON_POP + z + j*4);
                    }
                    wait_vbl_done();
                }

                for (int j = 0; j < 4; j++) {
                    move_sprite(30U + j, 0, 0);
                }

                j_balloons[i].playedPopAnim = true;
            }
        }

        move_sprite(5U + (i*8), j_balloons[i].x, j_balloons[i].y + 16);
        move_sprite(6U + (i*8), j_balloons[i].x, j_balloons[i].y + 24);
        move_sprite(7U + (i*8), j_balloons[i].x + 8, j_balloons[i].y + 16);
        move_sprite(8U + (i*8), j_balloons[i].x + 8, j_balloons[i].y + 24);
    }
}

static void j_removeBalloon(UINT8 i) {
    for (int j = 0; j < 4; j++) {
        move_sprite(5U + j + (i*8), 0, 0);
    }

    j_balloons[i].done = true;
    spawnThumbsUp(i);
}

static void spawnThumbsUp(UINT8 i) {
    move_sprite(28U + m, j_balloons[i].x + 8, j_balloons[i].y + 16);
    j_balloons[i].kid = m;
    m++;
    j_playDing();
}

static void j_animateThumbs(UINT8 i) {
    j_balloons[i].thumbsAnimCounter++;

    if (j_balloons[i].thumbsAnimCounter > 3 && j_balloons[i].playedDong == false) {
        j_playDong();
        j_balloons[i].playedDong = true;
    }

    if (j_balloons[i].thumbsAnimCounter > 8) 
    {
        j_balloons[i].thumbsAnimCounter = 0;

        // ping pong animation 0 1 2 1 0 1 2 1 0
        if (j_balloons[i].thumbsAnim < 2 && j_balloons[i].thumbs == true) {
            j_balloons[i].thumbsAnim++;
        }
        else if (j_balloons[i].thumbsAnim >= 2 && j_balloons[i].thumbs == true) {
            j_balloons[i].thumbs = false;
            j_balloons[i].thumbsAnim--;
        }
        else if (j_balloons[i].thumbsAnim > 0 && j_balloons[i].thumbs == false) {
            j_balloons[i].thumbsAnim--;
        }
        else {
            j_balloons[i].thumbsAnim++;
            j_balloons[i].thumbs = true;
        }

        set_sprite_tile(28U + j_balloons[i].kid, SPRTILE_J_THUMBS_UP + j_balloons[i].thumbsAnim);
    }
}