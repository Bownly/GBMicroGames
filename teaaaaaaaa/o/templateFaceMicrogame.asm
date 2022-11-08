;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module templateFaceMicrogame
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_whackMolesMicrogameMain
	.globl _whackMolesMicrogameMain
	.globl b_whackMolesLoop
	.globl _whackMolesLoop
	.globl b_WhackMolesUpdateSprite
	.globl _WhackMolesUpdateSprite
	.globl b_whackMolesinitialize
	.globl _whackMolesinitialize
	.globl _playSong
	.globl _fadein
	.globl _set_sprite_data
	.globl _set_bkg_submap
	.globl _set_bkg_data
	.globl _joypad
	.globl _numberOfMoles
	.globl _teaaaStoredSpriteX
	.globl _teaaaSpriteMemory
	.globl _teaaaFrameIndex
	.globl _teaaaStoredFrame
	.globl _teaaaSprite3X
	.globl _teaaaSprite2X
	.globl _teaaaSprite1X
	.globl _teaaaSpriteY
	.globl _teaaaAnimationSpeed
	.globl _teaaaAnimationState
	.globl _teaaaflipSprite
	.globl _teaaaPlayableSpriteY
	.globl _teaaaPlayableSpriteX
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_teaaaPlayableSpriteX::
	.ds 1
_teaaaPlayableSpriteY::
	.ds 1
_teaaaflipSprite::
	.ds 1
_teaaaAnimationState::
	.ds 1
_teaaaAnimationSpeed::
	.ds 1
_teaaaSpriteY::
	.ds 1
_teaaaSprite1X::
	.ds 1
_teaaaSprite2X::
	.ds 1
_teaaaSprite3X::
	.ds 1
_teaaaStoredFrame::
	.ds 1
_teaaaFrameIndex::
	.ds 1
_teaaaSpriteMemory::
	.ds 1
_teaaaStoredSpriteX::
	.ds 1
_numberOfMoles::
	.ds 1
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
;teaaaaaaaa/states/templateFaceMicrogame.c:58: void whackMolesinitialize() BANKED
;	---------------------------------
; Function whackMolesinitialize
; ---------------------------------
	b_whackMolesinitialize	= 8
_whackMolesinitialize::
;teaaaaaaaa/states/templateFaceMicrogame.c:60: set_bkg_data(48,21,WMBGgraphics);
	ld	de, #_WMBGgraphics
	push	de
	ld	hl, #0x1530
	push	hl
	call	_set_bkg_data
	add	sp, #4
;teaaaaaaaa/states/templateFaceMicrogame.c:61: set_bkg_submap(0,0,20,18,whackMolesBG,20);
	ld	a, #0x14
	push	af
	inc	sp
	ld	de, #_whackMolesBGPLN0
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_submap
	add	sp, #7
;teaaaaaaaa/states/templateFaceMicrogame.c:62: numberOfMoles = 3;
	ld	hl, #_numberOfMoles
	ld	(hl), #0x03
;teaaaaaaaa/states/templateFaceMicrogame.c:63: teaaaSpriteY = 88;
	ld	hl, #_teaaaSpriteY
	ld	(hl), #0x58
;teaaaaaaaa/states/templateFaceMicrogame.c:64: WMMoleFrameData[0] = 0;
	ld	hl, #_WMMoleFrameData
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:65: WMMoleFrameData[1] = 0;
	ld	hl, #(_WMMoleFrameData + 1)
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:66: WMMoleFrameData[2] = 0;
	ld	hl, #(_WMMoleFrameData + 2)
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:67: WMMoleFrameData[3] = 0;
	ld	hl, #(_WMMoleFrameData + 3)
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:68: teaaaSprite1X = 20;
	ld	hl, #_teaaaSprite1X
	ld	(hl), #0x14
;teaaaaaaaa/states/templateFaceMicrogame.c:69: teaaaSprite2X = 80;
	ld	hl, #_teaaaSprite2X
	ld	(hl), #0x50
;teaaaaaaaa/states/templateFaceMicrogame.c:70: teaaaSprite3X = 140;
	ld	hl, #_teaaaSprite3X
	ld	(hl), #0x8c
