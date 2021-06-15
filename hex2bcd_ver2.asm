; HEX to BCD conversion

INIT:	LD	A,	0X00		; High byte.
	LD	(0X1901),	A
	LD	A,	0Xff		; Low byte.
	LD	(0X1900),	A	; Loads HL with source bytes.

START:
	LD	DE,	0X0000		; Destination
	LD	B,	0X10		; Counter.
	LD	HL,	(0x1900)	; Source bytes.
LOOP:
	SLA	L		; [CARRY] <<<<<<<< - 0
	RL	H		; <<<<<<<< - [CARRY]
	RL	D		; <<<<<<<< - [CARRY]
	RL	E		; <<<<<<<< - [CARRY]

	DEC	B
	JR	Z,	EXIT	; Exit when done.

	LD	A,	D
	AND	0X0F
	SUB	0X05
	JR	C,	SKIP1	; Skip if low nibble less than 5.
ONES_ADD_3:
	LD	A,	D
	AND	0X0F		; Mask off high nibble.
	ADD	A,	0X03	; Add 3 to low nibble.

	EX	AF,	AF'
	LD	A,	D
	AND	0XF0
	LD	D,	A
	EX	AF,	AF'
	OR	D		; Combine high and low nibbles again.
	LD	D,	A
SKIP1:



		LD	A,	D
	AND	0XF0
	SUB	0X50
	JR	C,	SKIP2	; Skip if high nibble less than 5.
TENS_ADD_3:
	LD	A,	D
	AND	0XF0		; Mask off low nibble.
	ADD	A,	0X30	; Add 0x30 to high nibble.

	EX	AF,	AF'
	LD	A,	D
	AND	0X0F
	LD	D,	A
	EX	AF,	AF'
	OR	D		; Combine high and low nibbles again.
	LD	D,	A
SKIP2:



	JR	LOOP
EXIT:
	HALT






