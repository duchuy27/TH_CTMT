.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:	
	movia 	r2,SW
	movia 	r3,RED_LED
	movia 	sp,SDRAM_END -3
	movi	r16,0x3FF
LOOP:
	ldwio	r4,(r2)
	andi	r5,r4,0xFF		#r5=N
	mov		r6,r5
	
	call	DO
	
	br LOOP
	
DO:
	subi	sp,sp,16
	stw		r6,0(sp)
	stw		r7,4(sp)
	stw		r8,8(sp)
	stw		r9,12(sp)

	movi	r7,2			#r7=i
	movi	r9,0			#r9=flat
	blt		r6,r7,END1
	beq		r6,r7,END2
	subi	r8,r6,1			#r8=N-1
FOR:
	beq		r7,r8,FOR_END
	sub		r6,r6,r7
	blt		r6,r7,DO1
	beq		r6,r7,DO2
	br FOR
DO1:
	addi 	r7,r7,1
	mov		r6,r5
	br FOR
DO2:
	addi	r7,r7,1
	addi	r9,r9,1
	mov		r6,r5
	br FOR
FOR_END:
	beq		r9,r0,END2
	br END1
	
END1:
	stwio	r0,(r3)
	
	ldw		r6,0(sp)
	ldw		r7,4(sp)
	ldw		r8,8(sp)
	ldw		r9,12(sp)
	addi	sp,sp,16
	
	ret
END2:
	stwio	r16,(r3)
	
	ldw		r6,0(sp)
	ldw		r7,4(sp)
	ldw		r8,8(sp)
	ldw		r9,12(sp)
	addi	sp,sp,16
	
	ret
	
.data

.end