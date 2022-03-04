	.globl main 

	.text 		

# The label 'main' represents the starting point
main:
	addiu $s0,$zero,0 # uint32_t n1
	addiu $s1,$zero,0 # uint32_t n2
	li $s2, 0 # i = 0
	li $t0, 10 # storing constant value 10 or $t0 = 10
	
	for: bge $s2, $t0, exitfor # exit condition
	
	     addi $sp, $sp, -4 # adjusting stack pointer
	     sw $t0, 0($sp) # saving $t0 register
	     
	     li $a0, 1 # $a0 = 1, first argument 
	     li $a1, 10000 # $a1 = 10000, second argument
	     
	     addi $sp, $sp, -4 # adjusting stack pointer
	     sw $a0, 0($sp) # saving $a0 register prior to function call
	     
	     addi $sp, $sp, -4 # adjusting stack pointer
	     sw $a1, 0($sp) # saving $a1 register prior to function call
	        
	     jal random_in_range # 1st function call
	     move $s0, $v0 # gets returned value stored in $s0 or n1 = returned value from the function call.
	     
	     lw $a1, 0($sp) # restore second argument 
	     addi $sp, $sp, 4 # adjusting stack pointer
	     lw $a0, 0($sp) # restore first argument 
	     addi $sp, $sp, 4 # adjusting stack pointer
	     
	     jal random_in_range # 2nd function call
	     move $s1, $v0 # gets returned value stored in $s1 or n2 = returned value from the function call.
	     
	     addiu $a0, $s0,0 # $a0 = n1
	     addiu $a1, $s1,0 # $a1 = n2
	     
	     jal gcd # function call
	     move $s3, $v0 # storing final result from gcd() function call
	     
	     # printing string 
	     li $v0, 4
	     la $a0, msg  
	     syscall
	     
	     # printing n1
	     li $v0, 1
	     move $a0, $s0
	     syscall
	     
	     # printing string 'and'
	     li $v0, 4
	     la $a0, msg1
	     syscall
	     
	     # printing n2
	     li $v0, 1
	     move $a0, $s1
	     syscall
	     
	     # printing string 'is'
	     li $v0, 4
	     la $a0 msg2 
	     syscall
	     
	     # printing gcd or final result
	     li $v0, 1
	     move $a0, $s3
	     syscall
	     
	     lw $t0, 0($sp) # restoring 10 stored in $t0 register
	     addi $sp, $sp, 4 # adjusting stack pointer
	     
	     addi $s2, $s2, 1 # i++
	     j for 
	     
	
	exitfor:
		
	li $v0, 10 # Sets $v0 to "10" to select exit syscall
	syscall # Exit


# gcd function goes here
gcd:
	# push s.regs used by the caller, main
	addi $sp, $sp, -4 #adjusting stack pointer
	sw $s0, 0($sp) # storing $s0 
	
	addi $sp, $sp, -4 #adjusting stack pointer
	sw $s1, 0($sp) # storing $s1
	
	addi $sp, $sp, -4 #adjusting stack pointer
	sw $s2, 0($sp) # storing $s2
	
	addi $sp, $sp, -4 #adjusting stack pointer
	sw $ra, 0($sp) # storing $ra or return address
	
	#function stuff
	move $s0, $a0 # n1 = $s0
	move $s1, $a1 # n2 = $s1
	
	if: beq $s1, $zero, else
	    divu $s0, $s1 # n1 % n2 or $s0 % $s1
	    move $a0,$s1 # $a0 = n2 # first argument
	    mfhi $a1 # second argument holding remainder
	    jal gcd 
	    # Popping stack and restoring saved values in the stack
	   	lw $ra, 0($sp) # restoring return address 
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s2, 0($sp) # restoring $s2
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s1, 0($sp) # restoring $s1
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   	
	   	lw $s0, 0($sp) # restoring $s0
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   	
	   	jr $ra
	
	else:
	 	move $v0, $s0
	 	# Popping stack and restoring saved values in the stack
	   	lw $ra, 0($sp) # restoring return address 
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s2, 0($sp) # restoring $s2
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s1, 0($sp) # restoring $s1
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   	
	   	lw $s0, 0($sp) # restoring $s0
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   	 
	 	jr $ra
	
	


