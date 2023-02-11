.data
piece2:	.asciiz "ZZZZZZZZZZZZZZZZZZZZZZZZZ"
piece1:	.asciiz "ZZZZZZZZZZZZZZZZZZZZZZZZZ"
piece:	.asciiz	"ZZZZZZZZZZZZZZZZZZZZZZZZZ"
board:	.asciiz "ZZZZZ_ZZZZZ_ZZZZZ_ZZZZZ_ZZZZZ"
true:	.asciiz "true"
false:	.asciiz	"false"

lineU:	.asciiz "\t\t\t     |     |     |     |     "
lineD:	.asciiz "\t\t\t_____|_____|_____|_____|_____"

line1:	.asciiz	"\t\t\t  1  |  2  |  3  |  4  |  5  "
line2:	.asciiz	"\t\t\t  6  |  7  |  8  |  9  |  10 "
line3:	.asciiz	"\t\t\t  11 |  12 |  13 |  14 |  15 "
line4:	.asciiz	"\t\t\t  16 |  17 |  18 |  19 |  20 \t\t 0 to undo once"
line5:	.asciiz	"\t\t\t  21 |  22 |  23 |  24 |  25 \t\t-1 to quit game"

upLine:	.asciiz	"\n     |     |     |     |     "
doLine:	.asciiz	"\n_____|_____|_____|_____|_____"
leLine:	.asciiz	"\n  "
miLine:	.asciiz	"  |  "
mLine:	.asciiz " |  "
space:	.asciiz	""
space1:	.asciiz " "
nLine:	.asciiz	"\n"

prmt1:	.asciiz	"\n\nPlayer 1 move: "
prmt2:	.asciiz	"\n\nPlayer 2 move: "
prmt3:	.asciiz "\n\nDraw!"
prmt4:	.asciiz	"\n\nPlayer 1 wins!"
prmt5:	.asciiz	"\n\nPlayer 2 wins!"
prmt6:	.asciiz "\nPlease don't choose the central point during your first turn!"
prmt7:	.asciiz	"\nCan't undo in the first move!"
prmt8:	.asciiz	"\nYou've already undo!"
prmt9:	.asciiz	"\nIllegal move!"

wlcm:	.asciiz	"Welcome to Q's 5x5 Tic-tac-toe.\nThe game is very simple, the player with 3 points in a row, column or a diagonal line will win.\nWhen asked, please enter a number, corresponding to the cell you choose.\nNoted that you can't choose the center cell (cell 13) in your first turn.\nBoth player can undo once each turn by inputing 0 in the opponent's turn.\nFinally, you can input -1 to quit game.\n\n"
.text
main:
	la	$a0, wlcm
	li	$v0, 4
	syscall

	jal	print

	li	$t2, 0
	li	$t9, 0
Lm0:	
	la	$s0, piece

	la	$a0, prmt1
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	li	$t7, 0
	sgt	$t7, $t0, 25
	bne	$t7, 1, Illm1
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm0
Illm1:	slti	$t7, $t0, -1
	bne	$t7, 1, Illm0
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm0
	
Illm0:	bne	$t0, 0, LmN0		#undo
	bne	$t8, 1, LmN4
	la	$a0, prmt8
	li	$v0, 4
	syscall
	j	Lm0
LmN4:	bne	$t9, 0, LmN2
	la	$a0, prmt7
	li	$v0, 4
	syscall
	j	Lm0
LmN2:	jal	strcpy10
	jal	print
	addi	$t8, $t8, 1
	j	Lm3
LmN0:	beq	$t0, -1, LmE0		#check cell 13 1st move
	bne	$t9, 0, Lm2		#check cell 13 1st move
	bne	$t0, 13, Lm2		#check cell 13 1st move
	la	$a0, prmt6		#check cell 13 1st move
	li	$v0, 4			#check cell 13 1st move
	syscall				#check cell 13 1st move
	j	Lm0			#check cell 13 1st move
Lm2:	
	addi	$t0, $t0, -1
	
	
	add	$t6, $t0, $s0
	lb	$t6, 0($t6)
	beq	$t6, 90, Illm4
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm0
	
	
	
