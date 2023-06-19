.text
.equ	SW,	0xFF200040
.equ	RED_LED,	0xFF200000
.equ	SDRAM_END,	0x03FFFFFF
.global _start
_start:
	movia r2,SW
	movia r3,RED_LED
	movia sp,SDRAM_END -3
	
	movi r16,0
LOOP:
	ldwio r4,(r2)
	andi  r5,r4,0b111111			#r5=N
	andi r6,r4,0b111000000
	srli r6,r6,0x6				#r6=M
	
	call FUNCT1
	br LOOP
FUNCT1:
	subi sp,sp,12
	stw r16,8(sp)
	stw r5,4(sp)
	stw r6,0(sp)
FOR:
	blt r5,r6,END
	sub r5,r5,r6
	addi r16,r16,1
	br FOR
END:
	stwio r16,(r3)
	ldw r16,8(sp)
	ldw r5,4(sp)
	ldw r6,0(sp)
	addi sp,sp,12
	ret

.data
.end