;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module fade
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fadeout
	.globl _fadein
	.globl _performantdelay
	.globl _getIsFadedOut
	.globl _wait_vbl_done
	.globl _isFadedOut
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_isFadedOut::
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
	.area _CODE
;Engine/fade.c:5: UINT8 getIsFadedOut()
;	---------------------------------
; Function getIsFadedOut
; ---------------------------------
_getIsFadedOut::
;Engine/fade.c:7: return isFadedOut;
	ld	hl, #_isFadedOut
	ld	e, (hl)
;Engine/fade.c:8: }
	ret
;Engine/fade.c:11: void performantdelay(UINT8 numloops)
;	---------------------------------
; Function performantdelay
; ---------------------------------
_performantdelay::
;Engine/fade.c:14: for (j = 0U; j != numloops; j++)
	ld	c, #0x00
00103$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, c
	ret	Z
;Engine/fade.c:16: wait_vbl_done();
	call	_wait_vbl_done
;Engine/fade.c:14: for (j = 0U; j != numloops; j++)
	inc	c
;Engine/fade.c:18: }
	jr	00103$
;Engine/fade.c:20: void fadein() 
;	---------------------------------
; Function fadein
; ---------------------------------
_fadein::
;Engine/fade.c:23: for (i = 0U; i != 3U; i++) 
	ld	c, #0x00
00106$:
;Engine/fade.c:25: switch(i) 
	ld	a, c
	or	a, a
	jr	Z, 00101$
	ld	a, c
	dec	a
	jr	Z, 00102$
	ld	a, c
	sub	a, #0x02
	jr	Z, 00103$
	jr	00104$
;Engine/fade.c:27: case 0U:
00101$:
;Engine/fade.c:29: OBP0_REG = 0x40;  // Dark grey as transparent
	ld	a, #0x40
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:30: OBP1_REG = 0x40;
	ld	a, #0x40
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:31: BGP_REG = 0x40;  // Bkg
	ld	a, #0x40
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:32: break;
	jr	00104$
;Engine/fade.c:33: case 1U:
00102$:
;Engine/fade.c:35: OBP0_REG = 0x81;  // Dark grey as transparent
	ld	a, #0x81
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:36: OBP1_REG = 0x81;
	ld	a, #0x81
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:37: BGP_REG = 0x90;
	ld	a, #0x90
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:38: break;
	jr	00104$
;Engine/fade.c:39: case 2U:
00103$:
;Engine/fade.c:42: OBP0_REG = 0xD2;  // Dark grey as transparent  11010010
	ld	a, #0xd2
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:43: OBP1_REG = 0xD2;
	ld	a, #0xd2
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:44: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:46: }
00104$:
;Engine/fade.c:47: performantdelay(1U);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	call	_performantdelay
	inc	sp
	pop	bc
;Engine/fade.c:23: for (i = 0U; i != 3U; i++) 
	inc	c
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00106$
;Engine/fade.c:49: isFadedOut = 0U;
	ld	hl, #_isFadedOut
	ld	(hl), #0x00
;Engine/fade.c:51: }
	ret
;Engine/fade.c:53: void fadeout() 
;	---------------------------------
; Function fadeout
; ---------------------------------
_fadeout::
;Engine/fade.c:57: for (i = 0U; i != 4U; i++) 
	ld	c, #0x00
00110$:
;Engine/fade.c:59: switch(i) 
	ld	a, c
	or	a, a
	jr	Z, 00101$
	ld	a, c
	dec	a
	jr	Z, 00102$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00103$
	sub	a, #0x03
	jr	Z, 00104$
	jr	00105$
;Engine/fade.c:61: case 0U:
00101$:
;Engine/fade.c:63: OBP0_REG = 0xD2;  // Dark grey as transparent  11010010
	ld	a, #0xd2
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:64: OBP1_REG = 0xD2;
	ld	a, #0xd2
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:65: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:66: break;
	jr	00105$
;Engine/fade.c:67: case 1U:
00102$:
;Engine/fade.c:69: OBP0_REG = 0x81;  // Dark grey as transparent
	ld	a, #0x81
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:70: OBP1_REG = 0x81;
	ld	a, #0x81
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:71: BGP_REG = 0x90;
	ld	a, #0x90
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:72: break;
	jr	00105$
;Engine/fade.c:73: case 2U:
00103$:
;Engine/fade.c:75: OBP0_REG = 0x40;  // Dark grey as transparent
	ld	a, #0x40
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:76: OBP1_REG = 0x40;
	ld	a, #0x40
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:77: BGP_REG = 0x40;
	ld	a, #0x40
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:78: break;
	jr	00105$
;Engine/fade.c:79: case 3U:
00104$:
;Engine/fade.c:80: OBP0_REG = 0x00;
	ld	a, #0x00
	ldh	(_OBP0_REG + 0), a
;Engine/fade.c:81: OBP1_REG = 0x00;
	ld	a, #0x00
	ldh	(_OBP1_REG + 0), a
;Engine/fade.c:82: BGP_REG = 0x00;
	ld	a, #0x00
	ldh	(_BGP_REG + 0), a
;Engine/fade.c:84: }
00105$:
;Engine/fade.c:85: performantdelay(1U);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	call	_performantdelay
	inc	sp
	pop	bc
;Engine/fade.c:57: for (i = 0U; i != 4U; i++) 
	inc	c
	ld	a, c
;Engine/fade.c:89: for (i = 0U; i != 40U; i++)
	sub	a,#0x04
	jr	NZ, 00110$
	ld	c,a
00112$:
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl), #0x00
;Engine/fade.c:89: for (i = 0U; i != 40U; i++)
	inc	c
	ld	a, c
	sub	a, #0x28
	jr	NZ, 00112$
;Engine/fade.c:95: isFadedOut = 1U;
	ld	hl, #_isFadedOut
	ld	(hl), #0x01
;Engine/fade.c:96: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