Illm4:	add	$t0, $s0, $t0
	li	$t1, 88
	sb	$t1, 0($t0)
	
	addi	$t2, $t2, 1
	li	$t8, 0
	jal	strcpy01
	jal	print
	jal	cPtB
	jal	cP1
	
	beq	$t2, 25, LmE1
Lm3:	
	la	$s0, piece

	la	$a0, prmt2
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	move	$t0, $v0
	
	
	
	
	li	$t7, 0
	sgt	$t7, $t0, 25
	bne	$t7, 1, Illm3
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm3
Illm3:	slti	$t7, $t0, -1
	bne	$t7, 1, Illm2
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm3
	
	
	
	
Illm2:	bne	$t0, 0, LmN1		#undo
	
	
	bne	$t8, 1, LmN5
	la	$a0, prmt8
	li	$v0, 4
	syscall
	j	Lm3
LmN5:	#bne	$t9, 0, LmN2
	#la	$a0, prmt7
	#li	$v0, 4
	#syscall
	#j	Lm0
	
	
	jal	strcpy20
	jal	print
	addi	$t8, $t8, 1
	j	Lm0
LmN1:	beq	$t0, -1, LmE0		#check cell 13 1st move
	bne	$t9, 0, Lm4		#check cell 13 1st move
	bne	$t0, 13, Lm4		#check cell 13 1st move
	la	$a0, prmt6		#check cell 13 1st move
	li	$v0, 4			#check cell 13 1st move
	syscall				#check cell 13 1st move
	j	Lm3			#check cell 13 1st move
Lm4:	
	addi	$t0, $t0, -1
	
	
	add	$t6, $t0, $s0
	lb	$t6, 0($t6)
	beq	$t6, 90, Illm5
	li	$v0, 4
	la	$a0, prmt9
	syscall
	j	Lm3
	
	
	
Illm5:	add	$t0, $s0, $t0
	li	$t1, 79
	sb	$t1, 0($t0)
	
	addi	$t2, $t2, 1
	jal	strcpy02
	jal	print
	jal	cPtB
	jal	cP2
	
	
	addi	$t9, $t9, 1
	j	Lm0

LmE1:	la	$a0, prmt3
	li	$v0, 4
	syscall	
	
LmE0:	li	$v0, 10
	syscall
	
	
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
print:
	la	$s0, piece
	li	$t0, 1
	
	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall

	la	$a0, leLine
	li	$v0, 4
	syscall
	
	lb	$a0, 0($s0)
	bne	$a0, 90, Lpr0
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE0
Lpr0:	li	$v0, 11
	syscall
LprE0:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 1($s0)
	bne	$a0, 90, Lpr1
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE1
Lpr1:	li	$v0, 11
	syscall
LprE1:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 2($s0)
	bne	$a0, 90, Lpr2
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE2
Lpr2:	li	$v0, 11
	syscall
LprE2:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 3($s0)
	bne	$a0, 90, Lpr3
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE3
Lpr3:	li	$v0, 11
	syscall
LprE3:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 4($s0)
	bne	$a0, 90, Lpr4
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE4
Lpr4:	li	$v0, 11
	syscall
LprE4:	addi	$t0, $t0, 1

	la	$a0, line1
	li	$v0, 4
	syscall
	
	la	$a0, doLine
	li	$v0, 4
	syscall
	
	la	$a0, lineD
	li	$v0, 4
	syscall
	
#------------------------------------------------------------------#

	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall

	la	$a0, leLine
	li	$v0, 4
	syscall
	
	lb	$a0, 5($s0)
	bne	$a0, 90, Lpr5
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE5
Lpr5:	li	$v0, 11
	syscall
LprE5:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 6($s0)
	bne	$a0, 90, Lpr6
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE6
Lpr6:	li	$v0, 11
	syscall
LprE6:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 7($s0)
	bne	$a0, 90, Lpr7
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE7
Lpr7:	li	$v0, 11
	syscall
LprE7:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 8($s0)
	bne	$a0, 90, Lpr8
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE8
Lpr8:	li	$v0, 11
	syscall
LprE8:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 9($s0)
	bne	$a0, 90, Lpr9
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE9
Lpr9:	li	$v0, 11
	syscall
LprE9:	addi	$t0, $t0, 1
	
	
	la	$a0, line2
	li	$v0, 4
	syscall
	
	la	$a0, doLine
	li	$v0, 4
	syscall	

	la	$a0, lineD
	li	$v0, 4
	syscall

