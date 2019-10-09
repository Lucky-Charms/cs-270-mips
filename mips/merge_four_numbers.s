	.data
a: 	.word 1
b:	.word 2
c:	.word 4
d: 	.word 8

	.text
	.globl main
	
main:

lw $t0, a
sll $t0, $t0, 24
lw $t1, b
sll $t1, $t1, 16
lw $t2, c
sll $t2, $t2, 8
lw $t3, d

or $a0, $t0, $t1
or $a0, $a0, $t2
or $a0, $a0, $t3

li $v0, 1
syscall