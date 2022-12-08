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
extern UINT16 mgTimeRemaining;
extern UINT8 mgTimerTickSpeed;

extern UINT8 animTick;
extern UINT8 animFrame;

UINT8 teaaaPlayableSpriteX;
UINT16 teaaaPlayableSpriteY;
UINT8 teaaaPlayableSpriteSpeed;
UINT8 teaaaDownshiftedPlayableSpriteY;
INT8 teaaaYVelocity;
UINT8 teaaaflipSprite;
UINT8 teaaaAnimationState;
UINT8 teaaaAnimationSpeed;
UINT8 teaaaSprite1X;
UINT8 teaaaSprite2X;
UINT8 teaaaSprite3X;
UINT8 teaaaSprite1Y;
UINT8 teaaaSprite2Y;
UINT8 teaaaSprite3Y;
UINT8 teaaaStoredFrame;
UINT8 teaaaFrameIndex;
UINT8 teaaaSpriteMemory;
UINT8 teaaaStoredSpriteX;
UINT8 teaaaStoredSpriteY;
UINT8 getTile1;
UINT8 getTile2;
UINT8 getTile3;
UINT8 getTile4;
UINT8 numberOfMoles;

const unsigned char teaaaaSpriteXPositions[] =
{
20,80,140,0,
20,80,150,0,
20,88,155,0,
70,90,40
};

const unsigned char teaaaaSpriteYPositions[] =
{
88,88,88,0,
48,88,64,0,
88,64,48,0,
};

void whackMolesinitialize() BANKED
{
set_bkg_data(48,21,WMBGgraphics);
set_bkg_submap(0,0,20,18,whackMolesBG + (mgDifficulty * (18 * 20)),20);
numberOfMoles = 3;
WMMoleFrameData[0] = 0;
WMMoleFrameData[1] = 0;
WMMoleFrameData[2] = 0;
WMMoleFrameData[3] = 0;
if (mgSpeed < 2)
{
teaaaPlayableSpriteSpeed = 2;
}
else
{
teaaaPlayableSpriteSpeed = 3;
}
teaaaSprite1X = teaaaaSpriteXPositions[(mgDifficulty << 2)];
teaaaSprite2X = teaaaaSpriteXPositions[(mgDifficulty << 2) + 1];
teaaaSprite3X = teaaaaSpriteXPositions[(mgDifficulty << 2) + 2];
teaaaSprite1Y = teaaaaSpriteYPositions[(mgDifficulty << 2)];
teaaaSprite2Y = teaaaaSpriteYPositions[(mgDifficulty << 2) + 1];
teaaaSprite3Y = teaaaaSpriteYPositions[(mgDifficulty << 2) + 2];
teaaaYVelocity = 0;
teaaaAnimationSpeed = 6;
animFrame = 0;
animTick = 6;
teaaaDownshiftedPlayableSpriteY = 104;
teaaaPlayableSpriteY = teaaaDownshiftedPlayableSpriteY << 4;
teaaaPlayableSpriteX = teaaaaSpriteXPositions[mgDifficulty + 12];
teaaaAnimationState = 0;
fadein();
playSong(&whackMolesMusic);
set_sprite_data(0,39,WMSpriteGraphics);
substate = SUB_LOOP;
}

void WhackMolesUpdateSprite() BANKED
{
if (teaaaStoredSpriteX > teaaaPlayableSpriteX - 16 & teaaaStoredSpriteX < teaaaPlayableSpriteX + 20 & teaaaStoredSpriteY < teaaaDownshiftedPlayableSpriteY + 16 & teaaaStoredSpriteY > teaaaDownshiftedPlayableSpriteY - 32)
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
move_sprite(teaaaSpriteMemory,teaaaStoredSpriteX - 8,teaaaStoredSpriteY);
move_sprite(teaaaSpriteMemory + 1,teaaaStoredSpriteX,teaaaStoredSpriteY);
move_sprite(teaaaSpriteMemory + 2,teaaaStoredSpriteX - 8,teaaaStoredSpriteY + 8);
move_sprite(teaaaSpriteMemory + 3,teaaaStoredSpriteX,teaaaStoredSpriteY + 8);
move_sprite(teaaaSpriteMemory + 4,teaaaStoredSpriteX - 8,teaaaStoredSpriteY + 16);
move_sprite(teaaaSpriteMemory + 5,teaaaStoredSpriteX,teaaaStoredSpriteY + 16);
}

