;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyMP5Microgame
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyMP5MicrogameMain
	.globl _playMoveSfx
	.globl _playHurtSfx
	.globl _playCollisionSfx
	.globl _playSong
	.globl _fadein
	.globl _getRandUint8
	.globl _init_bkg
	.globl _set_sprite_data
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
_buttonHoldTick:
	.ds 1
_screenShakeTick:
	.ds 1
_flipAnimTick:
	.ds 1
_flipDuration:
	.ds 1
_prestonXIndex:
	.ds 1
_prestonYIndex:
	.ds 1
_prestonIsHorz:
	.ds 1
_prestonHP:
	.ds 1
_gridPanels:
	.ds 150
_remaining5s:
	.ds 1
_didWinFlip:
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
;Bownly/states/bownlyMP5Microgame.c:85: void bownlyMP5MicrogameMain()
;	---------------------------------
; Function bownlyMP5MicrogameMain
; ---------------------------------
_bownlyMP5MicrogameMain::
;Bownly/states/bownlyMP5Microgame.c:87: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Bownly/states/bownlyMP5Microgame.c:89: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;Bownly/states/bownlyMP5Microgame.c:91: case SUB_INIT:
00101$:
;Bownly/states/bownlyMP5Microgame.c:92: phaseMagipanels5Init();
	call	_phaseMagipanels5Init
;Bownly/states/bownlyMP5Microgame.c:93: break;
	jr	00104$
;Bownly/states/bownlyMP5Microgame.c:94: case SUB_LOOP:
00102$:
;Bownly/states/bownlyMP5Microgame.c:95: phaseMagipanels5Loop();
	call	_phaseMagipanels5Loop
;Bownly/states/bownlyMP5Microgame.c:96: break;
	jr	00104$
;Bownly/states/bownlyMP5Microgame.c:97: default:  // Abort to title in the event of unexpected state
00103$:
;Bownly/states/bownlyMP5Microgame.c:98: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:99: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:101: }
00104$:
;Bownly/states/bownlyMP5Microgame.c:102: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Bownly/states/bownlyMP5Microgame.c:103: }
	ret
