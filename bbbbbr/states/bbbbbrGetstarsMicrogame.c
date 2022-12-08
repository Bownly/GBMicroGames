#include <gbdk/platform.h>
#include <rand.h>
#include <stdbool.h>

#include "../../Engine/common.h"
#include "../../Engine/enums.h"
#include "../../Engine/fade.h"
#include "../../Engine/songPlayer.h"

// #include "../enums.h"
// #include "../sfx.h"

#include "../res/maps/bbbbbr_getstars_map.h"

#include "../res/sprites/bbbbbr_stars.h"
#include "../res/sprites/bbbbbr_singlestar.h"
#include "../res/sprites/bbbbbr_bomb.h"
#include "../res/sprites/bbbbbr_getstars_player.h"

// TODO:
// - More accomodations for unmodded DMG/MGB screens? (less motion? make the stars "Hang" at the top of the arc for a moment?)

// #define DIFFICULTY_EXTRAHARD
// #define DIFFICULTY_HARD
#define DIFFICULTY_MEDIUM
// #define DIFFICULTY_EASY


// =========================================


typedef enum {
    STAR_READY,
    STAR_LAUNCHED,
    STAR_DROPPING,
    STAR_LAST,
    STAR_OFF
} STAR_STATES;

typedef enum {
    PLAYER_IDLE,
    PLAYER_WALKING,
    PLAYER_IN_AIR
} ENTITY_STATES;

#define PX_PER_TILE   8u
#define ENTITY_BSHIFT 4u  // 4 bits fixed point precision

#define FLOOR_Y           (15u * PX_PER_TILE)

#define PLAYER_X_START    (((DEVICE_SCREEN_PX_WIDTH - bbbbbr_getstars_player_WIDTH) / 2u)  << ENTITY_BSHIFT)
#define PLAYER_Y_START    ((FLOOR_Y - bbbbbr_getstars_player_HEIGHT) << ENTITY_BSHIFT)

// #define PLAYER_JUMP_SPEED  (3u << ENTITY_BSHIFT)
#define PLAYER_JUMP_SPEED  (3u << ENTITY_BSHIFT)
#define PLAYER_BASE_SPEED  (2u << ENTITY_BSHIFT)

#define PLAYER_PIVOT_W_GAP ((bbbbbr_getstars_player_WIDTH - bbbbbr_getstars_player_PIVOT_W) / 2u)
#define PLAYER_PIVOT_H_GAP ((bbbbbr_getstars_player_HEIGHT - bbbbbr_getstars_player_PIVOT_H) / 2u)

#define JUMP_DURATION      8u
#define JUMP_GRAVITY       3u
#define JUMP_MAX_VEL       (int16_t)(3u << ENTITY_BSHIFT)

#define LEFT_BOUND_PX    1u
#define RIGHT_BOUND_PX   ((DEVICE_SCREEN_PX_WIDTH - LEFT_BOUND_PX) - bbbbbr_getstars_player_WIDTH)
#define BOTTOM_BOUND_PX  (FLOOR_Y - bbbbbr_getstars_player_HEIGHT)

#define STAR_SINGLE_FRAME     0u // First star in it's metasprite frames is the single one
#define STAR_Y_START          ((DEVICE_SCREEN_PX_HEIGHT + bbbbbr_singlestar_HEIGHT) << ENTITY_BSHIFT)// start just off-screen (bottom)
//#define STAR_LAUNCH_SPEED     (7u << ENTITY_BSHIFT)
#define STAR_MOVE_SPEED       0u // Stars don't move left/right
#define STAR_BOUND_Y_PX  (FLOOR_Y - bbbbbr_singlestar_HEIGHT)  // bottom bound is just below launch location (ars up, then down and below)
#define STAR_BOUND_X_PX  (DEVICE_SCREEN_PX_WIDTH)  // X bound is off-screen to the right, works for left and right due to unsigned wraparound

#define STAR_COUNT_RESET  0u;

