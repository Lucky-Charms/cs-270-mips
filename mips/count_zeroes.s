	.data
array: .word 3, 0, 1, 0, 6, -2, 4, 7, 0, 7
array_size: .word 10
index: .word 0

	.text
	.globl main
main:
	lw $s0, array_size #Array Size is stored into register s0
	la $s1, array         # put address of list into $t3
   	li $t0, 0          # This is like the int i = 0 
   	li $t2, 0 	#Zero Counter
  	#li $v0, 1 #instruction to print 
LforLoop:
	beq $t0, $s0, Lend 
	lb $s2, ($s1)
	
	beqz $s2 Lmatch
	b LincrementLoop
	#move $a0, $s2
	#syscall
Lmatch:
	addi $t2, $t2, 1
	b LincrementLoop

LincrementLoop:
	addi $s1, $s1, 4
	addi $t0, $t0, 1 #increment your 1
	b LforLoop


Lend:
	li $v0, 1
	move $a0, $t2
	syscall

	jr $ra
 
