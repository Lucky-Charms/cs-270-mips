	.data
a: .word 1
b: .word 2
c: .word 4
d: .word 8

	.text
	.globl main
main:
	lw $t0, a
	lw $t1, b
	lw $t2, c
	lw $t3, d
	
	li $v0, 4
	la $t0, a
	syscall
	
	