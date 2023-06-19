.text
.equ SW,		0xFF200040
.equ HEX3_HEX0, 0xFF200020
.equ SDRAM_END, 0x03FFFFFF
.global _start
_start:
	movia	sp,SDRAM_END -3
	movia 	r2,SW
	movia	r7, SEVEN_SEG_DECODE_TABLE
	mov		r21,zero
	mov		r22,zero
	
LOOP:
	movia 	r9, HEX_SEGMENTS
	
	ldwio 	r3,(r2)
	andi	r3,r3,0x3FF
	movi	r4,0	#r4=i
	movi	r5,0	#r5=count
	movi 	r10,9
	movi 	r11,10
	
FOR:
	bgt		r4,r10,FOR_END
	andi	r6,r3,1
	cmpne	r8,r6,r0
	add		r5,r5,r8
	srli	r3,r3,1
	addi	r4,r4,1
	br FOR
FOR_END:
	beq		r5,r11,END
	mov		r21,r5
	movi	r22,0
	br		DO
END:
	movi	r21,0
	movi	r22,1
	br 		DO
DO:
	call SEVEN_SEG_DECODER
	
	br LOOP
	
SEVEN_SEG_DECODER:
	subi sp,sp,16
	
	stw	r15,0(sp)
	stw	r9,4(sp)
	stw	r16,8(sp)
	stw	r17,12(sp)
	
	add r15, r7, r21
	ldb r16, 0(r15)
	stb r16, 0(r9)
	addi r9, r9, 1
	
	add r15, r7, r22
	ldb r16, 0(r15)
	stb r16, 0(r9)
	addi r9, r9, 1
	
	movia r9, HEX_SEGMENTS
	ldw r16, 0(r9)
	movia r17, HEX3_HEX0
	stwio r16, 0(r17)
	
	ldw	r15,0(sp)
	ldw	r9,4(sp)
	ldw	r16,8(sp)
	ldw	r17,12(sp)
	addi 	sp,sp,16
	
	ret
	
.data
SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
HEX_SEGMENTS: .fill 1, 4, 0
.end