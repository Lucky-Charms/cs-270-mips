#######################
# guess.s
# -------
# This program asks the user to enter a guess. It
# reprompts if the user's entry is either an invalid
# hexadecimal number or a valid hexadecimal number
# that is outside the range specified in the program
# by min and max.
#
	.data
min:        .word   1
max:        .word   10
msgguess:   .asciiz "Make a guess.\n"
msgnewline: .asciiz "\n"
	.text
	.globl main
main:
	# Make space for arguments and saved return address
	subi  $sp, $sp, 20
	sw    $ra,16($sp)

	# Get the guess
	la    $a0, msgguess
    lw    $a1, min
    lw    $a2, max
    jal   GetGuess
    
    # Print the guess
    move  $a0, $v0
    jal   PrintInteger
    
    # Print a newline character
    la    $a0, msgnewline
    jal   PrintString
    
    # Return
    lw    $ra, 16($sp)
    addi  $sp, $sp, 20
    jr    $ra

################################
# GetGuess
################################

    .data
invalid:    .asciiz "Not a valid hexadecimal number.\n"
badrange:   .asciiz "Guess not in range.\n"
    .text
    .globl  GetGuess
# 
# C code:
#
# int GetGuess(char * question, int min, int max)
# {
#     // Local variables
#     int theguess;      // Store this on the stack
#     int bytes_read;    // You can just keep this one in a register
#     int status;        // This can also be kept in a register
#     char buffer[16];   // This is 16 contiguous bytes on the stack
#
#     // Loop
#     while (true)
#     {
#         // Print prompt, get string (NOTE: You must pass the
#         // address of the beginning of the character array
#         // buffer as the second argument!)
#         bytes_read = InputConsoleString(question, buffer, 16);
#         if (bytes_read == 0) return -1;
#
#         // Ok, we successfully got a string. Now, give it
#         // to axtoi, which, if successful, will put the
#         // int equivalent in theguess. 
#         //
#         // Here, you must pass the address of theguess as
#         // the first argument, and the address of the
#         // beginning of buffer as the second argument.
#         status = axtoi(&theguess, buffer);
#         if (status != 1)
#         {
#             PrintString(invalid);  // invalid is a global
#             continue;
#         }
#
#         // Now we know we got a valid hexadecimal number, and the
#         // int equivalent is in theguess. Check it against min and
#         // max to make sure it's in the right range.
#         if (theguess < min || theguess > max)
#         {
#             PrintString(badrange); // badrange is a global
#             continue;
#         }
#
#         return theguess;
#     }
# }
#     
#
GetGuess:
    # stack frame must contain $ra (4 bytes)
    # plus room for theguess (int) (4 bytes)
    # plus room for a 16-byte string
    # plus room for arguments (16)
    # total: 40 bytes
    #  16 byte buffer is at 16($sp)
    #  theguess is at 32($sp)
    #

	#######################
	# YOUR CODE HERE      #
	#######################
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
    
    .include  "./util.s"
