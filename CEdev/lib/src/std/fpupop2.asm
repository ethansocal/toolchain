;--------------------------------------------------------------
;
;	        Code Generation Helper
;		For the  Zilog eZ80 C Compiler
;	        Copyright 1992-2008 Zilog, Inc. 
;
;--------------------------------------------------------------
;--------------------------------------------------------------
;
;	  	Unpack IEEE op2 of dyadic operations.
;
; INPUTS:	EuHL:	32 bits
;
;		E EEEEEEEH HHHHHHHHHHHHHHHLLLLLLLL
;		S EEEEEEEE FFFFFFFFFFFFFFFFFFFFFFF
;		0 1      8 9                    31
; 
; OUTPUTS:	uHL:		Mantissa
;		E:		Exponent
;		D:		Sign Bit
;		ZERO FLAG	Set if op was zero.
; 
; MODIFIES:
;		flags
;--------------------------------------------------------------
	.def __fpupop2
	.assume adl=1

__fpupop2:
	push    bc
	ld	bc,0800000h
	add	hl,bc
	jr	nc,ncarry
	add	hl,bc
	scf
ncarry:
	ld	d,c
	pop	bc
	rl	e
	jr	nz,nzero
	or	a,a
	sbc	hl,hl
nzero:
	rl	d
	inc	e
	dec	e
	ret