;Bownly/states/bownlyMP5Microgame.c:107: static void phaseMagipanels5Init()
;	---------------------------------
; Function phaseMagipanels5Init
; ---------------------------------
_phaseMagipanels5Init:
;Bownly/states/bownlyMP5Microgame.c:110: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Bownly/states/bownlyMP5Microgame.c:111: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:112: flipAnimTick = 0U;
	ld	hl, #_flipAnimTick
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:114: buttonHoldTick = 0U;
	ld	hl, #_buttonHoldTick
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:115: screenShakeTick = 0U;
	ld	hl, #_screenShakeTick
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:117: prestonXIndex = 0U;
	ld	hl, #_prestonXIndex
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:118: prestonYIndex = 1U;
	ld	hl, #_prestonYIndex
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:119: prestonIsHorz = FALSE;
	ld	hl, #_prestonIsHorz
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:120: prestonHP = 1U;
	ld	hl, #_prestonHP
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:122: didWinFlip = FALSE;
	ld	hl, #_didWinFlip
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:123: remaining5s = mgDifficulty + 1U;
	ld	a, (#_mgDifficulty)
	inc	a
	ld	(#_remaining5s),a
;Bownly/states/bownlyMP5Microgame.c:124: flipDuration = 21U - mgDifficulty - mgDifficulty;  // Looks dumb, but it's more space efficient
	ld	a, #0x15
	ld	hl, #_mgDifficulty
	sub	a, (hl)
	sub	a, (hl)
	ld	(#_flipDuration),a
;Bownly/states/bownlyMP5Microgame.c:126: set_bkg_data(BKGTILE_DICE, 36U, bownlyMP5DiceTiles);
	ld	de, #_bownlyMP5DiceTiles
	push	de
	ld	hl, #0x2450
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:127: set_bkg_data(BKGTILE_STAGE, 14U, bownlyMP5StageTiles);
	ld	de, #_bownlyMP5StageTiles
	push	de
	ld	hl, #0xe40
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:128: set_bkg_tiles(0U, 0U, 20U, 2U, bownlyMP5StageTopMap);
	ld	de, #_bownlyMP5StageTopMap
	push	de
	ld	hl, #0x214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyMP5Microgame.c:129: set_bkg_tiles(0U, 2U, 2U, 14U, bownlyMP5StageColMap);
	ld	bc, #_bownlyMP5StageColMap+0
	push	bc
	ld	hl, #0xe02
	push	hl
	ld	hl, #0x200
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyMP5Microgame.c:130: set_bkg_tiles(18U, 2U, 2U, 14U, bownlyMP5StageColMap);
	push	bc
	ld	hl, #0xe02
	push	hl
	ld	hl, #0x212
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyMP5Microgame.c:131: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00102$:
;Bownly/states/bownlyMP5Microgame.c:133: set_bkg_tile_xy(i, 16U, 0x4C);
	ld	hl, #0x4c10
	push	hl
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyMP5Microgame.c:134: set_bkg_tile_xy(i, 17U, 0x4D);
	ld	hl, #0x4d11
	push	hl
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Bownly/states/bownlyMP5Microgame.c:131: for (i = 0U; i != 20U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x14
	jr	NZ, 00102$
;Bownly/states/bownlyMP5Microgame.c:137: set_sprite_data(SPRTILE_HEARTS, 2U, bownlyMP5HeartTiles);
	ld	de, #_bownlyMP5HeartTiles
	push	de
	ld	hl, #0x240
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:138: setupHearts();
	call	_setupHearts
;Bownly/states/bownlyMP5Microgame.c:139: set_sprite_data(SPRTILE_PRESTON, bownlySprPreston_TILE_COUNT, bownlySprPreston_tiles);
	ld	de, #_bownlySprPreston_tiles
	push	de
	ld	hl, #0x3400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:141: initGrid();
	call	_initGrid
;Bownly/states/bownlyMP5Microgame.c:143: playSong(&bownlyTheWhiteSong);
	ld	de, #_bownlyTheWhiteSong
	push	de
	call	_playSong
	pop	hl
;Bownly/states/bownlyMP5Microgame.c:145: fadein();
	call	_fadein
;Bownly/states/bownlyMP5Microgame.c:146: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:148: }
	ret
;Bownly/states/bownlyMP5Microgame.c:150: static void phaseMagipanels5Loop()
;	---------------------------------
; Function phaseMagipanels5Loop
; ---------------------------------
_phaseMagipanels5Loop:
;Bownly/states/bownlyMP5Microgame.c:152: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Bownly/states/bownlyMP5Microgame.c:153: if (flipAnimTick != 0U && flipAnimTick != flipDuration)
	ld	hl, #_flipAnimTick
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, (hl)
	ld	hl, #_flipDuration
	sub	a, (hl)
	jr	Z, 00102$
;Bownly/states/bownlyMP5Microgame.c:154: ++flipAnimTick;
	ld	hl, #_flipAnimTick
	inc	(hl)
	jr	00103$
00102$:
;Bownly/states/bownlyMP5Microgame.c:156: flipAnimTick = 0U;
	ld	hl, #_flipAnimTick
	ld	(hl), #0x00
00103$:
;Bownly/states/bownlyMP5Microgame.c:158: inputsMP5();
	call	_inputsMP5
;Bownly/states/bownlyMP5Microgame.c:160: animatePreston();
	call	_animatePreston
;Bownly/states/bownlyMP5Microgame.c:161: if (flipAnimTick != 0U)
	ld	hl, #_flipAnimTick
	ld	a, (hl)
	or	a, a
	jp	Z,_tryShakeScreen
;Bownly/states/bownlyMP5Microgame.c:162: updateFlippingPanels();
	call	_updateFlippingPanels
;Bownly/states/bownlyMP5Microgame.c:164: tryShakeScreen();
;Bownly/states/bownlyMP5Microgame.c:166: }
	jp	_tryShakeScreen
;Bownly/states/bownlyMP5Microgame.c:170: static void inputsMP5()
;	---------------------------------
; Function inputsMP5
; ---------------------------------
_inputsMP5:
	dec	sp
;Bownly/states/bownlyMP5Microgame.c:172: if (!curJoypad & (J_UP | J_DOWN | J_LEFT | J_RIGHT))
	ld	a, (#_curJoypad)
	or	a, a
	jr	NZ, 00102$
;Bownly/states/bownlyMP5Microgame.c:174: buttonHoldTick = 0U;
	ld	hl, #_buttonHoldTick
	ld	(hl), #0x00
00102$:
;Bownly/states/bownlyMP5Microgame.c:177: if (screenShakeTick == 0U && mgStatus != LOST)
	ld	a, (#_screenShakeTick)
	or	a, a
	jp	NZ, 00152$
	ld	a, (#_mgStatus)
	sub	a, #0x03
	jp	Z,00152$
;Bownly/states/bownlyMP5Microgame.c:179: if(curJoypad & J_LEFT)
	ld	a, (#_curJoypad)
	ldhl	sp,	#0
	ld	(hl), a
;Bownly/states/bownlyMP5Microgame.c:181: ++buttonHoldTick;
	ld	a, (#_buttonHoldTick)
	inc	a
;Bownly/states/bownlyMP5Microgame.c:182: if (!(prevJoypad & J_LEFT) || (buttonHoldTick % 16U == 0U))
	ld	hl, #_prevJoypad
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;Bownly/states/bownlyMP5Microgame.c:179: if(curJoypad & J_LEFT)
	push	hl
	ldhl	sp,	#2
	bit	1, (hl)
	pop	hl
	jr	Z, 00132$
;Bownly/states/bownlyMP5Microgame.c:181: ++buttonHoldTick;
	ld	(_buttonHoldTick), a
;Bownly/states/bownlyMP5Microgame.c:182: if (!(prevJoypad & J_LEFT) || (buttonHoldTick % 16U == 0U))
	bit	1, l
	jr	Z, 00107$
	ld	a, (#_buttonHoldTick)
	and	a, #0x0f
	jp	NZ,00133$
00107$:
;Bownly/states/bownlyMP5Microgame.c:184: prestonIsHorz = TRUE;
	ld	hl, #_prestonIsHorz
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:185: if (prestonXIndex == 0U || prestonXIndex == 1U)
	ld	hl, #_prestonXIndex
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
	ld	a, (hl)
	dec	a
	jr	NZ, 00104$
00103$:
;Bownly/states/bownlyMP5Microgame.c:186: prestonXIndex = 5U;
	ld	hl, #_prestonXIndex
	ld	(hl), #0x05
	jr	00105$
00104$:
;Bownly/states/bownlyMP5Microgame.c:188: --prestonXIndex;
	ld	hl, #_prestonXIndex
	dec	(hl)
00105$:
;Bownly/states/bownlyMP5Microgame.c:189: prestonYIndex = 0U;
	ld	hl, #_prestonYIndex
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:190: playMoveSfx();
	call	_playMoveSfx
	jp	00133$
00132$:
;Bownly/states/bownlyMP5Microgame.c:193: else if(curJoypad & J_RIGHT)
	push	hl
	ldhl	sp,	#2
	bit	0, (hl)
	pop	hl
	jr	Z, 00129$
;Bownly/states/bownlyMP5Microgame.c:195: ++buttonHoldTick;
	ld	(_buttonHoldTick), a
;Bownly/states/bownlyMP5Microgame.c:196: if (!(prevJoypad & J_RIGHT) || (buttonHoldTick % 16U == 0U))
	bit	0, l
	jr	Z, 00110$
	ld	a, (#_buttonHoldTick)
	and	a, #0x0f
	jp	NZ,00133$
00110$:
;Bownly/states/bownlyMP5Microgame.c:198: prestonIsHorz = TRUE;
	ld	hl, #_prestonIsHorz
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:199: prestonXIndex = (prestonXIndex) % 5U + 1U;
	ld	hl, #_prestonXIndex
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x0005
	push	de
	push	bc
	call	__moduint
	add	sp, #4
	ld	a, e
	inc	a
	ld	(#_prestonXIndex),a
;Bownly/states/bownlyMP5Microgame.c:200: prestonYIndex = 0U;
	ld	hl, #_prestonYIndex
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:201: playMoveSfx();
	call	_playMoveSfx
	jr	00133$
00129$:
;Bownly/states/bownlyMP5Microgame.c:204: else if(curJoypad & J_UP)
	push	hl
	ldhl	sp,	#2
	bit	2, (hl)
	pop	hl
	jr	Z, 00126$
;Bownly/states/bownlyMP5Microgame.c:206: ++buttonHoldTick;
	ld	(_buttonHoldTick), a
;Bownly/states/bownlyMP5Microgame.c:207: if (!(prevJoypad & J_UP) || (buttonHoldTick % 16U == 0U))
	bit	2, l
	jr	Z, 00117$
	ld	a, (#_buttonHoldTick)
	and	a, #0x0f
	jr	NZ, 00133$
00117$:
;Bownly/states/bownlyMP5Microgame.c:209: prestonIsHorz = FALSE;
	ld	hl, #_prestonIsHorz
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:210: if (prestonYIndex == 0U || prestonYIndex == 1U)
	ld	hl, #_prestonYIndex
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ld	a, (hl)
	dec	a
	jr	NZ, 00114$
00113$:
;Bownly/states/bownlyMP5Microgame.c:211: prestonYIndex = 5U;
	ld	hl, #_prestonYIndex
	ld	(hl), #0x05
	jr	00115$
00114$:
;Bownly/states/bownlyMP5Microgame.c:213: --prestonYIndex;
	ld	hl, #_prestonYIndex
	dec	(hl)
00115$:
;Bownly/states/bownlyMP5Microgame.c:214: prestonXIndex = 0U;
	ld	hl, #_prestonXIndex
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:215: playMoveSfx();
	call	_playMoveSfx
	jr	00133$
00126$:
;Bownly/states/bownlyMP5Microgame.c:218: else if(curJoypad & J_DOWN)
	push	hl
	ldhl	sp,	#2
	bit	3, (hl)
	pop	hl
	jr	Z, 00133$
;Bownly/states/bownlyMP5Microgame.c:220: ++buttonHoldTick;
	ld	(_buttonHoldTick), a
;Bownly/states/bownlyMP5Microgame.c:221: if (!(prevJoypad & J_DOWN) || (buttonHoldTick % 16U == 0U))
	bit	3, l
	jr	Z, 00120$
	ld	a, (#_buttonHoldTick)
	and	a, #0x0f
	jr	NZ, 00133$
00120$:
;Bownly/states/bownlyMP5Microgame.c:223: prestonIsHorz = FALSE;
	ld	hl, #_prestonIsHorz
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:224: prestonYIndex = (prestonYIndex) % 5U + 1U;
	ld	hl, #_prestonYIndex
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x0005
	push	de
	push	bc
	call	__moduint
	add	sp, #4
	ld	a, e
	inc	a
	ld	(#_prestonYIndex),a
;Bownly/states/bownlyMP5Microgame.c:225: prestonXIndex = 0U;
	ld	hl, #_prestonXIndex
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:226: playMoveSfx();
	call	_playMoveSfx
00133$:
;Bownly/states/bownlyMP5Microgame.c:231: if (mgStatus == PLAYING)
	ld	a, (#_mgStatus)
	dec	a
	jp	NZ,00152$
;Bownly/states/bownlyMP5Microgame.c:233: if (curJoypad & J_A && !(prevJoypad & J_A) && flipAnimTick == 0U)
	ld	a, (#_curJoypad)
	bit	4, a
	jp	Z,00152$
	ld	a, (#_prevJoypad)
	bit	4, a
	jr	NZ, 00152$
	ld	a, (#_flipAnimTick)
	or	a, a
	jr	NZ, 00152$
;Bownly/states/bownlyMP5Microgame.c:235: playCollisionSfx();
	call	_playCollisionSfx
;Bownly/states/bownlyMP5Microgame.c:236: flipAnimTick = 1U;
	ld	hl, #_flipAnimTick
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:239: if (prestonIsHorz == TRUE)
	ld	a, (#_prestonIsHorz)
	dec	a
	jr	NZ, 00137$
;Bownly/states/bownlyMP5Microgame.c:241: j = (prestonXIndex - 1U) * 5U;
	ld	a, (#_prestonXIndex)
	dec	a
	ld	c, a
	add	a, a
	add	a, a
	add	a, c
	ld	(#_j),a
;Bownly/states/bownlyMP5Microgame.c:242: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00148$:
;Bownly/states/bownlyMP5Microgame.c:243: incrementPanel(&gridPanels[j+i]);
	ld	hl, #_j
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_i
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_gridPanels
	add	hl, de
	push	hl
	call	_incrementPanel
	pop	hl
;Bownly/states/bownlyMP5Microgame.c:242: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00152$
	jr	00148$
00137$:
;Bownly/states/bownlyMP5Microgame.c:247: j = (prestonYIndex - 1U);
	ld	a, (#_prestonYIndex)
	dec	a
	ld	(#_j),a
;Bownly/states/bownlyMP5Microgame.c:248: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00150$:
;Bownly/states/bownlyMP5Microgame.c:250: incrementPanel(&gridPanels[j]);
	ld	hl, #_j
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	push	hl
	call	_incrementPanel
	pop	hl
;Bownly/states/bownlyMP5Microgame.c:251: j += 5U;
	ld	hl, #_j
	ld	a, (hl)
	add	a, #0x05
	ld	(hl), a
;Bownly/states/bownlyMP5Microgame.c:248: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00150$
00152$:
;Bownly/states/bownlyMP5Microgame.c:257: }
	inc	sp
	ret
;Bownly/states/bownlyMP5Microgame.c:261: static void initGrid()
;	---------------------------------
; Function initGrid
; ---------------------------------
_initGrid:
;Bownly/states/bownlyMP5Microgame.c:263: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00123$:
;Bownly/states/bownlyMP5Microgame.c:265: for (j = 0U; j != 5U; ++j)
	ld	hl, #_j
	ld	(hl), #0x00
00121$:
;Bownly/states/bownlyMP5Microgame.c:267: l = i*5U+j;
	ld	a, (#_i)
	ld	c, a
	add	a, a
	add	a, a
	add	a, c
	ld	hl, #_j
	add	a, (hl)
	ld	(#_l),a
;Bownly/states/bownlyMP5Microgame.c:268: setupPanel(l, i, j, 6U);
	ld	a, #0x06
	push	af
	inc	sp
	ld	a, (#_j)
	ld	h, a
	ld	a, (#_i)
	ld	l, a
	push	hl
	ld	a, (#_l)
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:265: for (j = 0U; j != 5U; ++j)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00121$
;Bownly/states/bownlyMP5Microgame.c:263: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00123$
;Bownly/states/bownlyMP5Microgame.c:273: i = getRandUint8(5U);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_i
	ld	(hl), e
;Bownly/states/bownlyMP5Microgame.c:274: j = getRandUint8(5U);
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_j
	ld	(hl), e
;Bownly/states/bownlyMP5Microgame.c:275: setupPanel(i*5U+j, i, j, getRandUint8(2U));
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	b, e
	ld	a, (#_i)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #_j
	add	a, (hl)
	push	bc
	inc	sp
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_i
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:277: if (mgDifficulty != 0U)  // AKA, if 1 or 2
	ld	a, (#_mgDifficulty)
	or	a, a
	jr	Z, 00111$
;Bownly/states/bownlyMP5Microgame.c:279: k = getRandUint8(2U);  // Horz or vert
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_k
	ld	(hl), e
;Bownly/states/bownlyMP5Microgame.c:280: if (k == 0U)  // Horz
	ld	a, (hl)
	or	a, a
	jr	NZ, 00108$
;Bownly/states/bownlyMP5Microgame.c:282: if (++i == 5U)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00104$
;Bownly/states/bownlyMP5Microgame.c:283: i = 0U;
	ld	hl, #_i
	ld	(hl), #0x00
00104$:
;Bownly/states/bownlyMP5Microgame.c:284: setupPanel(i*5U+j, i, j, getRandUint8(2U));
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	b, e
	ld	a, (#_i)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #_j
	add	a, (hl)
	push	bc
	inc	sp
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_i
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
	jr	00111$
00108$:
;Bownly/states/bownlyMP5Microgame.c:288: if (++j == 5U)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00106$
;Bownly/states/bownlyMP5Microgame.c:289: j = 0U;
	ld	hl, #_j
	ld	(hl), #0x00
00106$:
;Bownly/states/bownlyMP5Microgame.c:290: setupPanel(i*5U+j, i, j, getRandUint8(2U));
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	b, e
	ld	a, (#_i)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #_j
	add	a, (hl)
	push	bc
	inc	sp
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_i
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
00111$:
;Bownly/states/bownlyMP5Microgame.c:293: if (mgDifficulty == 2U)
	ld	a, (#_mgDifficulty)
	sub	a, #0x02
	ret	NZ
;Bownly/states/bownlyMP5Microgame.c:295: if (k == 0U)  // Horz
	ld	a, (#_k)
	or	a, a
	jr	NZ, 00117$
;Bownly/states/bownlyMP5Microgame.c:297: if (++i == 5U)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00113$
;Bownly/states/bownlyMP5Microgame.c:298: i = 0U;
	ld	hl, #_i
	ld	(hl), #0x00
00113$:
;Bownly/states/bownlyMP5Microgame.c:299: setupPanel(i*5U+j, i, j, getRandUint8(2U));
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	b, e
	ld	a, (#_i)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #_j
	add	a, (hl)
	push	bc
	inc	sp
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_i
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
	ret
00117$:
;Bownly/states/bownlyMP5Microgame.c:303: if (++j == 5U)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00115$
;Bownly/states/bownlyMP5Microgame.c:304: j = 0U;
	ld	hl, #_j
	ld	(hl), #0x00
00115$:
;Bownly/states/bownlyMP5Microgame.c:305: setupPanel(i*5U+j, i, j, getRandUint8(2U));
	ld	a, #0x02
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	b, e
	ld	a, (#_i)
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #_j
	add	a, (hl)
	push	bc
	inc	sp
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	hl, #_i
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_setupPanel
	add	sp, #4
;Bownly/states/bownlyMP5Microgame.c:308: }
	ret
;Bownly/states/bownlyMP5Microgame.c:310: static void incrementPanel(BownlyPanel* panel)
;	---------------------------------
; Function incrementPanel
; ---------------------------------
_incrementPanel:
;Bownly/states/bownlyMP5Microgame.c:312: if (panel->panelValue != 6U)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (bc)
	sub	a, #0x06
	ret	Z
;Bownly/states/bownlyMP5Microgame.c:314: panel->isFlipping = 1U;
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:316: l = panel->panelValue + 1U;
	ld	a, (bc)
	inc	a
	ld	hl, #_l
	ld	(hl), a
;Bownly/states/bownlyMP5Microgame.c:317: if (l == 5U)  // Panel has exceeded max capacity
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00104$
;Bownly/states/bownlyMP5Microgame.c:319: l = 6U;
	ld	hl, #_l
	ld	(hl), #0x06
;Bownly/states/bownlyMP5Microgame.c:320: if (screenShakeTick == 0U)
	ld	hl, #_screenShakeTick
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;Bownly/states/bownlyMP5Microgame.c:321: screenShakeTick = 1U;
	ld	(hl), #0x01
00102$:
;Bownly/states/bownlyMP5Microgame.c:323: mgStatus = LOST;
	ld	hl, #_mgStatus
	ld	(hl), #0x03
;Bownly/states/bownlyMP5Microgame.c:325: playHurtSfx();
	push	bc
	call	_playHurtSfx
	pop	bc
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 42)
	ld	(hl), #0x41
;Bownly/states/bownlyMP5Microgame.c:326: set_sprite_tile(SPRID_HEARTS + 6U, SPRTILE_HEARTS + 1U);
00104$:
;Bownly/states/bownlyMP5Microgame.c:328: panel->panelValue = l;
	ld	hl, #_l
	ld	a, (hl)
	ld	(bc), a
;Bownly/states/bownlyMP5Microgame.c:330: if (l == 4U)  // Level 5
	ld	a, (hl)
	sub	a, #0x04
	ret	NZ
;Bownly/states/bownlyMP5Microgame.c:331: --remaining5s;
	ld	hl, #_remaining5s
	dec	(hl)
;Bownly/states/bownlyMP5Microgame.c:333: }
	ret
;Bownly/states/bownlyMP5Microgame.c:335: static void setupPanel(UINT8 index, UINT8 x, UINT8 y, UINT8 val)
;	---------------------------------
; Function setupPanel
; ---------------------------------
_setupPanel:
	add	sp, #-5
;Bownly/states/bownlyMP5Microgame.c:337: gridPanels[index].xIndex = x;
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
;Bownly/states/bownlyMP5Microgame.c:338: gridPanels[index].yIndex = y;
	ld	hl, #0x0003
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ldhl	sp,	#9
;Bownly/states/bownlyMP5Microgame.c:339: gridPanels[index].panelValue = val;
	ld	a, (hl+)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (hl)
	ld	(de), a
;Bownly/states/bownlyMP5Microgame.c:340: gridPanels[index].panelId = index;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(bc), a
;Bownly/states/bownlyMP5Microgame.c:342: gridPanels[index].isWinner = 1U;
	ld	hl, #0x0004
	add	hl, bc
;Bownly/states/bownlyMP5Microgame.c:341: if (val == 5U)
	push	hl
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x05
	pop	hl
	jr	NZ, 00102$
;Bownly/states/bownlyMP5Microgame.c:342: gridPanels[index].isWinner = 1U;
	ld	(hl), #0x01
	jr	00103$
00102$:
;Bownly/states/bownlyMP5Microgame.c:344: gridPanels[index].isWinner = 0U;
	ld	(hl), #0x00
00103$:
;Bownly/states/bownlyMP5Microgame.c:345: gridPanels[index].isFlipping = 0U;
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:348: panelsYOrigin + (gridPanels[index].yIndex << 1U), &gridPanels[index]);
	pop	de
	push	de
	ld	a, (de)
	add	a, a
	add	a, #0x04
	ldhl	sp,	#4
;Bownly/states/bownlyMP5Microgame.c:347: drawPanel(panelsXOrigin + (gridPanels[index].xIndex << 1U),
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, #0x05
	push	bc
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_drawPanel
;Bownly/states/bownlyMP5Microgame.c:349: }
	add	sp, #9
	ret
;Bownly/states/bownlyMP5Microgame.c:353: static void animatePreston()
;	---------------------------------
; Function animatePreston
; ---------------------------------
_animatePreston:
;Bownly/states/bownlyMP5Microgame.c:355: if (mgStatus == LOST)  // Hurt anims
	ld	a, (#_mgStatus)
	sub	a, #0x03
	jr	NZ, 00119$
;Bownly/states/bownlyMP5Microgame.c:356: animFrame = 6U;
	ld	hl, #_animFrame
	ld	(hl), #0x06
	jr	00120$
00119$:
;Bownly/states/bownlyMP5Microgame.c:357: else if (flipAnimTick != 0U)  // Attack anims
	ld	hl, #_flipAnimTick
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
;Bownly/states/bownlyMP5Microgame.c:360: if (flipAnimTick == 1U)
	ld	a, (hl)
	dec	a
	jr	NZ, 00111$
;Bownly/states/bownlyMP5Microgame.c:362: animFrame = 3U;
	ld	hl, #_animFrame
	ld	(hl), #0x03
	jr	00120$
00111$:
;Bownly/states/bownlyMP5Microgame.c:363: else if (flipAnimTick == 2U || flipAnimTick == 3U)
	ld	a,(#_flipAnimTick)
	cp	a,#0x02
	jr	Z, 00106$
	sub	a, #0x03
	jr	NZ, 00107$
00106$:
;Bownly/states/bownlyMP5Microgame.c:364: animFrame = 3U;
	ld	hl, #_animFrame
	ld	(hl), #0x03
	jr	00120$
00107$:
;Bownly/states/bownlyMP5Microgame.c:365: else if (flipAnimTick == 4U || flipAnimTick == 5U || flipAnimTick == 6U)
	ld	a,(#_flipAnimTick)
	cp	a,#0x04
	jr	Z, 00101$
	cp	a,#0x05
	jr	Z, 00101$
	sub	a, #0x06
	jr	NZ, 00102$
00101$:
;Bownly/states/bownlyMP5Microgame.c:366: animFrame = 4U;
	ld	hl, #_animFrame
	ld	(hl), #0x04
	jr	00120$
00102$:
;Bownly/states/bownlyMP5Microgame.c:369: animFrame = 5U;
	ld	hl, #_animFrame
	ld	(hl), #0x05
	jr	00120$
00116$:
;Bownly/states/bownlyMP5Microgame.c:374: animFrame = (animTick >> 4U) % 4U;
	ld	a, (#_animTick)
	swap	a
	and	a, #0x3
;	spillPairReg hl
;	spillPairReg hl
	ld	(_animFrame), a
;Bownly/states/bownlyMP5Microgame.c:375: if (animFrame == 3U)
	ld	a, (#_animFrame)
	sub	a, #0x03
	jr	NZ, 00120$
;Bownly/states/bownlyMP5Microgame.c:376: animFrame = 1U;
	ld	hl, #_animFrame
	ld	(hl), #0x01
00120$:
;Bownly/states/bownlyMP5Microgame.c:379: if (prestonIsHorz == FALSE)
	ld	a, (#_prestonIsHorz)
	or	a, a
	jr	NZ, 00122$
;Bownly/states/bownlyMP5Microgame.c:380: animFrame += 7U;
	ld	hl, #_animFrame
	ld	a, (hl)
	add	a, #0x07
	ld	(hl), a
00122$:
;Bownly/states/bownlyMP5Microgame.c:382: i = (prestonXIndex << 4U) + prestonXOffset;
	ld	a, (#_prestonXIndex)
	swap	a
	and	a, #0xf0
	add	a, #0x20
	ld	(#_i),a
;Bownly/states/bownlyMP5Microgame.c:383: j = (prestonYIndex << 4U) + prestonYOffset;
	ld	a, (#_prestonYIndex)
	swap	a
	and	a, #0xf0
	add	a, #0x20
	ld	hl, #_j
	ld	(hl), a
;Bownly/states/bownlyMP5Microgame.c:384: move_metasprite(bownlySprPreston_metasprites[animFrame], SPRTILE_PRESTON, SPRID_PRESTON, i, j);
	ld	b, (hl)
	ld	hl, #_i
	ld	c, (hl)
	ld	de, #_bownlySprPreston_metasprites+0
	ld	hl, #_animFrame
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
;Bownly/states/bownlyMP5Microgame.c:384: move_metasprite(bownlySprPreston_metasprites[animFrame], SPRTILE_PRESTON, SPRID_PRESTON, i, j);
;Bownly/states/bownlyMP5Microgame.c:385: }
	ret
;Bownly/states/bownlyMP5Microgame.c:387: static void drawPanel(UINT8 xCoord, UINT8 yCoord, BownlyPanel* panel)
;	---------------------------------
; Function drawPanel
; ---------------------------------
_drawPanel:
;Bownly/states/bownlyMP5Microgame.c:389: switch(panel->panelValue)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	a, #0x05
	sub	a, c
	jp	C, 00107$
	ld	b, #0x00
	ld	hl, #00116$
	add	hl, bc
	add	hl, bc
	add	hl, bc
	jp	(hl)
00116$:
	jp	00101$
	jp	00102$
	jp	00103$
	jp	00104$
	jp	00105$
	jp	00106$
;Bownly/states/bownlyMP5Microgame.c:391: case 0U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panel0Map); break;
00101$:
	ld	de, #_panel0Map
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:392: case 1U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panel1Map); break;
00102$:
	ld	de, #_panel1Map
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:393: case 2U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panel2Map); break;
00103$:
	ld	de, #_panel2Map
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:394: case 3U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panel3Map); break;
00104$:
	ld	de, #_panel3Map
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:395: case 4U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panel4Map); break;
00105$:
	ld	de, #_panel4Map
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:396: case 5U: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panelPointMap); break;
00106$:
	ld	de, #_panelPointMap
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ret
;Bownly/states/bownlyMP5Microgame.c:397: default: set_bkg_tiles(xCoord, yCoord, 2U, 2U, panelXMap); break;
00107$:
	ld	de, #_panelXMap
	push	de
	ld	hl, #0x202
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;Bownly/states/bownlyMP5Microgame.c:398: }
;Bownly/states/bownlyMP5Microgame.c:399: }
	ret
;Bownly/states/bownlyMP5Microgame.c:401: static void setupHearts()
;	---------------------------------
; Function setupHearts
; ---------------------------------
_setupHearts:
;Bownly/states/bownlyMP5Microgame.c:403: for (i = 0; i != 7; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00105$:
;Bownly/states/bownlyMP5Microgame.c:405: set_sprite_tile(SPRID_HEARTS + i, SPRTILE_HEARTS + 1U);
	ld	hl, #_i
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
	inc	c
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x41
;Bownly/states/bownlyMP5Microgame.c:406: move_sprite(SPRID_HEARTS + i, 136U, 47U + 12U * i);
	ld	a, (#_i)
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, #0x2f
	ld	c, a
	ld	hl, #_i
	ld	b, (hl)
	inc	b
	inc	b
	inc	b
	inc	b
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x88
;Bownly/states/bownlyMP5Microgame.c:403: for (i = 0; i != 7; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x07
	jr	NZ, 00105$
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 42)
	ld	(hl), #0x40
;Bownly/states/bownlyMP5Microgame.c:408: set_sprite_tile(SPRID_HEARTS + 6U, SPRTILE_HEARTS);
;Bownly/states/bownlyMP5Microgame.c:409: }
	ret
;Bownly/states/bownlyMP5Microgame.c:411: static void tryShakeScreen()
;	---------------------------------
; Function tryShakeScreen
; ---------------------------------
_tryShakeScreen:
;Bownly/states/bownlyMP5Microgame.c:413: if (screenShakeTick != 0U)
	ld	hl, #_screenShakeTick
	ld	a, (hl)
	or	a, a
	ret	Z
;Bownly/states/bownlyMP5Microgame.c:415: if (screenShakeTick != 26U)
	ld	a, (hl)
	sub	a, #0x1a
	ret	Z
;Bownly/states/bownlyMP5Microgame.c:417: ++screenShakeTick;
	ld	hl, #_screenShakeTick
	inc	(hl)
;Bownly/states/bownlyMP5Microgame.c:418: switch (screenShakeTick)
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00101$
	ld	a, (#_screenShakeTick)
	sub	a, #0x0a
	jr	Z, 00102$
	ld	a, (#_screenShakeTick)
	sub	a, #0x0f
	jr	Z, 00103$
	ld	a, (#_screenShakeTick)
	sub	a, #0x14
	jr	Z, 00104$
	ld	a, (#_screenShakeTick)
	sub	a, #0x19
	jr	Z, 00105$
	ret
;Bownly/states/bownlyMP5Microgame.c:420: case 5U:
00101$:
;C:/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	inc	a
	ldh	(_SCX_REG + 0), a
;Bownly/states/bownlyMP5Microgame.c:422: break;
	ret
;Bownly/states/bownlyMP5Microgame.c:423: case 10U:
00102$:
;C:/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	add	a, #0xfe
	ldh	(_SCX_REG + 0), a
;Bownly/states/bownlyMP5Microgame.c:425: break;
	ret
;Bownly/states/bownlyMP5Microgame.c:426: case 15U:
00103$:
;C:/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCY_REG + 0)
	inc	a
	ldh	(_SCY_REG + 0), a
;Bownly/states/bownlyMP5Microgame.c:428: break;
	ret
;Bownly/states/bownlyMP5Microgame.c:429: case 20U:
00104$:
;C:/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCY_REG + 0)
	add	a, #0xfe
	ldh	(_SCY_REG + 0), a
;Bownly/states/bownlyMP5Microgame.c:431: break;
	ret
;Bownly/states/bownlyMP5Microgame.c:432: case 25U:
00105$:
;C:/gbdk/include/gb/gb.h:1080: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;Bownly/states/bownlyMP5Microgame.c:434: screenShakeTick = 0U;
	ld	hl, #_screenShakeTick
	ld	(hl), #0x00
;Bownly/states/bownlyMP5Microgame.c:436: }
;Bownly/states/bownlyMP5Microgame.c:439: }
	ret
;Bownly/states/bownlyMP5Microgame.c:441: static void updateFlippingPanels()
;	---------------------------------
; Function updateFlippingPanels
; ---------------------------------
_updateFlippingPanels:
;Bownly/states/bownlyMP5Microgame.c:443: if (flipAnimTick == flipDuration - 1U)
	ld	hl, #_flipDuration
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
	ld	hl, #_flipAnimTick
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jp	NZ,00119$
	ld	a, d
	sub	a, b
	jp	NZ,00119$
;Bownly/states/bownlyMP5Microgame.c:445: for (i = 0; i != 25; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00122$:
;Bownly/states/bownlyMP5Microgame.c:447: if (gridPanels[i].isFlipping == 1U)
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	ld	bc, #0x0005
	add	hl, bc
	ld	a, (hl)
;Bownly/states/bownlyMP5Microgame.c:449: gridPanels[i].isFlipping = 0U;
	dec	a
	jr	NZ, 00123$
	ld	(hl),a
;Bownly/states/bownlyMP5Microgame.c:451: panelsYOrigin + (gridPanels[i].yIndex << 1U), &gridPanels[i]);
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	ld	e, l
	ld	d, h
	ld	c, l
	ld	b, h
;Bownly/states/bownlyMP5Microgame.c:450: drawPanel(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	inc	hl
	inc	hl
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	add	a, a
	add	a, #0x04
	ld	b, a
	ld	a, (hl)
	add	a, a
	add	a, #0x05
	push	de
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_drawPanel
	add	sp, #4
00123$:
;Bownly/states/bownlyMP5Microgame.c:445: for (i = 0; i != 25; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x19
	jr	NZ, 00122$
;Bownly/states/bownlyMP5Microgame.c:456: if (remaining5s == 0U && mgStatus != LOST)
	ld	a, (#_remaining5s)
	or	a, a
	ret	NZ
	ld	a, (#_mgStatus)
	sub	a, #0x03
	ret	Z
;Bownly/states/bownlyMP5Microgame.c:458: mgStatus = WON;
	ld	hl, #_mgStatus
	ld	(hl), #0x02
;Bownly/states/bownlyMP5Microgame.c:461: if (didWinFlip == FALSE)
	ld	a, (#_didWinFlip)
	or	a, a
	ret	NZ
;Bownly/states/bownlyMP5Microgame.c:463: playCollisionSfx();
	call	_playCollisionSfx
;Bownly/states/bownlyMP5Microgame.c:464: didWinFlip = TRUE;
	ld	hl, #_didWinFlip
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:465: flipAnimTick = 1U;
	ld	hl, #_flipAnimTick
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:466: for (i = 0U; i != 25U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00124$:
;Bownly/states/bownlyMP5Microgame.c:468: gridPanels[i].panelValue = 5U;
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	inc	hl
	ld	(hl), #0x05
;Bownly/states/bownlyMP5Microgame.c:469: gridPanels[i].isFlipping = 1U;
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_gridPanels
	add	hl,bc
	ld	bc, #0x0005
	add	hl, bc
	ld	(hl), #0x01
;Bownly/states/bownlyMP5Microgame.c:466: for (i = 0U; i != 25U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x19
	jr	NZ, 00124$
;Bownly/states/bownlyMP5Microgame.c:471: for (i = 0U; i != 6U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00126$:
;Bownly/states/bownlyMP5Microgame.c:472: set_sprite_tile(SPRID_HEARTS + i, SPRTILE_HEARTS);
	ld	hl, #_i
	ld	e, (hl)
	inc	e
	inc	e
	inc	e
	inc	e
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x40
;Bownly/states/bownlyMP5Microgame.c:471: for (i = 0U; i != 6U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	ret	Z
	jr	00126$
00119$:
;Bownly/states/bownlyMP5Microgame.c:479: for (i = 0; i != 25; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00128$:
;Bownly/states/bownlyMP5Microgame.c:447: if (gridPanels[i].isFlipping == 1U)
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
;Bownly/states/bownlyMP5Microgame.c:481: if (gridPanels[i].isFlipping == 1U)
	ld	bc,#_gridPanels
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	dec	a
	jr	NZ, 00129$
;Bownly/states/bownlyMP5Microgame.c:483: m = (flipAnimTick) >> 3U;
	ld	a, (#_flipAnimTick)
	swap	a
	rlca
	and	a, #0x1f
	ld	(#_m),a
;Bownly/states/bownlyMP5Microgame.c:487: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip1Map);
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
;Bownly/states/bownlyMP5Microgame.c:486: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
;Bownly/states/bownlyMP5Microgame.c:487: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip1Map);
	ld	a, (de)
;Bownly/states/bownlyMP5Microgame.c:486: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	ld	c, (hl)
;Bownly/states/bownlyMP5Microgame.c:487: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip1Map);
	add	a, a
;Bownly/states/bownlyMP5Microgame.c:486: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	sla	c
;Bownly/states/bownlyMP5Microgame.c:487: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip1Map);
	add	a, #0x04
	ld	b, a
;Bownly/states/bownlyMP5Microgame.c:486: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	ld	a, c
	add	a, #0x05
	ld	c, a
;Bownly/states/bownlyMP5Microgame.c:484: if (m == 0U || m == 2U)
	ld	hl, #_m
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00112$
00111$:
;Bownly/states/bownlyMP5Microgame.c:487: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip1Map);
;Bownly/states/bownlyMP5Microgame.c:486: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	ld	de, #_panelFlip1Map
	push	de
	ld	hl, #0x202
	push	hl
	push	bc
	call	_set_bkg_tiles
	add	sp, #6
	jr	00129$
00112$:
;Bownly/states/bownlyMP5Microgame.c:492: panelsYOrigin + (gridPanels[i].yIndex << 1U), 2U, 2U, panelFlip2Map);
;Bownly/states/bownlyMP5Microgame.c:491: set_bkg_tiles(panelsXOrigin + (gridPanels[i].xIndex << 1U),
	ld	de, #_panelFlip2Map
	push	de
	ld	hl, #0x202
	push	hl
	push	bc
	call	_set_bkg_tiles
	add	sp, #6
00129$:
;Bownly/states/bownlyMP5Microgame.c:479: for (i = 0; i != 25; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x19
	jr	NZ, 00128$
;Bownly/states/bownlyMP5Microgame.c:497: }
	ret
	.area _CODE_2
	.area _INITIALIZER
	.area _CABS (ABS)
