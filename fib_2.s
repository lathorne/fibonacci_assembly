.org 0

Main:
	ori $a0, $zero, 10 # put 10 in a0
	addi $sp, $zero, 1ffcH
	addi $fp, $zero, 1ffcH

	jal Fib
	add $t0, $zero, $v0 #move t0 to a0
	j Done 

Fib:
	addi $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	sw $a0, 0($fp)

	#********************* base case *****************
	lw $t0,0($fp)       	# Load n into $t0
	ori $v0,$zero, 0            	# Save 0 into return value register
	beq $t0,$zero,L1   	# if (n == 0) return 0;
	
	ori $v0,$zero,1        	#load 1 into return value register
	beq $t0, $v0, L1   	#if (n == 1) return 1;
	
	#***************recursive start **************
	#calculate n-1
	addi $a0, $t0, -1      	#put n-1 into $a0
	jal Fib                                   	#call fib(n-1)
	move $s0, $v0                    	#get return value of fib(n-1)
	sw $s0,12($sp)                  	#return value to the stack
	
	lw $t0,0($fp)   	# Load n into $t0
	#calculate n-2
	addi $a0, $t0, -2     	#put n-2 into $a0
	jal Fib                 #call fib(n-2)
	
	lw $a0, 12($sp)
	add $v0, $a0, $v0 #put fib(n-1) + fib(n-2) into $v0
	j L1                        	#return
                    	
 
L1:             	            	# Result is in $v0
	lw $ra, 20($sp)     	# Restore $ra
	lw $fp, 16($sp)    	 # Restore $fp
	addi $sp, $sp, 32  	# Pop stack
	jr $ra              	# Return to caller

Done:
	j Done

.org 1024
Data: