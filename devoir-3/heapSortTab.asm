# --------------------
# Description:
# Heap and heapSort implemented in MIPS assembly.
# --------------------
# Authors:
# Etienne Collin 20237904
# Ange Lilian Tchomtchoua Tokam 20230129
# Justin Villeneuve 20132792
# --------------------
# Contact:
# etienne.collin@umontreal.ca
# --------------------

.data
arrayStart:			.word	0x10040000							# Address of first element of array
n:					.word	0									# n = size of array (initializes at 0)
arraySizeMsg:		.asciiz	"Enter the length of the array: "
arrayInputMsg:		.asciiz	"Enter an element in the array: "
sortingMsg:			.asciiz	"Sorting array..."
arrayOpenMsg:		.asciiz	"\nArray: ["
arrayCloseMsg:		.asciiz	"]\n"
arraySeparatorMsg:	.asciiz ", "

.text
.globl	main

# --------------------
# Main method of the program.
# --------------------
# Parameters:
# No parameters used
# --------------------
# Registers used:
# No registers used
# --------------------
# Returns:
# No return
# --------------------
main:
	jal	init		# Initialize array
	jal	printArray 	# Print array
	jal	heapSort	# Sort array
	jal	printArray	# Print array
	jal	exit		# Exit program

# --------------------
# Initializes an array of n elements from address arrayStart
# and stores the array size in the variable n.
# --------------------
# Parameters:
# No parameters used
# --------------------
# Registers used:
# s0: Array address
# s1: Address of current element in array
# s2: Size of the array - 1
# s3: Counter
# --------------------
# Returns:
# No return
# --------------------
init:
	# Store registers getting overridden
	addi	$sp,	$sp,	-16				# Allocate 4 words
	sw		$s0,	12($sp)					# Store $s0
	sw		$s1,	8($sp)					# Store $s1
	sw		$s2,	4($sp)					# Store $s2
	sw		$s3,	0($sp)					# Store $s3

	# Ask the user the length of the array
	li		$v0,	4						# Print a message to the user
	la		$a0,	arraySizeMsg			# Address of the message
	syscall

	# Read the size of the array entered by the user
	li		$v0,	5						# Read an integer
	syscall
	la		$t0,	n						# Load address of n which will contain the array size
	sw		$v0,	0($t0)					# Store the array size in n
	move	$s2,	$v0						# Store array size in $s2
	addi	$s2,	$s2,	-1				# Store last index of array (n - 1)

	# Initialize table elements
	la		$s0,	arrayStart				# Load label of arrayStart
	lw		$s0,	0($s0)					# Load address of arrayStart
	li		$s3,	0						# Counter initialized to 0

# Fill the array
initLoop:
	bgt		$s3,	$s2,		initExit	# Verify if counter reached the end of the array

	# Get address of current element in array
	sll		$t0,	$s3,	2				# Get offset on element i in array (i * 4)
	add		$s1,	$s0,	$t0				# Get address of element

	# Ask user of input
	li		$v0,	4						# Print a string
	la		$a0,	arrayInputMsg			# Address of the message to print
	syscall

	# Get user input
	li		$v0,	5						# Read integer
	syscall

	sw		$v0,	0($s1)					# Store the integer in the array
	addi	$s3,	$s3,		1			# Increment counter
	j		initLoop

# Jump back to main
initExit:
	# Reload overriden registers
	lw		$s0,	12($sp)					# Reload $s0
	lw		$s1,	8($sp)					# Reload $s1
	lw		$s2,	4($sp)					# Reload $s2
	lw		$s3,	0($sp)					# Reload $s3

	addi	$sp,	$sp,	12				# Free allocated space

	jr		$ra								# Return

# --------------------
# Sorts an array of n elements from address arrayStart.
# --------------------
# Parameters:
# No parameters used
# --------------------
# Registers used:
# $s0: Index of last element in array
# $s1: heapSortBuildHeap counter, initialized at i = (n - 1)/2
# --------------------
# Returns:
# No return
# --------------------
heapSort:
	# Store return address
	addi	$sp,	$sp,	-12				# Allocate 3 words
	sw		$ra,	8($sp)					# Store return address
	# Store registers getting overridden
	sw		$s0,	4($sp)					# Store $s0
	sw		$s1,	0($sp)					# Store $s1

	# Print status message telling user the array is being sorted
	li		$v0,	4						# Print a status message telling user the array is being sorted
	la		$a0,	sortingMsg				# Address of the message
	syscall

	# Initialize $s0 = n - 1
	la		$s0,	n						# Load address of n which will contain the array size
	lw		$s0,	0($s0)					# Loads the value of n
	addi	$s0,	$s0,	-1				# Decrement by 1 to get lastIndex

	# Initialize heapSortBuildHeap $s1 = ($s0 - 1)/2
	addi	$s1,	$s0,	-1				# Compute ($s0-1)
	sra		$s1,	$s1,	1				# Divide by 2 using arithmetical shift