#------------------------------------------------------------------#


	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall

	la	$a0, leLine
	li	$v0, 4
	syscall
	
	lb	$a0, 10($s0)
	bne	$a0, 90, Lpr10
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE10
Lpr10:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE10:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 11($s0)
	bne	$a0, 90, Lpr11
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE11
Lpr11:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE11:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 12($s0)
	bne	$a0, 90, Lpr12
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE12
Lpr12:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE12:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 13($s0)
	bne	$a0, 90, Lpr13
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE13
Lpr13:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE13:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 14($s0)
	bne	$a0, 90, Lpr14
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE14
Lpr14:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE14:	addi	$t0, $t0, 1


	la	$a0, line3
	li	$v0, 4
	syscall
	
	la	$a0, doLine
	li	$v0, 4
	syscall
	
	la	$a0, lineD
	li	$v0, 4
	syscall
	
	
#-----------------------------------------------------------------


	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall

	la	$a0, leLine
	li	$v0, 4
	syscall
	
	lb	$a0, 15($s0)
	bne	$a0, 90, Lpr15
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE15
Lpr15:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE15:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 16($s0)
	bne	$a0, 90, Lpr16
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE16
Lpr16:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE16:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 17($s0)
	bne	$a0, 90, Lpr17
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE17
Lpr17:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE17:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 18($s0)
	bne	$a0, 90, Lpr18
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE18
Lpr18:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE18:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 19($s0)
	bne	$a0, 90, Lpr19
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE19
Lpr19:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE19:	addi	$t0, $t0, 1


	la	$a0, line4
	li	$v0, 4
	syscall
	
	la	$a0, doLine
	li	$v0, 4
	syscall
	
	la	$a0, lineD
	li	$v0, 4
	syscall
	
	
#-------------------------------------------------------------------


	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall

	la	$a0, leLine
	li	$v0, 4
	syscall
	
	lb	$a0, 20($s0)
	bne	$a0, 90, Lpr20
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE20
Lpr20:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE20:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 21($s0)
	bne	$a0, 90, Lpr21
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE21
Lpr21:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE21:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 22($s0)
	bne	$a0, 90, Lpr22
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE22
Lpr22:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE22:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 23($s0)
	bne	$a0, 90, Lpr23
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE23
Lpr23:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE23:	addi	$t0, $t0, 1
	
	la	$a0, miLine
	li	$v0, 4
	syscall
	
	lb	$a0, 24($s0)
	bne	$a0, 90, Lpr24
	la	$a0, space1
	li	$v0, 4
	syscall
	j	LprE24
Lpr24:	li	$v0, 11
	syscall
	la	$a0, space
	li	$v0, 4
	syscall
LprE24:	addi	$t0, $t0, 1

	la	$a0, line5
	li	$v0, 4
	syscall
	
	la	$a0, upLine
	li	$v0, 4
	syscall
	
	la	$a0, lineU
	li	$v0, 4
	syscall
	
	jr	$ra

#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------

cPtB:
	addi	$sp, $sp, -12
	sw	$t0, 0($sp)
	sw	$t1, 4($sp)
	sw	$t2, 8($sp)
	
	
	la	$t0, piece
	la	$t1, board
	
	lb	$t2, 0($t0)
	sb	$t2, 0($t1)
	
	lb	$t2, 1($t0)
	sb	$t2, 1($t1)
	
	lb	$t2, 2($t0)
	sb	$t2, 2($t1)
	
	lb	$t2, 3($t0)
	sb	$t2, 3($t1)
	
	lb	$t2, 4($t0)
	sb	$t2, 4($t1)
	
#-------------------------------------------------------------
	
	lb	$t2, 5($t0)
	sb	$t2, 6($t1)
	
	lb	$t2, 6($t0)
	sb	$t2, 7($t1)
	
	lb	$t2, 7($t0)
	sb	$t2, 8($t1)
	
	lb	$t2, 8($t0)
	sb	$t2, 9($t1)
	
	lb	$t2, 9($t0)
	sb	$t2, 10($t1)
	
