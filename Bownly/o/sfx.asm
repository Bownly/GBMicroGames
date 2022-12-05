;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module sfx
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playUnlockSfx
	.globl _playMoveSfx
	.globl _playHurtSfx
	.globl _playDingSfx
	.globl _playCollisionSfx
	.globl _playBleepSfx
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
;Bownly/sfx.c:4: void playBleepSfx()
;	---------------------------------
; Function playBleepSfx
; ---------------------------------
_playBleepSfx::
;Bownly/sfx.c:6: NR10_REG = 0x34U;
	ld	a, #0x34
	ldh	(_NR10_REG + 0), a
;Bownly/sfx.c:7: NR11_REG = 0x70U;
	ld	a, #0x70
	ldh	(_NR11_REG + 0), a
;Bownly/sfx.c:8: NR12_REG = 0xF0U;
	ld	a, #0xf0
	ldh	(_NR12_REG + 0), a
;Bownly/sfx.c:9: NR13_REG = 0xBAU;
	ld	a, #0xba
	ldh	(_NR13_REG + 0), a
;Bownly/sfx.c:10: NR14_REG = 0xC6U;
	ld	a, #0xc6
	ldh	(_NR14_REG + 0), a
;Bownly/sfx.c:11: }
	ret
;Bownly/sfx.c:13: void playCollisionSfx()
;	---------------------------------
; Function playCollisionSfx
; ---------------------------------
_playCollisionSfx::
;Bownly/sfx.c:15: NR41_REG = 0x1FU;
	ld	a, #0x1f
	ldh	(_NR41_REG + 0), a
;Bownly/sfx.c:16: NR42_REG = 0xF1U;
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;Bownly/sfx.c:17: NR43_REG = 0x40U;
	ld	a, #0x40
	ldh	(_NR43_REG + 0), a
;Bownly/sfx.c:18: NR44_REG = 0x87U;
	ld	a, #0x87
	ldh	(_NR44_REG + 0), a
;Bownly/sfx.c:19: }
	ret
;Bownly/sfx.c:21: void playDingSfx()
;	---------------------------------
; Function playDingSfx
; ---------------------------------
_playDingSfx::
;Bownly/sfx.c:23: NR21_REG = 0x80U;
	ld	a, #0x80
	ldh	(_NR21_REG + 0), a
;Bownly/sfx.c:24: NR22_REG = 0x73U;
	ld	a, #0x73
	ldh	(_NR22_REG + 0), a
;Bownly/sfx.c:25: NR23_REG = 0x9FU;
	ld	a, #0x9f
	ldh	(_NR23_REG + 0), a
;Bownly/sfx.c:26: NR24_REG = 0xC7U;
	ld	a, #0xc7
	ldh	(_NR24_REG + 0), a
;Bownly/sfx.c:27: }
	ret
;Bownly/sfx.c:29: void playHurtSfx()
;	---------------------------------
; Function playHurtSfx
; ---------------------------------
_playHurtSfx::
;Bownly/sfx.c:31: NR41_REG = 0x03U;
	ld	a, #0x03
	ldh	(_NR41_REG + 0), a
;Bownly/sfx.c:32: NR42_REG = 0xF0U;
	ld	a, #0xf0
	ldh	(_NR42_REG + 0), a
;Bownly/sfx.c:33: NR43_REG = 0x5FU;
	ld	a, #0x5f
	ldh	(_NR43_REG + 0), a
;Bownly/sfx.c:34: NR44_REG = 0xC0U;
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;Bownly/sfx.c:35: }
	ret
;Bownly/sfx.c:37: void playMoveSfx()
;	---------------------------------
; Function playMoveSfx
; ---------------------------------
_playMoveSfx::
;Bownly/sfx.c:39: NR41_REG = 0x1FU;
	ld	a, #0x1f
	ldh	(_NR41_REG + 0), a
;Bownly/sfx.c:40: NR42_REG = 0xF1U;
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;Bownly/sfx.c:41: NR43_REG = 0x20U;
	ld	a, #0x20
	ldh	(_NR43_REG + 0), a
;Bownly/sfx.c:42: NR44_REG = 0xC0U;
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;Bownly/sfx.c:43: }
	ret
;Bownly/sfx.c:45: void playUnlockSfx()
;	---------------------------------
; Function playUnlockSfx
; ---------------------------------
_playUnlockSfx::
;Bownly/sfx.c:47: NR10_REG = 0x1EU;
	ld	a, #0x1e
	ldh	(_NR10_REG + 0), a
;Bownly/sfx.c:48: NR11_REG = 0x10U;
	ld	a, #0x10
	ldh	(_NR11_REG + 0), a
;Bownly/sfx.c:49: NR12_REG = 0xF3U;
	ld	a, #0xf3
	ldh	(_NR12_REG + 0), a
;Bownly/sfx.c:50: NR13_REG = 0x00U;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;Bownly/sfx.c:51: NR14_REG = 0x87U;
	ld	a, #0x87
	ldh	(_NR14_REG + 0), a
;Bownly/sfx.c:52: }
	ret
	.area _CODE_2
	.area _INITIALIZER
	.area _CABS (ABS)
