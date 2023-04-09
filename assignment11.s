###########################################################
# Assignment #: 11
#  Name: Abdulelah Bin Morebah
#  ASU email: abinmore@asu.edu
#  Course: CSE/EEE230, M W 3:00pm
#  Description: This program takes to set of numbers from user then
#				create two arrays and swap 5 between them.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
                            .data  
prompt1: 	.asciiz "Specify how many numbers should be stored in the array (at most 11):\n" 
	 						#create a string containing "Specify how many numbers should be stored in the array (at most 11):\n"
prompt2: 	.asciiz "Enter a number:\n" 		#create a string containing "Enter a number:\n" 
arr1: 		.asciiz "First Array:\n" 		#create a string containing "First Array:\n"
arr1R:		.asciiz "First Array Content:\n" 	#create a string containing "First Array Content:\n"
arr2:		.asciiz "Second Array:\n" 		#create a string containing "Second Array:\n" 
arr2R:		.asciiz	"Second Array Content:\n"	#create a string containing "Second Array Content:\n" 
newLine:	.asciiz "\n" 				#create a string containing "\n" 
swappedPairs:	.asciiz " pair(s) of numbers are swapped\n " #create a string containing " pair(s) of numbers are swapped\n "
resultArr1:	.asciiz "First Array Result Content:\n" #create a string containing "First Array Result Content:\n"
resultArr2:	.asciiz "Second Array Result Content:\n"#create a string containing "Second Array Result Content:\n"

lowest:		.float	 -10.00 			  #create a float with value -10.00.
highest:	.float	  10.00			  	  #create a float with value 10.00.
numbers_len:    .word     11				  #create an integer with value 11	
arrOne:     	.word 	  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #create an array of integers
arrTwo:		.word     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 #create an array of integers



#program code is contained below under .text
                        .text
                        .globl    main  #define a global function main

# the program begins execution at main()

############################################################################
# Procedure/Function main
# Description: This main function takes the user's inputs and check the values if
#			it at most 11 or not
# parameters: $s4 = size of array, $s5 = arrOne, $s6 = arrTwo, $f1 = -10.00
#			  $f2 = 10.00, $t5 = iterator, $t6 = iterator, $t4 = 11.
# return value: $v4 = prompt1, $v5 = inputs from user.
# registers to be used: $s4, $s5, $s6, $t5, $t6, $t4, $f1,$f2.
############################################################################
main:
			
	#print prompt one 
        li          	$v0, 4   
	la 		$a0, prompt1
	syscall
			
	#take user's input of size of array variable and store it in $s4
        li          	$v0, 5
	syscall
	move 		$s4, $v0
			
	#print the second prompt
        li          	$v0, 4   
	la 		$a0, arr1
	syscall
			
	#declear all the varibles.
	la		$s5, arrOne
	la		$s6, arrTwo
	l.s		$f1, lowest
	l.s		$f2, highest
	add		$t5, $zero, $zero
	add		$t6, $zero, $zero
			
	#check if the input is bigger than 11
	lw		$t4, numbers_len
	bgt		$s4, $t4, adjustInput
			
	#go to arrayOne function
	j		arrayOne
			
############################################################################
# Procedure/Function adjustInput
# Description: this function checks if the size of array is greater than 11.
#			 if so, then size of array =11
# parameters: $s4 = size of array
# return value: none
# registers to be used: $s4
############################################################################
adjustInput:
		
	# change the value of the input to 11
	addi		$s4,$zero,11
			
	#go to arrayOne function
	j		arrayOne
			
############################################################################
# Procedure/Function arrayOne
# Description: takes user's float numbers and create an array of these numbers
# parameters: $s4 = size of array, $s5 = arrOne address, $t5 = i,
#		 $t7 = j, $f0 = floating point input.
# return value: $v4=prompt2 , $v6 = floating point inputs from user.
# registers to be used: $s4, $s5, $t5, $t7, $f0.
############################################################################
arrayOne:
		
	#if it store all the numbers exit the loop
	beq		$t5, $s4, printArrayOnee
				
	#print prompt two
	li         	$v0, 4   
	la 		$a0, prompt2
	syscall
				
	#shift the address to store new number increment i
	sll		$t7, $t5, 2
	addu		$t7, $t7, $s5
				
	#take user's float number input
	li          	$v0, 6
	syscall
				
	#store the input in the arrOne
	s.s		$f0, 0($t7)
				
	#incremnt i
	addi		$t5, $t5, 1
				
	#call itself until the condition satisfied
	j		arrayOne
				