#-------------------------------------------------------------

	lb	$t2, 10($t0)
	sb	$t2, 12($t1)

	lb	$t2, 11($t0)
	sb	$t2, 13($t1)
	
	lb	$t2, 12($t0)
	sb	$t2, 14($t1)
	
	lb	$t2, 13($t0)
	sb	$t2, 15($t1)
	
	lb	$t2, 14($t0)
	sb	$t2, 16($t1)
	
#-------------------------------------------------------------
	
	lb	$t2, 15($t0)
	sb	$t2, 18($t1)
	
	lb	$t2, 16($t0)
	sb	$t2, 19($t1)
	
	lb	$t2, 17($t0)
	sb	$t2, 20($t1)
	
	lb	$t2, 18($t0)
	sb	$t2, 21($t1)
	
	lb	$t2, 19($t0)
	sb	$t2, 22($t1)
	
#-------------------------------------------------------------

	lb	$t2, 20($t0)
	sb	$t2, 24($t1)
	
	lb	$t2, 21($t0)
	sb	$t2, 25($t1)
	
	lb	$t2, 22($t0)
	sb	$t2, 26($t1)
	
	lb	$t2, 23($t0)
	sb	$t2, 27($t1)
	
	lb	$t2, 24($t0)
	sb	$t2, 28($t1)
	

	lw	$t0, 0($sp)
	lw	$t1, 4($sp)
	lw	$t2, 8($sp)
	
	addi	$sp, $sp, 12
	
	jr	$ra
	
	
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------


cP1:
	addi	$sp, $sp, 16
	sw	$s0, 0($sp)
	sw	$t0, 4($sp)
	sw	$t1, 8($sp)
	sw	$t2, 12($sp)



	la	$s0, board
	li	$t0, 0
	li	$t1, 27
	add	$s0, $s0, $t0
while0:	beq	$t0, $t1, exitW0
	lb	$t2, 0($s0)
	bne	$t2, 88, exitIf0
	lb	$t2, 1($s0)
	bne	$t2, 88, exitIf0
	lb	$t2, 2($s0)
	bne	$t2, 88, exitIf0
	la	$a0, prmt4
	li	$v0, 4
	syscall
	j	LmE0
exitIf0:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j	while0
exitW0:	



	la	$s0, board
	li	$t0, 0
	li	$t1, 17
	add	$s0, $s0, $t0
while1:	beq	$t0, $t1, exitW1
	#addi	$s0, $s0, 1
	lb	$t2, 0($s0)
	bne	$t2, 88, exitIf1
	lb	$t2, 6($s0)
	bne	$t2, 88, exitIf1
	lb	$t2, 12($s0)
	bne	$t2, 88, exitIf1
	la	$a0, prmt4
	li	$v0, 4
	syscall
	j	LmE0
exitIf1:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	while1
exitW1:	
	
	
	la	$s0, board
	li	$t0, 0
	li	$t1, 15
	add	$s0, $s0, $t0
while2:	beq	$t0, $t1, exitW2
	#addi	$s0, $s0, 1
	lb	$t2, 0($s0)
	bne	$t2, 88, exitIf2
	lb	$t2, 7($s0)
	bne	$t2, 88, exitIf2
	lb	$t2, 14($s0)
	bne	$t2, 88, exitIf2
	la	$a0, prmt4
	li	$v0, 4
	syscall
	j	LmE0
exitIf2:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	while2
exitW2:
	
	
	la	$s0, board
	li	$t0, 2
	li	$t1, 17
	add	$s0, $s0, $t0
while3:	beq	$t0, $t1, exitW3
	lb	$t2, 0($s0)
	bne	$t2, 88, exitIf3
	lb	$t2, 5($s0)
	bne	$t2, 88, exitIf3
	lb	$t2, 10($s0)
	bne	$t2, 88, exitIf3
	la	$a0, prmt4
	li	$v0, 4
	syscall
	j	LmE0
exitIf3:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j	while3
exitW3:	

	lw	$s0, 0($sp)
	lw	$t0, 4($sp)
	lw	$t1, 8($sp)
	lw	$t2, 12($sp)
	
	addi	$sp, $sp, 16
	jr	$ra
	
	
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------


