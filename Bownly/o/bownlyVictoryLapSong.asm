;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyVictoryLapSong
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyVictoryLapSong
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
	.area _CODE_2
	.area _CODE_2
_order_cnt:
	.db #0x02	; 2
_P0:
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x1d	; 29
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x1d	; 29
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x0d	; 13
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x0d	; 13
	.db #0x1c	; 28
	.db #0x01	; 1
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
_P1:
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
_P2:
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x17	; 23
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x17	; 23
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x23	; 35
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x17	; 23
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x17	; 23
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x23	; 35
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x23	; 35
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x19	; 25
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x25	; 37
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0xfc	; 252
	.db #0x01	; 1
_P3:
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
_order1:
	.dw _P0
_order2:
	.dw _P1
_order3:
	.dw _P2
_order4:
	.dw _P3
_duty_instruments:
	.db #0x08	; 8
	.db #0x40	; 64
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0xc0	; 192
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
	.db #0x08	; 8
	.db #0x80	; 128
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x80	; 128
_wave_instruments:
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x01	; 1
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x02	; 2
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x03	; 3
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x04	; 4
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x05	; 5
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x06	; 6
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x01	; 1
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x02	; 2
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x03	; 3
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x04	; 4
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x05	; 5
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x06	; 6
	.dw #0x0000
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x07	; 7
	.dw #0x0000
	.db #0x80	; 128
