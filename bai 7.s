.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:
	movia r2,SW
	movia r3,RED_LED
	movia sp,SDRAM_END -3
	movi	r7,0					#r7=i
	movi	r8,0					#r8=tich
	movi	r11,25
	movia	r15,N
	
LOOP:
	ldwio	r4,(r2)
	andi	r5,r4,0xF				#r5=a
	andi	r6,r4,0xF0
	srli	r6,r6,0x4				#r6=b
	movi	r16,0
	
	mov		r9,r5
	mov		r10,r5
	call	NHAN
	ldw		r16,(r15)

	movi	r9,3
	mov		r10,r6
	call	NHAN
	ldw		r16,(r15)

	addi	r16,r16,25
	stwio	r16,0(r3)

	br LOOP

NHAN:
	subi	sp,sp,12
	stw		r8,8(sp)
	stw		r16,4(sp)
	stw		r7,0(sp)

FOR:
	bge		r7,r10,FOR_END
	add		r8,r8,r9
	addi	r7,r7,1
	br		FOR
FOR_END:
	add		r16,r16,r8
	movi	r8,0
	movi	r7,0
	
	stw		r16,(r15)
	
	ldw		r8,8(sp)
	ldw		r16,4(sp)
	ldw		r7,0(sp)
	addi	sp,sp,12

	ret

.data
N:	.word 0
.end