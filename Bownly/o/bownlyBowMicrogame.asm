;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyBowMicrogame
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyBowMicrogameMain
	.globl _playMoveSfx
	.globl _playCollisionSfx
	.globl _playSong
	.globl _fadein
	.globl _getRandUint8
	.globl _init_bkg
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _joypad
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_bowX:
	.ds 1
_bowY:
	.ds 1
_arrowX:
	.ds 1
_arrowY:
	.ds 1
_targetX:
	.ds 1
_targetY:
	.ds 1
_bowSpeed:
	.ds 1
_arrowSpeed:
	.ds 1
_targetSpeed:
	.ds 1
_targetsLeft:
	.ds 1
_bowFrame:
	.ds 1
_arrowState:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;Bownly/states/bownlyBowMicrogame.c:74: void bownlyBowMicrogameMain()
;	---------------------------------
; Function bownlyBowMicrogameMain
; ---------------------------------
_bownlyBowMicrogameMain::
;Bownly/states/bownlyBowMicrogame.c:76: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Bownly/states/bownlyBowMicrogame.c:78: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;Bownly/states/bownlyBowMicrogame.c:80: case SUB_INIT:
00101$:
;Bownly/states/bownlyBowMicrogame.c:81: phaseBowInit();
	call	_phaseBowInit
;Bownly/states/bownlyBowMicrogame.c:82: break;
	jr	00104$
;Bownly/states/bownlyBowMicrogame.c:83: case SUB_LOOP:
00102$:
;Bownly/states/bownlyBowMicrogame.c:84: phaseBowLoop();
	call	_phaseBowLoop
;Bownly/states/bownlyBowMicrogame.c:85: break;
	jr	00104$
;Bownly/states/bownlyBowMicrogame.c:86: default:  // Abort to title in the event of unexpected state
00103$:
;Bownly/states/bownlyBowMicrogame.c:87: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:88: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:90: }
00104$:
;Bownly/states/bownlyBowMicrogame.c:91: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Bownly/states/bownlyBowMicrogame.c:92: }
	ret
;Bownly/states/bownlyBowMicrogame.c:96: static void phaseBowInit()
;	---------------------------------
; Function phaseBowInit
; ---------------------------------
_phaseBowInit:
;Bownly/states/bownlyBowMicrogame.c:99: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Bownly/states/bownlyBowMicrogame.c:100: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:102: bowX = 150U;
	ld	hl, #_bowX
	ld	(hl), #0x96
;Bownly/states/bownlyBowMicrogame.c:103: bowY = 50U;
	ld	hl, #_bowY
	ld	(hl), #0x32
;Bownly/states/bownlyBowMicrogame.c:104: arrowX = 150U;
	ld	hl, #_arrowX
	ld	(hl), #0x96
;Bownly/states/bownlyBowMicrogame.c:105: arrowY = 49U;
	ld	hl, #_arrowY
	ld	(hl), #0x31
;Bownly/states/bownlyBowMicrogame.c:106: targetX = 24U;
	ld	hl, #_targetX
	ld	(hl), #0x18
;Bownly/states/bownlyBowMicrogame.c:107: targetY = 80U;
	ld	hl, #_targetY
	ld	(hl), #0x50
