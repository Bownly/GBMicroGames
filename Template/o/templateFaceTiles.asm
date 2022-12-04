;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module templateFaceTiles
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _templateFaceTiles
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
	.area _CODE_1
_templateFaceTiles:
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x87	; 135
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x43	; 67	'C'
	.db #0x43	; 67	'C'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x31	; 49	'1'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xe1	; 225
	.db #0xe1	; 225
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0xc2	; 194
	.db #0xc2	; 194
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x8c	; 140
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0x7f	; 127
	.db #0x44	; 68	'D'
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x31	; 49	'1'
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xfe	; 254
	.db #0x22	; 34
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.area _INITIALIZER
	.area _CABS (ABS)