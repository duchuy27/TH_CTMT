.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:	
	movia 	r2,SW
	movia 	r3,RED_LED
	movia 	sp,SDRAM_END -3
	movi	r7,3
	movi	r8,1
	movia	r11,N

LOOP:
	ldwio	r4,(r2)
	andi	r5,r4,0xF				#r5=a
	andi	r6,r4,0xF0
	srli	r6,r6,0x4				#r6=b
	movi	r10,0					#r10=count
	
	call DO1
	ldw		r10,(r11)
	
	call DO2
	ldw		r10,(r11)
	
	stwio		r10,(r3)
	
	br LOOP
	
DO1:
	subi	sp,sp,16
	stw		r5,0(sp)
	stw		r10,4(sp)
	stw		r11,8(sp)
	stw		r9,12(sp)
	
FOR:
	blt		r5,r7,FOR_END
	sub 	r5,r5,r7
	br FOR
FOR_END:
	cmpeq	r9,r5,r8
	add		r10,r10,r9
	stw		r10,(r11)
	
	ldw		r5,0(sp)
	ldw		r10,4(sp)
	ldw		r11,8(sp)
	ldw		r9,12(sp)
	addi	sp,sp,16
	
	ret
	
DO2:
	subi	sp,sp,16
	stw		r6,0(sp)
	stw		r10,4(sp)
	stw		r11,8(sp)
	stw		r9,12(sp)
	
FOR2:
	blt		r6,r7,FOR_END2
	sub 	r6,r6,r7
	br FOR2
FOR_END2:
	cmpeq	r9,r6,r8
	add		r10,r10,r9
	stw		r10,(r11)
	
	ldw		r6,0(sp)
	ldw		r10,4(sp)
	ldw		r11,8(sp)
	ldw		r9,12(sp)
	addi	sp,sp,16
	
	ret

.data
N: .word 0
.end