#random_in_range function goes here.
random_in_range:
		# push s.regs used by the caller, main
		addi $sp, $sp, -4 #adjusting stack pointer
		sw $s0, 0($sp) # storing $s0 
		
		addi $sp, $sp, -4 #adjusting stack pointer
		sw $s1, 0($sp) # storing $s1
		
		addi $sp, $sp, -4 #adjusting stack pointer
		sw $s2, 0($sp) # storing $s2
		
		addi $sp, $sp, -4 #adjusting stack pointer
		sw $ra, 0($sp) # storing $ra or return address
		
		#function stuff starts here
		addiu $s0,$a0,0 # uint32_t low
		addiu $s1,$a1,0 # uint32_t high
		
		subu $s2, $s1, $s0 # high - low
		addiu $t0, $s2, 1 # range = high - low + 1
		
		addi $sp, $sp, -4 #adjusting stack pointer
		sw $t0, 0($sp) # storing $t0 = range
		
		jal get_random # function call
		move $s3, $v0 # rand_num = get_random()
		
		lw $t0, 0($sp) # restoring range
		addi, $sp, $sp, 4 # adjusting stack pointer
		
		divu $s3, $t0 # rand_num % range
		mfhi $v0  # storing remainder in $v0
		addu $v0, $v0, $s0 # (rand_num % range) + low
		
		# Popping stack and restoring saved values in the stack
	   	lw $ra, 0($sp) # restoring return address 
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s2, 0($sp) # restoring $s2
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   
	   	lw $s1, 0($sp) # restoring $s1
	   	addi $sp, $sp, 4 # adjusting stack pointer
	   	
	   	lw $s0, 0($sp) # restoring $s0
	   	addi $sp, $sp, 4 # adjusting stack pointer
		
		# return from function
	   	jr $ra  # Jump to addr stored in $ra
		
		
		
# get_random function goes here.	
get_random:
	   # push s.regs used by the caller, random_in_range 
	   addi $sp, $sp, -4 #adjusting stack pointer
	   sw $s0, 0($sp) # storing $s0 
	
	   addi $sp, $sp, -4 #adjusting stack pointer
	   sw $s1, 0($sp) # storing $s1
	
	   addi $sp, $sp, -4 #adjusting stack pointer
	   sw $s2, 0($sp) # storing $s2
	
	   addi $sp, $sp, -4 #adjusting stack pointer
	   sw $ra, 0($sp) # storing $ra or return address
	   
	   # function stuff starts here	
	   lw $t0, m_w # m_w = 50000
	   lw $t1, m_z # m_z = 60000
	 
	   andi $t2, $t1, 65535 # (m_z & 65535) 
	   srl $t3, $t1, 16 # (m_z >> 16)
	   
	   li $t4, 36969 
	   mul $t5, $t4, $t2 # 36969 * (m_z & 65535) 
	   addu $t1,$t5, $t3 # 36969 * (m_z & 65535) + (m_z >> 16)
	   sw $t1, m_z # storing in memory the updated m_z
	   
	   andi $t6, $t0, 65535 # (m_w & 65535)
	   srl $t7, $t0, 16 # (m_w >> 16)
	   
	   li $t8, 18000
	   mul $t9, $t8, $t6 # 18000 * (m_w & 65535)
   	   addu $t0, $t9, $t7 # 18000 * (m_w & 65535) + (m_w >> 16)
   	   sw $t0, m_w # storing in memory the updated m_w
   	   
   	   sll $s0, $t1, 16 # (m_z << 16)
   	   addu $s1, $s0, $t0 # (m_z << 16) + m_w 
   	   # $s1 holds the final result
   	   # saving the final result in $v0
   	   move $v0, $s1
	   
	   # Popping stack and restoring saved values in the stack
	   lw $ra, 0($sp) # restoring return address 
	   addi $sp, $sp, 4 # adjusting stack pointer
	   
	   lw $s2, 0($sp) # restoring $s2
	   addi $sp, $sp, 4 # adjusting stack pointer
	   
	   lw $s1, 0($sp) # restoring $s1
	   addi $sp, $sp, 4 # adjusting stack pointer
	   	
	   lw $s0, 0($sp) # restoring $s0
	   addi $sp, $sp, 4 # adjusting stack pointer

	   # return from function
	   jr $ra  # Jump to addr stored in $ra


	# All memory structures are placed after the
	# .data assembler directive
	.data
	msg:	.asciiz "\n G.C.D of "
	msg1:	.asciiz " and "
	msg2:	.asciiz " is "
	m_w:	.word 50000
	m_z:	.word 60000