;teaaaaaaaa/states/templateFaceMicrogame.c:71: teaaaAnimationSpeed = 6;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x06
;teaaaaaaaa/states/templateFaceMicrogame.c:72: animFrame = 0;
	ld	hl, #_animFrame
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:73: animTick = 6;
	ld	hl, #_animTick
	ld	(hl), #0x06
;teaaaaaaaa/states/templateFaceMicrogame.c:74: teaaaPlayableSpriteY = 104;
	ld	hl, #_teaaaPlayableSpriteY
	ld	(hl), #0x68
;teaaaaaaaa/states/templateFaceMicrogame.c:75: teaaaPlayableSpriteX = 70;
	ld	hl, #_teaaaPlayableSpriteX
	ld	(hl), #0x46
;teaaaaaaaa/states/templateFaceMicrogame.c:76: teaaaAnimationState = 0;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:77: fadein();
	call	_fadein
;teaaaaaaaa/states/templateFaceMicrogame.c:78: playSong(&whackMolesMusic);
	ld	de, #_whackMolesMusic
	push	de
	call	_playSong
	pop	hl
;teaaaaaaaa/states/templateFaceMicrogame.c:79: set_sprite_data(0,39,WMSpriteGraphics);
	ld	de, #_WMSpriteGraphics
	push	de
	ld	hl, #0x2700
	push	hl
	call	_set_sprite_data
	add	sp, #4
;teaaaaaaaa/states/templateFaceMicrogame.c:80: substate = SUB_LOOP;
	ld	hl, #_substate
	ld	(hl), #0x01
;teaaaaaaaa/states/templateFaceMicrogame.c:81: }
	ret
;teaaaaaaaa/states/templateFaceMicrogame.c:83: void WhackMolesUpdateSprite() BANKED
;	---------------------------------
; Function WhackMolesUpdateSprite
; ---------------------------------
	b_WhackMolesUpdateSprite	= 8
_WhackMolesUpdateSprite::
	add	sp, #-5
;teaaaaaaaa/states/templateFaceMicrogame.c:85: if (teaaaStoredSpriteX > teaaaPlayableSpriteX - 16 & teaaaStoredSpriteX < teaaaPlayableSpriteX + 20)
	ld	hl, #_teaaaPlayableSpriteX
	ld	c, (hl)
	ld	b, #0x00
	ld	de, #0x0010
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_teaaaStoredSpriteX)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#0
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00135$
	bit	7, d
	jr	NZ, 00136$
	cp	a, a
	jr	00136$
00135$:
	bit	7, d
	jr	Z, 00136$
	scf
00136$:
	ld	a, #0x00
	rla
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #0x0014
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00137$
	bit	7, d
	jr	NZ, 00138$
	cp	a, a
	jr	00138$
00137$:
	bit	7, d
	jr	Z, 00138$
	scf
00138$:
	ld	a, #0x00
	rla
	ldhl	sp,	#4
	and	a,(hl)
	jr	Z, 00104$
