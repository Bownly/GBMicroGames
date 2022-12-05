;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyPastelMicrogame
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyPastelMicrogameMain
	.globl _playDingSfx
	.globl _playBleepSfx
	.globl _playSong
	.globl _fadein
	.globl _getRandUint8
	.globl _set_sprite_data
	.globl _get_bkg_tile_xy
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_x:
	.ds 2
_y:
	.ds 2
_pastelX:
	.ds 2
_pastelY:
	.ds 2
_pastelXVel:
	.ds 1
_pastelYVel:
	.ds 1
_pastelState:
	.ds 1
_xSpeedWalking:
	.ds 1
_xSpeedInAir:
	.ds 1
_ySpeedJumping:
	.ds 1
_jumpTimer:
	.ds 1
_jumppuffX:
	.ds 1
_jumppuffY:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_heartCount:
	.ds 1
_pastelFlipX:
	.ds 1
_JUMP_DURATION:
	.ds 1
_jumppuffTimer:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_2
;Bownly/states/bownlyPastelMicrogame.c:93: void bownlyPastelMicrogameMain()
;	---------------------------------
; Function bownlyPastelMicrogameMain
; ---------------------------------
_bownlyPastelMicrogameMain::
;Bownly/states/bownlyPastelMicrogame.c:95: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:97: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;Bownly/states/bownlyPastelMicrogame.c:99: case SUB_INIT:
00101$:
;Bownly/states/bownlyPastelMicrogame.c:100: phasePastelInit();
	call	_phasePastelInit
;Bownly/states/bownlyPastelMicrogame.c:101: break;
	jr	00104$
;Bownly/states/bownlyPastelMicrogame.c:102: case SUB_LOOP:
00102$:
;Bownly/states/bownlyPastelMicrogame.c:103: phasePastelLoop();
	call	_phasePastelLoop
;Bownly/states/bownlyPastelMicrogame.c:104: break;
	jr	00104$
;Bownly/states/bownlyPastelMicrogame.c:105: default:  // Abort to title in the event of unexpected state
00103$:
;Bownly/states/bownlyPastelMicrogame.c:106: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:107: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:109: }
00104$:
;Bownly/states/bownlyPastelMicrogame.c:110: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Bownly/states/bownlyPastelMicrogame.c:111: }
	ret
;Bownly/states/bownlyPastelMicrogame.c:115: static void phasePastelInit()
;	---------------------------------
; Function phasePastelInit
; ---------------------------------
_phasePastelInit:
;Bownly/states/bownlyPastelMicrogame.c:118: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:119: pastelX = 336U;
	ld	hl, #_pastelX
	ld	a, #0x50
	ld	(hl+), a
	ld	(hl), #0x01
;Bownly/states/bownlyPastelMicrogame.c:120: pastelY = 320U;
	ld	hl, #_pastelY
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0x01
;Bownly/states/bownlyPastelMicrogame.c:121: pastelXVel = 0U;
	ld	hl, #_pastelXVel
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:122: pastelYVel = 0U;
	ld	hl, #_pastelYVel
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:123: ySpeedJumping = 12U;
	ld	hl, #_ySpeedJumping
	ld	(hl), #0x0c
;Bownly/states/bownlyPastelMicrogame.c:124: jumpTimer = 0U;
	ld	hl, #_jumpTimer
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:127: pastelState = AIRBORNE;
	ld	hl, #_pastelState
	ld	(hl), #0x02