#define STAR_LAUNCH_DIVISIONS         10u
#define STAR_LAUNCH_DIVISIONS_BORDER   2u
#define STAR_LAUNCH_DIVISION_RANGE    (STAR_LAUNCH_DIVISIONS - (STAR_LAUNCH_DIVISIONS_BORDER *2u))
#define STAR_LAUNCH_DIVISION_SZ (DEVICE_SCREEN_PX_WIDTH / STAR_LAUNCH_DIVISIONS)

#define STAR_GRAVITY       3u
#define STAR_MAX_VEL       (int16_t)(4u << ENTITY_BSHIFT)

#if defined(DIFFICULTY_EXTRAHARD)
    #define STAR_LAUNCH_LEFT (16u)
#elif defined(DIFFICULTY_HARD)
    #define STAR_LAUNCH_LEFT (20u)
#elif defined(DIFFICULTY_MEDIUM)
    #define STAR_LAUNCH_LEFT (30u)
#else
    #define STAR_LAUNCH_LEFT (40u)
#endif
#define STAR_LAUNCH_RIGHT ((DEVICE_SCREEN_PX_WIDTH - 1)- (STAR_LAUNCH_LEFT + bbbbbr_singlestar_WIDTH))

// =========================================


static void sfx_jump()
{
    NR10_REG = 0x46;
    NR11_REG = 0x01;
    NR12_REG = 0xF1;
    NR13_REG = 0x0F;
    NR14_REG = 0x86;
}

static void sfx_blah()
{
    NR10_REG = 0x2A;
    NR11_REG = 0x42;
    NR12_REG = 0xF2;
    NR13_REG = 0x37;
    NR14_REG = 0x86;
}

static void sfx_happybleep()
{
    NR10_REG = 0x45;
    NR11_REG = 0x96;
    NR12_REG = 0xF2;
    NR13_REG = 0x9B;
    NR14_REG = 0x86;
}

static void sfx_sparkle()
{
    NR10_REG = 0x66;
    NR11_REG = 0x83;
    NR12_REG = 0xF6;
    NR13_REG = 0xD0;
    NR14_REG = 0x86;
}

// =========================================

extern const hUGESong_t bbbbbrTwilightDriveSong;

// ==== Externs
extern uint8_t curJoypad;
extern uint8_t prevJoypad;
extern uint8_t i;  // Used mostly for loops
extern uint8_t j;  // Used mostly for loops
extern uint8_t k;  // Used for whatever
extern int8_t l;  // Used for whatever
extern uint8_t m;  // Used for menus generally
extern uint8_t n;  // Used for menus generally
extern uint8_t r;  // Used for randomization stuff

extern uint8_t substate;
extern uint8_t mgDifficulty;  // Readonly!
extern uint8_t mgSpeed;  // Readonly!
extern uint8_t mgStatus;

extern uint8_t animTick;
extern uint8_t animFrame;

typedef struct entity {
    uint16_t x;
    uint16_t y;
    int16_t   velX;
    int16_t   velY;
    uint8_t  state;
    uint8_t  tileBase;
    uint16_t  speedMoveX;
    uint16_t  speedJumpY;
    uint8_t  gravity;
    bool     faceLeft;

} entity;


// Locals
static entity player;
static entity starChart;
static entity starSingle;
static entity bomb;

static uint8_t starCount = 0U;
static uint8_t starCountMax = 0U;
static uint8_t starCountMetaSprOffset = 0u;
static uint8_t starSlot = 0u;
static const uint8_t starSlotsX[2] = {STAR_LAUNCH_LEFT, STAR_LAUNCH_RIGHT};

static uint8_t jumpTimer;

static uint8_t next_free_oam;
static uint8_t sprite_mode_save;


/* SUBSTATE METHODS */
static void phaseInit();
static void phaseLoop();

static void updateInput();

static void updatePlayerMovement();
static void updateStarMovement();

static void handleCollisions();

static bool checkStarCollision();
static bool checkBombCollision();

static void updatePlayerSprite();
static void updateStarSprite();