heapSortBuildHeap:
	# Check condition
	bltz	$s1,	heapSortSort			# If i < 0, start sorting

	# Fix heap
	move	$a0,	$s1						# $a0 = index of last element in array
	move	$a1,	$s0						# $a1 = value of heapSortBuildHeap counter
	jal	 fixHeap							# Call fixHeap($a0, $a1)

	# Decrement i
	addi	$s1,	$s1,	-1				# Decrement i
	j		heapSortBuildHeap

heapSortSort:
	# Check condition
	blez	$s0,	heapSortExit			# If n <= 0, exit

	# Swap values
	li		$a0,	0						# $a0 = 0
	move	$a1,	$s0						# $a1 = index of last element in array
	jal		swap							# Call swap($a0, $a1)

	# Decrement n
	addi	$s0,	$s0,	-1				# Decrement n

	# Fix heap
	li		$a0,	0						# Set first argument of fixHeap() function.
	move	$a1,	$s0						# Set second argument of fixHeap() function.
	jal		fixHeap							# Call fixHeap(0, n)

	# Continue loop
	j	   heapSortSort

heapSortExit:
	# Reload return address
	lw		$ra,	8($sp)					# Reload return address
	# Reload overriden registers
	lw		$s0,	4($sp)					# Reload $s0
	lw		$s1,	0($sp)					# Reload $s1

	addi	$sp,	$sp,	12				# Free allocated space
	jr		$ra								# Return


# --------------------
# Prints an array of n elements from address arrayStart.
# --------------------
# Parameters:
# No parameters used
# --------------------
# Registers used:
# $s0: Address of the array
# $s1: Last index of array
# $s2: Index in array (Counter)
# --------------------
# Returns:
# No return
# --------------------
printArray:
	# Store registers getting overridden
	addi	$sp,	$sp,	-12				# Allocate 3 words
	sw		$s0,	8($sp)					# Store $s0
	sw		$s1,	4($sp)					# Store $s1
	sw		$s2,	0($sp)					# Store $s2

	# Prepare for loop
	# Load address of array
	la		$s0,	arrayStart				# Load label of arrayStart
	lw		$s0,	0($s0)					# Load address of arrayStart

	# Initialize counter i = 0
	li		$s1,	0

	# Get array length
	la		$s2,	n						# Load address of n which will contain the array size
	lw		$s2,	0($s2)					# Loads the value of n

	# Print array opening bracket
	li		$v0,	4						# Print an opening bracket at then end of the printed array
	la		$a0,	arrayOpenMsg			# Address of the message
	syscall

printArrayLoop:
	bge		$s1,	$s2,	printArrayExit	# Check if we have gone through the entire array

	# Get the integer in the array and print it
	sll		$t0,	$s1,	2				# i = i * 4
	add		$t0,	$s0,	$t0				# Get address 4i(arrayStart) to get value at index i
	lw		$a0,	0($t0)					# Get value in array
	li		$v0,	1						# Print integer
	syscall

	# Increment counter
	addi	$s1,	$s1,	1				# i = i + 1

	# Check if a separator is needed
	bge		$s1,	$s2,	printArrayLoop	# If we are at last element, do not print separator

	# Print separator after value
	li		$v0,	4						# Print a separator after the value
	la		$a0,	arraySeparatorMsg		# Address of the message
	syscall

	# Continue loop
	j	printArrayLoop

printArrayExit:
	# Print array closing bracket
	li		$v0,	4						# Print a closing bracket at then end of the printed array
	la		$a0,	arrayCloseMsg			# Address of the message
	syscall

	# Reload overriden registers


	lw		$s0,	8($sp)					# Reload $s0
	lw		$s1,	4($sp)					# Reload $s1
	lw		$s2,	0($sp)					# Reload $s2

	addi	$sp,	$sp,	12				# Free allocated space

	jr		$ra								# Return

# --------------------
# Terminates the program.
# --------------------
# Parameters:
# No parameters used
# --------------------
# Registers used:
# No registers used
# --------------------
# Returns:
# No return
# --------------------
exit:
	li		$v0,	10						# Terminate execution
	syscall

# --------------------
# Fixes a heap stored from address arrayStart.
# --------------------
# Parameters:
# $a0: Root index of the heap to fix (in the array)
# $a1: Last index of the heap to fix (in the array)
# --------------------
# Registers used:
# $s0: Array address
# $s1: Root value
# $s2: Left child index
# $s3: Right child index
# $s4: Left child value
# $s5: Right child value
# --------------------
# Returns:
# No return
# --------------------
fixHeap:
	# Store return address
	addi	$sp,	$sp,	-28					# Allocate 7 words
	sw		$ra,	24($sp)						# Store return address
	# Store registers getting overridden
	sw		$s0,	20($sp)						# Store $s0
	sw		$s1,	16($sp)						# Store $s1
	sw		$s2,	12($sp)						# Store $s2
	sw		$s3,	8($sp)						# Store $s3
	sw		$s4,	4($sp)						# Store $s4
	sw		$s5,	0($sp)						# Store $s5

	# Load array start
	la		$s0,	arrayStart					# Load label of arrayStart
	lw		$s0,	0($s0)						# Load address of arrayStart

	# Get value of root
	sll		$t0,	$a0,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	lw		$s1,	0($t0)						# Load rootValue into $s1

