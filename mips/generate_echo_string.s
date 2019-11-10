.include "./util.s"

		.data
prefix: .asciiz "You typed: "
prompt: .asciiz "Enter a string: "
string_to_modify: .space 40
	.align 2
	
	.text
	.globl main
main:
	subi $sp, $sp, 20
	sw $ra, 16($sp)
	
	la $a0, string_to_modify
	li $a1, 40
	
	jal generate_echo_string
	
	
	
	lw $ra, 16($sp)
	addi $sp, $sp 20
	jr $ra

generate_echo_string:
	subi $sp, $sp, 32
	sw $ra, 28($sp)
	sw $a0, 24($sp) #string_to_modify
	sw $a1, 20($sp) #max_bytes
	
	la $t0, 24($sp)
	addi $t1, $a1, -1
	add $t0, $t0, $t1 # move to the last index
	sw $zero, ($t0) #string_to_modify[maxbyte - 1] = '\0'
	
	la $a0, prefix
	jal strlen
	sw $v0, 16($sp) #prefix_length
	
	.include "./util.s"

		.data
prefix: .asciiz "You typed: "
prompt: .asciiz "Enter a string: "
string_to_modify: .space 40
	.align 2
	
	.text
	.globl main
main:
	subi $sp, $sp, 20
	sw $ra, 16($sp)
	
	la $a0, string_to_modify
	li $a1, 40
	
	jal generate_echo_string
	
	
	
	lw $ra, 16($sp)
	addi $sp, $sp 20
	jr $ra

generate_echo_string:
	subi $sp, $sp, 32
	sw $ra, 28($sp)
	sw $a0, 24($sp) #string_to_modify
	sw $a1, 20($sp) #max_bytes
	
	la $t0, 24($sp)
	addi $t1, $a1, -1
	add $t0, $t0, $t1 # move to the last index
	sw $zero, ($t0) #string_to_modify[maxbyte - 1] = '\0'
	
	la $a0, prefix
	jal strlen
	sw $v0, 16($sp) #prefix_length
	
	la $a0, 24($sp)
	la $a1, prefix
	lw $a2, 20($sp)
	addi $a2, $a2, -1
	jal strncpy #Bug here. Return address gets overwritten by this function because the max_bytes increments the address of the stackpoint which messes with the return address.
	
	lw $t0, 16($sp)
	lw $t1, 20($sp)
	bge $t0, $t1, Lend
	
	la $a0, prompt
	lw $t2, 16($sp)
	lw $a1, 24($sp)
	add $a1, $a1, $t2
	lw $a2, 20($sp)
	sub $a2, $a2, $t2
	jal InputConsoleString	

Lend:
	# Do Nothing
	lw $ra, 28($sp)
	addi $sp, $sp, 32
	jr $ra
	


	
	lw $t0, 16($sp)
	lw $t1, 20($sp)
	bge $t0, $t1, Lend
	
	la $a0, prompt
	lw $t2, 16($sp)
	lw $a1, 24($sp)
	add $a1, $a1, $t2
	lw $a2, 20($sp)
	sub $a2, $a2, $t2
	jal InputConsoleString	

Lend:
	# Do Nothing
	lw $ra, 28($sp)
	addi $sp, $sp, 32
	jr $ra
	
