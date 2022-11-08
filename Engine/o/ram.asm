;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module ram
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ram_data
	.globl _saveGameData
	.globl _loadGameData
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA_0
_ram_data::
	.ds 16
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
	.area _CODE
;Engine/ram.c:9: void saveGameData()
;	---------------------------------
; Function saveGameData
; ---------------------------------
_saveGameData::
;Engine/ram.c:11: }
	ret
;Engine/ram.c:12: void loadGameData()
;	---------------------------------
; Function loadGameData
; ---------------------------------
_loadGameData::
;Engine/ram.c:14: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)