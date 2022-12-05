;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyMP5StageTiles
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyMP5StageTiles
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
_bownlyMP5StageTiles:
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x2a	; 42
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0x48	; 72	'H'
	.db #0x60	; 96
	.db #0x4d	; 77	'M'
	.db #0x60	; 96
	.db #0x4a	; 74	'J'
	.db #0x60	; 96
	.db #0x48	; 72	'H'
	.db #0x70	; 112	'p'
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0xaa	; 170
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0xb9	; 185
	.db #0x03	; 3
	.db #0xa9	; 169
	.db #0x03	; 3
	.db #0xb9	; 185
	.db #0x03	; 3
	.db #0xa1	; 161
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0xe0	; 224
	.db #0xe7	; 231
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x07	; 7
	.db #0xe6	; 230
	.db #0x1e	; 30
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x07	; 7
	.db #0xe7	; 231
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0xe0	; 224
	.db #0x67	; 103	'g'
	.db #0x78	; 120	'x'
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0xe0	; 224
	.db #0xe7	; 231
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x07	; 7
	.db #0xe6	; 230
	.db #0x1e	; 30
	.db #0x1a	; 26
	.db #0xf8	; 248
	.db #0xea	; 234
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x07	; 7
	.db #0xe7	; 231
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x67	; 103	'g'
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0xe0	; 224
	.db #0xe7	; 231
	.db #0x78	; 120	'x'
	.db #0xb8	; 184
	.db #0x1f	; 31
	.db #0xaf	; 175
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
