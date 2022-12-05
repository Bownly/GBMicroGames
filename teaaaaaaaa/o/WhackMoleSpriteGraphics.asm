;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module WhackMoleSpriteGraphics
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _WMSpriteGraphics
	.globl ___bank_WMSpriteGraphics
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
	.area _CODE_8
	.area _CODE_8
___bank_WMSpriteGraphics	=	0x0008
_WMSpriteGraphics:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x6c	; 108	'l'
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x16	; 22
	.db #0x1f	; 31
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x1f	; 31
	.db #0x16	; 22
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0xf2	; 242
	.db #0xf3	; 243
	.db #0xf2	; 242
	.db #0xb3	; 179
	.db #0xfa	; 250
	.db #0x8b	; 139
	.db #0xfb	; 251
	.db #0xcb	; 203
	.db #0x3b	; 59
	.db #0x3b	; 59
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x50	; 80	'P'
	.db #0xf0	; 240
	.db #0x50	; 80	'P'
	.db #0xf0	; 240
	.db #0x50	; 80	'P'
	.db #0xf0	; 240
	.db #0x50	; 80	'P'
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x16	; 22
	.db #0x1f	; 31
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0xfc	; 252
	.db #0x1f	; 31
	.db #0x16	; 22
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x14	; 20
	.db #0x17	; 23
	.db #0xf4	; 244
	.db #0xf7	; 247
	.db #0xf9	; 249
	.db #0xbf	; 191
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0xcf	; 207
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xfe	; 254
	.db #0x1a	; 26
	.db #0x16	; 22
	.db #0xf6	; 246
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xc8	; 200
	.db #0xf8	; 248
	.db #0x4e	; 78	'N'
	.db #0x7e	; 126
	.db #0x2e	; 46
	.db #0x3e	; 62
	.db #0xbe	; 190
	.db #0xbe	; 190
	.db #0x98	; 152
	.db #0x98	; 152
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x6f	; 111	'o'
	.db #0x7f	; 127
	.db #0x7b	; 123
	.db #0x7a	; 122	'z'
	.db #0x82	; 130
	.db #0x83	; 131
	.db #0x0d	; 13
	.db #0x0d	; 13
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x83	; 131
	.db #0x82	; 130
	.db #0x63	; 99	'c'
	.db #0x62	; 98	'b'
	.db #0x53	; 83	'S'
	.db #0x72	; 114	'r'
	.db #0x7d	; 125
	.db #0x4d	; 77	'M'
	.db #0x33	; 51	'3'
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xd8	; 216
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0xd8	; 216
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x54	; 84	'T'
	.db #0xf4	; 244
	.db #0x53	; 83	'S'
	.db #0xf3	; 243
	.db #0x51	; 81	'Q'
	.db #0xf1	; 241
	.db #0x53	; 83	'S'
	.db #0xf2	; 242
	.db #0xfb	; 251
	.db #0xfa	; 250
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x9c	; 156
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0x9c	; 156
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x0a	; 10
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xfe	; 254
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x68	; 104	'h'
	.db #0xf8	; 248
	.db #0x68	; 104	'h'
	.db #0xf8	; 248
	.db #0x68	; 104	'h'
	.db #0xf8	; 248
	.db #0x68	; 104	'h'
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x17	; 23
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0xd2	; 210
	.db #0xde	; 222
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x74	; 116	't'
	.db #0xec	; 236
	.db #0x17	; 23
	.db #0x1e	; 30
	.db #0x17	; 23
	.db #0x1e	; 30
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x46	; 70	'F'
	.db #0x7f	; 127
	.db #0x49	; 73	'I'
	.db #0x7f	; 127
	.db #0x76	; 118	'v'
	.db #0xee	; 238
	.db #0x72	; 114	'r'
	.db #0xee	; 238
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x22	; 34
	.db #0xfe	; 254
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0x77	; 119	'w'
	.db #0x7f	; 127
	.db #0xd2	; 210
	.db #0xfe	; 254
	.db #0xd2	; 210
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xe6	; 230
	.db #0xfe	; 254
	.db #0xd4	; 212
	.db #0xfc	; 252
	.db #0xd4	; 212
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x16	; 22
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x8c	; 140
	.db #0x8c	; 140
	.db #0xd2	; 210
	.db #0xde	; 222
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x36	; 54	'6'
	.db #0xfe	; 254
	.db #0x42	; 66	'B'
	.db #0xfe	; 254
	.area _INITIALIZER
	.area _CABS (ABS)
