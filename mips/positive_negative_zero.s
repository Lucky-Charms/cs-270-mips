	.data
prompt: .asciiz "Enter number: "
positive: .asciiz "positive"
negative: .asciiz "negative"
zero: .asciiz "zero"

	.text
	.globl main

main:


	li $v0, 4
	la $a0, prompt
	syscall
	
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	beqz $t2 LequalToZero
	
	bge $t2, 1, Lpositive
	
	ble $t2, -1, Lnegative
	
	b Lend

LequalToZero:
	li $v0, 4
	la $a0, zero
	syscall
	
	b Lend

Lpositive:
	li $v0, 4
	la $a0, positive
	syscall
	b Lend

Lnegative:
	li $v0,4 
	la $a0, negative
	syscall
	
	b Lend


Lend:
	jr $ra
	
	