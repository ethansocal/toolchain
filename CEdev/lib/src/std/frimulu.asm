; (c) Copyright 2004-2008 Zilog, Inc.
;-------------------------------------------------------------------------
; fract interger Multiplication Unsigned.
;
; Input:
;	Operand1: 
;		  uHL : 24 bits
;
;	Operand2: 
;		  uBC : 24 bits
;
; Output:
;	Result:   uHL : 24 bits
; Registers Used:
;	none
;-------------------------------------------------------------------------
	.assume adl=1
	.def	__frimulu

__frimulu:
	push	af
	push	de
	push	iy
	push	bc
	push	hl
	ld	d,l
	ld	e,c
	mlt	de
	ld	a,d
	ld	d,h
	ld	e,b
	ld	b,h
	ld	h,e
	mlt	hl
	mlt	bc
	mlt	de
	add	a,c
	ld	c,a
	ld	a,b
	adc	a,0h
	ld	b,a
	add.s	hl,bc
	jr	nc,_L0
	inc	d
_L0:
	ld	iy,0h
	add	iy,sp
	ld	b,(iy+2)
	ld	c,(iy+5)
	mlt	bc
	ld	a,h
	add	a,e
	ld	e,a
	jr	nc,_L1
	inc	d
	jr	nz,_L1
	inc	bc
_L1:
	ld	h,(iy+2)
	ld	l,(iy+3)
	mlt	hl

	ld	a,l	;approximation
	add	a,80h
	ld	l,a
	ld	a,h
	adc	a,0h
	ld	h,a	

	add.s	hl,de
	jr	nc,_L2
	inc	bc
_L2:
	ld	d,(iy+0)
	ld	e,(iy+5)
	mlt	de
	add.s	hl,de
	jr	nc,_L3
	inc	bc
_L3:
	ld	a,h
	ld	d,(iy+2)
	ld	e,(iy+4)
	ld	h,(iy+1)
	ld	l,(iy+5)
	mlt	de
	mlt	hl
	add.s	hl,de
	jr	nc,_L4
	inc	b
_L4:
	add	a,l
	ld	l,a
	ld	a,h
	adc	a,c
	ld	h,a
	jr	nc,_L5
	inc	b
_L5:
	ex	de,hl
	push	bc
	dec	sp
	pop	hl
	inc	sp
	ld	h,d
	ld	l,e
	pop	bc
	pop	bc
	pop	iy
	pop	de
	pop	af
	ret
