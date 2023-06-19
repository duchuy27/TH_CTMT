.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:
	movia r2,SW
	movia r3,RED_LED
	movia sp,SDRAM_END -3
	
	movi r10,0x1
	movi r16,0
	movi r9,0
LOOP:
	ldwio r4,(r2)
	andi  r5,r4,0b00111100
	srli  r5,r5,0x2
	
	call FUNCT1
	br LOOP
FUNCT1:
	subi sp,sp,0x12
	stw r9,8(sp)
	stw r16,4(sp)
	stw r10,0(sp)
FOR:
	add r16,r16,r10
	beq r9,r5,END
	addi r9,r9,1
	addi r10,r10,2
	br FOR
END:
	stwio r16,(r3)
	ldw r9,8(sp)
	ldw r16,4(sp)
	ldw r10,0(sp)
	addi sp,sp,0x12
	ret

.data

.end