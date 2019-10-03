	.data
x:	.word 4
y: 	.word 4
z:	.word 0

	.text
	.globl main
	
main:
	lw $t0, x
	lw $t1, y
	add $t2, $t0, $t1
	sw $t2, z #store sum into z
	
	li $v0, 1 # System Call for print int
	move $a0, $t2
	syscall
	
	jr $ra