inline bool isLevelWon(void) {
    return (mgStatus == WON);
}

inline void setLevelWon(void) {
    mgStatus = WON;
}


void bbbbbrGetStarsMicrogameMain()
{
    curJoypad = joypad();

    switch (substate)
    {
        case SUB_INIT:
            phaseInit();
            break;
        case SUB_LOOP:
            phaseLoop();
            break;
        default:  // Abort to title in the event of unexpected state
            gamestate = STATE_TITLE;
            substate = SUB_INIT;
            break;
    }
    prevJoypad = curJoypad;
    // TODO: Cleanup
    // Restore previous sprite mode
    // LCDC_REG |= sprite_mode_save;
}


static uint8_t loadSpriteTiles(uint8_t startTileID, uint8_t * p_entityTileBase, uint8_t tileCount, uint8_t * p_tile_patterns) {

    *p_entityTileBase = startTileID;
    set_sprite_data(startTileID, tileCount, p_tile_patterns);
    return (startTileID + tileCount);
}

/******************************** SUBSTATE METHODS *******************************/
static void phaseInit()
{
    // Uses 8x16 mode, but main game uses 8x8, so save and restore it
    // sprite_mode_save = LCDC_REG & LCDCF_B_OBJ16;
    // SPRITES_8x16;

    animTick = 0U;

    // Init Player
    player.x = PLAYER_X_START;
    player.y = PLAYER_Y_START;
    player.velX = 0U;
    player.velY = 0U;
    player.gravity = JUMP_GRAVITY + mgSpeed;
    player.speedJumpY = PLAYER_JUMP_SPEED + (mgSpeed << (ENTITY_BSHIFT - 1u));
    // player.speedMoveX = PLAYER_BASE_SPEED + (mgSpeed << (ENTITY_BSHIFT - 1u));  // Adjust player movement based on game speed
                                            // TODO: Adjust gravity speed too?
    player.faceLeft = false;
    player.state = PLAYER_IDLE;
    jumpTimer = 0U;

    // Init Stars
    starSingle.state = STAR_READY;
    starSingle.speedMoveX = STAR_MOVE_SPEED;

    // Adjust star launch speed / gravity and player speed based on mgSpeed (0 - 2)
    switch (mgSpeed) {
        case 0:
            // Slow
            starSingle.gravity = STAR_GRAVITY;
            starSingle.speedJumpY = (7u << ENTITY_BSHIFT);
            player.speedMoveX = PLAYER_BASE_SPEED;
            break;

        case 1:
            // Slow Medium
            starSingle.gravity = STAR_GRAVITY + 2u;
            starSingle.speedJumpY = (9u << ENTITY_BSHIFT);
            player.speedMoveX = PLAYER_BASE_SPEED + (1 << (ENTITY_BSHIFT - 1u));
            break;

        case 2:
            // Fast
            starSingle.gravity = STAR_GRAVITY + 6u;
            starSingle.speedJumpY = (12u << ENTITY_BSHIFT);
            player.speedMoveX = PLAYER_BASE_SPEED + (3 << (ENTITY_BSHIFT - 1u));
            break;
    }

    starCount = STAR_COUNT_RESET;
    starCountMax = mgDifficulty + 1; // Range is 0 - 2

    // Star Chart metapsrite source looks like:
    //                     [ ] [ ] [ ] [x]
    //         [ ] [ ] [x] [ ] [ ] [x] [x]
    // [ ] [x] [ ] [x] [x] [ ] [x] [x] [x]
    switch (mgDifficulty)     {
        default:
        case 0U:
            starCountMetaSprOffset = 0u; // Chart with 1 star to fill
            break;
        case 1U:
            starCountMetaSprOffset = 2u; // Chart with 2 stars to fill
            break;
        case 2U:
            starCountMetaSprOffset = 5u; // Chart with 3 stars to fill
            break;
    }

    // == Background setup: Load tile patterns and set map ==
    // BG Tile Patterns Reserved for engine: 0x00-0x2F, 0xF0-0xFF.
    #define MG_START_TILES 0x30u
    set_bkg_data((MG_START_TILES), bbbbbr_getstars_map_TILE_COUNT, bbbbbr_getstars_map_tiles);
    set_bkg_based_tiles(0u, 0u, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, bbbbbr_getstars_map_map, (MG_START_TILES));

    // == Sprite setup ==
    // Sprites Reserved for engine: #39
    uint8_t next_free_spr_tile = 0u;

    next_free_spr_tile = loadSpriteTiles(next_free_spr_tile, &player.tileBase, bbbbbr_getstars_player_TILE_COUNT, bbbbbr_getstars_player_tiles);
    next_free_spr_tile = loadSpriteTiles(next_free_spr_tile, &starChart.tileBase, bbbbbr_stars_TILE_COUNT, bbbbbr_stars_tiles);
    next_free_spr_tile = loadSpriteTiles(next_free_spr_tile, &starSingle.tileBase, bbbbbr_singlestar_TILE_COUNT, bbbbbr_singlestar_tiles);
    next_free_spr_tile = loadSpriteTiles(next_free_spr_tile, &bomb.tileBase, bbbbbr_bomb_TILE_COUNT, bbbbbr_bomb_tiles);

    // playSong(&bbbbbrTwilightDriveSong);

    fadein();
    substate = SUB_LOOP;
}