;Bownly/states/bownlyBowMicrogame.c:108: bowSpeed = 2U + mgSpeed;
	ld	a, (#_mgSpeed)
	add	a, #0x02
	ld	(#_bowSpeed),a
;Bownly/states/bownlyBowMicrogame.c:109: arrowSpeed = 4U + mgSpeed;
	ld	a, (#_mgSpeed)
	add	a, #0x04
	ld	(#_arrowSpeed),a
;Bownly/states/bownlyBowMicrogame.c:110: targetSpeed = -1;
	ld	hl, #_targetSpeed
	ld	(hl), #0xff
;Bownly/states/bownlyBowMicrogame.c:111: targetsLeft = 1U;
	ld	hl, #_targetsLeft
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:112: bowFrame = 1U;
	ld	hl, #_bowFrame
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:113: arrowState = NOCKED;
	ld	hl, #_arrowState
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:116: set_bkg_data(BKGTILE_GRASS, 6U, bownlyBowBkgTiles);
	ld	de, #_bownlyBowBkgTiles
	push	de
	ld	hl, #0x660
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyBowMicrogame.c:117: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00108$:
;Bownly/states/bownlyBowMicrogame.c:119: set_bkg_tile_xy(i, 16U, BKGTILE_GRASS);
	ld	hl, #0x6010
	push	hl
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:120: set_bkg_tile_xy(i, 17U, BKGTILE_GRASS + 1U);
	ld	hl, #0x6111
	push	hl
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:117: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00108$
;Bownly/states/bownlyBowMicrogame.c:124: set_sprite_data(SPRTILE_BOW, bownlySprBow_TILE_COUNT, bownlySprBow_tiles);
	ld	de, #_bownlySprBow_tiles
	push	de
	ld	hl, #0xe00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyBowMicrogame.c:125: set_sprite_data(SPRTILE_ARROW, bownlySprArrow_TILE_COUNT, bownlySprArrow_tiles);
	ld	de, #_bownlySprArrow_tiles
	push	de
	ld	hl, #0x30e
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyBowMicrogame.c:126: set_sprite_data(SPRTILE_TARGET, bownlySprTarget_TILE_COUNT, bownlySprTarget_tiles);
	ld	de, #_bownlySprTarget_tiles
	push	de
	ld	hl, #0x611
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyBowMicrogame.c:128: spawnTarget();
	call	_spawnTarget
;Bownly/states/bownlyBowMicrogame.c:129: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, bowX, bowY);
	ld	hl, #_bowY
	ld	b, (hl)
	ld	hl, #_bowX
	ld	c, (hl)
	ld	de, #_bownlySprBow_metasprites+0
	ld	hl, #_bowFrame
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
	ld	(hl), #0x00
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	push	bc
	inc	sp
	ld	h, c
	ld	l, #0x00
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:130: move_metasprite(bownlySprArrow_metasprites[0U], SPRTILE_BOW + bownlySprBow_TILE_COUNT, SPRID_ARROW, arrowX, arrowY);
	ld	hl, #_arrowY
	ld	b, (hl)
	ld	hl, #_arrowX
	ld	c, (hl)
	ld	hl, #_bownlySprArrow_metasprites + 1
	ld	a,	(hl-)
;	spillPairReg hl
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	e, (hl)
	ld	d, a
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x0e
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	push	bc
	inc	sp
	ld	h, c
	ld	l, #0x0a
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:131: move_metasprite(bownlySprTarget_metasprites[0U], SPRTILE_TARGET, SPRID_TARGET, targetX, targetY);
	ld	hl, #_targetY
	ld	b, (hl)
	ld	hl, #_targetX
	ld	c, (hl)
	ld	hl, #_bownlySprTarget_metasprites + 1
	ld	a,	(hl-)
;	spillPairReg hl
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	e, (hl)
	ld	d, a
	ld	hl, #___current_metasprite
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x11
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	push	bc
	inc	sp
	ld	h, c
	ld	l, #0x0f
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:134: if (mgDifficulty == 2U)
	ld	a, (#_mgDifficulty)
	sub	a, #0x02
	jr	NZ, 00103$
;Bownly/states/bownlyBowMicrogame.c:135: targetsLeft = 2U;
	ld	hl, #_targetsLeft
	ld	(hl), #0x02
	jr	00104$
00103$:
;Bownly/states/bownlyBowMicrogame.c:137: targetsLeft = 1U;
	ld	hl, #_targetsLeft
	ld	(hl), #0x01
00104$:
;Bownly/states/bownlyBowMicrogame.c:139: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:141: playSong(&bownlyTheWhite2Song);
	ld	de, #_bownlyTheWhite2Song
	push	de
	call	_playSong
	pop	hl
;Bownly/states/bownlyBowMicrogame.c:143: fadein();
	call	_fadein
;Bownly/states/bownlyBowMicrogame.c:145: OBP0_REG = 0xE4;  // 11 10 01 00
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;Bownly/states/bownlyBowMicrogame.c:146: }
	ret
;Bownly/states/bownlyBowMicrogame.c:148: static void phaseBowLoop()
;	---------------------------------
; Function phaseBowLoop
; ---------------------------------
_phaseBowLoop:
	add	sp, #-6
;Bownly/states/bownlyBowMicrogame.c:150: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Bownly/states/bownlyBowMicrogame.c:151: if (bowY >= 130U || bowY <= 40U)
	ld	hl, #_bowY
	ld	a, (hl)
	sub	a, #0x82
	jr	NC, 00101$
	ld	a, #0x28
	sub	a, (hl)
	jr	C, 00102$
00101$:
;Bownly/states/bownlyBowMicrogame.c:152: bowSpeed *= -1;
	xor	a, a
	ld	hl, #_bowSpeed
	sub	a, (hl)
	ld	(hl), a
00102$:
;Bownly/states/bownlyBowMicrogame.c:153: bowY += bowSpeed;
	ld	a, (#_bowY)
	ld	hl, #_bowSpeed
	add	a, (hl)
	ld	(#_bowY),a
;Bownly/states/bownlyBowMicrogame.c:155: switch (arrowState)
	ld	a, (#_arrowState)
	or	a, a
	jr	Z, 00104$
;Bownly/states/bownlyBowMicrogame.c:192: else if (arrowX >= 200U)
	ld	hl, #_arrowX
	ld	a, (hl)
	sub	a, #0xc8
	ld	a, #0x00
	rla
	ld	c, a
;Bownly/states/bownlyBowMicrogame.c:200: arrowX -= arrowSpeed;
	ld	a, (hl)
	ld	hl, #_arrowSpeed
	sub	a, (hl)
	ld	b, a
;Bownly/states/bownlyBowMicrogame.c:155: switch (arrowState)
	ld	a, (#_arrowState)
	dec	a
	jr	Z, 00110$
	ld	a, (#_arrowState)
	sub	a, #0x02
	jp	Z,00126$
	jp	00133$
;Bownly/states/bownlyBowMicrogame.c:157: case NOCKED:
00104$:
;Bownly/states/bownlyBowMicrogame.c:158: inputsShoot();
	call	_inputsShoot
;Bownly/states/bownlyBowMicrogame.c:160: if (mgDifficulty != 0U)
	ld	a, (#_mgDifficulty)
	or	a, a
	jr	Z, 00109$
;Bownly/states/bownlyBowMicrogame.c:163: if (targetY >= 130U || targetY <= 40U)
	ld	hl, #_targetY
	ld	a, (hl)
	sub	a, #0x82
	jr	NC, 00105$
	ld	a, #0x28
	sub	a, (hl)
	jr	C, 00106$
00105$:
;Bownly/states/bownlyBowMicrogame.c:164: targetSpeed *= -1;
	xor	a, a
	ld	hl, #_targetSpeed
	sub	a, (hl)
	ld	(hl), a
00106$:
;Bownly/states/bownlyBowMicrogame.c:165: targetY += targetSpeed;
	ld	a, (#_targetY)
	ld	hl, #_targetSpeed
	add	a, (hl)
	ld	(#_targetY),a
00109$:
;Bownly/states/bownlyBowMicrogame.c:168: arrowY += bowSpeed;
	ld	a, (#_arrowY)
	ld	hl, #_bowSpeed
	add	a, (hl)
	ld	(#_arrowY),a
;Bownly/states/bownlyBowMicrogame.c:169: break;
	jp	00133$
;Bownly/states/bownlyBowMicrogame.c:170: case FLYING:
00110$:
;Bownly/states/bownlyBowMicrogame.c:171: if (mgDifficulty != 0U)
	ld	a, (#_mgDifficulty)
	or	a, a
	jr	Z, 00115$
;Bownly/states/bownlyBowMicrogame.c:174: if (targetY >= 130U || targetY <= 40U)
	ld	hl, #_targetY
	ld	a, (hl)
	sub	a, #0x82
	jr	NC, 00111$
	ld	a, #0x28
	sub	a, (hl)
	jr	C, 00112$
00111$:
;Bownly/states/bownlyBowMicrogame.c:175: targetSpeed *= -1;
	xor	a, a
	ld	hl, #_targetSpeed
	sub	a, (hl)
	ld	(hl), a
00112$:
;Bownly/states/bownlyBowMicrogame.c:176: targetY += targetSpeed;
	ld	a, (#_targetY)
	ld	hl, #_targetSpeed
	add	a, (hl)
	ld	(#_targetY),a
00115$:
;Bownly/states/bownlyBowMicrogame.c:179: if (arrowX == 30U)
	ld	a, (#_arrowX)
	sub	a, #0x1e
	jr	NZ, 00124$
;Bownly/states/bownlyBowMicrogame.c:181: if (arrowY <= targetY + 15U && arrowY >= targetY - 15U)
	ld	hl, #_targetY
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x000f
	add	hl, bc
	ld	e, l
	ld	a, (_arrowY)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	d, #0x00
	ld	a, e
	sub	a, l
	ld	a, h
	sbc	a, d
	jr	C, 00117$
	ld	a, c
	add	a, #0xf1
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, l
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	C, 00117$
;Bownly/states/bownlyBowMicrogame.c:183: playCollisionSfx();
	call	_playCollisionSfx
;Bownly/states/bownlyBowMicrogame.c:184: arrowState = HIT;
	ld	hl, #_arrowState
	ld	(hl), #0x02
	jr	00133$
00117$:
;Bownly/states/bownlyBowMicrogame.c:188: arrowX -= 1;
	ld	hl, #_arrowX
	dec	(hl)
	jr	00133$
00124$:
;Bownly/states/bownlyBowMicrogame.c:192: else if (arrowX >= 200U)
	bit	0, c
	jr	NZ, 00121$
;Bownly/states/bownlyBowMicrogame.c:194: arrowState = NOCKED;
	ld	hl, #_arrowState
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:195: bowFrame = 1U;
	ld	hl, #_bowFrame
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:196: arrowX = bowX;
	ld	a, (#_bowX)
	ld	(#_arrowX),a
;Bownly/states/bownlyBowMicrogame.c:197: arrowY = bowY;
	ld	a, (#_bowY)
	ld	(#_arrowY),a
	jr	00133$
00121$:
;Bownly/states/bownlyBowMicrogame.c:200: arrowX -= arrowSpeed;
	ld	hl, #_arrowX
	ld	(hl), b
;Bownly/states/bownlyBowMicrogame.c:201: break;
	jr	00133$
;Bownly/states/bownlyBowMicrogame.c:202: case HIT:
00126$:
;Bownly/states/bownlyBowMicrogame.c:203: if (arrowX >= 200U)  // Offscreen, or close enough
	bit	0, c
	jr	NZ, 00131$
;Bownly/states/bownlyBowMicrogame.c:205: if (--targetsLeft == 0U)  // End game if no more targets
	ld	hl, #_targetsLeft
	dec	(hl)
	jr	NZ, 00128$
;Bownly/states/bownlyBowMicrogame.c:207: mgStatus = WON;
	ld	hl, #_mgStatus
	ld	(hl), #0x02
;Bownly/states/bownlyBowMicrogame.c:210: arrowSpeed = 0U;
	ld	hl, #_arrowSpeed
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:211: arrowX = 190U;
	ld	hl, #_arrowX
	ld	(hl), #0xbe
;Bownly/states/bownlyBowMicrogame.c:212: targetX = 190U;
	ld	hl, #_targetX
	ld	(hl), #0xbe
	jr	00133$
00128$:
;Bownly/states/bownlyBowMicrogame.c:216: spawnTarget();
	call	_spawnTarget
;Bownly/states/bownlyBowMicrogame.c:217: arrowState = NOCKED;
	ld	hl, #_arrowState
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:218: bowFrame = 1U;
	ld	hl, #_bowFrame
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:219: arrowX = bowX;
	ld	a, (#_bowX)
	ld	(#_arrowX),a
;Bownly/states/bownlyBowMicrogame.c:220: arrowY = bowY;
	ld	a, (#_bowY)
	ld	(#_arrowY),a
	jr	00133$
00131$:
;Bownly/states/bownlyBowMicrogame.c:225: arrowX -= arrowSpeed;
	ld	hl, #_arrowX
	ld	(hl), b
;Bownly/states/bownlyBowMicrogame.c:226: targetX -= arrowSpeed;
	ld	a, (#_targetX)
	ld	hl, #_arrowSpeed
	sub	a, (hl)
	ld	(#_targetX),a
;Bownly/states/bownlyBowMicrogame.c:229: }
00133$:
;Bownly/states/bownlyBowMicrogame.c:233: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, arrowX, arrowY);
	ld	a, (#_bowFrame)
	ld	c, #0x00
	add	a, a
	rl	c
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), c
;Bownly/states/bownlyBowMicrogame.c:232: if (mgDifficulty == 2U && targetsLeft == 1U)
	ld	a, (#_mgDifficulty)
	sub	a, #0x02
	jr	NZ, 00135$
	ld	a, (#_targetsLeft)
	dec	a
	jr	NZ, 00135$
;Bownly/states/bownlyBowMicrogame.c:233: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, arrowX, arrowY);
	ld	a, (#_arrowY)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_arrowX)
	ldhl	sp,	#5
	ld	(hl), a
	ld	de, #_bownlySprBow_metasprites
	pop	hl
	push	hl
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	ldhl	sp,	#4
	ld	a, (hl+)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x00
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:233: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, arrowX, arrowY);
	jr	00136$
00135$:
;Bownly/states/bownlyBowMicrogame.c:235: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, bowX, bowY);
	ld	a, (#_bowY)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_bowX)
	ldhl	sp,	#3
	ld	(hl), a
	ld	de, #_bownlySprBow_metasprites
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;C:/gbdk/include/gb/metasprites.h:138: __current_metasprite = metasprite;
	ld	(hl-), a
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;C:/gbdk/include/gb/metasprites.h:139: __current_base_tile = base_tile;
	ld	hl, #___current_base_tile
	ld	(hl), #0x00
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	ldhl	sp,	#2
	ld	a, (hl+)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x00
	push	hl
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:235: move_metasprite(bownlySprBow_metasprites[bowFrame], SPRTILE_BOW, SPRID_BOW, bowX, bowY);
00136$:
;Bownly/states/bownlyBowMicrogame.c:237: move_metasprite(bownlySprArrow_metasprites[0U], SPRTILE_ARROW, SPRID_ARROW, arrowX, arrowY);
	ld	hl, #_arrowY
	ld	c, (hl)
	ld	hl, #_arrowX
	ld	b, (hl)
	ld	hl, #_bownlySprArrow_metasprites
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
	ld	(hl), #0x0e
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	ld	a, c
	push	af
	inc	sp
	ld	c, #0x0a
	push	bc
	call	___move_metasprite
	add	sp, #3
;Bownly/states/bownlyBowMicrogame.c:238: move_metasprite(bownlySprTarget_metasprites[0U], SPRTILE_TARGET, SPRID_TARGET, targetX, targetY);
	ld	hl, #_targetY
	ld	c, (hl)
	ld	hl, #_targetX
	ld	b, (hl)
	ld	hl, #_bownlySprTarget_metasprites
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
	ld	(hl), #0x11
;C:/gbdk/include/gb/metasprites.h:140: return __move_metasprite(base_sprite, x, y);
	ld	a, c
	push	af
	inc	sp
	ld	c, #0x0f
	push	bc
	call	___move_metasprite
;Bownly/states/bownlyBowMicrogame.c:238: move_metasprite(bownlySprTarget_metasprites[0U], SPRTILE_TARGET, SPRID_TARGET, targetX, targetY);
;Bownly/states/bownlyBowMicrogame.c:239: }
	add	sp, #9
	ret
;Bownly/states/bownlyBowMicrogame.c:243: static void inputsShoot()
;	---------------------------------
; Function inputsShoot
; ---------------------------------
_inputsShoot:
;Bownly/states/bownlyBowMicrogame.c:245: if (curJoypad & J_A && !(prevJoypad & J_A))
	ld	a, (#_curJoypad)
	bit	4, a
	ret	Z
	ld	a, (#_prevJoypad)
	bit	4, a
	ret	NZ
;Bownly/states/bownlyBowMicrogame.c:247: playMoveSfx();
	call	_playMoveSfx
;Bownly/states/bownlyBowMicrogame.c:248: arrowState = FLYING;
	ld	hl, #_arrowState
	ld	(hl), #0x01
;Bownly/states/bownlyBowMicrogame.c:249: bowFrame = 0U;
	ld	hl, #_bowFrame
	ld	(hl), #0x00
;Bownly/states/bownlyBowMicrogame.c:251: }
	ret
;Bownly/states/bownlyBowMicrogame.c:255: static void spawnTarget()
;	---------------------------------
; Function spawnTarget
; ---------------------------------
_spawnTarget:
;Bownly/states/bownlyBowMicrogame.c:257: targetX = 24U;
	ld	hl, #_targetX
	ld	(hl), #0x18
;Bownly/states/bownlyBowMicrogame.c:258: targetY = getRandUint8(90U);  // Range of 40-130
	ld	a, #0x5a
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_targetY
	ld	(hl), e
;Bownly/states/bownlyBowMicrogame.c:259: targetY += 40U;
	ld	a, (hl)
	add	a, #0x28
	ld	(hl), a
;Bownly/states/bownlyBowMicrogame.c:260: }
	ret
	.area _CODE_2
	.area _INITIALIZER
	.area _CABS (ABS)
