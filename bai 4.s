.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:
	movia r2,SW
	movia r3,RED_LED
	movia sp,SDRAM_END -3
	
	movi r10,0
LOOP:
	ldwio r4,(r2)
	andi  r5,r4,0b00011110
	srli r5,r5,0x1				#r5=N
	andi r6,r4,0b111100000
	srli r6,r6,0x5				#r6=M
	
	call FUNCT1
	br LOOP
FUNCT1:
	subi sp,sp,0x8
	stw r6,4(sp)
	stw r5,0(sp)
FOR:
	blt r6,r5,END
	sub r6,r6,r5
	beq r6,r10,END
	br FOR
END:
	mov r16,r6
	stwio r16,(r3)
	ldw r6,4(sp)
	ldw r5,0(sp)
	addi sp,sp,0x8
	ret

.data
.end