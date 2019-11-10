.include "./util.s"

	.data
my_string: .space 40
prompt: .asciiz "Enter a hexadecimal number: "
error: .asciiz "Invalid hexadecimal number.\n"
	.align 2
	
	.text
	.globl main
main:
	#prepare stack pointer
	subi $sp, $sp, 32
	sw $ra, 28($sp)
	sw $s0, 24($sp)
	sw $s1, 20($sp)
	li $s0, 1
	li $s1, 1
Lbegin:
	bne $s0, $s1, Lend
	la $a0, prompt
	la $a1, my_string
	li $a2, 40
	jal InputConsoleString

	la $a0, 16($sp) #&result
	la $a1, my_string
	jal axtoi
	
	li $t0, 0
	bne $v0, $t0, LfinishWhile
	
	la $a0, error
	jal PrintString

	b Lbegin

LfinishWhile:
	lw $a0, 16($sp)
	jal PrintInteger

Lend:
	li $v0, 0
	#return stack pointer
	lw $ra, 28($sp)
	lw $s0, 24($sp)
	lw $s1, 20($sp)
	addi $sp, $sp, 32
	jr $ra