void whackMolesLoop() BANKED
{
curJoypad = joypad();
animTick --;
if (teaaaYVelocity < 40)
{
teaaaYVelocity += 3;
}
if (curJoypad & J_RIGHT)
{
if (teaaaAnimationState < 1 & teaaaPlayableSpriteX < 157)
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
teaaaPlayableSpriteX += teaaaPlayableSpriteSpeed;
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
teaaaPlayableSpriteX -= teaaaPlayableSpriteSpeed;
teaaaAnimationSpeed = 6;
}
}
}
if (!(curJoypad & J_RIGHT) & !(curJoypad & J_LEFT) & teaaaAnimationState < 1)
{
animTick = 6;
animFrame = 0;
}
if (curJoypad & J_B)
{
if (!(prevJoypad & J_B))
{
animTick = 3;
teaaaAnimationSpeed = 3;
animFrame = 18;
teaaaAnimationState = 1;
}
}
getTile1 = get_bkg_tile_xy(teaaaPlayableSpriteX >> 3,(teaaaDownshiftedPlayableSpriteY >> 3) - 1);
getTile2 = get_bkg_tile_xy((teaaaPlayableSpriteX >> 3) - 1,(teaaaDownshiftedPlayableSpriteY >> 3) - 1);
getTile3 = get_bkg_tile_xy((teaaaPlayableSpriteX >> 3) - 2,(teaaaDownshiftedPlayableSpriteY >> 3) - 1);
if (teaaaYVelocity >= 0)
{
if (getTile1 == 62 || getTile2 == 62 || getTile3 == 62)
{
teaaaYVelocity = 0;
teaaaPlayableSpriteY = (((teaaaPlayableSpriteY >> 4) >> 3) << 7);
}
}
if (curJoypad & J_A)
{
if (!(prevJoypad & J_A))
{
if (getTile1 == 62 || getTile2 == 62 || getTile3 == 62)
{
if (teaaaYVelocity == 0)
teaaaYVelocity = -45;
}
}
}
teaaaPlayableSpriteY += teaaaYVelocity;
teaaaDownshiftedPlayableSpriteY = teaaaPlayableSpriteY >> 4;
if (teaaaDownshiftedPlayableSpriteY > 144)
{
mgTimeRemaining = mgTimerTickSpeed;
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
teaaaStoredSpriteY = teaaaSprite1Y;
WhackMolesUpdateSprite();
teaaaStoredFrame = WMMoleFrameData[1];
teaaaFrameIndex = 1;
teaaaSpriteMemory = 15;
teaaaStoredSpriteX = teaaaSprite2X;
teaaaStoredSpriteY = teaaaSprite2Y;
WhackMolesUpdateSprite();
teaaaStoredFrame = WMMoleFrameData[2];
teaaaFrameIndex = 2;
teaaaSpriteMemory = 21;
teaaaStoredSpriteX = teaaaSprite3X;
teaaaStoredSpriteY = teaaaSprite3Y;
WhackMolesUpdateSprite();
if (numberOfMoles == 0)
{
mgStatus = WON;
}
if (teaaaflipSprite == 0)
{
move_sprite(0,teaaaPlayableSpriteX - 16,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(1,teaaaPlayableSpriteX - 8,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(2,teaaaPlayableSpriteX,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(3,teaaaPlayableSpriteX - 8,teaaaDownshiftedPlayableSpriteY - 8);
move_sprite(4,teaaaPlayableSpriteX,teaaaDownshiftedPlayableSpriteY - 8);
move_sprite(5,teaaaPlayableSpriteX - 16,teaaaDownshiftedPlayableSpriteY);
move_sprite(6,teaaaPlayableSpriteX - 8,teaaaDownshiftedPlayableSpriteY);
move_sprite(7,teaaaPlayableSpriteX,teaaaDownshiftedPlayableSpriteY);
move_sprite(8,teaaaPlayableSpriteX + 8,teaaaDownshiftedPlayableSpriteY);
}
else
{
move_sprite(0,teaaaPlayableSpriteX + 12,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(1,teaaaPlayableSpriteX + 4,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(2,teaaaPlayableSpriteX - 4,teaaaDownshiftedPlayableSpriteY - 16);
move_sprite(3,teaaaPlayableSpriteX + 4,teaaaDownshiftedPlayableSpriteY - 8);
move_sprite(4,teaaaPlayableSpriteX - 4,teaaaDownshiftedPlayableSpriteY - 8);
move_sprite(5,teaaaPlayableSpriteX + 12,teaaaDownshiftedPlayableSpriteY);
move_sprite(6,teaaaPlayableSpriteX + 4,teaaaDownshiftedPlayableSpriteY);
move_sprite(7,teaaaPlayableSpriteX - 4,teaaaDownshiftedPlayableSpriteY);
move_sprite(8,teaaaPlayableSpriteX - 12,teaaaDownshiftedPlayableSpriteY);
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
