	.include "./util.s"
	
#Problem: Given a string add ** to the beginnign and end for example: Input: hello Output: **hello**
	.data
user_string: .asciiz "fsfdsadsdad"
prompt: .asciiz "Enter a string: "
stars: .asciiz "**"

	.align 2
		
	.text
	.globl main

main:
	subi $sp, $sp, 20
	sw $ra, 16($sp)
	
	#jal InputConsoleString #Retrieve user input
	
	la $a0, user_string
	jal print_with_stars
	
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
	#Adjust the String by doing something like string a = "**" + user_input + "**"
	
	
print_with_stars:
	subi $sp, $sp, 60
	sw $ra, 56($sp)
	sw $a0, 60($sp) #store into parent stack frame
	
	la $a0, 16($sp) #points into final[0].
	la $a1, stars
	li $a2, 2
	jal strncpy

	la $a0, 18($sp)
	#addi $a0, $a0, 2
	lw $a1, 60($sp) #if we use la then it would be the address of an address. Thus, we must use lw because we need to interact with your RAM.
	li $a2, 35
	jal strncpy
	
	sb $zero, 53($sp) # set final[37] = "\0" because 16 + 37 = 53
	
	la $a0, 16($sp)
	jal strlen # $v0 contains the length
	
	la $a0, 16($sp)
	add $a0, $a0, $v0
	la $a1, stars
	li $a2, 3
	jal strncpy

	
	la $a0, 16($sp)
	jal PrintString
	
	lw $ra, 56($sp)
	addi $sp, $sp, 60
	jr $ra
	
	
		

	

	
	
	
	
	
	
	
	
	
