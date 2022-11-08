;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module titleState
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _titleStateMain
	.globl _fadeout
	.globl _printLine
	.globl _initrand
	.globl _init_bkg
	.globl _set_bkg_tile_xy
	.globl _joypad
	.globl _phaseTitleInit
	.globl _phaseTitleLoop
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
	.area _CODE_1
;Engine/states/titleState.c:38: void titleStateMain()
;	---------------------------------
; Function titleStateMain
; ---------------------------------
_titleStateMain::
;Engine/states/titleState.c:40: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Engine/states/titleState.c:42: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;Engine/states/titleState.c:44: case SUB_INIT:
00101$:
;Engine/states/titleState.c:45: phaseTitleInit();
	call	_phaseTitleInit
;Engine/states/titleState.c:46: break;
	jr	00104$
;Engine/states/titleState.c:47: case SUB_LOOP:
00102$:
;Engine/states/titleState.c:48: phaseTitleLoop();
	call	_phaseTitleLoop
;Engine/states/titleState.c:49: break;
	jr	00104$
;Engine/states/titleState.c:50: default:  // Abort to... uh, itself in the event of unexpected state
00103$:
;Engine/states/titleState.c:51: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Engine/states/titleState.c:52: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Engine/states/titleState.c:54: }
00104$:
;Engine/states/titleState.c:55: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Engine/states/titleState.c:56: }
	ret
;Engine/states/titleState.c:60: void phaseTitleInit()
;	---------------------------------
; Function phaseTitleInit
; ---------------------------------
_phaseTitleInit::
;Engine/states/titleState.c:63: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Engine/states/titleState.c:64: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;C:/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	add	a, #0xfc
	ldh	(_SCX_REG + 0), a
;Engine/states/titleState.c:68: printLine(2U, 3U, "LEGALLY DISTINCT", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_0
	push	de
	ld	hl, #0x302
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/titleState.c:69: printLine(4U, 4U, "TOTALLY NOT", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_1
	push	de
	ld	hl, #0x404
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/titleState.c:70: printLine(5U, 6U, "WARIOWARE", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_2
	push	de
	ld	hl, #0x605
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/titleState.c:71: printLine(1U, 8U, "COMMUNITY EDITION", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_3
	push	de
	ld	hl, #0x801
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/titleState.c:72: printLine(4U, 13U, "PRESS START", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_4
	push	de
	ld	hl, #0xd04
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/titleState.c:74: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Engine/states/titleState.c:76: }
	ret
___str_0:
	.ascii "LEGALLY DISTINCT"
	.db 0x00
___str_1:
	.ascii "TOTALLY NOT"
	.db 0x00
___str_2:
	.ascii "WARIOWARE"
	.db 0x00
___str_3:
	.ascii "COMMUNITY EDITION"
	.db 0x00
___str_4:
	.ascii "PRESS START"
	.db 0x00
;Engine/states/titleState.c:78: void phaseTitleLoop()
;	---------------------------------
; Function phaseTitleLoop
; ---------------------------------
_phaseTitleLoop::
;Engine/states/titleState.c:80: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Engine/states/titleState.c:82: if ((animTick % 64U) / 48U == 0U)
	ld	a, (hl)
	and	a, #0x3f
	ld	b, #0x00
	ld	de, #0x0030
	push	de
	ld	c, a
	push	bc
	call	__divuint
	add	sp, #4
	ld	c, e
	ld	a, d
	or	a, c
	jr	NZ, 00103$
;Engine/states/titleState.c:84: printLine(4U, 13U, "PRESS START", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_5
	push	de
	ld	hl, #0xd04
	push	hl
	call	_printLine
	add	sp, #5
	jr	00104$
00103$:
;Engine/states/titleState.c:88: for (i = 4U; i != 15U; ++i)
	ld	hl, #_i
	ld	(hl), #0x04
00109$:
;Engine/states/titleState.c:89: set_bkg_tile_xy(i, 13U, 0xFFU);
	ld	hl, #0xff0d
	push	hl
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/titleState.c:88: for (i = 4U; i != 15U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x0f
	jr	NZ, 00109$
00104$:
;Engine/states/titleState.c:92: if (curJoypad & J_START && !(prevJoypad & J_START))
	ld	a, (#_curJoypad)
	rlca
	ret	NC
	ld	a, (#_prevJoypad)
	rlca
	ret	C
;Engine/states/titleState.c:94: fadeout();
	call	_fadeout
;Engine/states/titleState.c:95: initrand(DIV_REG);
	ldh	a, (_DIV_REG + 0)
	ld	b, #0x00
	ld	c, a
	push	bc
	call	_initrand
	pop	hl
;C:/gbdk/include/gb/gb.h:1080: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;Engine/states/titleState.c:98: gamestate = STATE_MICROGAME_MANAGER;
	ld	hl, #_gamestate
	ld	(hl), #0x02
;Engine/states/titleState.c:99: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Engine/states/titleState.c:101: }
	ret
___str_5:
	.ascii "PRESS START"
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