;teaaaaaaaa/states/templateFaceMicrogame.c:87: if (animFrame == 36 & teaaaStoredFrame == 0)
	ld	a, (#_animFrame)
	sub	a, #0x24
	ld	a, #0x01
	jr	Z, 00140$
	xor	a, a
00140$:
	ld	c, a
	ld	a, (#_teaaaStoredFrame)
	or	a, a
	ld	a, #0x01
	jr	Z, 00142$
	xor	a, a
00142$:
	and	a,c
	jr	Z, 00104$
;teaaaaaaaa/states/templateFaceMicrogame.c:89: teaaaStoredFrame = 6;
	ld	hl, #_teaaaStoredFrame
	ld	(hl), #0x06
;teaaaaaaaa/states/templateFaceMicrogame.c:90: WMMoleFrameData[teaaaFrameIndex] = 6;
	ld	bc, #_WMMoleFrameData+0
	ld	a, c
	ld	hl, #_teaaaFrameIndex
	add	a, (hl)
	ld	c, a
	jr	NC, 00143$
	inc	b
00143$:
	ld	a, #0x06
	ld	(bc), a
;teaaaaaaaa/states/templateFaceMicrogame.c:91: numberOfMoles --;
	ld	hl, #_numberOfMoles
	dec	(hl)
00104$:
;teaaaaaaaa/states/templateFaceMicrogame.c:94: set_sprite_prop(teaaaSpriteMemory,0);
	ld	hl, #_teaaaSpriteMemory
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:95: set_sprite_prop(teaaaSpriteMemory + 1,0);
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:96: set_sprite_prop(teaaaSpriteMemory + 2,0);
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
	inc	e
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:97: set_sprite_prop(teaaaSpriteMemory + 3,0);
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x03
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	l, a
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:98: set_sprite_prop(teaaaSpriteMemory + 4,0);
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x04
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	l, a
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:99: set_sprite_prop(teaaaSpriteMemory + 5,0);
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x05
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	l, a
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:100: set_sprite_tile(teaaaSpriteMemory,WMMoleTileData[teaaaStoredFrame]);
	ld	a, #<(_WMMoleTileData)
	ld	hl, #_teaaaStoredFrame
	add	a, (hl)
	ld	c, a
	ld	a, #>(_WMMoleTileData)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
	ld	hl, #_teaaaSpriteMemory
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:101: set_sprite_tile(teaaaSpriteMemory + 1,WMMoleTileData[teaaaStoredFrame + 1]);
	ld	hl, #_teaaaStoredFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_WMMoleTileData
	add	hl, bc
	ld	c, (hl)
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:102: set_sprite_tile(teaaaSpriteMemory + 2,WMMoleTileData[teaaaStoredFrame + 2]);
	ld	hl, #_teaaaStoredFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	ld	hl, #_WMMoleTileData
	add	hl, bc
	ld	c, (hl)
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
	inc	e
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:103: set_sprite_tile(teaaaSpriteMemory + 3,WMMoleTileData[teaaaStoredFrame + 3]);
	ld	hl, #_teaaaStoredFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #_WMMoleTileData
	add	hl, bc
	ld	c, (hl)
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x03
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:104: set_sprite_tile(teaaaSpriteMemory + 4,WMMoleTileData[teaaaStoredFrame + 4]);
	ld	hl, #_teaaaStoredFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #_WMMoleTileData
	add	hl, bc
	ld	c, (hl)
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x04
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:105: set_sprite_tile(teaaaSpriteMemory + 5,WMMoleTileData[teaaaStoredFrame + 5]);
	ld	hl, #_teaaaStoredFrame
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	de, #_WMMoleTileData
	add	hl, de
	ld	c, (hl)
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x05
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	l, a
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:106: move_sprite(teaaaSpriteMemory,teaaaStoredSpriteX - 8,teaaaSpriteY);
	ld	hl, #_teaaaSpriteY
	ld	b, (hl)
	ld	a, (#_teaaaStoredSpriteX)
	add	a, #0xf8
	ld	c, a
	ld	hl, #_teaaaSpriteMemory
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:107: move_sprite(teaaaSpriteMemory + 1,teaaaStoredSpriteX,teaaaSpriteY);
	ld	hl, #_teaaaSpriteY
	ld	b, (hl)
	ld	hl, #_teaaaStoredSpriteX
	ld	c, (hl)
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:108: move_sprite(teaaaSpriteMemory + 2,teaaaStoredSpriteX - 8,teaaaSpriteY + 8);
	ld	a, (#_teaaaSpriteY)
	add	a, #0x08
	ld	c, a
	ld	a, (#_teaaaStoredSpriteX)
	add	a, #0xf8
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #_teaaaSpriteMemory
	ld	e, (hl)
	inc	e
	inc	e
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;teaaaaaaaa/states/templateFaceMicrogame.c:109: move_sprite(teaaaSpriteMemory + 3,teaaaStoredSpriteX,teaaaSpriteY + 8);
	ld	a, (#_teaaaSpriteY)
	add	a, #0x08
	ld	b, a
	ld	hl, #_teaaaStoredSpriteX
	ld	c, (hl)
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x03
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:110: move_sprite(teaaaSpriteMemory + 4,teaaaStoredSpriteX - 8,teaaaSpriteY + 16);
	ld	a, (#_teaaaSpriteY)
	add	a, #0x10
	ld	b, a
	ld	a, (#_teaaaStoredSpriteX)
	add	a, #0xf8
	ld	c, a
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x04
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:111: move_sprite(teaaaSpriteMemory + 5,teaaaStoredSpriteX,teaaaSpriteY + 16);
	ld	a, (#_teaaaSpriteY)
	add	a, #0x10
	ld	b, a
	ld	hl, #_teaaaStoredSpriteX
	ld	c, (hl)
	ld	a, (#_teaaaSpriteMemory)
	add	a, #0x05
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:111: move_sprite(teaaaSpriteMemory + 5,teaaaStoredSpriteX,teaaaSpriteY + 16);
;teaaaaaaaa/states/templateFaceMicrogame.c:112: }
	add	sp, #5
	ret
;teaaaaaaaa/states/templateFaceMicrogame.c:114: void whackMolesLoop() BANKED
;	---------------------------------
; Function whackMolesLoop
; ---------------------------------
	b_whackMolesLoop	= 8
_whackMolesLoop::
;teaaaaaaaa/states/templateFaceMicrogame.c:116: curJoypad = joypad();
	call	_joypad
	ld	hl, #_curJoypad
	ld	(hl), e
;teaaaaaaaa/states/templateFaceMicrogame.c:117: animTick --;
	ld	hl, #_animTick
	dec	(hl)
;teaaaaaaaa/states/templateFaceMicrogame.c:118: if (curJoypad & J_RIGHT)
	ld	hl, #_curJoypad
	ld	c, (hl)
	bit	0, c
	jr	Z, 00107$
;teaaaaaaaa/states/templateFaceMicrogame.c:120: if (teaaaAnimationState < 1 & teaaaPlayableSpriteX > 1)
	ld	a, (#_teaaaAnimationState)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	b, a
	ld	a, #0x01
	ld	hl, #_teaaaPlayableSpriteX
	sub	a, (hl)
	ld	a, #0x00
	rla
	and	a,b
	jr	Z, 00107$
;teaaaaaaaa/states/templateFaceMicrogame.c:122: if (teaaaflipSprite == S_FLIPX)
	ld	a, (#_teaaaflipSprite)
	sub	a, #0x20
	jr	NZ, 00102$
;teaaaaaaaa/states/templateFaceMicrogame.c:124: teaaaAnimationState = 2;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x02
;teaaaaaaaa/states/templateFaceMicrogame.c:125: animFrame = 45;
	ld	hl, #_animFrame
	ld	(hl), #0x2d
;teaaaaaaaa/states/templateFaceMicrogame.c:126: animTick = 4;
	ld	hl, #_animTick
	ld	(hl), #0x04
;teaaaaaaaa/states/templateFaceMicrogame.c:127: teaaaAnimationSpeed = 4;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x04
	jr	00107$
00102$:
;teaaaaaaaa/states/templateFaceMicrogame.c:131: teaaaPlayableSpriteX += 2;
	ld	hl, #_teaaaPlayableSpriteX
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
;teaaaaaaaa/states/templateFaceMicrogame.c:132: teaaaAnimationSpeed = 6;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x06
00107$:
;teaaaaaaaa/states/templateFaceMicrogame.c:136: if (curJoypad & J_LEFT)
	bit	1, c
	jr	Z, 00114$
;teaaaaaaaa/states/templateFaceMicrogame.c:138: if (teaaaAnimationState < 1 & teaaaPlayableSpriteX < 159)
	ld	a, (#_teaaaAnimationState)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	b, a
	ld	a, (#_teaaaPlayableSpriteX)
	sub	a, #0x9f
	ld	a, #0x00
	rla
	and	a,b
	jr	Z, 00114$
;teaaaaaaaa/states/templateFaceMicrogame.c:140: if (teaaaflipSprite == 0)
	ld	a, (#_teaaaflipSprite)
	or	a, a
	jr	NZ, 00109$
;teaaaaaaaa/states/templateFaceMicrogame.c:142: teaaaAnimationState = 2;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x02
;teaaaaaaaa/states/templateFaceMicrogame.c:143: animFrame = 45;
	ld	hl, #_animFrame
	ld	(hl), #0x2d
;teaaaaaaaa/states/templateFaceMicrogame.c:144: animTick = 4;
	ld	hl, #_animTick
	ld	(hl), #0x04
;teaaaaaaaa/states/templateFaceMicrogame.c:145: teaaaAnimationSpeed = 4;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x04
	jr	00114$
00109$:
;teaaaaaaaa/states/templateFaceMicrogame.c:149: teaaaPlayableSpriteX -= 2;
	ld	hl, #_teaaaPlayableSpriteX
	ld	a, (hl)
	add	a, #0xfe
	ld	(hl), a
;teaaaaaaaa/states/templateFaceMicrogame.c:150: teaaaAnimationSpeed = 6;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x06
00114$:
;teaaaaaaaa/states/templateFaceMicrogame.c:154: if (!(curJoypad & J_RIGHT) & !(curJoypad & J_LEFT) & teaaaAnimationState < 1)
	ld	hl, #_curJoypad
	ld	a, (hl)
	and	a, #0x01
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x01
	sub	a,#0x01
	ld	a, #0x00
	rla
	and	a, e
	ld	b, a
	ld	a, (#_teaaaAnimationState)
	sub	a, #0x01
	ld	a, #0x00
	rla
	and	a,b
	jr	Z, 00116$
;teaaaaaaaa/states/templateFaceMicrogame.c:156: animTick = 6;
	ld	hl, #_animTick
	ld	(hl), #0x06
;teaaaaaaaa/states/templateFaceMicrogame.c:157: animFrame = 0;
	ld	hl, #_animFrame
	ld	(hl), #0x00
00116$:
;teaaaaaaaa/states/templateFaceMicrogame.c:159: if (curJoypad & J_A)
	bit	4, c
	jr	Z, 00120$
;teaaaaaaaa/states/templateFaceMicrogame.c:161: if (!(prevJoypad & J_A))
	ld	a, (#_prevJoypad)
	bit	4, a
	jr	NZ, 00120$
;teaaaaaaaa/states/templateFaceMicrogame.c:163: animTick = 3;
	ld	hl, #_animTick
	ld	(hl), #0x03
;teaaaaaaaa/states/templateFaceMicrogame.c:164: teaaaAnimationSpeed = 3;
	ld	hl, #_teaaaAnimationSpeed
	ld	(hl), #0x03
;teaaaaaaaa/states/templateFaceMicrogame.c:165: animFrame = 18;
	ld	hl, #_animFrame
	ld	(hl), #0x12
;teaaaaaaaa/states/templateFaceMicrogame.c:166: teaaaAnimationState = 1;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x01
00120$:
;teaaaaaaaa/states/templateFaceMicrogame.c:169: if (animTick == 0)
	ld	a, (#_animTick)
	or	a, a
	jr	NZ, 00122$
;teaaaaaaaa/states/templateFaceMicrogame.c:171: animTick = teaaaAnimationSpeed;
	ld	a, (#_teaaaAnimationSpeed)
	ld	(#_animTick),a
;teaaaaaaaa/states/templateFaceMicrogame.c:172: animFrame += 9;
	ld	hl, #_animFrame
	ld	a, (hl)
	add	a, #0x09
	ld	(hl), a
00122$:
;teaaaaaaaa/states/templateFaceMicrogame.c:174: if (animFrame > 9 & teaaaAnimationState == 0)
	ld	a, #0x09
	ld	hl, #_animFrame
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	ld	a, (#_teaaaAnimationState)
	or	a, a
	ld	a, #0x01
	jr	Z, 00263$
	xor	a, a
00263$:
	and	a,c
	jr	Z, 00124$
;teaaaaaaaa/states/templateFaceMicrogame.c:176: animFrame = 0;
	ld	hl, #_animFrame
	ld	(hl), #0x00
00124$:
;teaaaaaaaa/states/templateFaceMicrogame.c:178: if (animFrame > 36 & teaaaAnimationState == 1)
	ld	a, #0x24
	ld	hl, #_animFrame
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	ld	a, (#_teaaaAnimationState)
	dec	a
	ld	a, #0x01
	jr	Z, 00265$
	xor	a, a
00265$:
	and	a,c
	jr	Z, 00126$
;teaaaaaaaa/states/templateFaceMicrogame.c:180: teaaaAnimationState = 0;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:181: animFrame = 0;
	ld	hl, #_animFrame
	ld	(hl), #0x00
00126$:
;teaaaaaaaa/states/templateFaceMicrogame.c:183: if (animFrame > 45)
	ld	a, #0x2d
	ld	hl, #_animFrame
	sub	a, (hl)
	jr	NC, 00131$
;teaaaaaaaa/states/templateFaceMicrogame.c:185: teaaaAnimationState = 0;
	ld	hl, #_teaaaAnimationState
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:186: animFrame = 0;
	ld	hl, #_animFrame
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:187: if (teaaaflipSprite == 0)
	ld	hl, #_teaaaflipSprite
	ld	a, (hl)
	or	a, a
	jr	NZ, 00128$
;teaaaaaaaa/states/templateFaceMicrogame.c:188: teaaaflipSprite = S_FLIPX;
	ld	(hl), #0x20
	jr	00131$
00128$:
;teaaaaaaaa/states/templateFaceMicrogame.c:190: teaaaflipSprite = 0;
	ld	hl, #_teaaaflipSprite
	ld	(hl), #0x00
00131$:
;teaaaaaaaa/states/templateFaceMicrogame.c:192: set_sprite_tile(0,WMTileData[animFrame]);
	ld	a, #<(_WMTileData)
	ld	hl, #_animFrame
	add	a, (hl)
	ld	c, a
	ld	a, #>(_WMTileData)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:193: set_sprite_tile(1,WMTileData[animFrame + 1]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_WMTileData
	add	hl, bc
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:194: set_sprite_tile(2,WMTileData[animFrame + 2]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	ld	hl, #_WMTileData
	add	hl, bc
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:195: set_sprite_tile(3,WMTileData[animFrame + 3]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #_WMTileData
	add	hl, bc
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:196: set_sprite_tile(4,WMTileData[animFrame + 4]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #_WMTileData
	add	hl, bc
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:197: set_sprite_tile(5,WMTileData[animFrame + 5]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	de, #_WMTileData
	add	hl, de
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:198: set_sprite_tile(6,WMTileData[animFrame + 6]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0006
	add	hl, bc
	ld	de, #_WMTileData
	add	hl, de
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:199: set_sprite_tile(7,WMTileData[animFrame + 7]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0007
	add	hl, bc
	ld	de, #_WMTileData
	add	hl, de
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:200: set_sprite_tile(8,WMTileData[animFrame + 8]);
	ld	hl, #_animFrame
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #0x0008
	add	hl, bc
	ld	de, #_WMTileData
	add	hl, de
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:201: set_sprite_prop(0,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:202: set_sprite_prop(1,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:203: set_sprite_prop(2,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:204: set_sprite_prop(3,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 15)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:205: set_sprite_prop(4,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 19)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:206: set_sprite_prop(5,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 23)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:207: set_sprite_prop(6,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 27)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:208: set_sprite_prop(7,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 31)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:209: set_sprite_prop(8,teaaaflipSprite);
	ld	hl, #_teaaaflipSprite
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1493: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 35)
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:210: teaaaStoredFrame = WMMoleFrameData[0];
	ld	a, (#_WMMoleFrameData + 0)
	ld	(#_teaaaStoredFrame),a
;teaaaaaaaa/states/templateFaceMicrogame.c:211: teaaaFrameIndex = 0;
	ld	hl, #_teaaaFrameIndex
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:212: teaaaSpriteMemory = 9;
	ld	hl, #_teaaaSpriteMemory
	ld	(hl), #0x09
;teaaaaaaaa/states/templateFaceMicrogame.c:213: teaaaStoredSpriteX = teaaaSprite1X;
	ld	a, (#_teaaaSprite1X)
	ld	(#_teaaaStoredSpriteX),a
;teaaaaaaaa/states/templateFaceMicrogame.c:214: WhackMolesUpdateSprite();
	ld	e, #b_WhackMolesUpdateSprite
	ld	hl, #_WhackMolesUpdateSprite
	call	___sdcc_bcall_ehl
;teaaaaaaaa/states/templateFaceMicrogame.c:215: teaaaStoredFrame = WMMoleFrameData[1];
	ld	a, (#(_WMMoleFrameData + 1) + 0)
	ld	(#_teaaaStoredFrame),a
;teaaaaaaaa/states/templateFaceMicrogame.c:216: teaaaFrameIndex = 1;
	ld	hl, #_teaaaFrameIndex
	ld	(hl), #0x01
;teaaaaaaaa/states/templateFaceMicrogame.c:217: teaaaSpriteMemory = 15;
	ld	hl, #_teaaaSpriteMemory
	ld	(hl), #0x0f
;teaaaaaaaa/states/templateFaceMicrogame.c:218: teaaaStoredSpriteX = teaaaSprite2X;
	ld	a, (#_teaaaSprite2X)
	ld	(#_teaaaStoredSpriteX),a
;teaaaaaaaa/states/templateFaceMicrogame.c:219: WhackMolesUpdateSprite();
	ld	e, #b_WhackMolesUpdateSprite
	ld	hl, #_WhackMolesUpdateSprite
	call	___sdcc_bcall_ehl
;teaaaaaaaa/states/templateFaceMicrogame.c:220: teaaaStoredFrame = WMMoleFrameData[2];
	ld	a, (#(_WMMoleFrameData + 2) + 0)
	ld	(#_teaaaStoredFrame),a
;teaaaaaaaa/states/templateFaceMicrogame.c:221: teaaaFrameIndex = 2;
	ld	hl, #_teaaaFrameIndex
	ld	(hl), #0x02
;teaaaaaaaa/states/templateFaceMicrogame.c:222: teaaaSpriteMemory = 21;
	ld	hl, #_teaaaSpriteMemory
	ld	(hl), #0x15
;teaaaaaaaa/states/templateFaceMicrogame.c:223: teaaaStoredSpriteX = teaaaSprite3X;
	ld	a, (#_teaaaSprite3X)
	ld	(#_teaaaStoredSpriteX),a
;teaaaaaaaa/states/templateFaceMicrogame.c:224: WhackMolesUpdateSprite();
	ld	e, #b_WhackMolesUpdateSprite
	ld	hl, #_WhackMolesUpdateSprite
	call	___sdcc_bcall_ehl
;teaaaaaaaa/states/templateFaceMicrogame.c:225: if (numberOfMoles == 0)
	ld	a, (#_numberOfMoles)
	or	a, a
	jr	NZ, 00133$
;teaaaaaaaa/states/templateFaceMicrogame.c:227: mgStatus = WON;
	ld	hl, #_mgStatus
	ld	(hl), #0x02
00133$:
;teaaaaaaaa/states/templateFaceMicrogame.c:131: teaaaPlayableSpriteX += 2;
	ld	hl, #_teaaaPlayableSpriteX
	ld	c, (hl)
;teaaaaaaaa/states/templateFaceMicrogame.c:231: move_sprite(0,teaaaPlayableSpriteX - 16,teaaaPlayableSpriteY - 16);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf0
	ld	e, a
;teaaaaaaaa/states/templateFaceMicrogame.c:229: if (teaaaflipSprite == 0)
	ld	a, (#_teaaaflipSprite)
	or	a, a
	jp	NZ, 00135$
;teaaaaaaaa/states/templateFaceMicrogame.c:231: move_sprite(0,teaaaPlayableSpriteX - 16,teaaaPlayableSpriteY - 16);
	ld	a, c
	add	a, #0xf0
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:232: move_sprite(1,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY - 16);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf0
	ld	e, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xf8
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:233: move_sprite(2,teaaaPlayableSpriteX,teaaaPlayableSpriteY - 16);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf0
	ld	e, a
	ld	hl, #_teaaaPlayableSpriteX
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:234: move_sprite(3,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY - 8);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf8
	ld	e, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xf8
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:235: move_sprite(4,teaaaPlayableSpriteX,teaaaPlayableSpriteY - 8);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf8
	ld	e, a
	ld	hl, #_teaaaPlayableSpriteX
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:236: move_sprite(5,teaaaPlayableSpriteX - 16,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	e, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xf0
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:237: move_sprite(6,teaaaPlayableSpriteX - 8,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	e, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xf8
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:238: move_sprite(7,teaaaPlayableSpriteX,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	e, (hl)
	ld	hl, #_teaaaPlayableSpriteX
	ld	c, (hl)
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 28)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:239: move_sprite(8,teaaaPlayableSpriteX + 8,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	e, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0x08
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 32)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:239: move_sprite(8,teaaaPlayableSpriteX + 8,teaaaPlayableSpriteY);
	jp	00136$
00135$:
;teaaaaaaaa/states/templateFaceMicrogame.c:243: move_sprite(0,teaaaPlayableSpriteX + 12,teaaaPlayableSpriteY - 16);
	ld	a, c
	add	a, #0x0c
	ld	c, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;teaaaaaaaa/states/templateFaceMicrogame.c:244: move_sprite(1,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY - 16);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf0
	ld	c, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0x04
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:245: move_sprite(2,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY - 16);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf0
	ld	c, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xfc
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:246: move_sprite(3,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY - 8);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf8
	ld	c, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0x04
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:247: move_sprite(4,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY - 8);
	ld	a, (#_teaaaPlayableSpriteY)
	add	a, #0xf8
	ld	c, a
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xfc
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:248: move_sprite(5,teaaaPlayableSpriteX + 12,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	c, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0x0c
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:249: move_sprite(6,teaaaPlayableSpriteX + 4,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	c, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0x04
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:250: move_sprite(7,teaaaPlayableSpriteX - 4,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	c, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xfc
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 28)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:251: move_sprite(8,teaaaPlayableSpriteX - 12,teaaaPlayableSpriteY);
	ld	hl, #_teaaaPlayableSpriteY
	ld	c, (hl)
	ld	a, (#_teaaaPlayableSpriteX)
	add	a, #0xf4
	ld	b, a
;C:/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 32)
;C:/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;teaaaaaaaa/states/templateFaceMicrogame.c:251: move_sprite(8,teaaaPlayableSpriteX - 12,teaaaPlayableSpriteY);
00136$:
;teaaaaaaaa/states/templateFaceMicrogame.c:253: prevJoypad = curJoypad;
	ld	a, (#_curJoypad)
	ld	(#_prevJoypad),a
;teaaaaaaaa/states/templateFaceMicrogame.c:254: }
	ret
;teaaaaaaaa/states/templateFaceMicrogame.c:256: void whackMolesMicrogameMain() BANKED
;	---------------------------------
; Function whackMolesMicrogameMain
; ---------------------------------
	b_whackMolesMicrogameMain	= 8
_whackMolesMicrogameMain::
;teaaaaaaaa/states/templateFaceMicrogame.c:261: switch (substate)
	ld	a, (#_substate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_substate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;teaaaaaaaa/states/templateFaceMicrogame.c:263: case SUB_INIT:
00101$:
;teaaaaaaaa/states/templateFaceMicrogame.c:264: whackMolesinitialize();
	ld	e, #b_whackMolesinitialize
	ld	hl, #_whackMolesinitialize
;teaaaaaaaa/states/templateFaceMicrogame.c:265: break;
	jp  ___sdcc_bcall_ehl
;teaaaaaaaa/states/templateFaceMicrogame.c:266: case SUB_LOOP:
00102$:
;teaaaaaaaa/states/templateFaceMicrogame.c:267: whackMolesLoop();
	ld	e, #b_whackMolesLoop
	ld	hl, #_whackMolesLoop
;teaaaaaaaa/states/templateFaceMicrogame.c:268: break;
	jp  ___sdcc_bcall_ehl
;teaaaaaaaa/states/templateFaceMicrogame.c:269: default:  // Abort to title in the event of unexpected state
00103$:
;teaaaaaaaa/states/templateFaceMicrogame.c:270: gamestate = STATE_TITLE;
	ld	hl, #_gamestate
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:271: substate = SUB_INIT;
	ld	hl, #_substate
	ld	(hl), #0x00
;teaaaaaaaa/states/templateFaceMicrogame.c:273: }
;teaaaaaaaa/states/templateFaceMicrogame.c:274: }
	ret
	.area _CODE_8
	.area _INITIALIZER
	.area _CABS (ABS)
