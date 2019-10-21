	.data
prompt: .asciiz "Enter number: "
i: .word 0

	.text
	.globl main

main:
	lw $t1, i

	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 
	
LbeginLoop:
	
	bgt $t1, $t0, LendLoop
	
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	addi $t1, $t1, 1
	
	b LbeginLoop
	
LendLoop:
	jr $ra
