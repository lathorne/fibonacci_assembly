# creating MIPS rpt

# Loop:
# 	line to decrement specified register
# 	branch if less than or equal to 0
# 	j Loop

.org 0

Main:
	ori 4,0,10 #set n value and 1 in another register
	ori 1,0,1
	addi $sp, $zero, 1ffcH #set stack and frame pointers
	addi $fp, $zero, 1ffcH
	jal Fib

#n in $a0, for n<=1 to return
Fib: #do without a stack frame if possible, base case
	bne 4, 1, Fib_recurse
	move 2, 4 #put a0 return value in v0
	jr 31 #end of base case

End:
	j End	

Fib_recurse:
	addi 29, 29, -12 #3*4 = 12 because 3 things are stored on the stack
	sw 31, 0($sp) #save $ra in 0($sp)

	sw 4, 4($sp) #save n to a different slot in the stack
	addi 4, 4, -1 #n-1
	jal Fib #recursive call

	#restore values after call
	lw 4, 4($sp) #restore n
	sw 2, 8($sp) #save return val fom fib(n-1)

	#moving on to second call
	addi 4, 4, -2 #n-2
	jal Fib #recursive call

	#restore registers after second call
	lw 8, 8(29)
	add 2, 2, 8 #return value after both calls

	#deallocate the stack frame and return
	lw 31, 0(29)	#restore ra
	addi 29, 29, 12 #tear down the stack frame
	jr 31

#changed $ra to $31
#changed $sp to $29
#changed $a0 to $4
#changed $v0 to $2
#changed $t0 to $8

.org 1024
Data:

	# 4
	# fib(3) + fib(2)
	# fib(2) + fib(1) + fib(1) + fib(0)
	# fib(1) + fib(0) + 1 + 1 + 0 = 3

	# fib(3) + fib(2)
	# fib(2) + fib(1)


	#0 + 1 + 1 + 2 + 3 + 5 + 8 + 13 + 21 + 34 = 