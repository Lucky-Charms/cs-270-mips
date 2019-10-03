	.data
a:	.word 7
b:	.word -3
c:	.word 0


	.text
	.globl main
main:

	lw $t0, a
	lw $t1, b
	
	add $t2, $t0, $t1
	
	sw $t2, c
	
	jr $ra