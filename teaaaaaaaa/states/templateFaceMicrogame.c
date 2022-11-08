#pragma bank 8
/* This microgame features moles. Yeah...
// The player controls a character that has to whack every one.
// Pressing A will make the character use his hammer.
// The game is won when all moles are whacked.
// The game is lost if the player fails to whack all the moles in time.
*/

#include <gb/gb.h>
#include <rand.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

#include "../enums.h"
#include "../res/tiles/WhackMoleSpriteGraphics.h"
#include "../res/tiles/WhackMoleSpriteTileData.h"
#include "../res/tiles/WhackMoleBGgraphics.h"
#include "../res/maps/WhackMolesBG.h"

extern const hUGESong_t whackMolesMusic;

extern UINT8 curJoypad;
extern UINT8 prevJoypad;
extern UINT8 i;  // Used mostly for loops
extern UINT8 j;  // Used mostly for loops
extern UINT8 k;  // Used for whatever
extern INT8 l;  // Used for whatever
extern UINT8 m;  // Used for menus generally
extern UINT8 n;  // Used for menus generally
extern UINT8 r;  // Used for randomization stuff

extern UINT8 substate;
extern UINT8 mgDifficulty;  // Readonly!
extern UINT8 mgSpeed;  // Readonly!
extern UINT8 mgStatus;

extern UINT8 animTick;
extern UINT8 animFrame;

UINT8 teaaaPlayableSpriteX;
UINT8 teaaaPlayableSpriteY;
UINT8 teaaaflipSprite;
UINT8 teaaaAnimationState;
UINT8 teaaaAnimationSpeed;
UINT8 teaaaSpriteY;
UINT8 teaaaSprite1X;
UINT8 teaaaSprite2X;
UINT8 teaaaSprite3X;
UINT8 teaaaStoredFrame;
UINT8 teaaaFrameIndex;
UINT8 teaaaSpriteMemory;
UINT8 teaaaStoredSpriteX;
UINT8 numberOfMoles;

void whackMolesinitialize() BANKED
{
set_bkg_data(48,21,WMBGgraphics);
set_bkg_submap(0,0,20,18,whackMolesBG,20);
numberOfMoles = 3;
teaaaSpriteY = 88;
WMMoleFrameData[0] = 0;
WMMoleFrameData[1] = 0;
WMMoleFrameData[2] = 0;
WMMoleFrameData[3] = 0;
teaaaSprite1X = 20;
teaaaSprite2X = 80;
teaaaSprite3X = 140;
teaaaAnimationSpeed = 6;
animFrame = 0;
animTick = 6;
teaaaPlayableSpriteY = 104;
teaaaPlayableSpriteX = 70;
teaaaAnimationState = 0;
fadein();
playSong(&whackMolesMusic);
set_sprite_data(0,39,WMSpriteGraphics);
substate = SUB_LOOP;
}

void WhackMolesUpdateSprite() BANKED
{
if (teaaaStoredSpriteX > teaaaPlayableSpriteX - 16 & teaaaStoredSpriteX < teaaaPlayableSpriteX + 20)
{
if (animFrame == 36 & teaaaStoredFrame == 0)
{
teaaaStoredFrame = 6;
WMMoleFrameData[teaaaFrameIndex] = 6;
numberOfMoles --;
}
}
set_sprite_prop(teaaaSpriteMemory,0);
set_sprite_prop(teaaaSpriteMemory + 1,0);
set_sprite_prop(teaaaSpriteMemory + 2,0);
set_sprite_prop(teaaaSpriteMemory + 3,0);
set_sprite_prop(teaaaSpriteMemory + 4,0);
set_sprite_prop(teaaaSpriteMemory + 5,0);
set_sprite_tile(teaaaSpriteMemory,WMMoleTileData[teaaaStoredFrame]);
set_sprite_tile(teaaaSpriteMemory + 1,WMMoleTileData[teaaaStoredFrame + 1]);
set_sprite_tile(teaaaSpriteMemory + 2,WMMoleTileData[teaaaStoredFrame + 2]);
set_sprite_tile(teaaaSpriteMemory + 3,WMMoleTileData[teaaaStoredFrame + 3]);
set_sprite_tile(teaaaSpriteMemory + 4,WMMoleTileData[teaaaStoredFrame + 4]);
set_sprite_tile(teaaaSpriteMemory + 5,WMMoleTileData[teaaaStoredFrame + 5]);
move_sprite(teaaaSpriteMemory,teaaaStoredSpriteX - 8,teaaaSpriteY);
move_sprite(teaaaSpriteMemory + 1,teaaaStoredSpriteX,teaaaSpriteY);
move_sprite(teaaaSpriteMemory + 2,teaaaStoredSpriteX - 8,teaaaSpriteY + 8);
move_sprite(teaaaSpriteMemory + 3,teaaaStoredSpriteX,teaaaSpriteY + 8);
move_sprite(teaaaSpriteMemory + 4,teaaaStoredSpriteX - 8,teaaaSpriteY + 16);
move_sprite(teaaaSpriteMemory + 5,teaaaStoredSpriteX,teaaaSpriteY + 16);
}

