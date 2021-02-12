.data
critical:  .byte 'c','s','d','j','m','b','k','p','m','b','k','p','m','b','k','p','m','b','k','p'
medium:    .byte 'm','b','k','p','a','s','d','j','m','b','k','p','m','b','k','p','m','b','k','p'
high:      .byte 'b','k','l','z','m','b','k','p','a','s','d','j','m','b','k','p','m','b','k','p'
low:       .byte 'm','j','o','p','b','k','p','a','s','d','j','m','b','k','p','m','b','k','p','m'
critical_size: .word 0 #counter 1=0
high_size: .word 0  #counter 2=0
medium_size: .word 0 #counter 3=0
low_size  : .word 0 #counter 4=0
nline: .asciiz"\n"
message: .asciiz      "array is deleted"
IfMessage:    .asciiz  "\nElement is not present in array\n"
ElseMessage:  .asciiz  "\nElement is present in array\n"
p1: .word 1 #priority 1
p2: .word 2 #priority 2
p3:.word 3   #priority 3
p4: .word 4  #priority 4
.text

main:
    li $s0,20 #critical size
    li $s1,20 #high size
    li $s2,20 #medium size
    li $s3,20 #low size   
    
    
    	la	$s6, critical		# Load address of array
	li	$s4, 'b'		# Load target value
	
	add 	$a0,$s6,$0 		# copy Array into argument register
	add	$a1,$s4,$0		# copy target into argument register
	jal	BinarySearch		# Calling BinarySearch function
	move 	$s3, $s7 		# copy result to variable x
	
	bne 	$s5, -1, Else 		# result != -1
	li      $v0, 4    		# 4 = print string
	la      $a0,IfMessage  		# $a0 = address of the array
	syscall		 		
Else:
	li      $v0,4      		# 4 = print string
	la      $a0,ElseMessage  	# $a0 = address of the array
	syscall	
#--------------------------------------------------------end of test binarysearch function
    lw $a0, p1 #priority
    jal delet_one_array #call function--------------     
    lw $a0, p2 #priority
    jal delet_one_array #call function--------------     
    lw $a0, p3 #priority
    jal delet_one_array #call function--------------     
    lw $a0, p4 #priority
    jal delet_one_array #call function--------------               
#-------------------------------------------------------------end test of calling delete 
    la  $a0, critical#load critical in argument a0
	jal process    #call function process

	la  $a0, high #load critical in argument a0
	jal process     #call function process
	
	la $a0, medium #load medium in argument a0
	jal process     #call function process
	
	la $a0, low  #load low in argument a0
	jal process   #call function process
	
	li  $v0,10     #termiate the program 
	syscall        #end of program (return 0)
    #----------------------------------------------------------------end test of calling process
	 jal empty_all_array #call function-------------- 
     #-------------------------------end test of call empty function
	
#----------------------------------------------------------------------------------------------------------(binary search function)
BinarySearch:
	addi $sp, $sp, -4
	sw $ra, 0($sp)   		# saves $ra on stack
	li $t1, 0 			# left = 0
	li $t2, 0 			# middle = 0
	subu $t3, $s2, 1 		# right = size - 1 
	li $t4, -1 			# elementindex = -1
whileLoop:
	ble $t1,$t3,exit1		# left <= right
	subu $t2, $t3, $t1 		# Mid = right - left
	srl $t2, $t2, 1 		# Mid = (right - left) / 2
	add $t2, $t2, $t1	 	# Mid = left + (right - left) / 2
	sll $t6, $t2, 2    		# index for Array[Mid]
        addu $s0, $0, $t6       	# point to mid
	lb  $s5, 0($s6)         	# s5 = A[rraymid]	
	bne $s5, $s4, notEqual 		# if ( Array[mid] == target)  IF not skip to notEqual	
	add $t4, $0, $t2 		# element_index = mid
	j exit1
	notEqual:
		slt $t5, $a0, $s4 	# is Array[mid] < target . IF yes, t5 = TRUE
		beqz $t5, notLess	# go to not less if $t5 == 0
		addi $t1, $t2, 1 	# left = mid + 1
		j pastnotLess		# go to pastnotLess
	notLess:	
		subi $t3, $t2, 1 	# right = mid - 1
	pastnotLess:
		j whileLoop		# END WHILE
exit1:
	move $s7, $t4 			#return of function               
	lw $ra, 0($sp)			#restore $ra from stack
	addi $sp, $sp, 4		#pop $sp by 4
	jr $ra				#return
	
#-----------------------------------------------------------------------------------------------(process function)
process: #function that print requests with specific priority 
	addi $sp, $sp, -4 #push $sp by 4
	sw   $ra, 0($sp)  # saves $ra (store previous value)on stack
	li   $t0, 0       #load immediately counter=0
	move $t2 , $a0    #move the argument a0 of the array to temporary register $t2

loop: #loop to print all char stored in array of specific priority
	beq $t0,20,exit #condition of loop(branch if value in $t0==20 to exit)

	
	lb $a0,0($t2) #load from the first index of array to $a0
	li $v0,11     #syscall 11 is printchar
	syscall       #print on screen

	li $v0, 4     #print string
	la $a0, nline #load nline(\n) in $a0
	syscall       #print new line on screen

	addi $t0,$t0,1 #increment $t0 (counter++)
	addi $t2,$t2,1 #increment to move to the next index in array

	j loop #jump to loop

exit: #exit of loop 
	lw $ra, 0($sp)     #restore $ra from stack
	addi $sp, $sp, 4   #pop $sp by 4
	jr $ra             #return (returns control to the caller)
#-------------------------------------------------------------------------------------------------------------(empty function)
empty_all_array:

    li $s0,0 #size $s0=0
    li $s1,0 #size $s1=0
    li $s2,0 #size $s2=0
    li $s3,0 #size $s3=0
    jr $ra  #return 
#-----------------------------------------------------------------------------------------------------------(delete-function) 
delet_one_array:
    li $t1,1 #load priority =1
    bne $a0,$t1,second #if a0==t1
    li $s0,0 #load s0=0
    jr  $ra #return
second: #else if
    addi $t1,$t1,1 # priority++
    bne $a0,$t1,third #if a0==t1
    li $s1,0   #load s1=0
    jr  $ra   #return
third:
    addi $t1,$t1,1 # priority++
    bne $a0,$t1,forth #if a0==t1
    li $s2,0  #load s2=0
    jr  $ra  #return
forth:
    li $s3,0  #load s3=0
    jr  $ra  #return      
#------------------------------------------------------------------------------------------------------------------------------------
