;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module microgameManagerState
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _microgameManagerGameLoop
	.globl _microgameManagerStateMain
	.globl _templateFaceMicrogameMain
	.globl _stopSong
	.globl _playSong
	.globl _fadeout
	.globl _fadein
	.globl _printLine
	.globl _drawPopupWindow
	.globl _getRandUint8
	.globl _init_bkg
	.globl _set_win_tile_xy
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _joypad
	.globl _lobbyDurationInstructions
	.globl _lobbyDurationStats
	.globl _transitionTimer
	.globl _mgTimerTickSpeed
	.globl _mgTimeRemaining
	.globl _currentScore
	.globl _currentLives
	.globl _phaseInitMicrogameManager
	.globl _phaseMicrogameManagerInitLobby
	.globl _phaseMicrogameManagerLobbyLoop
	.globl _callMicrogameFunction
	.globl _loadNewMG
	.globl _startMG
	.globl _drawTimer
	.globl _updateTimer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_currentLives::
	.ds 1
_currentScore::
	.ds 1
_mgTimeRemaining::
	.ds 2
_mgTimerTickSpeed::
	.ds 1
_transitionTimer::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_lobbyDurationStats::
	.ds 1
_lobbyDurationInstructions::
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
	.area _CODE_0
;Engine/states/microgameManagerState.c:71: void microgameManagerStateMain()
;	---------------------------------
; Function microgameManagerStateMain
; ---------------------------------
_microgameManagerStateMain::
;Engine/states/microgameManagerState.c:73: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;Engine/states/microgameManagerState.c:75: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00103$
	ld	a, (#_substate)
	sub	a, #0x02
	jr	Z, 00102$
	jr	00104$
;Engine/states/microgameManagerState.c:77: case SUB_INIT:
00101$:
;Engine/states/microgameManagerState.c:78: phaseInitMicrogameManager();
	call	_phaseInitMicrogameManager
;Engine/states/microgameManagerState.c:79: break;
	jr	00105$
;Engine/states/microgameManagerState.c:80: case MGM_INIT_LOBBY:
00102$:
;Engine/states/microgameManagerState.c:81: phaseMicrogameManagerInitLobby();
	call	_phaseMicrogameManagerInitLobby
;Engine/states/microgameManagerState.c:82: case SUB_LOOP:
00103$:
;Engine/states/microgameManagerState.c:83: phaseMicrogameManagerLobbyLoop();
	call	_phaseMicrogameManagerLobbyLoop
;Engine/states/microgameManagerState.c:84: break;
	jr	00105$
;Engine/states/microgameManagerState.c:85: default:  // Abort to title in the event of unexpected state
00104$:
;Engine/states/microgameManagerState.c:86: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:87: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:89: }
00105$:
;Engine/states/microgameManagerState.c:90: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;Engine/states/microgameManagerState.c:91: }
	ret
;Engine/states/microgameManagerState.c:93: void microgameManagerGameLoop()
;	---------------------------------
; Function microgameManagerGameLoop
; ---------------------------------
_microgameManagerGameLoop::
;Engine/states/microgameManagerState.c:95: updateTimer();
	call	_updateTimer