void whackMolesLoop() BANKED
{
curJoypad = joypad();
animTick --;
if (curJoypad & J_RIGHT)
{
if (teaaaAnimationState < 1 & teaaaPlayableSpriteX < 159)
{
if (teaaaflipSprite == S_FLIPX)
{
teaaaAnimationState = 2;
animFrame = 45;
animTick = 4;
teaaaAnimationSpeed = 4;
}
else
{
teaaaPlayableSpriteX += 2;
teaaaAnimationSpeed = 6;
}
}
}
if (curJoypad & J_LEFT)
{
if (teaaaAnimationState < 1 & teaaaPlayableSpriteX > 12)
{
if (teaaaflipSprite == 0)
{
teaaaAnimationState = 2;
animFrame = 45;
animTick = 4;
teaaaAnimationSpeed = 4;
}
else
{
teaaaPlayableSpriteX -= 2;
teaaaAnimationSpeed = 6;
}
}
}
if (!(curJoypad & J_RIGHT) & !(curJoypad & J_LEFT) & teaaaAnimationState < 1)
{
animTick = 6;
animFrame = 0;
}
if (curJoypad & J_A)
{
if (!(prevJoypad & J_A))
{
animTick = 3;
teaaaAnimationSpeed = 3;
animFrame = 18;
teaaaAnimationState = 1;
}
}
if (animTick == 0)
{
animTick = teaaaAnimationSpeed;
animFrame += 9;
}
if (animFrame > 9 & teaaaAnimationState == 0)
{
animFrame = 0;
}
if (animFrame > 36 & teaaaAnimationState == 1)
{
teaaaAnimationState = 0;
animFrame = 0;
}
if (animFrame > 45)
{
teaaaAnimationState = 0;
animFrame = 0;
if (teaaaflipSprite == 0)
teaaaflipSprite = S_FLIPX;
else
teaaaflipSprite = 0;
}
set_sprite_tile(0,WMTileData[animFrame]);
set_sprite_tile(1,WMTileData[animFrame + 1]);
set_sprite_tile(2,WMTileData[animFrame + 2]);
set_sprite_tile(3,WMTileData[animFrame + 3]);
set_sprite_tile(4,WMTileData[animFrame + 4]);
set_sprite_tile(5,WMTileData[animFrame + 5]);
set_sprite_tile(6,WMTileData[animFrame + 6]);
set_sprite_tile(7,WMTileData[animFrame + 7]);
set_sprite_tile(8,WMTileData[animFrame + 8]);
set_sprite_prop(0,teaaaflipSprite);
set_sprite_prop(1,teaaaflipSprite);
set_sprite_prop(2,teaaaflipSprite);
set_sprite_prop(3,teaaaflipSprite);
set_sprite_prop(4,teaaaflipSprite);
set_sprite_prop(5,teaaaflipSprite);
set_sprite_prop(6,teaaaflipSprite);
set_sprite_prop(7,teaaaflipSprite);
set_sprite_prop(8,teaaaflipSprite);
teaaaStoredFrame = WMMoleFrameData[0];
teaaaFrameIndex = 0;
teaaaSpriteMemory = 9;
teaaaStoredSpriteX = teaaaSprite1X;
WhackMolesUpdateSprite();
teaaaStoredFrame = WMMoleFrameData[1];
teaaaFrameIndex = 1;
teaaaSpriteMemory = 15;
teaaaStoredSpriteX = teaaaSprite2X;
WhackMolesUpdateSprite();
teaaaStoredFrame = WMMoleFrameData[2];
teaaaFrameIndex = 2;
teaaaSpriteMemory = 21;
teaaaStoredSpriteX = teaaaSprite3X;
WhackMolesUpdateSprite();
if (numberOfMoles == 0)
{
mgStatus = WON;
}
if (teaaaflipSprite == 0)
{
move_sprite(0,teaaaPlayableSpriteX - 16,teaaaPlayableSpriteY - 16);
move_sprite(1,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY - 16);
move_sprite(2,teaaaPlayableSpriteX,teaaaPlayableSpriteY - 16);
move_sprite(3,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY - 8);
move_sprite(4,teaaaPlayableSpriteX,teaaaPlayableSpriteY - 8);
move_sprite(5,teaaaPlayableSpriteX - 16,teaaaPlayableSpriteY);
move_sprite(6,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY);
move_sprite(7,teaaaPlayableSpriteX,teaaaPlayableSpriteY);
move_sprite(8,teaaaPlayableSpriteX + 8,teaaaPlayableSpriteY);
}
else
{
move_sprite(0,teaaaPlayableSpriteX + 12,teaaaPlayableSpriteY - 16);
move_sprite(1,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY - 16);
move_sprite(2,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY - 16);
move_sprite(3,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY - 8);
move_sprite(4,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY - 8);
move_sprite(5,teaaaPlayableSpriteX + 12,teaaaPlayableSpriteY);
move_sprite(6,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY);
move_sprite(7,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY);
move_sprite(8,teaaaPlayableSpriteX - 12,teaaaPlayableSpriteY);
}
prevJoypad = curJoypad;
}

void whackMolesMicrogameMain() BANKED
{
// phaseFaceLoop();
// break;

switch (substate)
    {
        case SUB_INIT:
            whackMolesinitialize();
            break;
        case SUB_LOOP:
            whackMolesLoop();
            break;
        default:  // Abort to title in the event of unexpected state
        gamestate = STATE_TITLE;
        substate = SUB_INIT;
        break;
    }
}