cP2:
	addi	$sp, $sp, 16
	sw	$s0, 0($sp)
	sw	$t0, 4($sp)
	sw	$t1, 8($sp)
	sw	$t2, 12($sp)



	la	$s0, board
	li	$t0, 0
	li	$t1, 27
	add	$s0, $s0, $t0
while4:	beq	$t0, $t1, exitW4
	lb	$t2, 0($s0)
	bne	$t2, 79, exitIf4
	lb	$t2, 1($s0)
	bne	$t2, 79, exitIf4
	lb	$t2, 2($s0)
	bne	$t2, 79, exitIf4
	la	$a0, prmt5
	li	$v0, 4
	syscall
	j	LmE0
exitIf4:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j	while4
exitW4:	



	la	$s0, board
	li	$t0, 0
	li	$t1, 17
	add	$s0, $s0, $t0
while5:	beq	$t0, $t1, exitW5
	#addi	$s0, $s0, 1
	lb	$t2, 0($s0)
	bne	$t2, 79, exitIf5
	lb	$t2, 6($s0)
	bne	$t2, 79, exitIf5
	lb	$t2, 12($s0)
	bne	$t2, 79, exitIf5
	la	$a0, prmt5
	li	$v0, 4
	syscall
	j	LmE0
exitIf5:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	while5
exitW5:	
	
	
	la	$s0, board
	li	$t0, 0
	li	$t1, 15
	add	$s0, $s0, $t0
while6:	beq	$t0, $t1, exitW6
	#addi	$s0, $s0, 1
	lb	$t2, 0($s0)
	bne	$t2, 79, exitIf6
	lb	$t2, 7($s0)
	bne	$t2, 79, exitIf6
	lb	$t2, 14($s0)
	bne	$t2, 79, exitIf6
	la	$a0, prmt5
	li	$v0, 4
	syscall
	j	LmE0
exitIf6:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	while6
exitW6:
	
	
	la	$s0, board
	li	$t0, 2
	li	$t1, 17
	add	$s0, $s0, $t0
while7:	beq	$t0, $t1, exitW7
	lb	$t2, 0($s0)
	bne	$t2, 79, exitIf7
	lb	$t2, 5($s0)
	bne	$t2, 79, exitIf7
	lb	$t2, 10($s0)
	bne	$t2, 79, exitIf7
	la	$a0, prmt5
	li	$v0, 4
	syscall
	j	LmE0
exitIf7:addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j	while7
exitW7:	

	lw	$s0, 0($sp)
	lw	$t0, 4($sp)
	lw	$t1, 8($sp)
	lw	$t2, 12($sp)
	
	addi	$sp, $sp, 16
	jr	$ra



#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
strcpy01:
	addi	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$t1, 8($sp)
	
	
	la	$s0, piece
	la	$s1, piece1
	
lsc0:	lb	$t0, 0($s0)
	beq	$t0, $0, lsc1
	sb	$t0, 0($s1)
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	j	lsc0
	
lsc1:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$t1, 8($sp)
	addi	$sp, $sp, 12
	
	jr	$ra


#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
strcpy02:
	addi	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$t1, 8($sp)
	
	
	la	$s0, piece
	la	$s1, piece2
	
lsc2:	lb	$t0, 0($s0)
	beq	$t0, $0, lsc3
	sb	$t0, 0($s1)
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	j	lsc2
	
lsc3:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$t1, 8($sp)
	addi	$sp, $sp, 12
	
	jr	$ra

#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
strcpy10:
	addi	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$t1, 8($sp)
	
	
	la	$s1, piece
	la	$s0, piece1
	
lsc4:	lb	$t0, 0($s0)
	beq	$t0, $0, lsc5
	sb	$t0, 0($s1)
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	j	lsc4
	
lsc5:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$t1, 8($sp)
	addi	$sp, $sp, 12
	
	jr	$ra
	
	
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
#-------------------------------------------------------------
strcpy20:
	addi	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$t1, 8($sp)
	
	
	la	$s1, piece
	la	$s0, piece2
	
lsc6:	lb	$t0, 0($s0)
	beq	$t0, $0, lsc7
	sb	$t0, 0($s1)
	addi	$s0, $s0, 1
	addi	$s1, $s1, 1
	j	lsc6
	
lsc7:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$t1, 8($sp)
	addi	$sp, $sp, 12
	
	jr	$ra
