;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module templateFaceMicrogame
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _templateFaceMicrogameMain
	.globl _playSong
	.globl _fadein
	.globl _getRandUint8
	.globl _init_bkg
	.globl _set_sprite_data
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
_facesGrid:
	.ds 20
_sadCount:
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
	.area _CODE_1
;Template/states/templateFaceMicrogame.c:64: void templateFaceMicrogameMain()
;	---------------------------------
; Function templateFaceMicrogameMain
; ---------------------------------
_templateFaceMicrogameMain::
;Template/states/templateFaceMicrogame.c:66: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Template/states/templateFaceMicrogame.c:68: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;Template/states/templateFaceMicrogame.c:70: case SUB_INIT:
00101$:
;Template/states/templateFaceMicrogame.c:71: phaseFaceInit();
	call	_phaseFaceInit
;Template/states/templateFaceMicrogame.c:72: break;
	jr	00104$
;Template/states/templateFaceMicrogame.c:73: case SUB_LOOP:
00102$:
;Template/states/templateFaceMicrogame.c:74: phaseFaceLoop();
	call	_phaseFaceLoop
;Template/states/templateFaceMicrogame.c:75: break;
	jr	00104$
;Template/states/templateFaceMicrogame.c:76: default:  // Abort to title in the event of unexpected state
00103$:
;Template/states/templateFaceMicrogame.c:77: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:78: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:80: }
00104$:
;Template/states/templateFaceMicrogame.c:81: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Template/states/templateFaceMicrogame.c:82: }
	ret