static void phaseLoop()
{
    // Reset OAM current frame OAM usage counter
    next_free_oam = 0u;

    ++animTick;

    updateInput();
    updatePlayerMovement();
    updateStarMovement();

    handleCollisions();

    updatePlayerSprite();
    updateStarSprite();

    // Clean up rest of OAM until reserved slot
    hide_sprites_range(next_free_oam, 38u); // Sprite 39 is reserved
}


/******************************** INPUT METHODS *********************************/
static void updateInput()
{
    // Movement
    if (curJoypad & (J_LEFT | J_RIGHT)) {
        switch (player.state)
        {
            case PLAYER_IDLE:
            case PLAYER_WALKING:
                player.state = PLAYER_WALKING;
            case PLAYER_IN_AIR:
                player.velX = player.speedMoveX;
                break;
        }
        player.faceLeft = (curJoypad & (J_LEFT)) ? true : false;
    }
    else if ((curJoypad & (J_LEFT | J_RIGHT)) == 0u) {
        // Neither left nor right pressed, zero velocity and set PLAYER_idle if not jumping
        if (player.state == PLAYER_WALKING)
            player.state = PLAYER_IDLE;
        player.velX = 0;
    }

    // Jumping
    if (curJoypad & J_A)
    {
        if ((player.state == PLAYER_IDLE || player.state == PLAYER_WALKING) && !(prevJoypad & J_A))  // Start jump
        {
            sfx_jump();
            ++jumpTimer;
            player.velY = -player.speedJumpY;
            player.state = PLAYER_IN_AIR;
            // playBleepSfx(); // TODO: Jump SFX
        }
        else if ((player.state == PLAYER_IN_AIR) && (jumpTimer != JUMP_DURATION))  // Continue jump
        {
            ++jumpTimer;
            player.velY = -player.speedJumpY;
        }
    }
    else if (player.state == PLAYER_IN_AIR)
    {
        jumpTimer = JUMP_DURATION;
    }
}


