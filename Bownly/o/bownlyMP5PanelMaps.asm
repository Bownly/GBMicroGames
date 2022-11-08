;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyMP5PanelMaps
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _panelFlip2Map
	.globl _panelFlip1Map
	.globl _panelPointMap
	.globl _panelXMap
	.globl _panel4Map
	.globl _panel3Map
	.globl _panel2Map
	.globl _panel1Map
	.globl _panel0Map
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
_panel0Map:
	.db #0x50	; 80	'P'
	.db #0x52	; 82	'R'
	.db #0x51	; 81	'Q'
	.db #0x53	; 83	'S'
_panel1Map:
	.db #0x54	; 84	'T'
	.db #0x56	; 86	'V'
	.db #0x55	; 85	'U'
	.db #0x57	; 87	'W'
_panel2Map:
	.db #0x58	; 88	'X'
	.db #0x5a	; 90	'Z'
	.db #0x59	; 89	'Y'
	.db #0x5b	; 91
_panel3Map:
	.db #0x5c	; 92
	.db #0x5e	; 94
	.db #0x5d	; 93
	.db #0x5f	; 95
_panel4Map:
	.db #0x60	; 96
	.db #0x62	; 98	'b'
	.db #0x61	; 97	'a'
	.db #0x63	; 99	'c'
_panelXMap:
	.db #0x64	; 100	'd'
	.db #0x66	; 102	'f'
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
_panelPointMap:
	.db #0x68	; 104	'h'
	.db #0x6a	; 106	'j'
	.db #0x69	; 105	'i'
	.db #0x6b	; 107	'k'
_panelFlip1Map:
	.db #0x6c	; 108	'l'
	.db #0x6e	; 110	'n'
	.db #0x6d	; 109	'm'
	.db #0x6f	; 111	'o'
_panelFlip2Map:
	.db #0x70	; 112	'p'
	.db #0x72	; 114	'r'
	.db #0x71	; 113	'q'
	.db #0x73	; 115	's'
	.area _INITIALIZER
	.area _CABS (ABS)