############################################################################
# Procedure/Function printArrayOnee
# Description: just print "First Array Content:"
# parameters: none
# return value: $v0 = arr1R
# registers to be used: none
############################################################################
printArrayOnee:

	#print "First Array Content:"
	li          	$v0,4   
	la 		$a0, arr1R
	syscall
				
	#go to printArrayOne function
	j 		printArrayOne
				
############################################################################
# Procedure/Function printArrayOne
# Description: this function prints all the array one elements.
# parameters: $s4 = size of array, $s5 = arrOne address, $t6 = i, $t7 =j, $f12 = floating point output.
# return value: $v2 = floating point output
# registers to be used: $s4, $s5, $t6, $t7, $f12.
############################################################################
printArrayOne:
				
	#shift the address to store new number increment i
	sll		$t7,$t6,2	
	addu		$t7,$t7,$s5
				
	#printing array elements
	li		$v0,2
	l.s		$f12,0($t7)
	syscall			
	li          	$v0,4   
	la 		$a0, newLine
	syscall
				
	#i = i + 1
	addi		$t6,$t6,1
		
	#if it print all the numbers exit the loop
	beq		$t6, $s4, arrayTwoo
				
	#call itself until the condition satisfied
	j		printArrayOne

############################################################################
# Procedure/Function arrayTwoo
# Description: this function just print "Second Array:" 
# parameters: $t5=i, $t6 = j.
# return value: $v4 = arr2
# registers to be used: $t5, $t6.
############################################################################
arrayTwoo:

	#print "Second Array:
	li          	$v0,4   
	la 		$a0, arr2
	syscall
				
	#reset i and j
	addi		$t5,$zero,0
	addi		$t6,$zero,0
				
	#go to arrayTwo function
	j		arrayTwo

############################################################################
# Procedure/Function arrayTwo
# Description: takes user's float numbers and create an array of these numbers
# parameters: $s4 = size of array, $s6 = arrTwo, $t5 = i, $t7 = j, $f0 = floating point input.
# return value: $v4 = prompt2, $v6 = floating point inputs from user.
# registers to be used: $s4, $s6, $t5, $t7, $f0.
############################################################################
arrayTwo:
		
	#if it store all the numbers exit the loop
	beq		$t5,$s4,printArrayTwoo
				
	#print prompt two
	li          	$v0,4   
	la 		$a0, prompt2
	syscall
			
	#shift the address to store new number increment i
	sll		$t7,$t5,2
	addu		$t7,$t7,$s6
			
	#store user's input in the array
	li          	$v0,6
	syscall
	s.s		$f0,0($t7)
				
	#i = i + 1
	addi		$t5,$t5,1
			
	#call itself until the condition satisfied
	j		arrayTwo
			
############################################################################
# Procedure/Function printArrayTwoo
# Description: this function just print "Second Array content:" 
# parameters: $t5=iterator, $t6=iterator.
# return value: $v4=arr2R
# registers to be used: $t5, $t6.
############################################################################
printArrayTwoo:
			
	#print "Second Array content:
	li   	       	$v0,4   
	la 		$a0, arr2R
	syscall
				
	#reset i and j
	addi		$t5, $zero, 0
	addi		$t4, $zero, 0
				
	#go to printArrayTwoo function
	j 		printArrayTwo
				
############################################################################
# Procedure/Function printArrayTwo
# Description:  this function prints all the array one elements.
# parameters: $s4 = size of array, $s6= arrTwo, $t5 =i, $t7 = j, $f12 = floating point output.
# return value: $v4 = newLine, $v2 = floating point output
# registers to be used: $s4, $s6, $t5, $t7, $f12.
############################################################################
printArrayTwo:
				
	#shift the address to store new number increment i
	sll		$t7, $t6, 2
	addu		$t7, $t7, $s6
				
	#print the array element
	li		$v0, 2
	l.s		$f12, 0($t7)
	syscall
								
	#printing newLine
	li          	$v0, 4   
	la 		$a0, newLine
	syscall
			
	#i = i + 1
	addi		$t6, $t6, 1
				
	#if it prints all the numbers exit the loop
	beq		$t6, $s4, comparing
				
	#call itself until the condition satisfied
	j		printArrayTwo
				
