.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:	
	movia 	r2,SW
	movia 	r3,RED_LED
	movia 	sp,SDRAM_END -3
	movi	r6,0x14
	movi	r7,0x41
	movia	r10,N
	movi	r13,1
	movi	r14,0x3FF
	movi	r15,0xF
	
LOOP:
	ldwio	r4,(r2)
	srli	r4,r4,2
	andi	r5,r4,0xFF		#r5=N
	movi	r8,0			#r8=count
	
	mov		r12,r5
	call DO
	ldw		r8,(r10)
	
	cmpgt	r11,r5,r7
	add		r8,r8,r11
END:
	beq		r8,r0,END0
	beq		r8,r13,END1
	stwio	r14,(r3)
	br LOOP
END0:
	stwio	r0,(r3)
	br LOOP
END1:
	stwio	r15,(r3)
	br LOOP
	
DO:
	subi	sp,sp,16
	stw		r12,0(sp)
	stw		r9,4(sp)
	stw		r8,8(sp)
	stw		r10,12(sp)
FOR:
	blt		r12,r6,FOR_END
	sub		r12,r12,r6
	br FOR
FOR_END:
	cmpeq	r9,r12,r0
	add		r8,r8,r9
	
	stw		r8,(r10)
	
	ldw		r12,0(sp)
	ldw		r9,4(sp)
	ldw		r8,8(sp)
	ldw		r10,12(sp)
	addi	sp,sp,16
	
	ret
	
	
	
	
.data
N: .word 0
.end