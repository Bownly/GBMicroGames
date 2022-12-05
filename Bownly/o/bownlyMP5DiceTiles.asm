;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module bownlyMP5DiceTiles
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bownlyMP5DiceTiles
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
_bownlyMP5DiceTiles:
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0xc5	; 197
	.db #0xc7	; 199
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0xbc	; 188
	.db #0xa4	; 164
	.db #0xb3	; 179
	.db #0xaf	; 175
	.db #0x90	; 144
	.db #0x9f	; 159
	.db #0x88	; 136
	.db #0x8f	; 143
	.db #0x88	; 136
	.db #0x8f	; 143
	.db #0x98	; 152
	.db #0x97	; 151
	.db #0xb3	; 179
	.db #0xaf	; 175
	.db #0xa4	; 164
	.db #0xbc	; 188
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0xd5	; 213
	.db #0xb7	; 183
	.db #0x95	; 149
	.db #0x77	; 119	'w'
	.db #0x25	; 37
	.db #0xe7	; 231
	.db #0x45	; 69	'E'
	.db #0xc7	; 199
	.db #0x45	; 69	'E'
	.db #0xc7	; 199
	.db #0x25	; 37
	.db #0xe7	; 231
	.db #0x15	; 21
	.db #0xf7	; 247
	.db #0x95	; 149
	.db #0xf7	; 247
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x86	; 134
	.db #0x86	; 134
	.db #0x89	; 137
	.db #0x89	; 137
	.db #0x8a	; 138
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x8b	; 139
	.db #0x8a	; 138
	.db #0x88	; 136
	.db #0x8b	; 139
	.db #0x8a	; 138
	.db #0x9f	; 159
	.db #0x9f	; 159
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x80	; 128
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x65	; 101	'e'
	.db #0x67	; 103	'g'
	.db #0x95	; 149
	.db #0x97	; 151
	.db #0xa5	; 165
	.db #0xa7	; 167
	.db #0xa5	; 165
	.db #0x27	; 39
	.db #0xa5	; 165
	.db #0xa7	; 167
	.db #0xf5	; 245
	.db #0xf7	; 247
	.db #0xe5	; 229
	.db #0xe7	; 231
	.db #0xe5	; 229
	.db #0x07	; 7
	.db #0xe5	; 229
	.db #0xe7	; 231
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xe8	; 232
	.db #0x28	; 40
	.db #0xe4	; 228
	.db #0x24	; 36
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0x22	; 34
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0x12	; 18
	.db #0xf2	; 242
	.db #0x0a	; 10
	.db #0xfa	; 250
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x47	; 71	'G'
	.db #0x7f	; 127
	.db #0x4f	; 79	'O'
	.db #0x78	; 120	'x'
	.db #0x5f	; 95
	.db #0x70	; 112	'p'
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
