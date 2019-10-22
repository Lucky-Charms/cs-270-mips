	.data
array: .word 5 -5 10 3 -7
array_size: .word 5

	.text
	.globl main
main:
	lw $s0, array_size #Array Size is stored into register s0
	la $s1, array         # put address of list into $s1
   	li $t0, 0          # This is like the int i = 0 
   	li $t1, 0 # Total
  
LforLoop:
	beq $t0, $s0, Lend
	lb $s2, ($s1)
	#bltz $s2, Labs
	abs $s2, $s2
	add $t1, $t1, $s2
	
	addi $s1, $s1, 4 
	addi $t0, $t0, 1
	b LforLoop
	
Lend:
	li $v0, 1
	move $a0, $t1
	syscall
	
	jr $ra