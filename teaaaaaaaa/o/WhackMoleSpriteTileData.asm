;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module WhackMoleSpriteTileData
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___bank_WMMoleFrameData
	.globl _WMMoleTileData
	.globl ___bank_WMMoleTileData
	.globl _WMTileData
	.globl ___bank_WMTileData
	.globl _WMMoleFrameData
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
_WMMoleFrameData::
	.ds 4
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
	.area _CODE_8
	.area _CODE_8
___bank_WMTileData	=	0x0008
_WMTileData:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x02	; 2
	.db #0x10	; 16
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x00	; 0
___bank_WMMoleTileData	=	0x0008
_WMMoleTileData:
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x23	; 35
___bank_WMMoleFrameData	=	0x0008
	.area _INITIALIZER
__xinit__WMMoleFrameData:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