;Engine/states/microgameManagerState.c:96: if (mgTimeRemaining <= mgTimerTickSpeed)
	ld	hl, #_mgTimerTickSpeed
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_mgTimeRemaining
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	C,_callMicrogameFunction
;Engine/states/microgameManagerState.c:98: if (mgStatus != WON)
	ld	a, (#_mgStatus)
	sub	a, #0x02
	jr	Z, 00102$
;Engine/states/microgameManagerState.c:99: mgStatus = LOST;
	ld	hl, #_mgStatus
	ld	(hl), #0x03
00102$:
;Engine/states/microgameManagerState.c:101: if (mgStatus == LOST)
	ld	a, (#_mgStatus)
	sub	a, #0x03
	jr	NZ, 00104$
;Engine/states/microgameManagerState.c:103: --currentLives;
	ld	hl, #_currentLives
	dec	(hl)
00104$:
;Engine/states/microgameManagerState.c:106: if (currentLives == 0U)
	ld	a, (#_currentLives)
	or	a, a
	jr	NZ, 00106$
;Engine/states/microgameManagerState.c:108: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:109: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
	ret
00106$:
;Engine/states/microgameManagerState.c:113: ++currentScore;
	ld	hl, #_currentScore
	inc	(hl)
;Engine/states/microgameManagerState.c:114: gamestate = STATE_MICROGAME_MANAGER;
	ld	hl, #_gamestate
	ld	(hl), #0x02
;Engine/states/microgameManagerState.c:115: substate = MGM_INIT_LOBBY;
	ld	hl, #_substate
	ld	(hl), #0x02
;Engine/states/microgameManagerState.c:116: fadeout();
	call	_fadeout
;Engine/states/microgameManagerState.c:119: mgDifficulty = currentScore % 3U;
	ld	hl, #_currentScore
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #0x0003
	push	de
	push	bc
	call	__moduint
	add	sp, #4
	pop	bc
	ld	hl, #_mgDifficulty
	ld	(hl), e
;Engine/states/microgameManagerState.c:121: mgSpeed = (currentScore / 3U) % 3U;
	ld	de, #0x0003
	push	de
	push	bc
	call	__divuint
	add	sp, #4
	ld	bc, #0x0003
	push	bc
	push	de
	call	__moduint
	add	sp, #4
	ld	hl, #_mgSpeed
	ld	(hl), e
;Engine/states/microgameManagerState.c:123: loadNewMG(getRandUint8(5U));
	ld	a, #0x05
	push	af
	inc	sp
	call	_getRandUint8
	inc	sp
	ld	a, e
	push	af
	inc	sp
	call	_loadNewMG
	inc	sp
;Engine/states/microgameManagerState.c:129: callMicrogameFunction();
	ret
;Engine/states/microgameManagerState.c:130: }
	ret
;Engine/states/microgameManagerState.c:134: void phaseInitMicrogameManager()
;	---------------------------------
; Function phaseInitMicrogameManager
; ---------------------------------
_phaseInitMicrogameManager::
;Engine/states/microgameManagerState.c:137: currentLives = 4U;
	ld	hl, #_currentLives
	ld	(hl), #0x04
;Engine/states/microgameManagerState.c:138: currentScore = 0U;
	ld	hl, #_currentScore
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:139: mgDifficulty = 0U;
	ld	hl, #_mgDifficulty
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:140: mgSpeed = 0U;
	ld	hl, #_mgSpeed
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:142: loadNewMG(MG_BOWNLY_BOW);  // Edit this line with your MG's enum for testing purposes
	ld	a, #0x01
	push	af
	inc	sp
	call	_loadNewMG
	inc	sp
;Engine/states/microgameManagerState.c:144: substate = MGM_INIT_LOBBY;
	ld	hl, #_substate
	ld	(hl), #0x02
;Engine/states/microgameManagerState.c:145: }
	ret
;Engine/states/microgameManagerState.c:147: void phaseMicrogameManagerInitLobby()
;	---------------------------------
; Function phaseMicrogameManagerInitLobby
; ---------------------------------
_phaseMicrogameManagerInitLobby::
;Engine/states/microgameManagerState.c:149: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Engine/states/microgameManagerState.c:152: stopSong();
	call	_stopSong
;Engine/states/microgameManagerState.c:153: SWITCH_ROM(1U);
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #0x2000
	ld	(hl), #0x01
;Engine/states/microgameManagerState.c:154: switch (mgStatus)
	ld	a, (#_mgStatus)
	sub	a, #0x02
	jr	Z, 00102$
	ld	a, (#_mgStatus)
	sub	a, #0x03
	jr	Z, 00103$
;Engine/states/microgameManagerState.c:157: break;
	jr	00104$
;Engine/states/microgameManagerState.c:158: case WON:
00102$:
;Engine/states/microgameManagerState.c:159: printLine(6U, 4U, "NICE ONE!", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_0
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	ld	a, #0x06
	push	af
	inc	sp
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:160: playSong(&wonJingle);
	ld	de, #_wonJingle
	push	de
	call	_playSong
	pop	hl
;Engine/states/microgameManagerState.c:161: break;
	jr	00104$
;Engine/states/microgameManagerState.c:162: case LOST:
00103$:
;Engine/states/microgameManagerState.c:163: printLine(6U, 4U, "BUMMER!", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_1
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	ld	a, #0x06
	push	af
	inc	sp
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:164: playSong(&lostJingle);
	ld	de, #_lostJingle
	push	de
	call	_playSong
	pop	hl
;Engine/states/microgameManagerState.c:166: }
00104$:
;Engine/states/microgameManagerState.c:169: animTick = 0U;
	ld	hl, #_animTick
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:170: mgStatus = PLAYING;
	ld	hl, #_mgStatus
	ld	(hl), #0x01
;Engine/states/microgameManagerState.c:171: mgTimeRemaining = 2560U;  // 2560 = 160px * 16
	ld	hl, #_mgTimeRemaining
	ld	(hl), #0x00
	inc	hl
	ld	(hl), #0x0a
;Engine/states/microgameManagerState.c:172: mgTimerTickSpeed = mgTimeRemaining / mgCurrentMG.duration / (60U - mgSpeed * 9U);
	ld	a, (#(_mgCurrentMG + 2) + 0)
	ld	b, #0x00
	ld	c, a
	push	bc
	ld	de, #0x0a00
	push	de
	call	__divuint
	add	sp, #4
	ld	c, e
	ld	b, d
	ld	hl, #_mgSpeed
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	a, #0x3c
	sub	a, l
	ld	e, a
	sbc	a, a
	sub	a, h
	ld	d, a
	push	de
	push	bc
	call	__divuint
	add	sp, #4
	ld	hl, #_mgTimerTickSpeed
	ld	(hl), e
;Engine/states/microgameManagerState.c:174: lobbyDurationStats = 100U - mgSpeed * 9U;
	ld	a, (#_mgSpeed)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	ld	a, #0x64
	sub	a, c
	ld	(#_lobbyDurationStats),a
;Engine/states/microgameManagerState.c:175: lobbyDurationInstructions = 95U - mgSpeed * 9U;
	ld	a, #0x5f
	sub	a, c
	ld	(#_lobbyDurationInstructions),a
;Engine/states/microgameManagerState.c:177: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;Engine/states/microgameManagerState.c:180: set_bkg_data(0U, 46U, fontTiles);
	ld	de, #_fontTiles
	push	de
	ld	hl, #0x2e00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Engine/states/microgameManagerState.c:181: set_bkg_data(0xF0U, 8U, borderTiles);
	ld	de, #_borderTiles
	push	de
	ld	hl, #0x8f0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Engine/states/microgameManagerState.c:182: set_bkg_data(0xFCU, 3U, timerTiles);
	ld	de, #_timerTiles
	push	de
	ld	hl, #0x3fc
	push	hl
	call	_set_bkg_data
	add	sp, #4
;Engine/states/microgameManagerState.c:185: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;Engine/states/microgameManagerState.c:188: printLine(6U, 7U, "SCORE:", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_2
	push	de
	ld	hl, #0x706
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:189: printLine(6U, 8U, "LIVES:", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_3
	push	de
	ld	hl, #0x806
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:190: printLine(6U, 9U, "SPEED:", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_4
	push	de
	ld	hl, #0x906
	push	hl
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:191: printLine(1U, 10U, "DIFFICULTY:", FALSE);
	xor	a, a
	push	af
	inc	sp
	ld	de, #___str_5
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, #0x01
	push	af
	inc	sp
	call	_printLine
	add	sp, #5
;Engine/states/microgameManagerState.c:193: fadein();
;Engine/states/microgameManagerState.c:194: }
	jp	_fadein
___str_0:
	.ascii "NICE ONE!"
	.db 0x00
___str_1:
	.ascii "BUMMER!"
	.db 0x00
___str_2:
	.ascii "SCORE:"
	.db 0x00
___str_3:
	.ascii "LIVES:"
	.db 0x00
___str_4:
	.ascii "SPEED:"
	.db 0x00
___str_5:
	.ascii "DIFFICULTY:"
	.db 0x00
;Engine/states/microgameManagerState.c:196: void phaseMicrogameManagerLobbyLoop()
;	---------------------------------
; Function phaseMicrogameManagerLobbyLoop
; ---------------------------------
_phaseMicrogameManagerLobbyLoop::
;Engine/states/microgameManagerState.c:198: ++animTick;
	ld	hl, #_animTick
	inc	(hl)
;Engine/states/microgameManagerState.c:201: if (animTick < lobbyDurationStats)
	ld	a, (hl)
	ld	hl, #_lobbyDurationStats
	sub	a, (hl)
	jp	NC, 00110$
;Engine/states/microgameManagerState.c:203: set_bkg_tile_xy(12U, 7U, currentScore/100U);
	ld	hl, #_currentScore
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x0064
	push	de
	push	bc
	call	__divuint
	add	sp, #4
	ld	h, e
	ld	l, #0x07
	push	hl
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:204: set_bkg_tile_xy(13U, 7U, (currentScore/10U)%10U);
	ld	hl, #_currentScore
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x000a
	push	de
	push	bc
	call	__divuint
	add	sp, #4
	ld	bc, #0x000a
	push	bc
	push	de
	call	__moduint
	add	sp, #4
	ld	h, e
	ld	l, #0x07
	push	hl
	ld	a, #0x0d
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:205: set_bkg_tile_xy(14U, 7U, currentScore%10U);
	ld	hl, #_currentScore
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x000a
	push	de
	push	bc
	call	__moduint
	add	sp, #4
	ld	h, e
	ld	l, #0x07
	push	hl
	ld	a, #0x0e
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:207: set_bkg_tile_xy(12U, 8U, currentLives);
	ld	a, (#_currentLives)
	ld	h, a
	ld	l, #0x08
	push	hl
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:208: set_bkg_tile_xy(12U, 8U, currentLives);
	ld	a, (#_currentLives)
	ld	h, a
	ld	l, #0x08
	push	hl
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:210: set_bkg_tile_xy(12U, 9U, mgSpeed);
	ld	a, (#_mgSpeed)
	ld	h, a
	ld	l, #0x09
	push	hl
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:211: set_bkg_tile_xy(12U, 10U, mgDifficulty);
	ld	a, (#_mgDifficulty)
	ld	h, a
	ld	l, #0x0a
	push	hl
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
	ret
00110$:
;Engine/states/microgameManagerState.c:214: else if (animTick == lobbyDurationStats)
	ld	a, (#_animTick)
	ld	hl, #_lobbyDurationStats
	sub	a, (hl)
	jr	NZ, 00107$
;Engine/states/microgameManagerState.c:216: stopSong();
	call	_stopSong
;Engine/states/microgameManagerState.c:217: playSong(&premgJingle);
	ld	de, #_premgJingle
	push	de
	call	_playSong
	pop	hl
;Engine/states/microgameManagerState.c:220: init_bkg(0xFFU);
	ld	a, #0xff
	push	af
	inc	sp
	call	_init_bkg
	inc	sp
;Engine/states/microgameManagerState.c:223: k = 0U;
	ld	hl, #_k
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:224: while (mgCurrentMG.instructionsPtr[k] != 0U)
00101$:
	ld	hl, #(_mgCurrentMG + 7)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	ld	hl, #_k
	add	a, (hl)
	ld	c, a
	jr	NC, 00141$
	inc	b
00141$:
	ld	a, (bc)
;Engine/states/microgameManagerState.c:225: ++k;
	ld	b, (hl)
	inc	b
;Engine/states/microgameManagerState.c:224: while (mgCurrentMG.instructionsPtr[k] != 0U)
	or	a, a
	jr	Z, 00103$
;Engine/states/microgameManagerState.c:225: ++k;
	ld	(hl), b
	jr	00101$
00103$:
;Engine/states/microgameManagerState.c:226: l = (20U - k) >> 1U;
	ld	hl, #_k
	ld	e, (hl)
	ld	d, #0x00
	ld	a, #0x14
	sub	a, e
	ld	e, a
	sbc	a, a
	sub	a, d
	ld	d, a
	srl	d
	rr	e
	ld	hl, #_l
	ld	(hl), e
;Engine/states/microgameManagerState.c:227: drawPopupWindow(l-1U, 7U, k+1U, 2U);
	ld	a, (hl)
	dec	a
	ld	h, #0x02
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	bc
	inc	sp
	ld	h, #0x07
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_drawPopupWindow
	add	sp, #4
;Engine/states/microgameManagerState.c:228: printLine(l, 8U, mgCurrentMG.instructionsPtr, FALSE);
	ld	hl, #(_mgCurrentMG + 7)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	push	af
	inc	sp
	push	bc
	ld	a, #0x08
	push	af
	inc	sp
	ld	a, (#_l)
	push	af
	inc	sp
	call	_printLine
	add	sp, #5
	ret
00107$:
;Engine/states/microgameManagerState.c:230: else if (animTick == (lobbyDurationStats + lobbyDurationInstructions))
	ld	hl, #_lobbyDurationStats
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_lobbyDurationInstructions
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_animTick
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	ret	NZ
	ld	a, d
	sub	a, b
	jp	Z,_startMG
;Engine/states/microgameManagerState.c:232: startMG();
	ret
;Engine/states/microgameManagerState.c:235: }
	ret
;Engine/states/microgameManagerState.c:242: void callMicrogameFunction()
;	---------------------------------
; Function callMicrogameFunction
; ---------------------------------
_callMicrogameFunction::
;Engine/states/microgameManagerState.c:244: SWITCH_ROM(mgCurrentMG.bankId);
	ld	a, (#(_mgCurrentMG + 1) + 0)
	ldh	(__current_bank + 0), a
	ld	(#0x2000),a
;Engine/states/microgameManagerState.c:245: switch (mgCurrentMG.id)
	ld	hl, #_mgCurrentMG
	ld	c, (hl)
	ld	a, #0x04
	sub	a, c
	jr	C, 00106$
	ld	b, #0x00
	ld	hl, #00115$
	add	hl, bc
	add	hl, bc
	add	hl, bc
	jp	(hl)
00115$:
	jp	_templateFaceMicrogameMain
	jp	_bownlyBowMicrogameMain
	jp	_bownlyMP5MicrogameMain
	jp	_bownlyPastelMicrogameMain
;Engine/states/../database/microgameList.h:16: MICROGAME(MG_TEMPLATE_FACE, templateFaceMicrogameMain, 1U, 3U, "TEMPLATE FACE GAME", "TEMPLATE DEV", "MAKE HAPPY!")
;Engine/states/../database/microgameList.h:17: MICROGAME(MG_BOWNLY_BOW, bownlyBowMicrogameMain, 2U, 4U, "BOW", "BOWNLY", "SHOOT")
;Engine/states/../database/microgameList.h:18: MICROGAME(MG_BOWNLY_MAGIPANELS5, bownlyMP5MicrogameMain, 2U, 4U, "MAGIPANELS 5", "BOWNLY", "INCREASE TO 5")
;Engine/states/../database/microgameList.h:19: MICROGAME(MG_BOWNLY_PASTEL, bownlyPastelMicrogameMain, 2U, 4U, "PASTEL", "BOWNLY", "COLLECT HEARTS!")
;Engine/states/../database/microgameList.h:20: MICROGAME(MG_TEAAA_WHACKMOLES,whackMolesMicrogameMain, 8U, 3U, "WHACK THE MOLES", "TEAAA", "HAMMER!")
	jp	_whackMolesMicrogameMain
;Engine/states/microgameManagerState.c:254: default:
00106$:
;Engine/states/microgameManagerState.c:255: SWITCH_ROM(1U);
	ld	a, #0x01
	ldh	(__current_bank + 0), a
	ld	hl, #0x2000
	ld	(hl), #0x01
;Engine/states/microgameManagerState.c:256: templateFaceMicrogameMain();
;Engine/states/microgameManagerState.c:258: }
;Engine/states/microgameManagerState.c:259: }
	jp	_templateFaceMicrogameMain
;Engine/states/microgameManagerState.c:261: void loadNewMG(MICROGAME newMicrogame)
;	---------------------------------
; Function loadNewMG
; ---------------------------------
_loadNewMG::
	dec	sp
	dec	sp
;Engine/states/microgameManagerState.c:263: mgCurrentMG.id = newMicrogame;
	ld	de, #_mgCurrentMG
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
;Engine/states/microgameManagerState.c:264: mgCurrentMG.bankId = microgameDex[newMicrogame].bankId;
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc,#_microgameDex
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	ld	(#(_mgCurrentMG + 1)),a
;Engine/states/microgameManagerState.c:265: mgCurrentMG.namePtr = microgameDex[newMicrogame].namePtr;
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #(_mgCurrentMG + 3)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;Engine/states/microgameManagerState.c:266: mgCurrentMG.bylinePtr = microgameDex[newMicrogame].bylinePtr;
	ld	hl, #0x0005
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #(_mgCurrentMG + 5)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;Engine/states/microgameManagerState.c:267: mgCurrentMG.instructionsPtr = microgameDex[newMicrogame].instructionsPtr;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	de, #(_mgCurrentMG + 7)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;Engine/states/microgameManagerState.c:268: mgCurrentMG.duration = microgameDex[newMicrogame].duration;
	ld	de, #_mgCurrentMG + 2
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	(de), a
;Engine/states/microgameManagerState.c:269: }
	inc	sp
	inc	sp
	ret
;Engine/states/microgameManagerState.c:271: void startMG()
;	---------------------------------
; Function startMG
; ---------------------------------
_startMG::
;Engine/states/microgameManagerState.c:273: fadeout();
	call	_fadeout
;Engine/states/microgameManagerState.c:274: stopSong();
	call	_stopSong
;Engine/states/microgameManagerState.c:275: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;Engine/states/microgameManagerState.c:276: drawTimer();
	call	_drawTimer
;Engine/states/microgameManagerState.c:277: transitionTimer = 0U;
	ld	hl, #_transitionTimer
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:278: gamestate = STATE_MICROGAME;
	ld	hl, #_gamestate
	ld	(hl), #0x03
;Engine/states/microgameManagerState.c:279: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;Engine/states/microgameManagerState.c:280: mgStatus = PLAYING;
	ld	hl, #_mgStatus
	ld	(hl), #0x01
;Engine/states/microgameManagerState.c:281: }
	ret
;Engine/states/microgameManagerState.c:285: void drawTimer()
;	---------------------------------
; Function drawTimer
; ---------------------------------
_drawTimer::
;Engine/states/microgameManagerState.c:287: set_win_tile_xy(0U, 0U, 0xFCU);  // Left end
	ld	a, #0xfc
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_win_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:288: for (i = 1U; i != 21U; ++i)
	ld	hl, #_i
	ld	(hl), #0x01
00105$:
;Engine/states/microgameManagerState.c:289: set_win_tile_xy(i, 0U, 0xFDU);  // Body
	ld	a, #0xfd
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_i)
	push	af
	inc	sp
	call	_set_win_tile_xy
	add	sp, #3
;Engine/states/microgameManagerState.c:288: for (i = 1U; i != 21U; ++i)
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x15
	jr	NZ, 00105$
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 158)
	ld	(hl), #0xfe
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 156)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	(hl), #0x98
	inc	hl
	ld	(hl), #0xa0
;C:/gbdk/include/gb/gb.h:1316: WX_REG=x, WY_REG=y;
	xor	a, a
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;Engine/states/microgameManagerState.c:292: move_win(0U, 136U);
;Engine/states/microgameManagerState.c:293: }
	ret
;Engine/states/microgameManagerState.c:295: void updateTimer()
;	---------------------------------
; Function updateTimer
; ---------------------------------
_updateTimer::
;Engine/states/microgameManagerState.c:297: mgTimeRemaining -= mgTimerTickSpeed;
	ld	hl, #_mgTimerTickSpeed
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #_mgTimeRemaining
	ld	a, (hl)
	sub	a, c
	ld	(hl+), a
	ld	a, (hl)
	sbc	a, b
;Engine/states/microgameManagerState.c:298: move_win((160U - (mgTimeRemaining >> 4U)), 136U);
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, #0xa0
	sub	a, c
	ldh	(_WX_REG + 0), a
;C:/gbdk/include/gb/gb.h:1316: WX_REG=x, WY_REG=y;
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;Engine/states/microgameManagerState.c:298: move_win((160U - (mgTimeRemaining >> 4U)), 136U);
;Engine/states/microgameManagerState.c:299: }
	ret
	.area _CODE_0
	.area _INITIALIZER
__xinit__lobbyDurationStats:
	.db #0x5a	; 90	'Z'
__xinit__lobbyDurationInstructions:
	.db #0x5a	; 90	'Z'
	.area _CABS (ABS)
