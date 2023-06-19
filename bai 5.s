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
	movi r9,0
	movi r8,2
LOOP:
	ldwio r4,(r2)
	andi  r5,r4,0xF			#r5=N
	andi r6,r4,0b110000
	srli r6,r6,0x4				#r6=M
	
	mov r10,r5
	call FUNCT1
	br LOOP
FUNCT1:
	subi sp,sp,16
	stw r9,12(sp)
	stw r8,8(sp)
	stw r16,4(sp)
	stw r10,0(sp)
FOR1:
	beq r9,r5,FOR2
	add r16,r16,r10
	addi r9,r9,1
	br FOR1
FOR2:
	beq r8,r6,END
	mov r10,r16
	sub r9,r9,r5
	addi r9,r9,1
	addi r8,r8,1
	br FOR1
END:
	stwio r16,(r3)
	ldw r9,12(sp)
	ldw r8,8(sp)
	ldw r16,4(sp)
	ldw r10,0(sp)
	addi sp,sp,16
	ret

.data
.end