/******************************** HELPER METHODS *********************************/
// TODO: make generic to entity and accept pointer
static void updatePlayerMovement()
{
    static uint8_t x_px, y_px;

    // Hypothetical coords that include velocity changes
    if ((player.faceLeft) && (player.x < player.velX)) player.x = 0;  // Prevent unsigned wraparound on X, clamp to 0
    else player.x += (player.faceLeft) ? -player.velX : player.velX;

    if (player.state == PLAYER_IN_AIR)
        player.y += player.velY;

    x_px = player.x >> ENTITY_BSHIFT;
    y_px = player.y >> ENTITY_BSHIFT;

    // Left right screen edge collision, reset speed if reached edge
    if (x_px < LEFT_BOUND_PX) {
        player.x = LEFT_BOUND_PX << ENTITY_BSHIFT;
        player.velX = 0U;
    }
    else if (x_px > RIGHT_BOUND_PX)
    {
        player.x = RIGHT_BOUND_PX << ENTITY_BSHIFT;
        player.velX = 0U;
    }

    if (player.state == PLAYER_IN_AIR)
    {
        if (y_px > BOTTOM_BOUND_PX) {
            // Player landed, reset jumping/falling
            player.state = PLAYER_IDLE;
            jumpTimer = 0U;
            player.velX = 0U;
            player.y = (BOTTOM_BOUND_PX) << ENTITY_BSHIFT;
        }
        else {
            // Still in air. Apply gravity and clamp speed
            player.velY += player.gravity;
            if (player.velY > JUMP_MAX_VEL)
                player.velY = JUMP_MAX_VEL;
        }
    }
}


/******************************** DISPLAY METHODS ********************************/
// static void animateHearts()
// {
//     set_bkg_data(BKGID_HEART, 1U, &bownlyPastelHeartTiles[((animTick >> 3U) % 2U) << 4U]);
// }

static void updatePlayerSprite()
{
    static uint8_t x_px, y_px;

    x_px = player.x >> ENTITY_BSHIFT;
    y_px = player.y >> ENTITY_BSHIFT;

    switch (player.state)
    {
        case PLAYER_IDLE:
        case PLAYER_WALKING:
        default:
            animFrame = (animTick >> 4u) & 0x01u;
            // animFrame = 0x00;
            break;
        case PLAYER_IN_AIR:
            animFrame = 2u;
            break;
    }

    // TODO: Separate animation states for Left Vs Right?
    // Flip doesn't interact nicely with pivot set at negative offset
    next_free_oam += move_metasprite(bbbbbr_getstars_player_metasprites[animFrame], player.tileBase, next_free_oam, x_px, y_px);

    // Move carried stars around
    uint8_t stars_frame = starCountMetaSprOffset + starCount;
    next_free_oam += move_metasprite(bbbbbr_stars_metasprites[stars_frame], starChart.tileBase, next_free_oam, x_px + ((bbbbbr_getstars_player_WIDTH - bbbbbr_stars_WIDTH) / 2u), y_px - bbbbbr_stars_HEIGHT);
}


static void updateStarSprite()
{
    // When star is rising use a lighter meta sprite, when dropping and catchable use a dark one
    uint8_t star_frame = (starSingle.state == STAR_DROPPING) ? 1u : 0u;

    if (starSingle.state != STAR_OFF) {
        next_free_oam += move_metasprite(bbbbbr_singlestar_metasprites[star_frame], starSingle.tileBase, next_free_oam, (starSingle.x >> ENTITY_BSHIFT), starSingle.y >> ENTITY_BSHIFT);

        // Bomb is at opposite X and same Y as single star sprite
        next_free_oam += move_metasprite(bbbbbr_bomb_metasprites[star_frame],       bomb.tileBase,       next_free_oam, (bomb.x >> ENTITY_BSHIFT),       bomb.y >> ENTITY_BSHIFT);
    }
}