;Bownly/states/bownlyPastelMicrogame.c:128: pastelFlipX = FALSE;
	ld	hl, #_pastelFlipX
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:129: heartCount = 0U;
	ld	hl, #_heartCount
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:131: jumppuffX = 0U;
	ld	hl, #_jumppuffX
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:132: jumppuffY = 0U;
	ld	hl, #_jumppuffY
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:133: jumppuffTimer = 0U;
	ld	hl, #_jumppuffTimer
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:135: xSpeedWalking = 6U + (mgSpeed << 1U);
	ld	a, (#_mgSpeed)
	add	a, a
	add	a, #0x06
	ld	(#_xSpeedWalking),a
;Bownly/states/bownlyPastelMicrogame.c:136: xSpeedInAir = 6U + (mgSpeed << 1U);
	ld	(#_xSpeedInAir),a
;Bownly/states/bownlyPastelMicrogame.c:140: set_bkg_data(0x3FU, 30U, bownlyPastelBkgTiles);
	ld	de, #_bownlyPastelBkgTiles
	push	de
	ld	hl, #0x1e3f
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:141: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00110$:
;Bownly/states/bownlyPastelMicrogame.c:143: for (j = 0U; j != 18U; ++j)
	ld	hl, #_j
	ld	(hl), #0x00
00108$:
;Bownly/states/bownlyPastelMicrogame.c:145: set_bkg_tile_xy(i, j, 0x3FU);  // Full black tile
	ld	a, #0x3f
	push	af
	inc	sp
	ld	a, (#_j)
	ld	h, a
	ld	a, (#_i)
	ld	l, a
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:143: for (j = 0U; j != 18U; ++j)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x12
	jr	NZ, 00108$
;Bownly/states/bownlyPastelMicrogame.c:141: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00110$
;Bownly/states/bownlyPastelMicrogame.c:150: set_sprite_data(SPRTILE_PASTEL, bownlySprPastel_TILE_COUNT, bownlySprPastel_tiles);
	ld	de, #_bownlySprPastel_tiles
	push	de
	ld	hl, #0x5600
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:151: set_sprite_data(SPRTILE_JUMPPUFF, bownlySprJumppuff_TILE_COUNT, bownlySprJumppuff_tiles);
	ld	de, #_bownlySprJumppuff_tiles
	push	de
	ld	hl, #0x856
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:152: set_bkg_data(BKGID_HEART, 1U, &bownlyPastelHeartTiles[0U]);
	ld	de, #_bownlyPastelHeartTiles
	push	de
	ld	hl, #0x160
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:153: set_bkg_data(0x70U, 42U, bownlyPastelTreeTiles);
	ld	de, #_bownlyPastelTreeTiles
	push	de
	ld	hl, #0x2a70
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:155: switch (mgDifficulty)
	ld	a, (#_mgDifficulty)
	or	a, a
	jr	Z, 00104$
	ld	a, (#_mgDifficulty)
	dec	a
	jr	Z, 00105$
	ld	a, (#_mgDifficulty)
	sub	a, #0x02
	jp	Z,00106$
;Bownly/states/bownlyPastelMicrogame.c:158: case 0U:
00104$:
;Bownly/states/bownlyPastelMicrogame.c:160: set_bkg_tiles(0U, 13U, 20U, 5U, bownlyPastelBkg1Map);
	ld	de, #_bownlyPastelBkg1Map
	push	de
	ld	hl, #0x514
	push	hl
	ld	hl, #0xd00
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:163: set_bkg_tiles(0U, 3U, 6U, 10U, bownlyPastelTreeMap);
	ld	de, #_bownlyPastelTreeMap
	push	de
	ld	hl, #0xa06
	push	hl
	ld	hl, #0x300
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:166: set_bkg_tile_xy(6U, 8U + getRandUint8(5U), BKGID_HEART);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x08
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x06
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:167: set_bkg_tile_xy(12U, 6U + getRandUint8(6U), BKGID_HEART);
	ld	a, #0x06
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x06
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x0c
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:168: set_bkg_tile_xy(17U, 9U + getRandUint8(4U), BKGID_HEART);
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x09
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x11
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:169: break;
	jp	00107$
;Bownly/states/bownlyPastelMicrogame.c:170: case 1U:
00105$:
;Bownly/states/bownlyPastelMicrogame.c:172: set_bkg_tiles(0U, 13U, 20U, 5U, bownlyPastelBkg1Map);
	ld	de, #_bownlyPastelBkg1Map
	push	de
	ld	hl, #0x514
	push	hl
	ld	hl, #0xd00
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:173: set_bkg_tiles(12U, 10U, 5U, 6U, bownlyPastelBkg2Map);
	ld	de, #_bownlyPastelBkg2Map
	push	de
	ld	hl, #0x605
	push	hl
	ld	hl, #0xa0c
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:176: set_bkg_tiles(3U, 3U, 6U, 10U, bownlyPastelTreeMap);
	ld	de, #_bownlyPastelTreeMap
	push	de
	ld	hl, #0xa06
	push	hl
	ld	hl, #0x303
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:179: set_bkg_tile_xy(1U, 8U + getRandUint8(5U), BKGID_HEART);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x08
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x01
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:180: set_bkg_tile_xy(9U, 5U + getRandUint8(4U), BKGID_HEART);
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x05
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x09
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:181: set_bkg_tile_xy(14U, 6U + getRandUint8(4U), BKGID_HEART);
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x06
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x0e
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:182: set_bkg_tile_xy(18U, 9U + getRandUint8(4U), BKGID_HEART);
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x09
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x12
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:183: break;
	jp	00107$
;Bownly/states/bownlyPastelMicrogame.c:184: case 2U:
00106$:
;Bownly/states/bownlyPastelMicrogame.c:186: set_bkg_tiles(16U, 3U, 6U, 10U, bownlyPastelTreeMap);
	ld	bc, #_bownlyPastelTreeMap+0
	push	bc
	ld	hl, #0xa06
	push	hl
	ld	hl, #0x310
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:189: set_bkg_tiles(0U, 13U, 20U, 5U, bownlyPastelBkg1Map);
	ld	de, #_bownlyPastelBkg1Map
	push	de
	ld	hl, #0x514
	push	hl
	ld	hl, #0xd00
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:190: set_bkg_tiles(12U, 10U, 5U, 6U, bownlyPastelBkg2Map);
	ld	de, #_bownlyPastelBkg2Map
	push	de
	ld	hl, #0x605
	push	hl
	ld	hl, #0xa0c
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:191: set_bkg_tiles(4U, 7U, 4U, 6U, bownlyPastelBkg3Map);
	ld	de, #_bownlyPastelBkg3Map
	push	de
	ld	hl, #0x604
	push	hl
	ld	hl, #0x704
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:194: set_bkg_tiles(30U, 3U, 6U, 10U, bownlyPastelTreeMap);
	push	bc
	ld	hl, #0xa06
	push	hl
	ld	hl, #0x31e
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyPastelMicrogame.c:197: set_bkg_tile_xy(2U, 0U + getRandUint8(5U), BKGID_HEART);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x02
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:198: set_bkg_tile_xy(6U, 1U + getRandUint8(5U), BKGID_HEART);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	inc	a
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x06
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:199: set_bkg_tile_xy(9U, 2U + getRandUint8(6U), BKGID_HEART);
	ld	a, #0x06
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x02
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x09
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:200: set_bkg_tile_xy(14U, 3U + getRandUint8(6U), BKGID_HEART);
	ld	a, #0x06
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x03
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x0e
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:201: set_bkg_tile_xy(17U, 5U + getRandUint8(4U), BKGID_HEART);
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	add	a, #0x05
	ld	h, #0x60
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, a
	ld	l, #0x11
	push	hl
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:203: }
00107$:
;Bownly/states/bownlyPastelMicrogame.c:205: playSong(&bownlyVictoryLapSong);
	ld	de, #_bownlyVictoryLapSong
	push	de
	call	_playSong
	pop	hl
;Bownly/states/bownlyPastelMicrogame.c:207: fadein();
	call	_fadein
;Bownly/states/bownlyPastelMicrogame.c:208: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Bownly/states/bownlyPastelMicrogame.c:209: }
	ret
;Bownly/states/bownlyPastelMicrogame.c:211: static void phasePastelLoop()
;	---------------------------------
; Function phasePastelLoop
; ---------------------------------
_phasePastelLoop:
;Bownly/states/bownlyPastelMicrogame.c:213: hide_metasprite(bownlySprPastel_metasprites[animFrame % 16U], SPRTILE_PASTEL);
	ld	a, (#_animFrame)
	and	a, #0x0f
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	de, #_bownlySprPastel_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	c, (hl)
;C:/gbdk/include/gb/metasprites.h:241: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), c
;C:/gbdk/include/gb/metasprites.h:242: __hide_metasprite(base_sprite);
	xor	a, a
	push	af
	inc	sp
	call	___hide_metasprite
	inc	sp
;Bownly/states/bownlyPastelMicrogame.c:214: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Bownly/states/bownlyPastelMicrogame.c:216: inputsPastel();
	call	_inputsPastel
;Bownly/states/bownlyPastelMicrogame.c:217: calcPhysics();
	call	_calcPhysics
;Bownly/states/bownlyPastelMicrogame.c:218: if (checkHeartCollision() == TRUE)
	call	_checkHeartCollision
	dec	e
	jr	NZ, 00104$
;Bownly/states/bownlyPastelMicrogame.c:220: ++heartCount;
	ld	hl, #_heartCount
	inc	(hl)
;Bownly/states/bownlyPastelMicrogame.c:221: if (heartCount == mgDifficulty + 3U)
	ld	hl, #_mgDifficulty
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #_heartCount
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00102$
	ld	a, d
	sub	a, b
	jr	NZ, 00102$
;Bownly/states/bownlyPastelMicrogame.c:222: mgStatus = WON;
	ld	hl, #_mgStatus
	ld	(hl), #0x02
00102$:
;Bownly/states/bownlyPastelMicrogame.c:223: playDingSfx();
	call	_playDingSfx
00104$:
;Bownly/states/bownlyPastelMicrogame.c:226: animatePastel();
	call	_animatePastel
;Bownly/states/bownlyPastelMicrogame.c:227: animateHearts();
	call	_animateHearts
;Bownly/states/bownlyPastelMicrogame.c:230: if (jumppuffTimer == JUMPPUFF_DURATION)
	ld	a, (#_jumppuffTimer)
	sub	a, #0x07
	jr	NZ, 00106$
;Bownly/states/bownlyPastelMicrogame.c:231: hide_metasprite(bownlySprJumppuff_metasprites[0U], SPRID_JUPMPUFF);
	ld	hl, #_bownlySprJumppuff_metasprites
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
;C:/gbdk/include/gb/metasprites.h:241: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl), c
	inc	hl
	ld	(hl), a
;C:/gbdk/include/gb/metasprites.h:242: __hide_metasprite(base_sprite);
	ld	a, #0x0a
	push	af
	inc	sp
	call	___hide_metasprite
	inc	sp
;Bownly/states/bownlyPastelMicrogame.c:231: hide_metasprite(bownlySprJumppuff_metasprites[0U], SPRID_JUPMPUFF);
	ret
00106$:
;Bownly/states/bownlyPastelMicrogame.c:234: move_metasprite(bownlySprJumppuff_metasprites[jumppuffTimer], SPRTILE_JUMPPUFF, SPRID_JUPMPUFF, jumppuffX, jumppuffY);
	ld	hl, #_jumppuffY
	ld	b, (hl)
	ld	hl, #_jumppuffX
	ld	c, (hl)
	ld	de, #_bownlySprJumppuff_metasprites+0
	ld	hl, #_jumppuffTimer
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	e, a
	ld	d, l
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x56
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	push	bc
	inc	sp
	ld	h, c
	ld	l, #0x0a
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:235: ++jumppuffTimer;
	ld	hl, #_jumppuffTimer
	inc	(hl)
;Bownly/states/bownlyPastelMicrogame.c:237: }
	ret
;Bownly/states/bownlyPastelMicrogame.c:241: static void inputsPastel()
;	---------------------------------
; Function inputsPastel
; ---------------------------------
_inputsPastel:
	dec	sp
	dec	sp
;Bownly/states/bownlyPastelMicrogame.c:244: if (curJoypad & J_LEFT)
	ld	hl, #_curJoypad
	ld	c, (hl)
;Bownly/states/bownlyPastelMicrogame.c:248: switch (pastelState)
	ld	a, (#_pastelState)
	or	a, a
	ld	a, #0x01
	jr	Z, 00235$
	xor	a, a
00235$:
	ld	b, a
	ld	a, (#_pastelState)
	dec	a
	ld	a, #0x01
	jr	Z, 00237$
	xor	a, a
00237$:
	ld	e, a
	ld	a, (#_pastelState)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00239$
	xor	a, a
00239$:
	ld	d, a
;Bownly/states/bownlyPastelMicrogame.c:244: if (curJoypad & J_LEFT)
	bit	1, c
	jr	Z, 00122$
;Bownly/states/bownlyPastelMicrogame.c:246: if (pastelX != LEFT_BOUND)
	ld	hl, #_pastelX
	ld	a, (hl+)
	sub	a, #0x30
	or	a, (hl)
	jp	Z,00123$
;Bownly/states/bownlyPastelMicrogame.c:248: switch (pastelState)
	ld	a, b
	or	a,a
	jr	NZ, 00102$
	or	a,e
	jr	NZ, 00102$
	or	a,d
	jr	NZ, 00103$
	jr	00104$
;Bownly/states/bownlyPastelMicrogame.c:251: case WALKING:
00102$:
;Bownly/states/bownlyPastelMicrogame.c:252: pastelState = WALKING;
	ld	hl, #_pastelState
	ld	(hl), #0x01
;Bownly/states/bownlyPastelMicrogame.c:253: pastelXVel = -xSpeedWalking;
	xor	a, a
	ld	hl, #_xSpeedWalking
	sub	a, (hl)
	ld	(#_pastelXVel),a
;Bownly/states/bownlyPastelMicrogame.c:254: break;
	jr	00104$
;Bownly/states/bownlyPastelMicrogame.c:255: case AIRBORNE:
00103$:
;Bownly/states/bownlyPastelMicrogame.c:256: pastelXVel = -xSpeedInAir;
	xor	a, a
	ld	hl, #_xSpeedInAir
	sub	a, (hl)
	ld	(#_pastelXVel),a
;Bownly/states/bownlyPastelMicrogame.c:258: }
00104$:
;Bownly/states/bownlyPastelMicrogame.c:259: pastelFlipX = TRUE;
	ld	hl, #_pastelFlipX
	ld	(hl), #0x01
	jr	00123$
00122$:
;Bownly/states/bownlyPastelMicrogame.c:262: else if (curJoypad & J_RIGHT)
	ld	a, c
	and	a, #0x01
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	or	a, l
	jr	Z, 00119$
;Bownly/states/bownlyPastelMicrogame.c:264: if (pastelX != RIGHT_BOUND)
	ld	hl, #_pastelX
	ld	a, (hl)
	sub	a, #0x8c
	jr	NZ, 00242$
	inc	hl
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00123$
00242$:
;Bownly/states/bownlyPastelMicrogame.c:266: switch (pastelState)
	ld	a, b
	or	a,a
	jr	NZ, 00108$
	or	a,e
	jr	NZ, 00108$
	or	a,d
	jr	NZ, 00109$
	jr	00110$
;Bownly/states/bownlyPastelMicrogame.c:269: case WALKING:
00108$:
;Bownly/states/bownlyPastelMicrogame.c:270: pastelState = WALKING;
	ld	hl, #_pastelState
	ld	(hl), #0x01
;Bownly/states/bownlyPastelMicrogame.c:271: pastelXVel = xSpeedWalking;
	ld	a, (#_xSpeedWalking)
	ld	(#_pastelXVel),a
;Bownly/states/bownlyPastelMicrogame.c:272: break;
	jr	00110$
;Bownly/states/bownlyPastelMicrogame.c:273: case AIRBORNE:
00109$:
;Bownly/states/bownlyPastelMicrogame.c:274: pastelXVel = xSpeedInAir;
	ld	a, (#_xSpeedInAir)
	ld	(#_pastelXVel),a
;Bownly/states/bownlyPastelMicrogame.c:276: }
00110$:
;Bownly/states/bownlyPastelMicrogame.c:277: pastelFlipX = FALSE;
	ld	hl, #_pastelFlipX
	ld	(hl), #0x00
	jr	00123$
00119$:
;Bownly/states/bownlyPastelMicrogame.c:280: else if (!(curJoypad & J_RIGHT) && !(curJoypad & J_RIGHT))
	ld	a, h
	or	a, l
	jr	NZ, 00123$
	ld	a, h
;Bownly/states/bownlyPastelMicrogame.c:282: if (pastelState == WALKING)
	or	a,l
	jr	NZ, 00123$
	or	a,e
	jr	Z, 00114$
;Bownly/states/bownlyPastelMicrogame.c:283: pastelState = IDLE;
	ld	hl, #_pastelState
	ld	(hl), #0x00
00114$:
;Bownly/states/bownlyPastelMicrogame.c:284: pastelXVel = 0;
	ld	hl, #_pastelXVel
	ld	(hl), #0x00
00123$:
;Bownly/states/bownlyPastelMicrogame.c:248: switch (pastelState)
	ld	a, (#_pastelState)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00244$
	xor	a, a
00244$:
	ld	e, a
;Bownly/states/bownlyPastelMicrogame.c:288: if (curJoypad & J_A)
	bit	4, c
	jp	Z,00135$
;Bownly/states/bownlyPastelMicrogame.c:292: ++jumpTimer;
	ld	hl, #_jumpTimer
	ld	c, (hl)
	inc	c
;Bownly/states/bownlyPastelMicrogame.c:293: pastelYVel = -ySpeedJumping;
	xor	a, a
	ld	hl, #_ySpeedJumping
	sub	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;Bownly/states/bownlyPastelMicrogame.c:290: if ((pastelState == IDLE || pastelState == WALKING) && !(prevJoypad & J_A))  // Start jump
	ld	hl, #_pastelState
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
	ld	a, (hl)
	dec	a
	jr	NZ, 00128$
00131$:
	ld	a, (#_prevJoypad)
	bit	4, a
	jr	NZ, 00128$
;Bownly/states/bownlyPastelMicrogame.c:292: ++jumpTimer;
	ld	hl, #_jumpTimer
	ld	(hl), c
;Bownly/states/bownlyPastelMicrogame.c:293: pastelYVel = -ySpeedJumping;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_pastelYVel),a
;Bownly/states/bownlyPastelMicrogame.c:294: pastelState = AIRBORNE;
	ld	hl, #_pastelState
	ld	(hl), #0x02
;Bownly/states/bownlyPastelMicrogame.c:295: jumppuffTimer = 0U;
	ld	hl, #_jumppuffTimer
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:296: jumppuffX = pastelX >> 2U;
	ld	hl, #_pastelX
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	ld	hl, #_jumppuffX
	ld	(hl), c
;Bownly/states/bownlyPastelMicrogame.c:297: jumppuffY = ((pastelY + PASTEL_BOTTOM_OFFSET + 4U) >> 2U) + 10U;
	ld	hl, #_pastelY
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0034
	add	hl, de
	inc	sp
	inc	sp
	ld	c, l
	ld	b, h
	push	bc
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	add	a, #0x0a
	ld	hl, #_jumppuffY
	ld	(hl), a
;Bownly/states/bownlyPastelMicrogame.c:298: playBleepSfx();
	inc	sp
	inc	sp
	jp	_playBleepSfx
	jr	00137$
00128$:
;Bownly/states/bownlyPastelMicrogame.c:300: else if (pastelState == AIRBORNE && jumpTimer != JUMP_DURATION)  // Continue jump
	ld	a, e
	or	a, a
	jr	Z, 00137$
	ld	a, (#_jumpTimer)
	ld	hl, #_JUMP_DURATION
	sub	a, (hl)
	jr	Z, 00137$
;Bownly/states/bownlyPastelMicrogame.c:302: ++jumpTimer;
	ld	hl, #_jumpTimer
	ld	(hl), c
;Bownly/states/bownlyPastelMicrogame.c:303: pastelYVel = -ySpeedJumping;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_pastelYVel),a
	jr	00137$
00135$:
;Bownly/states/bownlyPastelMicrogame.c:306: else if (pastelState == AIRBORNE)
	ld	a, e
	or	a, a
	jr	Z, 00137$
;Bownly/states/bownlyPastelMicrogame.c:308: jumpTimer = JUMP_DURATION;
	ld	a, (#_JUMP_DURATION)
	ld	(#_jumpTimer),a
00137$:
;Bownly/states/bownlyPastelMicrogame.c:310: }
	inc	sp
	inc	sp
	ret
;Bownly/states/bownlyPastelMicrogame.c:314: static void calcPhysics()
;	---------------------------------
; Function calcPhysics
; ---------------------------------
_calcPhysics:
	dec	sp
;Bownly/states/bownlyPastelMicrogame.c:317: x = pastelX + pastelXVel;
	ld	a, (#_pastelXVel)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (#_pastelX)
	add	a, c
	ld	(#_x),a
	ld	a, (#_pastelX + 1)
	adc	a, b
	ld	(#_x + 1),a
;Bownly/states/bownlyPastelMicrogame.c:318: y = pastelY + pastelYVel;
	ld	a, (#_pastelYVel)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (#_pastelY)
	add	a, c
	ld	(#_y),a
	ld	a, (#_pastelY + 1)
	adc	a, b
	ld	(#_y + 1),a
;Bownly/states/bownlyPastelMicrogame.c:320: INT8 pastelBottomBound = (pastelY + PASTEL_BOTTOM_OFFSET) >> 5U;
	ld	hl, #_pastelY
	ld	a, (hl+)
	add	a, #0x30
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;Bownly/states/bownlyPastelMicrogame.c:321: INT8 pastelLeftBound = (x - 32U - PASTEL_LEFT_OFFSET) >> 5U;
	ld	hl, #_x
	ld	a, (hl+)
	add	a, #0xd4
	ld	e, a
;Bownly/states/bownlyPastelMicrogame.c:322: INT8 pastelRightBound = (x - 32U + PASTEL_RIGHT_OFFSET) >> 5U;
	ld	a, (hl-)
	adc	a, #0xff
	ld	d, a
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, (hl+)
	add	a, #0xec
	ld	d, a
;Bownly/states/bownlyPastelMicrogame.c:324: UINT8 collided = TRUE;
;Bownly/states/bownlyPastelMicrogame.c:325: if (x < LEFT_BOUND)
	ld	a, (hl-)
	adc	a, #0xff
	ld	b, a
	srl	b
	rr	d
	srl	b
	rr	d
	srl	b
	rr	d
	srl	b
	rr	d
	srl	b
	rr	d
	ld	b, #0x01
	ld	a, (hl+)
	sub	a, #0x30
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00108$
;Bownly/states/bownlyPastelMicrogame.c:327: x = LEFT_BOUND;
	dec	hl
	ld	a, #0x30
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;Bownly/states/bownlyPastelMicrogame.c:328: collided = TRUE;
	ld	b, #0x01
	jr	00109$
00108$:
;Bownly/states/bownlyPastelMicrogame.c:333: l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
	push	de
	ld	d, c
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	pop	de
	ld	hl, #_l
;Bownly/states/bownlyPastelMicrogame.c:334: l >>= 4U;
	ld	(hl), a
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:335: if (l != 4U && l != 5U)  // ~Top left pixel can move left
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00109$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00109$
;Bownly/states/bownlyPastelMicrogame.c:337: l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
	push	de
	ld	d, c
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	pop	de
	ld	hl, #_l
;Bownly/states/bownlyPastelMicrogame.c:338: l >>= 4U;
	ld	(hl), a
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:339: if (l != 4U && l != 5U)  // ~Bottom left pixel can move left
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00109$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00109$
;Bownly/states/bownlyPastelMicrogame.c:341: collided = FALSE;
	ld	b, #0x00
00109$:
;Bownly/states/bownlyPastelMicrogame.c:345: if (collided == TRUE)
	ld	a, b
	dec	a
	jr	NZ, 00120$
;Bownly/states/bownlyPastelMicrogame.c:347: pastelXVel = 0U;
	ld	hl, #_pastelXVel
	ld	(hl), #0x00
	jr	00121$
00120$:
;Bownly/states/bownlyPastelMicrogame.c:349: else if (x > RIGHT_BOUND)
	ld	hl, #_x
	ld	a, #0x8c
	sub	a, (hl)
	inc	hl
	ld	a, #0x02
	sbc	a, (hl)
	jr	NC, 00117$
;Bownly/states/bownlyPastelMicrogame.c:351: x = RIGHT_BOUND;
	ld	hl, #_x
	ld	a, #0x8c
	ld	(hl+), a
	ld	(hl), #0x02
;Bownly/states/bownlyPastelMicrogame.c:352: collided = TRUE;
	ld	b, #0x01
	jr	00121$
00117$:
;Bownly/states/bownlyPastelMicrogame.c:356: collided = TRUE;
	ld	b, #0x01
;Bownly/states/bownlyPastelMicrogame.c:358: l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
	push	de
	ld	a, c
	push	af
	inc	sp
	push	de
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	pop	de
	ld	hl, #_l
;Bownly/states/bownlyPastelMicrogame.c:359: l >>= 4U;
	ld	(hl), a
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:360: if (l != 4U && l != 5U)  // ~Top right pixel can move right
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00121$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00121$
;Bownly/states/bownlyPastelMicrogame.c:362: l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
	ld	a, c
	push	af
	inc	sp
	push	de
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:363: l >>= 4U;
	ld	a, (hl)
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:364: if (l != 4U && l != 5U)  // ~Bottom right pixel can move right
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00121$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00121$
;Bownly/states/bownlyPastelMicrogame.c:366: collided = FALSE;
	ld	b, #0x00
;Bownly/states/bownlyPastelMicrogame.c:367: pastelX += pastelXVel;
	ld	a, (#_pastelXVel)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #_pastelX
	ld	a, (hl)
	add	a, e
	ld	(hl+), a
	ld	a, (hl)
	adc	a, d
	ld	(hl), a
00121$:
;Bownly/states/bownlyPastelMicrogame.c:371: if (collided == TRUE)
	dec	b
	jr	NZ, 00123$
;Bownly/states/bownlyPastelMicrogame.c:373: pastelXVel = 0U;
	ld	hl, #_pastelXVel
	ld	(hl), #0x00
00123$:
;Bownly/states/bownlyPastelMicrogame.c:376: x = pastelX;
	ld	a, (#_pastelX)
	ld	(#_x),a
	ld	a, (#_pastelX + 1)
	ld	hl, #_x + 1
;Bownly/states/bownlyPastelMicrogame.c:377: pastelLeftBound = (x - 32U - (PASTEL_LEFT_OFFSET >> 1U)) >> 5U;
	ld	(hl-), a
	ld	a, (hl+)
	add	a, #0xda
	ld	e, a
	ld	a, (hl)
	adc	a, #0xff
	ld	d, a
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#0
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:378: pastelRightBound = (x - 32U + (PASTEL_RIGHT_OFFSET >> 1U)) >> 5U;
	ld	hl, #_x
	ld	a, (hl+)
	add	a, #0xe6
	ld	e, a
	ld	a, (hl)
	adc	a, #0xff
	ld	d, a
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	d, e
;Bownly/states/bownlyPastelMicrogame.c:379: if (pastelState == AIRBORNE)
	ld	a, (#_pastelState)
	sub	a, #0x02
	jp	NZ,00143$
;Bownly/states/bownlyPastelMicrogame.c:382: collided = TRUE;
	ld	b, #0x01
;Bownly/states/bownlyPastelMicrogame.c:383: l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound);
	ld	a, c
	push	af
	inc	sp
	push	de
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:384: l >>= 4U;
	ld	a, (hl)
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:385: if (l != 4U && l != 5U)  // Right foot can move down
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00130$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00130$
;Bownly/states/bownlyPastelMicrogame.c:387: l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound);
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:388: l >>= 4U;
	ld	a, (hl)
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:389: if (l != 4U && l != 5U)  // Left foot can move down
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00130$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00130$
;Bownly/states/bownlyPastelMicrogame.c:391: pastelY = y;
	ld	a, (#_y)
	ld	(#_pastelY),a
	ld	a, (#_y + 1)
	ld	(#_pastelY + 1),a
;Bownly/states/bownlyPastelMicrogame.c:392: collided = FALSE;
	ld	b, #0x00
;Bownly/states/bownlyPastelMicrogame.c:394: pastelYVel += 1;  // Gravity
	ld	hl, #_pastelYVel
	inc	(hl)
;Bownly/states/bownlyPastelMicrogame.c:395: if (pastelYVel > PASTEL_MAX_YVEL)
	ld	e, (hl)
	ld	a,#0x20
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00285$
	bit	7, d
	jr	NZ, 00286$
	cp	a, a
	jr	00286$
00285$:
	bit	7, d
	jr	Z, 00286$
	scf
00286$:
	jr	NC, 00130$
;Bownly/states/bownlyPastelMicrogame.c:396: pastelYVel = PASTEL_MAX_YVEL;
	ld	hl, #_pastelYVel
	ld	(hl), #0x20
00130$:
;Bownly/states/bownlyPastelMicrogame.c:399: if (collided == TRUE)
	dec	b
	jp	NZ,00145$
;Bownly/states/bownlyPastelMicrogame.c:401: pastelState = IDLE;
	ld	hl, #_pastelState
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:402: jumpTimer = 0U;
	ld	hl, #_jumpTimer
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:403: pastelXVel = 0U;
	ld	hl, #_pastelXVel
	ld	(hl), #0x00
;Bownly/states/bownlyPastelMicrogame.c:404: pastelY = ((pastelBottomBound << 5U) - PASTEL_BOTTOM_OFFSET - 12U);
	ld	a, c
	rlca
	sbc	a, a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	a, c
	add	a, #0xc4
	ld	hl, #_pastelY
	ld	(hl+), a
	ld	a, b
	adc	a, #0xff
	ld	(hl), a
	jr	00145$
00143$:
;Bownly/states/bownlyPastelMicrogame.c:407: else if (pastelState == WALKING)
	ld	a, (#_pastelState)
	dec	a
	jr	NZ, 00145$
;Bownly/states/bownlyPastelMicrogame.c:410: l = get_bkg_tile_xy(pastelRightBound, pastelBottomBound + 1U);
	ld	b, c
	inc	b
	push	bc
	inc	sp
	push	de
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:411: l >>= 4U;
	ld	a, (hl)
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:412: if (l != 4U && l != 5U)  // Right foot can move down
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00145$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00145$
;Bownly/states/bownlyPastelMicrogame.c:414: l = get_bkg_tile_xy(pastelLeftBound, pastelBottomBound + 1U);
	push	bc
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:415: l >>= 4U;
	ld	a, (hl)
	sra	a
	sra	a
	sra	a
	sra	a
;Bownly/states/bownlyPastelMicrogame.c:416: if (l != 4U && l != 5U)  // Left foot can move down
	ld	(hl), a
	sub	a, #0x04
	jr	Z, 00145$
	ld	a, (#_l)
	sub	a, #0x05
	jr	Z, 00145$
;Bownly/states/bownlyPastelMicrogame.c:418: pastelState = AIRBORNE;
	ld	hl, #_pastelState
	ld	(hl), #0x02
;Bownly/states/bownlyPastelMicrogame.c:419: pastelYVel = 0;
	ld	hl, #_pastelYVel
	ld	(hl), #0x00
00145$:
;Bownly/states/bownlyPastelMicrogame.c:423: }
	inc	sp
	ret
;Bownly/states/bownlyPastelMicrogame.c:425: static UINT8 checkHeartCollision()
;	---------------------------------
; Function checkHeartCollision
; ---------------------------------
_checkHeartCollision:
;Bownly/states/bownlyPastelMicrogame.c:427: y = (pastelY >> 5U) - 1U;  // Her top tiles
	ld	hl, #_pastelY
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	add	a, #0xff
	ld	hl, #_y
	ld	(hl+), a
	ld	a, b
	adc	a, #0xff
	ld	(hl), a
;Bownly/states/bownlyPastelMicrogame.c:428: INT8 pastelLeftBound = (pastelX - 32U - PASTEL_LEFT_OFFSET) >> 5U;
	ld	hl, #_pastelX
	ld	a, (hl+)
	add	a, #0xd4
	ld	c, a
;Bownly/states/bownlyPastelMicrogame.c:429: INT8 pastelRightBound = (pastelX - 32U + PASTEL_RIGHT_OFFSET) >> 5U;
	ld	a, (hl-)
	adc	a, #0xff
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, (hl+)
	add	a, #0xec
	ld	b, a
	ld	a, (hl)
	adc	a, #0xff
	ld	e, a
	srl	e
	rr	b
	srl	e
	rr	b
	srl	e
	rr	b
	srl	e
	rr	b
	srl	e
	rr	b
;Bownly/states/bownlyPastelMicrogame.c:431: for (j = 0U; j != 3U; ++j)
	ld	hl, #_j
	ld	(hl), #0x00
00106$:
;Bownly/states/bownlyPastelMicrogame.c:433: l = get_bkg_tile_xy(pastelRightBound, y + j);
	ld	a, (#_y)
	ld	hl, #_j
	add	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
	ld	a, (#_y)
;Bownly/states/bownlyPastelMicrogame.c:436: set_bkg_tile_xy(pastelRightBound, y + j, 0x3FU);
	ld	hl, #_j
	add	a, (hl)
	ld	d, a
;Bownly/states/bownlyPastelMicrogame.c:434: if (l == BKGID_HEART)
	ld	a, (#_l)
	sub	a, #0x60
	jr	NZ, 00102$
;Bownly/states/bownlyPastelMicrogame.c:436: set_bkg_tile_xy(pastelRightBound, y + j, 0x3FU);
	ld	a, #0x3f
	push	af
	inc	sp
	ld	e, b
	push	de
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:437: return TRUE;
	ld	e, #0x01
	ret
00102$:
;Bownly/states/bownlyPastelMicrogame.c:439: l = get_bkg_tile_xy(pastelLeftBound, y + j);
	ld	e, c
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #_l
	ld	(hl), e
;Bownly/states/bownlyPastelMicrogame.c:440: if (l == BKGID_HEART)
	ld	a, (hl)
	sub	a, #0x60
	jr	NZ, 00107$
;Bownly/states/bownlyPastelMicrogame.c:442: set_bkg_tile_xy(pastelLeftBound, y + j, 0x3FU);
	ld	a, (#_y)
	ld	hl, #_j
	add	a, (hl)
	ld	h, #0x3f
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	b, a
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:443: return TRUE;
	ld	e, #0x01
	ret
00107$:
;Bownly/states/bownlyPastelMicrogame.c:431: for (j = 0U; j != 3U; ++j)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
;Bownly/states/bownlyPastelMicrogame.c:446: return FALSE;
	sub	a,#0x03
	jr	NZ, 00106$
	ld	e,a
;Bownly/states/bownlyPastelMicrogame.c:447: }
	ret
;Bownly/states/bownlyPastelMicrogame.c:451: static void animateHearts()
;	---------------------------------
; Function animateHearts
; ---------------------------------
_animateHearts:
;Bownly/states/bownlyPastelMicrogame.c:453: set_bkg_data(BKGID_HEART, 1U, &bownlyPastelHeartTiles[((animTick >> 3U) % 2U) << 4U]);
	ld	bc, #_bownlyPastelHeartTiles+0
	ld	a, (#_animTick)
	swap	a
	rlca
	and	a, #0x1
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	hl, #0x160
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyPastelMicrogame.c:454: }
	ret
;Bownly/states/bownlyPastelMicrogame.c:456: static void animatePastel()
;	---------------------------------
; Function animatePastel
; ---------------------------------
_animatePastel:
;Bownly/states/bownlyPastelMicrogame.c:458: switch (pastelState)
	ld	a, (#_pastelState)
	or	a, a
	jr	Z, 00102$
	ld	a, (#_pastelState)
	dec	a
	jr	Z, 00103$
	ld	a, (#_pastelState)
	sub	a, #0x02
	jr	Z, 00106$
;Bownly/states/bownlyPastelMicrogame.c:461: default:
00102$:
;Bownly/states/bownlyPastelMicrogame.c:462: animFrame = (animTick >> 4U) % 2U;
	ld	a, (#_animTick)
	swap	a
	and	a, #0x1
;	spillPairReg hl
;	spillPairReg hl
	ld	(_animFrame), a
;Bownly/states/bownlyPastelMicrogame.c:463: break;
	jr	00110$
;Bownly/states/bownlyPastelMicrogame.c:464: case WALKING:
00103$:
;Bownly/states/bownlyPastelMicrogame.c:465: animFrame = ((animTick >> 3U) % 4U) + 3U;
	ld	a, (#_animTick)
	swap	a
	rlca
	and	a, #0x3
	add	a, #0x03
;Bownly/states/bownlyPastelMicrogame.c:466: if (animFrame == 6U)
	ld	(#_animFrame),a
	sub	a, #0x06
	jr	NZ, 00110$
;Bownly/states/bownlyPastelMicrogame.c:467: animFrame = 4U;
	ld	hl, #_animFrame
	ld	(hl), #0x04
;Bownly/states/bownlyPastelMicrogame.c:468: break;
	jr	00110$
;Bownly/states/bownlyPastelMicrogame.c:469: case AIRBORNE:
00106$:
;Bownly/states/bownlyPastelMicrogame.c:470: if (pastelYVel < 0)
	ld	a, (#_pastelYVel)
	bit	7, a
	jr	Z, 00108$
;Bownly/states/bownlyPastelMicrogame.c:471: animFrame = 10U;
	ld	hl, #_animFrame
	ld	(hl), #0x0a
	jr	00110$
00108$:
;Bownly/states/bownlyPastelMicrogame.c:473: animFrame = 11U;
	ld	hl, #_animFrame
	ld	(hl), #0x0b
;Bownly/states/bownlyPastelMicrogame.c:475: }
00110$:
;Bownly/states/bownlyPastelMicrogame.c:477: move_metasprite_vflip(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
	ld	hl, #_pastelY
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	srl	c
	rr	b
	srl	c
	rr	b
	ld	hl, #_pastelX
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	ld	hl, #_animFrame
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	c, e
	add	hl, hl
	ld	e, l
	ld	d, h
;Bownly/states/bownlyPastelMicrogame.c:476: if (pastelFlipX == TRUE)
	ld	a, (#_pastelFlipX)
	dec	a
	jr	NZ, 00112$
;Bownly/states/bownlyPastelMicrogame.c:477: move_metasprite_vflip(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
	ld	hl, #_bownlySprPastel_metasprites
	add	hl, de
	ld	a, (hl+)
	ld	l, (hl)
;	spillPairReg hl
;C:/gbdk/include/gb/metasprites.h:167: __current_metasprite = metasprite;
	ld	e, a
	ld	d, l
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/gbdk/include/gb/metasprites.h:168: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;C:/gbdk/include/gb/metasprites.h:169: return __move_metasprite_vflip(base_sprite, x - 8, y);
	ld	a, c
	add	a, #0xf8
	push	bc
	inc	sp
	ld	h, a
	ld	l, #0x00
	push	hl
	call	___move_metasprite_vflip
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:477: move_metasprite_vflip(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
	ret
00112$:
;Bownly/states/bownlyPastelMicrogame.c:479: move_metasprite(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
	ld	hl, #_bownlySprPastel_metasprites
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	e, a
	ld	d, h
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	push	bc
	inc	sp
	ld	h, c
	ld	l, #0x00
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyPastelMicrogame.c:479: move_metasprite(bownlySprPastel_metasprites[animFrame], SPRTILE_PASTEL, SPRID_PASTEL, pastelX >> 2U, pastelY >> 2U);
;Bownly/states/bownlyPastelMicrogame.c:480: }
	ret
	.area _CODE_2
	.area _INITIALIZER
__xinit__heartCount:
	.db #0x00	; 0
__xinit__pastelFlipX:
	.db #0x00	; 0
__xinit__JUMP_DURATION:
	.db #0x08	; 8
__xinit__jumppuffTimer:
	.db #0x07	; 7
	.area _CABS (ABS)
