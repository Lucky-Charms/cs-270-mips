	.data
prompt:	.asciiz "Enter number: "


	.text
	.globl main

main:

li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall
move $s0, $v0

li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall
move $s1, $v0

add $t1, $s0, $s1

li $v0, 1
move $a0, $t1
syscall

jr $ra

