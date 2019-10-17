	.data
prompt: .asciiz "Enter number: "
matchMessage: .asciiz "Ten!"

	.text
	.globl main
main: 
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
	
	beq $t1, 10, LequalTen
	b Lend
	
LequalTen:
	li $v0, 4
	la $a0, matchMessage
	syscall


Lend:
	jr $ra