;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module common
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _printLine
	.globl _drawPopupWindow
	.globl _getRandUint8
	.globl _rand
	.globl _set_win_tiles
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
	.area _CODE
;Engine/common.c:9: UINT8 getRandUint8(UINT8 modulo)
;	---------------------------------
; Function getRandUint8
; ---------------------------------
_getRandUint8::
;Engine/common.c:11: r = rand() % modulo;
	call	_rand
	ld	a, e
	ldhl	sp,	#2
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	__moduchar
	pop	hl
	ld	hl, #_r
;Engine/common.c:12: return r;
	ld	(hl),e
;Engine/common.c:13: }
	ret
;Engine/common.c:15: void drawPopupWindow(UINT8 xCoord, UINT8 yCoord, UINT8 xDim, UINT8 yDim)
;	---------------------------------
; Function drawPopupWindow
; ---------------------------------
_drawPopupWindow::
;Engine/common.c:18: set_bkg_tile_xy(xCoord, yCoord, 0xF0U);
	ld	a, #0xf0
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:19: set_bkg_tile_xy(xCoord + xDim, yCoord, 0xF2U);
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	dec	hl
	ld	c, a
	ld	a, #0xf2
	push	af
	inc	sp
	ld	b, (hl)
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:20: set_bkg_tile_xy(xCoord, yCoord + yDim, 0xF5U);
	ldhl	sp,	#3
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	ld	b, a
	ld	a, #0xf5
	push	af
	inc	sp
	push	bc
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:21: set_bkg_tile_xy(xCoord + xDim, yCoord + yDim, 0xF7U);
	ld	a, #0xf7
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:24: for (i = 1U; i != xDim; ++i)
	ld	hl, #_i
	ld	(hl), #0x01
00108$:
	ld	a, (#_i)
	ldhl	sp,	#4
	sub	a, (hl)
	jr	Z, 00102$
;Engine/common.c:26: set_bkg_tile_xy(xCoord + i, yCoord, 0xF1U);
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #_i
	add	a, (hl)
	ld	h, #0xf1
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:27: set_bkg_tile_xy(xCoord + i, yCoord + yDim, 0xF6U);
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #_i
	add	a, (hl)
	ld	h, #0xf6
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:30: for (j = 1U; j != yDim; j++)
	ld	hl, #_j
	ld	(hl), #0x01
00105$:
	ld	a, (#_j)
	ldhl	sp,	#5
	sub	a, (hl)
	jr	Z, 00109$
;Engine/common.c:32: set_bkg_tile_xy(xCoord + i, yCoord + j, 0xF8U);
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #_j
	add	a, (hl)
	ld	d, a
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #_i
	add	a, (hl)
	ld	h, #0xf8
;	spillPairReg hl
;	spillPairReg hl
	ld	l, d
	push	hl
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:30: for (j = 1U; j != yDim; j++)
	ld	hl, #_j
	inc	(hl)
	jr	00105$
00109$:
;Engine/common.c:24: for (i = 1U; i != xDim; ++i)
	ld	hl, #_i
	inc	(hl)
	jr	00108$
00102$:
;Engine/common.c:35: for (j = 1U; j != yDim; ++j)
	ld	hl, #_j
	ld	(hl), #0x01
00111$:
	ld	a, (#_j)
	ldhl	sp,	#5
	sub	a, (hl)
	ret	Z
;Engine/common.c:37: set_bkg_tile_xy(xCoord, yCoord + j, 0xF3U);
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #_j
	add	a, (hl)
	ld	h, #0xf3
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:38: set_bkg_tile_xy(xCoord + xDim, yCoord + j, 0xF4U);
	ldhl	sp,	#3
	ld	a, (hl)
	ld	hl, #_j
	add	a, (hl)
	ld	h, #0xf4
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ld	b, a
	push	bc
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/common.c:35: for (j = 1U; j != yDim; ++j)
	ld	hl, #_j
	inc	(hl)
;Engine/common.c:40: }
	jr	00111$
;Engine/common.c:43: void printLine(UINT8 xCoord, UINT8 yCoord, unsigned char* line, UINT8 printToWindow)
;	---------------------------------
; Function printLine
; ---------------------------------
_printLine::
	add	sp, #-19
;Engine/common.c:46: unsigned char* tempLinePtr = tempLine;
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
;Engine/common.c:49: while (*line)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#18
	ld	(hl), #0x00
00122$:
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
;Engine/common.c:51: if (*line == ' ')
	ld	l,a
	or	a,a
	jr	Z, 00124$
	sub	a, #0x20
	jr	NZ, 00120$
;Engine/common.c:52: diff = 0x21;
	ld	h, #0x21
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00120$:
;Engine/common.c:53: else if (*line == '.')
	ld	a, l
	sub	a, #0x2e
	jr	NZ, 00117$
;Engine/common.c:54: diff = 0x0A;
	ld	h, #0x0a
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00117$:
;Engine/common.c:55: else if (*line == ',')
	ld	a, l
	sub	a, #0x2c
	jr	NZ, 00114$
;Engine/common.c:56: diff = 0x06;
	ld	h, #0x06
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00114$:
;Engine/common.c:57: else if (*line == '?')
	ld	a, l
	sub	a, #0x3f
	jr	NZ, 00111$
;Engine/common.c:58: diff = 0x1A;
	ld	h, #0x1a
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00111$:
;Engine/common.c:59: else if (*line == ':')
	ld	a, l
	sub	a, #0x3a
	jr	NZ, 00108$
;Engine/common.c:60: diff = 0x0F;
	ld	h, #0x0f
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00108$:
;Engine/common.c:61: else if (*line == '!')
	ld	a, l
	sub	a, #0x21
	jr	NZ, 00105$
;Engine/common.c:62: diff = 0xF9;
	ld	h, #0xf9
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00105$:
;Engine/common.c:63: else if (*line <= 0x39)  // 0-9... and anything lower in index than 0
	ld	a, #0x39
	sub	a, l
	jr	C, 00102$
;Engine/common.c:64: diff = 0x30;
	ld	h, #0x30
;	spillPairReg hl
;	spillPairReg hl
	jr	00121$
00102$:
;Engine/common.c:66: diff = 0x37;
	ld	h, #0x37
;	spillPairReg hl
;	spillPairReg hl
00121$:
;Engine/common.c:68: *tempLinePtr = *line - diff;
	ld	a, l
	sub	a, h
	ld	(bc), a
;Engine/common.c:69: tempLinePtr++;
	inc	bc
;Engine/common.c:70: line++;
	inc	de
;Engine/common.c:71: size++;
	ldhl	sp,	#18
	inc	(hl)
	jr	00122$
00124$:
;Engine/common.c:75: set_bkg_tiles(xCoord, yCoord, size, 1U, tempLinePtr-size);
	ldhl	sp,	#18
	ld	e, (hl)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;Engine/common.c:74: if (printToWindow == FALSE)
	ldhl	sp,	#25
	ld	a, (hl)
	or	a, a
	jr	NZ, 00126$
;Engine/common.c:75: set_bkg_tiles(xCoord, yCoord, size, 1U, tempLinePtr-size);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#21
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#26
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	jr	00128$
00126$:
;Engine/common.c:77: set_win_tiles(xCoord, yCoord, size, 1U, tempLinePtr-size);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#21
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#26
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_win_tiles
	add	sp, #6
00128$:
;Engine/common.c:78: }
	add	sp, #19
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
