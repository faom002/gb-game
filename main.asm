;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _joypadPrevious
	.globl _joypadCurrent
	.globl _velocityY
	.globl _velocityX
	.globl _spriteY
	.globl _spriteX
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_spriteX::
	.ds 1
_spriteY::
	.ds 1
_velocityX::
	.ds 1
_velocityY::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_joypadCurrent::
	.ds 1
_joypadPrevious::
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
	.area _CODE
;main.c:8: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:10: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:11: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:13: set_sprite_data(0,1,SimpleSprite);
	ld	de, #_SimpleSprite
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;/home/hacker/gbdk/include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;/home/hacker/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/hacker/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, #0x58
	ld	(hl+), a
	ld	(hl), #0x54
;main.c:18: spriteX=80;
	ld	hl, #_spriteX
	ld	(hl), #0x50
;main.c:19: spriteY=72;
	ld	hl, #_spriteY
	ld	(hl), #0x48
;main.c:22: velocityX=0;
	ld	hl, #_velocityX
	ld	(hl), #0x00
;main.c:23: velocityY=0;
	ld	hl, #_velocityY
	ld	(hl), #0x00
;main.c:26: while(1) {
00115$:
;main.c:31: joypadPrevious=joypadCurrent;
	ld	a, (#_joypadCurrent)
	ld	(#_joypadPrevious),a
;main.c:32: joypadCurrent = joypad();
	call	_joypad
	ld	hl, #_joypadCurrent
	ld	(hl), a
;main.c:35: if(joypadCurrent & J_RIGHT){
	ld	c, (hl)
	bit	0, c
	jr	Z, 00105$
;main.c:38: velocityX=1;
	ld	hl, #_velocityX
	ld	(hl), #0x01
	jr	00106$
00105$:
;main.c:41: }else if(joypadCurrent & J_LEFT){
	bit	1, c
	jr	Z, 00102$
;main.c:44: velocityX=-1;
	ld	hl, #_velocityX
	ld	(hl), #0xff
	jr	00106$
00102$:
;main.c:48: velocityX=0;
	ld	hl, #_velocityX
	ld	(hl), #0x00
00106$:
;main.c:52: if((joypadCurrent & J_A) && !(joypadPrevious & J_A)){
	ld	hl, #_joypadPrevious
	ld	b, (hl)
;main.c:55: spriteY+=8;
	ld	a, (#_spriteY)
;main.c:52: if((joypadCurrent & J_A) && !(joypadPrevious & J_A)){
	bit	4, c
	jr	Z, 00111$
	bit	4, b
	jr	NZ, 00111$
;main.c:55: spriteY+=8;
	add	a, #0x08
	ld	(#_spriteY),a
	jr	00112$
00111$:
;main.c:58: } else if((joypadCurrent & J_B) && !(joypadPrevious & J_B)){
	bit	5, c
	jr	Z, 00112$
	bit	5, b
	jr	NZ, 00112$
;main.c:61: spriteY-=8;
	add	a, #0xf8
	ld	(#_spriteY),a
00112$:
;main.c:65: spriteX+=velocityX;
	ld	a, (#_spriteX)
	ld	hl, #_velocityX
	add	a, (hl)
	ld	(#_spriteX),a
;main.c:66: spriteY+=velocityY;
	ld	a, (#_spriteY)
	ld	hl, #_velocityY
	add	a, (hl)
	ld	hl, #_spriteY
	ld	(hl), a
;main.c:72: move_sprite(0,spriteX+4,spriteY+12);
	ld	a, (hl)
	add	a, #0x0c
	ld	b, a
	ld	a, (#_spriteX)
	add	a, #0x04
	ld	c, a
;/home/hacker/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
;/home/hacker/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	hl, #_shadow_OAM
	ld	(hl), b
	ld	hl, #(_shadow_OAM + 1)
	ld	(hl), c
;main.c:75: wait_vbl_done();
	call	_wait_vbl_done
;main.c:77: }
	jr	00115$
	.area _CODE
	.area _INITIALIZER
__xinit__joypadCurrent:
	.db #0x00	; 0
__xinit__joypadPrevious:
	.db #0x00	; 0
	.area _CABS (ABS)
