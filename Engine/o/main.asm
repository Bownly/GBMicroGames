;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _titleStateMain
	.globl _microgameManagerGameLoop
	.globl _microgameManagerStateMain
	.globl _init_bkg
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _animTick
	.globl _animFrame
	.globl _mgSpeed
	.globl _mgDifficulty
	.globl _gamestate
	.globl _mgCurrentMG
	.globl _mgStatus
	.globl _substate
	.globl _r
	.globl _n
	.globl _m
	.globl _l
	.globl _k
	.globl _j
	.globl _i
	.globl _prevJoypad
	.globl _curJoypad
	.globl _vbl_count
	.globl _data
	.globl _RAM_SIG
	.globl _initRAM
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_data::
	.ds 2
_vbl_count::
	.ds 1
_curJoypad::
	.ds 1
_prevJoypad::
	.ds 1
_i::
	.ds 1
_j::
	.ds 1
_k::
	.ds 1
_l::
	.ds 1
_m::
	.ds 1
_n::
	.ds 1
_r::
	.ds 1
_substate::
	.ds 1
_mgStatus::
	.ds 1
_mgCurrentMG::
	.ds 9
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_gamestate::
	.ds 1
_mgDifficulty::
	.ds 1
_mgSpeed::
	.ds 1
_animFrame::
	.ds 1
_animTick::
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
	.area _CODE
;main.c:44: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:46: initRAM(0U);
	xor	a, a
	push	af
	inc	sp
	call	_initRAM
	inc	sp
;main.c:49: NR52_REG = 0x80; // is 1000 0000 in binary and turns on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:50: NR50_REG = 0x77; // sets the volume for both left and right channel just set to max 0x77
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:51: NR51_REG = 0xFF; // is 1111 1111 in binary, select which chanels we want to use in this case all of them. One bit for the L one bit for the R of all four channels
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:52: set_interrupts(TIM_IFLAG | VBL_IFLAG);
	ld	a, #0x05
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;main.c:54: set_bkg_data(0xF0U, 8U, borderTiles);
	ld	de, #_borderTiles
	push	de
	ld	hl, #0x8f0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:55: set_bkg_data(0U, 46U, fontTiles);
	ld	de, #_fontTiles
	push	de
	ld	hl, #0x2e00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:57: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;main.c:58: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:59: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:60: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:61: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;C:/gbdk/include/gb/gb.h:1316: WX_REG=x, WY_REG=y;
	ld	a, #0xa0
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;main.c:64: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;main.c:65: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;main.c:67: while(1U)
00107$:
;main.c:69: wait_vbl_done();
	call	_wait_vbl_done
;main.c:71: switch(gamestate)
	ld	a, (#_gamestate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_gamestate)
	dec	a
	jr	Z, 00107$
	ld	a, (#_gamestate)
	sub	a, #0x02
	jr	Z, 00103$
	ld	a, (#_gamestate)
	sub	a, #0x03
	jr	Z, 00104$
	jr	00107$
;main.c:73: case STATE_TITLE:
00101$:
;main.c:74: SWITCH_ROM(1U);
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #0x2000
	ld	(hl), #0x01
;main.c:75: titleStateMain();
	call	_titleStateMain
;main.c:76: break;
	jr	00107$
;main.c:79: case STATE_MICROGAME_MANAGER:
00103$:
;main.c:80: microgameManagerStateMain();
	call	_microgameManagerStateMain
;main.c:81: break;
	jr	00107$
;main.c:82: case STATE_MICROGAME:
00104$:
;main.c:83: microgameManagerGameLoop();
	call	_microgameManagerGameLoop
;main.c:85: }
;main.c:87: }
	jr	00107$
_RAM_SIG:
	.db #0x47	; 71	'G'
	.db #0x42	; 66	'B'
	.db #0x4d	; 77	'M'
	.db #0x47	; 71	'G'
;main.c:90: void initRAM(UBYTE force_clear)
;	---------------------------------
; Function initRAM
; ---------------------------------
_initRAM::
;main.c:94: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;main.c:95: SWITCH_RAM_MBC1(0U);
	ld	h, #0x40
	ld	(hl), #0x00
;main.c:98: initialized = 1U;
	ld	c, #0x01
;main.c:99: for (i = 0U; i != 4U; ++i)
	ld	hl, #_i
	ld	(hl), #0x00
00109$:
;main.c:101: if (ram_data[RAM_SIG_ADDR + i] != RAM_SIG[i])
	ld	hl, #_i
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #_ram_data
	add	hl, de
	ld	b, (hl)
	ld	a, #<(_RAM_SIG)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, #>(_RAM_SIG)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	sub	a, b
	jr	Z, 00110$
;main.c:103: initialized = 0U;
	ld	c, #0x00
;main.c:104: break;
	jr	00103$
00110$:
;main.c:99: for (i = 0U; i != 4U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00109$
00103$:
;main.c:109: if (initialized == 0U || force_clear)
	ld	a, c
	or	a, a
	jr	Z, 00106$
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
00106$:
;main.c:111: for(i = 0U; i != 255U; ++i) {
	ld	hl, #_i
	ld	(hl), #0x00
00111$:
;main.c:112: ram_data[i] = 0U;
	ld	a, #<(_ram_data)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_ram_data)
	adc	a, #0x00
	ld	b, a
	xor	a, a
	ld	(bc), a
;main.c:111: for(i = 0U; i != 255U; ++i) {
	inc	(hl)
	ld	a, (hl)
	inc	a
	jr	NZ, 00111$
;main.c:115: for (i = 0U; i != 7U; ++i) {
	ld	hl, #_i
	ld	(hl), #0x00
00113$:
;main.c:116: ram_data[RAM_SIG_ADDR + i] = RAM_SIG[i];
	ld	hl, #_i
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_ram_data
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, #<(_RAM_SIG)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
	ld	a, #>(_RAM_SIG)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	(bc), a
;main.c:115: for (i = 0U; i != 7U; ++i) {
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x07
	jr	NZ, 00113$
00107$:
;main.c:120: DISABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x00
;main.c:121: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__gamestate:
	.db #0x00	; 0
__xinit__mgDifficulty:
	.db #0x00	; 0
__xinit__mgSpeed:
	.db #0x00	; 0
__xinit__animFrame:
	.db #0x00	; 0
__xinit__animTick:
	.db #0x00	; 0
	.area _CABS (ABS)
