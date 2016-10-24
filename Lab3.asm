;This program takes in a a decimal integer
;and prints out the input as binary.


	.ORIG x3000    
START	LEA R0, WELCOME
	PUTS

INITIAL	LEA R0, PROMPT
	PUTS
	AND R0, R0, 0 ;INPUT
	AND R1, R1, 0 ;INT
	AND R2, R2, 0 ;LF
	AND R3, R3, 0 ;TEMP
	AND R4, R4, 0 ;FLAG/TEMP
	AND R5, R5, 0 ;NEGATIVE OFFSET/COUNTER
	AND R6, R6, 0 ;DIGIT
	AND R7, R7, 0 ;Counter
	LD  R2, LF
	LD  R5, NEG

GETIN	GETC
	OUT

CHKLF	ADD R3, R0, -10	;Checks to see if input is line feed
	BRz CHKFLG
	
CHKNEG  ADD R3, R0, R5  ;Checks to see if input is negative
	BRz SETFLAG	;Sets flag if it is
	BRnzp CHRTRNZ

CHRTRNZ	ADD R6, R0,  0	;Converts the charcter into its decimal
	ADD R6, R6, -3  ;number in binary. 
	ADD R6, R6, R5
	LD  R7, LF
	ADD R7, R7, -1
	AND R3, R3, 0
	ADD R3, R3, R1

MULTI	ADD R1, R1, R3  ;Multiplies the current number by 10
	ADD R7, R7, -1  ;then adds the digit to current number
	BRp MULTI
	ADD R1, R1, R6
	BRnzp GETIN		
	

END	HALT       	;ends the program

CHKFLG	AND R3, R3, 0	;Checks to see if the flag is set
	ADD R3, R4, -1	;If flag is set goes to comp function
	BRz COMP
	BRnzp MASK

COMP	NOT R1, R1	;Takes the twos complement of R1
	ADD R1, R1, 1
	BRnzp MASK

MASK	LEA R3, MSKPTR	;Loads R3 with pointer to first mask value
	AND R7, R7, 0
	ADD R7, R7, 15
	ADD R7, R7, 1	
	
PRINT	ADD R7, R7, -1  ;Decreases counter by one
	BRn AGAIN	;Checks to see if counter is zero
	AND R4, R4, 0	;Sets temp R4 to zero
	LDR R4, R3, 0	;Loads Data from Pointer to R4
	ADD R3, R3, 1	;Increments Pointer
	AND R6, R4, R1	;Bitwise and R4 and R1 stores result in R6
	BRz PRNTZRO
	BRnzp PRNTONE


PRNTONE	LD R0, ONE	;Prints the character one
	ST R7, SAVER7	;Need to save contents of R7 since out is being called
	OUT
	LD R7, SAVER7	;Loads data back into R7
	BRnzp PRINT

PRNTZRO LD R0, ZERO	;Printe the zero character
	ST R7, SAVER7	;Needs to save contents of R7 since out is being called
	OUT
	LD R7, SAVER7	;Loads data backinto R7
	BRnzp PRINT	

AGAIN	LEA R0, CONTINUE;Prompts user if they would like to continue
	PUTS
	GETC
	OUT
	LD R3, ESC
	ADD R0, R0, R3
	BRz END
	BRnzp START
	
		

SETFLAG	LD R4, FLAG	;Sets flag to 1
	BRnzp GETIN


WELCOME	  .STRINGZ	"\nHi, Welcome to Integers to Binary\n"
PROMPT    .STRINGZ	"Please enter a number (-16384 - 16384): "
CONTINUE  .STRINGZ	"\nPress any key to continue and ESC to quit\n"

NEG	.FILL -45
FLAG	.FILL 1
LF	.FILL 10
ESC	.FILL -27
MSKPTR	.FILL 32768
	.FILL 16384
	.FILL 8192
	.FILL 4096
	.FILL 2048
	.FILL 1024
	.FILL 512
	.FILL 256
	.FILL 128
	.FILL 64
	.FILL 32
	.FILL 16
	.FILL 8
	.FILL 4
	.FILL 2
	.FILL 1
ZERO	.FILL 48
ONE	.FILL 49
SAVER7	.FILL 0

.END