_noise_instruments:
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.dw #0x0000
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_waves:
	.db #0xa5	; 165
	.db #0xd7	; 215
	.db #0xc9	; 201
	.db #0xe1	; 225
	.db #0xbc	; 188
	.db #0x9a	; 154
	.db #0x76	; 118	'v'
	.db #0x31	; 49	'1'
	.db #0x0c	; 12
	.db #0xba	; 186
	.db #0xde	; 222
	.db #0x60	; 96
	.db #0x1b	; 27
	.db #0xca	; 202
	.db #0x03	; 3
	.db #0x93	; 147
	.db #0xf0	; 240
	.db #0xe1	; 225
	.db #0xd2	; 210
	.db #0xc3	; 195
	.db #0xb4	; 180
	.db #0xa5	; 165
	.db #0x96	; 150
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0x69	; 105	'i'
	.db #0x5a	; 90	'Z'
	.db #0x4b	; 75	'K'
	.db #0x3c	; 60
	.db #0x2d	; 45
	.db #0x1e	; 30
	.db #0x0f	; 15
	.db #0xfd	; 253
	.db #0xec	; 236
	.db #0xdb	; 219
	.db #0xca	; 202
	.db #0xb9	; 185
	.db #0xa8	; 168
	.db #0x97	; 151
	.db #0x86	; 134
	.db #0x79	; 121	'y'
	.db #0x68	; 104	'h'
	.db #0x57	; 87	'W'
	.db #0x46	; 70	'F'
	.db #0x35	; 53	'5'
	.db #0x24	; 36
	.db #0x13	; 19
	.db #0x02	; 2
	.db #0xde	; 222
	.db #0xfe	; 254
	.db #0xdc	; 220
	.db #0xba	; 186
	.db #0x9a	; 154
	.db #0xa9	; 169
	.db #0x87	; 135
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x87	; 135
	.db #0x65	; 101	'e'
	.db #0x56	; 86	'V'
	.db #0x54	; 84	'T'
	.db #0x32	; 50	'2'
	.db #0x10	; 16
	.db #0x12	; 18
	.db #0xab	; 171
	.db #0xcd	; 205
	.db #0xef	; 239
	.db #0xed	; 237
	.db #0xcb	; 203
	.db #0xa0	; 160
	.db #0x12	; 18
	.db #0x3e	; 62
	.db #0xdc	; 220
	.db #0xba	; 186
	.db #0xbc	; 188
	.db #0xde	; 222
	.db #0xfe	; 254
	.db #0xdc	; 220
	.db #0x32	; 50	'2'
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xdd	; 221
	.db #0xcc	; 204
	.db #0xbb	; 187
	.db #0xaa	; 170
	.db #0x99	; 153
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x66	; 102	'f'
	.db #0x55	; 85	'U'
	.db #0x44	; 68	'D'
	.db #0x33	; 51	'3'
	.db #0x22	; 34
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x79	; 121	'y'
	.db #0xbc	; 188
	.db #0xde	; 222
	.db #0xef	; 239
	.db #0xff	; 255
	.db #0xee	; 238
	.db #0xdc	; 220
	.db #0xb9	; 185
	.db #0x75	; 117	'u'
	.db #0x43	; 67	'C'
	.db #0x21	; 33
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x23	; 35
	.db #0x45	; 69	'E'
	.db #0xbb	; 187
	.db #0xe7	; 231
	.db #0x98	; 152
	.db #0xaa	; 170
	.db #0x7d	; 125
	.db #0xd4	; 212
	.db #0xcd	; 205
	.db #0x76	; 118	'v'
	.db #0xad	; 173
	.db #0xe9	; 233
	.db #0x1a	; 26
	.db #0xc0	; 192
	.db #0xd4	; 212
	.db #0x72	; 114	'r'
	.db #0x50	; 80	'P'
	.db #0x59	; 89	'Y'
	.db #0x48	; 72	'H'
	.db #0xca	; 202
	.db #0xdc	; 220
	.db #0xab	; 171
	.db #0x16	; 22
	.db #0x61	; 97	'a'
	.db #0x96	; 150
	.db #0x2c	; 44
	.db #0x50	; 80	'P'
	.db #0xde	; 222
	.db #0xba	; 186
	.db #0x87	; 135
	.db #0x58	; 88	'X'
	.db #0x39	; 57	'9'
	.db #0x28	; 40
	.db #0x32	; 50	'2'
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0xd6	; 214
	.db #0xc1	; 193
	.db #0x6a	; 106	'j'
	.db #0x47	; 71	'G'
	.db #0x14	; 20
	.db #0x93	; 147
	.db #0xec	; 236
	.db #0x0a	; 10
	.db #0xb6	; 182
	.db #0x5e	; 94
	.db #0x79	; 121	'y'
	.db #0xda	; 218
	.db #0x31	; 49	'1'
	.db #0xed	; 237
	.db #0x0e	; 14
	.db #0x80	; 128
	.db #0x54	; 84	'T'
	.db #0x95	; 149
	.db #0x25	; 37
	.db #0xbc	; 188
	.db #0xb3	; 179
	.db #0xeb	; 235
	.db #0x9e	; 158
	.db #0x76	; 118	'v'
	.db #0x6c	; 108	'l'
	.db #0xbc	; 188
	.db #0xb6	; 182
	.db #0x93	; 147
	.db #0x15	; 21
	.db #0x77	; 119	'w'
	.db #0x9d	; 157
	.db #0x20	; 32
	.db #0x79	; 121	'y'
	.db #0x1e	; 30
	.db #0xc8	; 200
	.db #0x10	; 16
	.db #0x6a	; 106	'j'
	.db #0xce	; 206
	.db #0xd8	; 216
	.db #0x0d	; 13
	.db #0xa2	; 162
	.db #0xde	; 222
	.db #0xaa	; 170
	.db #0xd7	; 215
	.db #0xe2	; 226
	.db #0x7a	; 122	'z'
	.db #0xcb	; 203
	.db #0x53	; 83	'S'
	.db #0x99	; 153
	.db #0x35	; 53	'5'
	.db #0xe8	; 232
	.db #0xd3	; 211
	.db #0x62	; 98	'b'
	.db #0x5c	; 92
	.db #0xda	; 218
	.db #0x10	; 16
	.db #0x53	; 83	'S'
	.db #0x69	; 105	'i'
	.db #0x98	; 152
	.db #0x7c	; 124
	.db #0xca	; 202
	.db #0xec	; 236
	.db #0xc9	; 201
	.db #0x93	; 147
	.db #0xc7	; 199
	.db #0x96	; 150
	.db #0xeb	; 235
	.db #0x5e	; 94
	.db #0x32	; 50	'2'
	.db #0xcc	; 204
	.db #0x81	; 129
	.db #0xa5	; 165
	.db #0x33	; 51	'3'
	.db #0x2d	; 45
	.db #0x24	; 36
	.db #0xe0	; 224
	.db #0xe8	; 232
	.db #0x02	; 2
	.db #0x9a	; 154
	.db #0x32	; 50	'2'
	.db #0xd0	; 208
	.db #0xad	; 173
	.db #0x01	; 1
	.db #0xa7	; 167
	.db #0x26	; 38
	.db #0x3a	; 58
	.db #0xe2	; 226
	.db #0x57	; 87	'W'
	.db #0xe7	; 231
	.db #0xd4	; 212
	.db #0xb0	; 176
	.db #0x65	; 101	'e'
	.db #0x0b	; 11
_bownlyVictoryLapSong:
	.db #0x07	; 7
	.dw _order_cnt
	.dw _order1
	.dw _order2
	.dw _order3
	.dw _order4
	.dw _duty_instruments
	.dw _wave_instruments
	.dw _noise_instruments
	.dw #0x0000
	.dw _waves
	.area _INITIALIZER
	.area _CABS (ABS)