############################################################################
# Procedure/Function comparing
# Description: This function compare between the two array and then decide wether to swap or not
# parameters: $s4 = size of array, $s5 = arrOne address, $s6 = arrTwo, $t5 = i, $t7 = j, $t8 = k,
#			  $f2 = 10.00, $f3 = arrOne elemnt, $f4 = arrTwo content, $f5 = difference.
# return value: none
# registers to be used: $s4, $s5, $s6, $t5, $t7, $t8, $f2, $f3, $f4, $f5.
############################################################################
comparing:
		
	#if it compares all the numbers exit the loop
	beq		$t5, $s4, resultOfSwap
				
	#shift the address to move next value and increment i
	sll		$t7, $t5, 2
	addu		$t7, $t7, $s5
				
	#store it in array one
	l.s		$f3, 0($t7)
				
	#shift the address to move next value and increment i
	sll		$t8, $t5, 2
	addu		$t8, $t8, $s6
				
	#store it in array two
	l.s		$f4, 0($t8)
				
	#get the difference 
	sub.s		$f5, $f3, $f4
				
	#i = i + 1
	addi		$t5, $t5, 1
				
	#check if greater or less than 10 
	c.lt.s		$f5, $f2
	bc1t		elseIf
				
	#repeat the loop
	j		comparing
				
############################################################################
# Procedure/Function elseIf
# Description: This function checks if the difference is greater than -10 or not
# parameters: $f1 = -10.00, $f5 = difference.
# return value: null
# registers to be used: $f1, $f5.
############################################################################
elseIf:
	#check if it is greater than -10
	c.lt.s		$f1, $f5
	bc1t		swap
				
	#call the comparing function
	j		comparing
############################################################################
# Procedure/Function swap
# Description: swaping elemnts between arrays
# parameters: $t7 = arrOne, $t4 = swapped Num, $t8 = arrTwo, $f3 = arrOne content,
#				 $f4=arrTwo content.
# return value: none
# registers to be used:  $t4, $t7, $t8, $f3, $f4.
############################################################################
swap:
	#swap arrays content
	s.s		$f4, 0($t7)
	s.s		$f3, 0($t8)
			
	#increment the swapped Num
	addi		$t4, $t4, 1
				
	#call the comparing function
	j		comparing
############################################################################
# Procedure/Function resultOfSwap
# Description: This function just print the number of swapped element
# parameters: $t6 = i, $t4 = swapped pairs Num.
# return value: $v4 = swappedPairs and resultArr1 , $v1 = swapped pairs Num.
# registers to be used: $t6, $t4.
############################################################################
resultOfSwap:

	#print number of swapped elements
	li		$v0, 1
	move		$a0, $t4
	syscall
				
	#print "pair(s) of numbers are swapped"
	li          	$v0,4   
	la 		$a0, swappedPairs
	syscall

	#printing the header of array one
	li          	$v0,4   
	la 		$a0, resultArr1
	syscall
				
	#i = 0
	addi		$t6,$zero,0
				
	#go to arrayOneResult function
	j		arrayOneResult
		
############################################################################
# Procedure/Function arrayOneResult
# Description: this function print the final result of array one
# parameters: $s4 = size of array, $s5 = arrOne, $t6 = i, $t7 = j, $f12 = floating point output.
# return value: $v4 = newLine , $v2 = floating point output
# registers to be used: $s4, $s5, $t6, $t7, $f12.
############################################################################
arrayOneResult:
				
	#shift the address to move next value and increment i
	sll		$t7, $t6, 2
	addu		$t7, $t7, $s5
				
	#print array content
	li		$v0, 2
	l.s		$f12, 0($t7)
	syscall
	li          	$v0, 4   
	la 		$a0, newLine
	syscall
				
	#i = i + 1
	addi		$t6, $t6, 1
				
	#if it prints all the numbers of array exit the loop
	beq		$t6, $s4, result
				
	#call itself
	j		arrayOneResult
				
############################################################################
# Procedure/Function arrayOneResultt
# Description:  this function just prints "Second Array Result Content:"
# parameters: $t6 = i.
# return value: $v4 = resultArr2
# registers to be used: $t6.
############################################################################
result:
	
	#print "Second Array Result Content:"
	li          	$v0,4   
	la 		$a0, resultArr2
	syscall
			
	#i = 0
	addi		$t6, $zero, 0
				
	#go to arrayTowResult function 
	j		arrayTwoResult
				
############################################################################
# Procedure/Function arrayTwoResult
# Description: this function print the result of array two
# parameters: $s4=size of array, $s6=arrTwo address, $t6=iterator, $t7=iterator, $f12=floating point output.
# return value: null
# registers to be used: $s4, $s6, $t6, $t7, $f12.
############################################################################
arrayTwoResult:

	#shift the address to move next value and increment i
	sll		$t7, $t6, 2
	addu		$t7, $t7, $s6
				
	#print array content
	li		$v0,2
	l.s		$f12,0($t7)
	syscall
	li          	$v0,4   
	la 		$a0, newLine
	syscall
				
	#i = i +1
	addi		$t6, $t6, 1
				
	#if it prints all the numbers of array exit the loop
	beq		$t6, $s4, exit
				
	#call it self
	j		arrayTwoResult
	
exit:		
	#end program
	li			$v0,10
	syscall
