    .data
min:       .word 1
max:       .word 10
num:       .word 8     # I'd recommend trying different values
                       # for this variable when testing.
msgintro:  .asciiz "Guess must be a hexadecimal number between "
msgand:    .asciiz " and "
msgend:    .asciiz "\nEnter your guess (or nothing to quit).\n"
msgnl:     .asciiz "\n"
msgwin:    .asciiz "Got it!"
msghigh:   .asciiz "Guess is too high."
msglow:    .asciiz "Guess is too low."
    .text
    .globl main
main:
    ##################
    # YOUR CODE HERE #
    ##################

    # Step 1: Build prompt.
   subi $sp, $sp, 40
   sw $ra, 36($sp)

   #32 stores the prompt
   #16 stores the buffer
   lw $a0, min
   la $a1, 16($sp)
   jal itoax
   
   la $a0, msgintro
   la $a1, 16($sp)
   jal strdup2
   
    move $a0, $v0
   la $a1, msgand
   jal strdup2

   sw $v0, 32($sp) #saves prompt into register.
   
   lw $a0, max
   la $a1, 16($sp)
   jal itoax
   
   lw $a0, 32($sp) #retreive prompt
   la $a1, 16($sp) #buffer
   jal strdup2

   move $a0, $v0
   la $a1, msgend
   jal strdup2
   sw $v0, 32($sp)
   

    # Step 2: Repeatedly use GetGuess to get a guess
    # from the user and report if it is too high, too
    # low, or correct.
.LguessLoop:
    li $t0, 1
    li $t1, 1
    bne $t0, $t1, .Lend
    
    lw $a0, 32($sp)
    lw $a1, min
    lw $a2, max
    jal GetGuess
    
    li $t2, -1 
    beq $v0, $t2, .LMainEnd
    lw $t3, num
    beq $v0, $t3, .LcorrectGuess
    bgt $v0, $t3, .LgreaterThanGuess
    blt $v0, $t3, .LlessThanGuess
        
    
.LgreaterThanGuess:
    la $a0, msghigh
    jal PrintString
    b .LguessLoop

.LlessThanGuess:
    la $a0, msglow
    jal PrintString
    b .LguessLoop   

.LcorrectGuess:
  la $a0, msgwin
  jal PrintString

.LMainEnd:
	lw $ra, 36($sp)
	addi $sp, $sp, 40
	jr $ra
	
################################
# GetGuess
################################
    .data
invalid:    .asciiz "Not a valid hexadecimal number"
badrange:   .asciiz "Guess not in range"
    .text
    .globl  GetGuess
# 
# int GetGuess(char * question, int min, int max)
# -----
# This is your function from assignment 5. It repeatedly
# asks the user for a guess until the guess is a valid
# hexadecimal number between min and max.
GetGuess:
    
    ###################################
    # YOUR CODE FROM ASMT 5 HERE      #
    ###################################    
	subi $sp, $sp, 40
	sw $ra 36($sp)
	#the guess is at 32
	#the bytes_read at register
	#buffer at 16
	sw $a1, 40($sp) #min
	sw $a2, 44($sp) #max
	sw $a0, 48($sp) #question
	
.LgetGuessBegin:
	li $t0, 1
	li $t1, 1
	bne $t0, $t1, .Lend #while true
	
	#question already in $a0
	lw $a0, 48($sp)
	la $a1, 16($sp)
	li $a2, 16
	jal InputConsoleString #bytes_read in $v0
	
.LbytesReadEqualZero: #if (bytes_read == 0 return 1
	li $t2, 0
	beq $v0, $t2, .LbytesEqualZero
	
	la $a0, 32($sp) #&theguess
	la $a1, 16($sp) #buffer
	
	jal axtoi
	
.LstatusNotEqualOne:
	li $t2, 0
	beq $v0, $t2, .LinvalidHex
	
.LcheckGuess:
	lw $t0, 40($sp)#min
	lw $t1, 44($sp)#max
	lw $t2, 32($sp)
	
	blt $t2, $t0, .LincorrectGuess
	bgt $t2, $t1, .LincorrectGuess
	
	move $v0,$t2 #return theguess
	b .Lend
	
.LincorrectGuess:
	la $a0, badrange
	jal PrintString
	b .LgetGuessBegin #continue;

.LinvalidHex:
	la $a0, invalid
	jal PrintString
	b .LgetGuessBegin #continue

.LbytesEqualZero:
	li $v0, -1

.Lend:
	lw $ra, 36($sp)
	addi $sp, $sp, 40
	jr $ra

###################################
#     OTHER HELPER FUNCTIONS      #
###################################

#
# char * strdup2 (char * str1, char * str2)
# -----
# strdup2 takes two strings, allocates new space big enough to hold 
# of them concatenated (str1 followed by str2), then copies each 
# string to the new space and returns a pointer to the result.
#
# strdup2 assumes neither str1 no str2 is NULL AND that malloc
# returns a valid pointer.
    .globl  strdup2
strdup2:
    # $ra   at 28($sp)
    # len1  at 24($sp)
    # len2  at 20($sp)
    # new   at 16($sp)
    sub     $sp,$sp,32
    sw      $ra,28($sp)
    
    # save $a0,$a1
    # str1  at 32($sp)
    # str2  at 36($sp)
    sw      $a0,32($sp)
    sw      $a1,36($sp)
    
    # get the lengths of each string 
    jal     strlen
    sw      $v0,24($sp)

    lw      $a0,36($sp)
    jal     strlen
    sw      $v0,20($sp)

    # allocate space for the new concatenated string 
    add     $a0,$v0,1
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    jal     malloc
    
    sw      $v0,16($sp)

    # copy each to the new area 
    move    $a0,$v0
    lw      $a1,32($sp)
    jal     strcpy

    lw      $a0,16($sp)
    lw      $t0,24($sp)
    add     $a0,$a0,$t0
    lw      $a1,36($sp)
    jal     strcpy

    # return the new string
    lw      $v0,16($sp)
    lw      $ra,28($sp)
    add     $sp,$sp,32
    jr      $ra

    .include  "./util.s"