fixHeapWhile:
	# Get left child index
	jal		getLeftChildIndex
	move	$s2,	$v0							# Store left child index into $s2

	# Check if left child index is within bounds
	bgt		$s2,	$a1,	fixHeapWhileExit	# If left child index > lastIndex, exit while loop

	# Get left child index
	jal		getRightChildIndex
	move	$s3,	$v0

fixHeapFirstIf:
	# First comparison
	bgt		$s3,	$a1,	fixHeapSecondIf		# If right child index <= lastIndex, compare

	# Prepare second comparison
	# Get value of left child
	sll		$t0,	$s2,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	lw		$s4,	0($t0)						# Load left child into $s4
	# Get value of right child
	sll		$t0,	$s3,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	lw		$s5,	0($t0)						# Load left child into $s5

	# Second comparison
	bge		$s4,	$s5,	fixHeapSecondIf		# If left child > right child
	move	$s2,	$s3

fixHeapSecondIf:
	# Get value of left child
	sll		$t0,	$s2,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	lw		$s4,	0($t0)						# Load left child into $s4

	# Check condition
	ble		$s4,	$s1,	fixHeapWhileExit	# if left child > rootValue

	# Update array
	sll		$t0,	$a0,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	sw		$s4,	0($t0)						# array[rootIndex] = array[leftChildIndex]

	# Update indices
	move	$a0,	$s2							# rootIndex = leftChildIndex

	# Continue loop
	j		fixHeapWhile

fixHeapWhileExit:
	# Update array
	sll		$t0,	$a0,	2					# i = rootIndex * 4
	add		$t0,	$s0,	$t0					# Get address of index i in array
	sw		$s1,	0($t0)						# array[rootIndex] = rootValue;


fixHeapExit:
	# Reload return address
	lw		$ra,	24($sp)						# Reload return address
	# Reload overriden registers
	lw		$s0,	20($sp)						# Reload $s0
	lw		$s1,	16($sp)						# Reload $s1
	lw		$s2,	12($sp)						# Reload $s2
	lw		$s3,	8($sp)						# Reload $s3
	lw		$s4,	4($sp)						# Reload $s4
	lw		$s5,	0($sp)						# Reload $s5

	addi	$sp,	$sp,	28					# Free allocated space
	jr		$ra									# Return


# --------------------
# Returns the indice of the left child in the data structure called "heap".
# The left child node of the node with index i has index 2i + 1.
# --------------------
# Parameters:
# $a0: Index of parent
# --------------------
# Registers used:
# No registers used
# --------------------
# Returns:
# $v0: Index of the left child
# --------------------
getLeftChildIndex:
	sll		$v0,	$a0,	1	# 2 * index
	addi	$v0,	$v0,	1	# (2 * index) + 1
	jr		$ra					# Return index

# --------------------
# Returns the indice of the right child in the data structure called "heap".
# The right child node of the node with index i has index 2i + 2.
# --------------------
# Parameters:
# $a0: Index of parent
# --------------------
# Registers used:
# No registers used
# --------------------
# Returns:
# $v0: Index of the right child
# --------------------
getRightChildIndex:
	sll		$v0,	$a0,	1	# 2 * index
	addi	$v0,	$v0,	2	# (2 * index) + 2
	jr		$ra					# Return index


# --------------------
# Swaps two values of an array.
# --------------------
# Parameters:
# $a0: Index of element i
# $a1: Index of element j
# --------------------
# Registers used:
# $s0: Array address
# $s1: Address of array[i]
# $s2: Value of array[i]
# $s3: Address of array[j]
# $s4: Value of array[j]
# --------------------
# Returns:
# No return
# --------------------
swap:
	# Store registers getting overridden
	addi	$sp,	$sp,	-20			# Allocate 5 words
	sw		$s0,	16($sp)				# Store $s0
	sw		$s1,	12($sp)				# Store $s1
	sw		$s2,	8($sp)				# Store $s2
	sw		$s3,	4($sp)				# Store $s3
	sw		$s4,	0($sp)				# Store $s4

	# Load array start
	la		$s0,	arrayStart			# Load label of arrayStart
	lw		$s0,	0($s0)				# Load address of arrayStart

	# Get address and value of array[i]
	sll		$s1,	$a0,		2		# i = i * 4
	add		$s1,	$s0,		$s1		# Get address of index i in array
	lw		$s2,	0($s1)				# s2 = array[i]

	# Get address and value of array[j]
	sll		$s3,	$a1,		2		# j = j * 4
	add		$s3,	$s0,		$s3		# Get address of index j in array
	lw		$s4,	0($s3)				# $s4 = array[j]

	# Swap the values
	sw		$s4,	0($s1)				# array[i] = array[j]
	sw		$s2,	0($s3)				# array[i] = array[j]

	# Reload overriden registers
	lw		$s0,	16($sp)				# Reload $s0
	lw		$s1,	12($sp)				# Reload $s1
	lw		$s2,	8($sp)				# Reload $s2
	lw		$s3,	4($sp)				# Reload $s3
	lw		$s4,	0($sp)				# Reload $s4

	addi	$sp,	$sp,	20			# Free allocated space
	jr $ra								# Return
