.text	
.equ SW,	0xFF200040
.equ LED,	0xFF200000
.equ SDRAM_END, 0x03FFFFFF
 
.global _start
_start:
	movia r2,SW
	movia r3,LED
	movia sp,SDRAM_END - 3
	movi	r16,7
	movi	r17,0b1101
LOOP:
	ldwio	r4,(r2)		#r4=N
	
	call	DO
	br LOOP
DO:
	# luu stack
	subi	sp,sp, 16
	stw		r5,12(sp)
	stw		r6,8(sp)
	stw		r7,4(sp)
	stw		r8,0(sp)
	# code
	movi 	r5,0		#r5=t
	movi	r6,0		#count=0
	movi	r7,0		#r7=i
	
FOR:
	beq		r7,r16,END_FOR
	andi	r5,r4,0xF
	cmpeq	r8,r5,r17
	add		r6,r6,r8
	srli	r4,r4,1
	addi	r7,r7,1
	br FOR
END_FOR:
	stwio	r6,(r3)
	# load stack
	ldw		r5,12(sp)
	ldw		r6,8(sp)
	ldw		r7,4(sp)
	ldw		r8,0(sp)
	addi	sp,sp, 16
	# return
	ret	

.data

.end