void updateStarMovement(void) {

    switch (starSingle.state) {

        case STAR_READY:
            bomb.y = starSingle.y = STAR_Y_START;
            // Choose random left/right x position for launching star, with bomb as opposite side
            starSlot = getRandUint8(2u);
            starSingle.x = starSlotsX[starSlot] << ENTITY_BSHIFT;
            bomb.x = starSlotsX[starSlot ^ 0x01] << ENTITY_BSHIFT;  // Opposite Left/Right location as star

            // Star moves left if launched from Right side & vice-versa
            starSingle.velX = (starSingle.x > (DEVICE_SCREEN_PX_WIDTH / 2u)) ? -starSingle.speedMoveX : starSingle.speedMoveX;
            starSingle.velY = -starSingle.speedJumpY;
            starSingle.state = STAR_LAUNCHED;
            break;

        case STAR_DROPPING:
            // If star reached bottom either stop stars if level was won or set for re-spawn
            if ((starSingle.y >> ENTITY_BSHIFT) > STAR_BOUND_Y_PX) {
                if (isLevelWon()) {
                    starSingle.y = STAR_Y_START;
                    starSingle.state = STAR_LAST;
                } else
                    starSingle.state = STAR_READY;
            }
            // Fall through to dropping state

        case STAR_LAUNCHED:
            starSingle.y += starSingle.velY;
            starSingle.x += starSingle.velX;

            // Apply gravity and clamp speed
            starSingle.velY += starSingle.gravity;
            if (starSingle.velY > STAR_MAX_VEL)
                starSingle.velY = STAR_MAX_VEL;

            // Once falling, change state
            if (starSingle.state == STAR_LAUNCHED)
                if (starSingle.velY > 0)
                    starSingle.state = STAR_DROPPING;
            break;

        case STAR_LAST:
            starSingle.state = STAR_OFF;
            break;

        case STAR_OFF:
            // Do nothing
            break;
    }

    // Bomb matches star Y always
    bomb.y = starSingle.y;
}

static bool checkStarCollision() {

    uint8_t star_x_px = starSingle.x >> ENTITY_BSHIFT;
    uint8_t star_y_px = starSingle.y >> ENTITY_BSHIFT;
    uint8_t player_x_px = player.x >> ENTITY_BSHIFT;
    uint8_t player_y_px = player.y >> ENTITY_BSHIFT;

    // Check for non-overlap X
    if (star_x_px > (player_x_px + bbbbbr_getstars_player_PIVOT_W + PLAYER_PIVOT_W_GAP))
        return false;
    if ((star_x_px + bbbbbr_singlestar_WIDTH) < (player_x_px + PLAYER_PIVOT_W_GAP))
        return false;

    // Check for non-overlap Y
    if (star_y_px > (player_y_px + bbbbbr_getstars_player_PIVOT_H + PLAYER_PIVOT_H_GAP))
        return false;
    if ((star_y_px + bbbbbr_singlestar_HEIGHT) < (player_y_px + PLAYER_PIVOT_H_GAP))
        return false;

    return true;
}

static bool checkBombCollision() {

    uint8_t bomb_x_px = bomb.x >> ENTITY_BSHIFT;
    uint8_t bomb_y_px = bomb.y >> ENTITY_BSHIFT;
    uint8_t player_x_px = player.x >> ENTITY_BSHIFT;
    uint8_t player_y_px = player.y >> ENTITY_BSHIFT;

    // Check for non-overlap X
    if (bomb_x_px > (player_x_px + bbbbbr_getstars_player_PIVOT_W + PLAYER_PIVOT_W_GAP))
        return false;
    if ((bomb_x_px + bbbbbr_bomb_WIDTH) < (player_x_px + PLAYER_PIVOT_W_GAP))
        return false;

    // Check for non-overlap Y
    if (bomb_y_px > (player_y_px + bbbbbr_getstars_player_PIVOT_H + PLAYER_PIVOT_H_GAP))
        return false;
    if ((bomb_y_px + bbbbbr_bomb_HEIGHT) < (player_y_px + PLAYER_PIVOT_H_GAP))
        return false;

    return true;
}


static void handleCollisions(void) {
        // Star can only be caught in the dropping state
    if ((!isLevelWon()) && (starSingle.state == STAR_DROPPING)) {

        if (checkStarCollision()) {

            if (starCount < starCountMax)
                starCount++;

            if (starCount == starCountMax) {

                sfx_sparkle();
                setLevelWon();
                // Queue star up for last redraw - TODO: NECESSARY?
                bomb.y = starSingle.y = STAR_Y_START;
                starSingle.state = STAR_LAST;
           } else {
                starSingle.state = STAR_READY;
                sfx_happybleep();
           }
        }
        else if (checkBombCollision()) {

            sfx_blah();
            starSingle.state = STAR_READY;
        }
    }
}
