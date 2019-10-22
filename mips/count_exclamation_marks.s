	.data
searchChar: .byte '!'
sentence: .asciiz "Hello!!!World!!!"

	.text
	.globl main
main:
	lb $t0, searchChar #loading char we are looking for which is exclamation point
	li $t1, 0 # Counter 
	la $s0, sentence # set pointer to sentence[0]
	lb $s1, ($s0) # loads sentence[0] insto s1

LforLoop:
	beq $s1, $zero, Lend # check for null char
	beq $s1, $t0, Lmatch
	b LincrementLoop

	
	
Lmatch:
	addi $t1, $t1, 1 #increment the found
	b LincrementLoop
	
LincrementLoop:
	addi $s0, $s0, 1
	lb $s1, ($s0)
	b LforLoop

Lend:
	li $v0, 1
	move $a0, $t1
	syscall
	
	jr $ra