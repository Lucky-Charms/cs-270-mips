	.text
	.globl main
main:
	subi $sp, $sp, 20
	sw $ra, 16($sp)
	li $a0, -3
	jal times_two_plus_one
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra

times_two_plus_one:
	subi $sp, $sp, 20
	sw $ra, 16($sp)
	
	jal multiply_by_two
	move $a0, $v0
	jal add_one
	
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra


multiply_by_two:
	sll $v0, $a0, 1
	jr $ra



add_one:
	addi $v0, $a0, 1
	jr $ra