;Template/states/templateFaceMicrogame.c:86: static void phaseFaceInit()
;	---------------------------------
; Function phaseFaceInit
; ---------------------------------
_phaseFaceInit:
;Template/states/templateFaceMicrogame.c:89: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Template/states/templateFaceMicrogame.c:90: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:91: m = 0U;  // Used as the X index for the cursor, uses faces as the unit of measurement
	ld	hl, #_m
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:92: n = 0U;  // Used as the Y index for the cursor, uses faces as the unit of measurement
	ld	hl, #_n
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:95: sadCount = mgDifficulty + 2U;  // Range of 2, 3 or 4
	ld	a, (#_mgDifficulty)
	add	a, #0x02
	ld	(#_sadCount),a
;Template/states/templateFaceMicrogame.c:102: set_bkg_data(BKGTILE_FACES, 8U, templateFaceTiles);
	ld	de, #_templateFaceTiles
	push	de
	ld	hl, #0x840
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Template/states/templateFaceMicrogame.c:103: set_sprite_data(SPRTILE_CURSOR, 3U, templateCursorTiles);
	ld	de, #_templateCursorTiles
	push	de
	ld	hl, #0x300
	push	hl
	call	_set_sprite_data
	add	sp, #4
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:107: animateCursor();
	call	_animateCursor
;Template/states/templateFaceMicrogame.c:108: updateCursorLocation();
	call	_updateCursorLocation
;Template/states/templateFaceMicrogame.c:111: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00111$:
;Template/states/templateFaceMicrogame.c:113: for (j = 0U; j != 4U; ++j)
	ld	hl, #_j
	ld	(hl), #0x00
00109$:
;Template/states/templateFaceMicrogame.c:115: facesGrid[j][i] = HAPPY;
	ld	hl, #_j
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_facesGrid
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #_i
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:116: set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace1Map);
	ld	a, (#_j)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	ld	b, a
	ld	hl, #_i
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, #0x03
	ld	de, #_templateFace1Map
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;Template/states/templateFaceMicrogame.c:113: for (j = 0U; j != 4U; ++j)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00109$
;Template/states/templateFaceMicrogame.c:111: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00111$
;Template/states/templateFaceMicrogame.c:121: k = 0U;
	ld	hl, #_k
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:122: while (k != sadCount)
00105$:
	ld	a, (#_k)
	ld	hl, #_sadCount
	sub	a, (hl)
	jr	Z, 00107$
;Template/states/templateFaceMicrogame.c:124: i = getRandUint8(5U);  // Number of columns
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_i
	ld	(hl), e
;Template/states/templateFaceMicrogame.c:125: j = getRandUint8(4U);  // Number of rows
	ld	a, #0x04
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	hl, #_j
	ld	(hl), e
;Template/states/templateFaceMicrogame.c:128: if (facesGrid[j][i] == HAPPY)
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_facesGrid
	add	hl,bc
	ld	c, l
	ld	b, h
;Template/states/templateFaceMicrogame.c:115: facesGrid[j][i] = HAPPY;
	ld	hl, #_i
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;Template/states/templateFaceMicrogame.c:128: if (facesGrid[j][i] == HAPPY)
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00105$
;Template/states/templateFaceMicrogame.c:130: facesGrid[j][i] = SAD;
	ld	(hl), #0x01
;Template/states/templateFaceMicrogame.c:131: set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace2Map);
	ld	a, (#_j)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	ld	b, a
	ld	hl, #_i
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, #0x03
	ld	de, #_templateFace2Map
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;Template/states/templateFaceMicrogame.c:132: ++k;  // Increase the count to prevent an infinite loop
	ld	hl, #_k
	inc	(hl)
	jr	00105$
00107$:
;Template/states/templateFaceMicrogame.c:137: playSong(&templateTwilightDriveSong);
	ld	de, #_templateTwilightDriveSong
	push	de
	call	_playSong
	pop	hl
;Template/states/templateFaceMicrogame.c:139: fadein();
	call	_fadein
;Template/states/templateFaceMicrogame.c:140: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Template/states/templateFaceMicrogame.c:141: }
	ret
;Template/states/templateFaceMicrogame.c:143: static void phaseFaceLoop()
;	---------------------------------
; Function phaseFaceLoop
; ---------------------------------
_phaseFaceLoop:
;Template/states/templateFaceMicrogame.c:145: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Template/states/templateFaceMicrogame.c:147: if (mgStatus == PLAYING)
	ld	a, (#_mgStatus)
	dec	a
	ret	NZ
;Template/states/templateFaceMicrogame.c:149: inputsFace();
	call	_inputsFace
;Template/states/templateFaceMicrogame.c:150: animateCursor();  
;Template/states/templateFaceMicrogame.c:152: }
	jp	_animateCursor
;Template/states/templateFaceMicrogame.c:155: static void inputsFace()
;	---------------------------------
; Function inputsFace
; ---------------------------------
_inputsFace:
;Template/states/templateFaceMicrogame.c:157: if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT))
	ld	a, (#_curJoypad)
	ld	hl, #_prevJoypad
	ld	c, (hl)
	bit	1, a
	jr	Z, 00109$
	bit	1, c
	jr	NZ, 00109$
;Template/states/templateFaceMicrogame.c:160: if (m-- == 0U)
	ld	hl, #_m
	ld	c, (hl)
	dec	(hl)
	ld	a, c
	or	a, a
	jr	NZ, 00102$
;Template/states/templateFaceMicrogame.c:161: m = 4U;
	ld	(hl), #0x04
00102$:
;Template/states/templateFaceMicrogame.c:162: updateCursorLocation();
	call	_updateCursorLocation
	jr	00110$
00109$:
;Template/states/templateFaceMicrogame.c:164: else if (curJoypad & J_RIGHT && !(prevJoypad & J_RIGHT))
	rrca
	jr	NC, 00110$
	bit	0, c
	jr	NZ, 00110$
;Template/states/templateFaceMicrogame.c:167: if (++m == 5U)
	ld	hl, #_m
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00104$
;Template/states/templateFaceMicrogame.c:168: m = 0U;
	ld	hl, #_m
	ld	(hl), #0x00
00104$:
;Template/states/templateFaceMicrogame.c:169: updateCursorLocation();
	call	_updateCursorLocation
00110$:
;Template/states/templateFaceMicrogame.c:157: if (curJoypad & J_LEFT && !(prevJoypad & J_LEFT))
	ld	a, (#_curJoypad)
	ld	hl, #_prevJoypad
	ld	c, (hl)
;Template/states/templateFaceMicrogame.c:172: if (curJoypad & J_UP && !(prevJoypad & J_UP))
	bit	2, a
	jr	Z, 00120$
	bit	2, c
	jr	NZ, 00120$
;Template/states/templateFaceMicrogame.c:175: if (n-- == 0U)
	ld	hl, #_n
	ld	c, (hl)
	dec	(hl)
	ld	a, c
	or	a, a
	jr	NZ, 00113$
;Template/states/templateFaceMicrogame.c:176: n = 3U;
	ld	(hl), #0x03
00113$:
;Template/states/templateFaceMicrogame.c:177: updateCursorLocation();
	call	_updateCursorLocation
	jr	00121$
00120$:
;Template/states/templateFaceMicrogame.c:179: else if (curJoypad & J_DOWN && !(prevJoypad & J_DOWN))
	bit	3, a
	jr	Z, 00121$
	bit	3, c
	jr	NZ, 00121$
;Template/states/templateFaceMicrogame.c:182: if (++n == 4U)
	ld	hl, #_n
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00115$
;Template/states/templateFaceMicrogame.c:183: n = 0U;
	ld	hl, #_n
	ld	(hl), #0x00
00115$:
;Template/states/templateFaceMicrogame.c:184: updateCursorLocation();
	call	_updateCursorLocation
00121$:
;Template/states/templateFaceMicrogame.c:187: if (curJoypad & J_A && !(prevJoypad & J_A))
	ld	a, (#_curJoypad)
	bit	4, a
	ret	Z
	ld	a, (#_prevJoypad)
	bit	4, a
	ret	NZ
;Template/states/templateFaceMicrogame.c:189: if (facesGrid[n][m] == HAPPY)
	ld	hl, #_n
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_facesGrid
	add	hl,bc
	ld	c, l
	ld	b, h
;Template/states/templateFaceMicrogame.c:160: if (m-- == 0U)
	ld	hl, #_m
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;Template/states/templateFaceMicrogame.c:189: if (facesGrid[n][m] == HAPPY)
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00128$
;Template/states/templateFaceMicrogame.c:191: mgStatus = LOST;
	ld	hl, #_mgStatus
	ld	(hl), #0x03
;Template/states/templateFaceMicrogame.c:195: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00135$:
;Template/states/templateFaceMicrogame.c:197: for (j = 0U; j != 4U; ++j)
	ld	hl, #_j
	ld	(hl), #0x00
00133$:
;Template/states/templateFaceMicrogame.c:199: facesGrid[j][i] = SAD;
	ld	hl, #_j
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_facesGrid
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	hl, #_i
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
	add	hl, bc
	ld	(hl), #0x01
;Template/states/templateFaceMicrogame.c:200: set_bkg_tiles(facesXAnchor + (i * 3U), facesYAnchor + (j * 3U), 2U, 2U, templateFace2Map);
	ld	a, (#_j)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	ld	b, a
	ld	hl, #_i
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, #0x03
	ld	de, #_templateFace2Map
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;Template/states/templateFaceMicrogame.c:197: for (j = 0U; j != 4U; ++j)
	ld	hl, #_j
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00133$
;Template/states/templateFaceMicrogame.c:195: for (i = 0U; i != 5U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	ret	Z
	jr	00135$
00128$:
;Template/states/templateFaceMicrogame.c:206: facesGrid[n][m] = HAPPY;
	ld	(hl), #0x00
;Template/states/templateFaceMicrogame.c:207: set_bkg_tiles(facesXAnchor + (m * 3U), facesYAnchor + (n * 3U), 2U, 2U, templateFace1Map);
	ld	a, (#_n)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	ld	b, a
	ld	hl, #_m
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	add	a, #0x03
	ld	de, #_templateFace1Map
	push	de
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;Template/states/templateFaceMicrogame.c:209: if (--sadCount == 0U)
	ld	hl, #_sadCount
	dec	(hl)
	ret	NZ
;Template/states/templateFaceMicrogame.c:211: mgStatus = WON;
	ld	hl, #_mgStatus
	ld	(hl), #0x02
;Template/states/templateFaceMicrogame.c:216: }
	ret
;Template/states/templateFaceMicrogame.c:223: static void animateCursor()
;	---------------------------------
; Function animateCursor
; ---------------------------------
_animateCursor:
;Template/states/templateFaceMicrogame.c:225: animFrame = (animTick >> 4U) % 4U;
	ld	a, (#_animTick)
	swap	a
	and	a, #0x3
;	spillPairReg hl
;	spillPairReg hl
	ld	(_animFrame), a
;Template/states/templateFaceMicrogame.c:226: if (animFrame == 3U)
	ld	a, (#_animFrame)
	sub	a, #0x03
	jr	NZ, 00102$
;Template/states/templateFaceMicrogame.c:227: animFrame = 1U;  // We want the pattern to be 0, 1, 2, 1, ad infinitum
	ld	hl, #_animFrame
	ld	(hl), #0x01
00102$:
;Template/states/templateFaceMicrogame.c:230: set_sprite_tile(0U, animFrame);
	ld	hl, #_animFrame
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;Template/states/templateFaceMicrogame.c:230: set_sprite_tile(0U, animFrame);
;Template/states/templateFaceMicrogame.c:231: }
	ret
;Template/states/templateFaceMicrogame.c:233: static void updateCursorLocation()
;	---------------------------------
; Function updateCursorLocation
; ---------------------------------
_updateCursorLocation:
;Template/states/templateFaceMicrogame.c:238: i = ((facesXAnchor + (m * 3U)) << 3U) + 12U;
	ld	a, (#_m)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x0c
	ld	(#_i),a
;Template/states/templateFaceMicrogame.c:239: j = ((facesYAnchor + (n * 3U)) << 3U) + 9U;
	ld	a, (#_n)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x03
	add	a, a
	add	a, a
	add	a, a
	add	a, #0x09
	ld	hl, #_j
	ld	(hl), a
;Template/states/templateFaceMicrogame.c:241: move_sprite(0U, i, j);
	ld	b, (hl)
	ld	hl, #_i
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;Template/states/templateFaceMicrogame.c:241: move_sprite(0U, i, j);
;Template/states/templateFaceMicrogame.c:242: }
	ret
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
