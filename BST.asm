.data
	printNextline: .asciiz "\n"
	printWelcome: .asciiz "Welcome to Exhausted Lions Tree!!\n"
	create_message: .asciiz "please press 'R' to create the tree first of all...\n"
	printComExplain: .asciiz "\tA - Add a new record\n \tP - Perform a preorder traversal\n \tI - Perform an inorder traversal\n \tO - Perform an Postorder traversal\n\tT - Depth of the Tree\n \tE - Check wheather the tree is empty or not\n \tC - Clear the tree\n \tD - Delete an element from the tree\n \tZ - Get size of the tree\n \tS - Search about an element\n \tR - Create the tree\n\tQ - Exit and quit the program\n\n"
	printCommand: .asciiz "Please enter a command (A,I,P,O,T,E,S,C,D,Z,R,Q): "
	printACommand: .asciiz " - Add a new record...\n"
	printPCommand: .asciiz " - Perform a preorder traversal...\n"
	printICommand: .asciiz " - Perform an inorder traversal...\n"
	printOCommand :  .asciiz " - Perform an postorder traversal...\n"
	printCCommand: .asciiz " - clear the tree ...\n"
	printZCommand:  .asciiz " - get the size of the tree ...\n"
	printECommand: .asciiz " -check whether the tree is empty or not ...\n"
	printSCommand: .asciiz " -Search about an element from the tree ...\n"
	prinDCommand :.asciiz " -Delete an element from the tree...\n"
	printCRCommand_1:  .asciiz "\n-Tree Created , You have Now "
	prinQCommand :.asciiz " -program end...\n"
	message: .asciiz "enter an element to search\n"
	prinDepthCommand : .asciiz "Check depth of tree\n"
	DeleteMessage : .asciiz "enter the element you want to delete\n"
	notDeleteMessage : .asciiz "element not found\n"
	ChooseTreeNum: .asciiz "\nChoose Tree Number : "
	printNotEmpty: .asciiz "The Tree is Not Empty....\n"
	printempty: .asciiz "The Tree is Empty....\n"
	printnotFound:.asciiz "Element is Not Found....\n"
	printFound:.asciiz "Element is Found....\n"
####################################################################################################
	NULL: .word 0                                  # Representation of NULL pointer.
	FlagTreeRoot: .word 0
	Heap_Start: .word 268697600
	inOrder_message: .asciiz "inOrder traversal : "
	preOrder_message: .asciiz "preOrder traversal : "
	postOrder_message: .asciiz "postOrder traversal : "
	format: .asciiz " "
	line: .asciiz "\n"
	RepeatMsg: .asciiz "Repeated Element Yasta\n"
	WrongInput: .asciiz "Wrong Input"
	NumOfTrees: .word 1
	AboAlaaWeAbdo: .word 0
	StartTreeRoot: .word 0
	
	
.text

###############################################################
# Main code 
# Loop to get the commands from user and perform commands
###############################################################

# main
# Prints welcome line and Command Explain line
main:
	la $s4 , StartTreeRoot
	lw $s7 , Heap_Start
	li $v0, 4			# Print welcome line
	la $a0, printWelcome
	syscall
	
	li $v0, 4			# Print Command Explain line
	la $a0, printComExplain
	syscall

			li $v0, 4			# Print Create first tree line line
	la $a0, create_message
	syscall
	
	li $v0, 12			# Enter the command character
	syscall
	move $s0, $v0			# Store in $s0
	beq $s0, 'R', isCreate                 # If command character = R (call isR)
	beq $s0, 'r', isCreate	

# End of main

# main_loop
# The main looping for getting commands from user
main_loop:
	li $v0, 4			# Prompt for the command character
	la $a0, printCommand
	syscall
	
	li $v0, 12			# Enter the command character
	syscall
	move $s0, $v0			# Store in $s0

	li $v0, 4			# Print nextline
	la $a0, printNextline
	syscall
	
	beq $s0, 'A', isA		# If command character = A (call isA)	
	beq $s0, 'a', isA		# If command character = a (call isA)
	beq $s0, 'P', isP		# If command character = P (call isP)
	beq $s0, 'p', isP		# If command character = p (call isP)
	beq $s0, 'I', isI		# If command character = I (call isI)
	beq $s0, 'i', isI		# If command character = i (call isI)
	beq $s0, 'O', isO                      # If command character = O (call isO) 
	beq $s0, 'o', isO                      # If command character = i (call isO) 
	beq $s0, 'Z', isZ                      # If command character = Z (call isZ)
	beq $s0, 'z', isZ                      # If command character = z (call isZ)
	beq $s0, 'C', isC                      # If command character = C (call isC)
	beq $s0, 'c', isC                      # If command character = c (call isC)
	beq $s0, 'E', isE                      # If command character = E (call isE)
	beq $s0, 'e', isE                      # If command character = e (call isE)
	beq $s0, 'S', isS                      # If command character = S (call isS)
	beq $s0, 's', isS                      # If command character = s (call isS)
	beq $s0, 'T', isDepth                  # If command character = T (call isDepth)
	beq $s0, 't', isDepth                  # If command character = t (call isDepth)
	beq $s0, 'D', isD                       # If command character = D (call isD)
	beq $s0, 'd', isD                      # If command character = d (call isD)
	beq $s0, 'Q', isQ                      # If command character = Q (call isQ)
	beq $s0, 'q', isQ                      # If command character = q (call isQ)
	beq $s0, 'R', isCreate                 # If command character = R (call isR)
	beq $s0, 'r', isCreate                 # If command character = r (call isR)
	
	li $v0 , 4
	la $a0 , WrongInput
	syscall
	jal after
	
# End of main_loop	

isA:
	EnterAgain:
	li $v0, 4			# Print A Command
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
	
	li $v0 , 5    #enter an integer 
	syscall 
	move $a2 , $v0 
	move $a3 , $s7	
	jal insert			# Call addFunct
	jal after
	
									# Call after	
isP:
	li $v0, 4			#choose tree nuber command
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5                                                 #take the number of tree
	syscall
	
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
	
	li $v0, 11			# Print the command character
	move $a0, $s0			# $a0 = $s0
	syscall
	
	li $v0, 4			# Print P Command
	la $a0, printPCommand
	syscall
	
	#lw $s7, root
	move $a3 , $s7			# curr = root
	jal preOrder			# Call preOrder
	jal after			# Call after
	
isI:
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot

	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printICommand
	syscall

	#lw $s0, root
	move $a3 , $s7			# curr = root
	jal InOrder			# Call inOrder
	jal after		

isO:
	li $v0, 4
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
	
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printOCommand
	syscall

	#lw $s0, root
	move $a3 , $s7			# curr = root
	jal postOrder			# Call inOrder
	jal after		

isC:
	
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printCCommand
	syscall

	#lw $s0, root
				# curr = root
	jal clear			# Call inOrder
	jal after
	
isZ:	
	
	li $v0, 4
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot						
	li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printZCommand
	syscall

	#lw $s0, root
	move $a3 , $s7
	li $s5,0			# curr = root
	jal size
	move $a0, $v0
	li $v0, 1
	syscall
	jal after								
															
isE:
	
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
                    li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printECommand
	syscall

	#lw $s0, root
	move $a3 , $s7
	li $s5,0			# curr = root
	jal empty
	move $a0, $v0
	move $v1,$t8
	beq $v1,0,EmptyTree
	li $v0,4
	la $a0,printNotEmpty
                  	syscall
                  	jal after
																
isS:
	
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
                  move $v1,$zero
                  li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, printSCommand
	syscall

	#lw $s0, root
	move $a2 , $s7
	li $v0,4
	la $a0,message
	syscall
	
	li $v0,5
	syscall
	move $a3,$v0
	
              	addi $a0 , $0 , 0	# curr = root
	jal Search
	move $a0, $v1
	beq $v1,0,NotFound
	li $v0,4
	la $a0,printFound
                  	syscall
                  	jal after	
	
	#############################################################
isD:
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
	#lw $s7 , Heap_Start

                  move $v1,$zero
                   move $v0,$zero
                     li $v0, 11			# Print the command character
	move $a0, $s0
	syscall
	li $v0, 4			
	la $a0, prinDCommand
	syscall

	#lw $s0, root
	move $a2 , $s7
	li $v0,4
	la $a0, DeleteMessage
	syscall
	
	li $v0,5
	syscall
	move $a3,$v0
                    move $t9 , $zero
              
	jal Delete
				
	jal after

isCreate:
	li $v0, 4			
	la $a0, printCRCommand_1
	syscall
	
	lw $a0 , NumOfTrees
	li $v0 , 1
	syscall
	
	jal CreateNewTreeRoot
	jal after
	
				

isDepth:
	
	li $v0, 4			
	la $a0, ChooseTreeNum
	syscall
	
	li $v0 , 5
	syscall
	move $a1 , $v0
	lw $a2 , NumOfTrees
	bgt $a1 , $a2 , EnterAgain
	jal SelectTreeRoot
                  move $v0,$zero
                 
	li $v0, 4			
	la $a0, prinDepthCommand
	syscall

	#lw $s0, root
	
	
	lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $a0 , 0($a0)
    move $v0 , $zero
    beq $a0 , $zero  , Skip
    move $v0 , $zero
    
    move $a0 , $s7
	
	jal TreeDepth
	Skip:
	move $a0, $v0
	li $v0, 1
	syscall			
	jal after
	
			
after:
	li $v0, 4			# Print Newline
	la $a0, printNextline
	syscall	
	
	jal main_loop
	
isQ:	
 			
	li $v0, 4			# Print nextline
	la $a0, printNextline
	syscall	
									
	li $v0, 10			# Exit
	syscall						# Call main_loop
# exit
# Return to OS

# End of exit

# End of main code
									
# Insert Function Implementation
insert:        
    lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $v0 , 0($a0)
    beq $v0 ,$zero , insertRoot
    
    #lw $v0 , FlagTreeRoot
    #beq $v0 , 0 ,insertOp
    #sw $a2 ,0($a3)
    #addi $v0 , $zero , 1
    #sw $v0 , 0($a0)
    #jr $ra
    
	# Save the stack pointer
insertOp:
    subu $sp, $sp, 28
    sw $a3, 0($sp)
    sw $s2, 4($sp)
    sw $s3, 8($sp)
    sw $a2, 12($sp)
    sw $t2, 16($sp)
    sw $t3, 20($sp) 
    sw $s6, 24($sp) 
    # allocate memory for a new node 
    li $v0, 9
    li $a0, 12
    syscall
    move $s2, $v0       # $s2 points to the new node
        
    # Work if tree empty , Make the Root Node
    lw $s6 , FlagTreeRoot
    beq $s6, 1 , insertRoot
    
    # start $s3 points to the Root Node
    move $s3, $a3
    
    # Moving in Tree to insert the new value
    insertLoop:
        # $t2 holds the value of Data of the current node
        lw $t2, 0($s3)
        # if the value of the Input Data is less than the current node , Traverse Left
        beq $a2 , $t2 , Repeat
        blt $a2, $t2, CheckLeft
        # else Traverse Right
        j CheckRight
    
    CheckLeft:
        # if the left child is null, insert the new node as the left child
        lw $t2, 4($s3)
        beq $t2, $zero, insertLeft
        # If Node is not NULL , move to the left child
        move $s3, $t2
        # Jump to behave this Left Child as the Root of sub tree now
        j insertLoop
       
     CheckRight:
        # if the right child is null, insert the new node as the right child
        lw $t2, 8($s3)
        beq $t2, $zero, insertRight
        # If Node is not NULL , move to the left child
        move $s3, $t2
        # Jump to behave this Right Child as the Root of sub tree now
        j insertLoop
    
    insertLeft:
        sw $s2, 4($s3)     # Make $s2 now point to Left Address
        sw $a2, 0($s2) 		# Store the Input Data to the Data Place in the New Node
        move $s7 , $s2
        # Restore Values
        lw $a3, 0($sp)
    	lw $s2, 4($sp)
    	lw $s3, 8($sp)
    	lw $a2, 12($sp)
    	lw $t2, 16($sp)
        lw $t3, 20($sp) 
        lw $s6, 24($sp) 
        addu $sp, $sp, 28
        jr $ra
        
    insertRight:
        sw $s2, 8($s3)     # Make $s2 now point to Right Address
        sw $a2, 0($s2) 		# Store the Input Data to the Data Place in the New Node
        move $s7 , $s2
        # Restore Values
        lw $a3, 0($sp)
    	lw $s2, 4($sp)
    	lw $s3, 8($sp)
    	lw $a2, 12($sp)
    	lw $t2, 16($sp)
    	lw $t3, 20($sp) 
        lw $s6, 24($sp) 
        addu $sp, $sp, 28
        jr $ra

	# Make Root if Tree is Empty , work in first only and for one time
	insertRoot:
		# $s2 now holds the first address of heap or the address come from Create Tree Function 
	#move $s6 , $zero
	#sw $s6 , FlagTreeRoot
	lw $s2, AboAlaaWeAbdo
    	lw $a3 ,0($s2)         # $a3 point to this address
    	sw $zero , 4($a3)     # Left with NULL
    	sw $zero , 8($a3)     # Right with NULL
    	sw $a2   , 0($a3)     # Data with value
    	move $s7 , $a3
    	addi $a3, $zero ,1
    	sw $a3 ,4($s2)
    	jr $ra
    	
    Repeat:
    li $v0 , 4
    la $a0 , RepeatMsg
    syscall
    jr $ra

#######################################################																	

																		
																																			
#InOrder   
InOrder:   
	lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $a0 , 0($a0)
    bne $a0 , $zero  , InOrderOp
    move $a0, $zero
    jr $ra
InOrderOp:
	move $a0, $a3			# $a0 = $s0
	
	# if(bPtr == NULL)
	bne $a0, $0, InOrderRecurse
	jr $ra				# Return to caller
	
InOrderRecurse:
	addi, $sp, $sp, -8		# Allocate 2 registers to stack
	sw $ra, 0($sp)			# $ra is the first register
	sw $a0, 4($sp)			# $a0 is the second register
        
        
	
	lw $a3,4($a3)		        # curr = curr->left
	jal InOrderOp			# Call InOrder
	
	lw $a0, 4($sp)			# Retrieve original value of $a0
	move $a3, $a0	                # $s7 = $a0
	jal printSmall		        # Call printSmall
	lw $a3, 8($a3)		        # curr = curr->right
	jal InOrderOp			# Call InOrder
		
			                
	lw $ra, 0($sp)			# Retrieve original return address
	addi $sp, $sp, 8		# Free the 2 register stack spaces
	jr $ra				# Return to caller

# End of InOrder traversal

######################################################
#preOrder   	
preOrder:
    lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $a0 , 0($a0)
    bne $a0 , $zero  , preOrderOp
    move $a0, $zero
    jr $ra
preOrderOp: 
	
	move $a0, $a3			# $a0 = $s0
	
	# if(bPtr == NULL)
	bne $a0, $0, preOrderRecurse
	jr $ra				# Return to caller
	
preOrderRecurse:
	addi, $sp, $sp, -8		# Allocate 2 registers to stack
	sw $ra, 0($sp)			# $ra is the first register
	sw $a0, 4($sp)			# $a0 is the second register
        
                    jal printSmall                                             # Call printSmall
	
	lw $a3,4($a3)		        # curr = curr->left
	jal preOrderOp			# Call preOrder
	
	lw $a0, 4($sp)			# Retrieve original value of $a0
	move $a3, $a0	                # $s7 = $a0
	lw $a3, 8($a3)		        # curr = curr->right
	jal preOrderOp			# Call preOrder
		
			                
	lw $ra, 0($sp)			# Retrieve original return address
	addi $sp, $sp, 8		# Free the 2 register stack spaces
	jr $ra				# Return to caller

# End of preOrder traversal
######################################################
# postOrder
postOrder:   
    lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $a0 , 0($a0)
    bne $a0 , $zero  , postOrderOp
    move $a0, $zero
    jr $ra
postOrderOp:
    move $a0, $a3           # a0 = $s0

    # if (bPtr == NULL)
    bne $a0, $0, postOrderRecurse
    jr $ra                  # Return to caller

postOrderRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the 1st
    sw $a0, 4($sp)          # $a0 is the 2nd

    lw $a3, 4($a3)        # curr = curr->left
    jal postOrderOp           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $a3, $a0           # $s0 = $a0

    lw $a3, 8($a3)        # curr = curr->right
    jal postOrderOp           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $a3, $a0           # $s0 = $a0
    jal printSmall          # Call printSmall

    lw $ra, 0($sp)          # Retrieve original $ra
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra
    
 #End of postOrder traversal
######################################################

# printSmall
printSmall:
	
	lw $a0, 0($a3)			
	li $v0, 1		
	syscall 
	
	li $v0, 4
	la $a0,format
	syscall
	 
	jr $ra

# End of printSmall
																																																																					
	
																									
																																																	# clear
clear:
    move $a0,$s7          # a0 = $s0
    # if (bPtr == NULL)
    bne $a0, $0, clearRecurse
    lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    sw $zero , 0($a0)
    move $a0 , $zero
    jr $ra                  # Return to caller

clearRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the 1st
    sw $a0, 4($sp)          # $a0 is the 2nd

    lw $s7 , 4($s7)        # curr = curr->left
    jal clear          # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $s7, $a0           # $s0 = $a0

    lw $s7, 8($s7)        # curr = curr->right
    jal clear           # Call postOrder

    lw $a0, 4($sp)          # Retrieve original $a0
    move $s7, $a0           # $s0 = $a0
    jal finalclear          # Call printSmall

    lw $ra, 0($sp)          # Retrieve original $ra
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra
    
 #End of clear
######################################################

# final clear
finalclear:
    sw $zero,0($s7)
    sw $zero , 4($s7)        # Set left pointer  to null    
    sw $zero , 8($s7)        # Set right pointer  to null
    li $s7 , 0              # Set $s7 to null
    jr $ra                  # Return to caller
    
# End of clear  edit this code to clear all nodes

size:
	lw $a0 , AboAlaaWeAbdo
    addi $a0 , $a0 , 4
    lw $a0 , 0($a0)
    bne $a0 , $zero  , sizeop
    move $v0,$zero
    move $a0, $zero
    jr $ra
sizeop:
    move $v0,$zero
    move $a0, $a3           # $a0 = $a3
    # if(bPtr == NULL)
    bne $a0, $0, sizeRecurse
    
    jr $ra               # Return to caller
    
sizeRecurse:
    addi $sp, $sp, -8       # Allocate 2 registers to stack
    sw $ra, 0($sp)          # $ra is the first register
    sw $a0, 4($sp)          # $a0 is the second register
    
    jal increaseSize            # Call printSize
    
    lw $a3, 4($a3)          # curr = curr->left
    jal sizeop            # Call size
    
    lw $a0, 4($sp)          # Retrieve original value of $a0
    move $a3, $a0           # $s0 = $a0
    lw $a3, 8($a3)          # curr = curr->right
    jal sizeop            # Call size
    
    move $v0, $s5
    lw $ra, 0($sp)          # Retrieve original return address
    addi $sp, $sp, 8        # Free the 2 register stack spaces
    jr $ra              # Return to caller

# End of size

# printSize
increaseSize:
        
    addi $s5, $s5, 1
    
    jr $ra              # Return to caller
						# Empty function
empty:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal size
	move $t8, $v0
	li $v0, 0
	beq $t8, $zero, isempty
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
isempty:
	addi $v0, $v0, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
# End of empty function
CreateNewTreeRoot:
	lw $t2 , NumOfTrees
	addi $t2 , $t2 , 1
	sw $t2 , NumOfTrees
	li $v0 , 9
	li $a0 , 12
	syscall
	move $s7 , $v0
	Operation:
	sw $s7 , 0($s4)
	addi $s4 , $s4 , 4
	addi $t2 , $zero , 0
	sw $t2 , 0($s4)
	addi $s4 , $s4 , 4
	addi $sp , $sp , -4
	sw $s6 , 0($sp)
	lw $s6 , FlagTreeRoot
	addi $s6 , $zero , 0
	sw $s6 , FlagTreeRoot
	lw $s6 , 0($sp)
	addi $sp , $sp , 4
	jr $ra

##############################################################
## Registers Used (save inside stack) ##
########################################
# $a1 : Tree Number
# $t1 : Temporary for carry the start place in .data memory
# $s5 : Pointer to All Trees Roots
##############################################################

SelectTreeRoot:
	addi $sp , $sp , -8
	sw $t1 , 0($sp)
	sw $a1 , 4($sp)
	la $t1 , StartTreeRoot
	addi $a1 , $a1 , -1
	mul $a1 , $a1 , 8 
	add $t1 , $t1 , $a1
	sw $t1 , AboAlaaWeAbdo
	lw $s7 , 0($t1)
	lw $t1 , 0($sp)
	lw $a1 , 4($sp)
	addi $sp , $sp , 8
	jr $ra
## strat depth 
TreeDepth:
	# Store in Stack
	addi $sp , $sp , -16
	sw $ra , 0($sp)	  # Return Call
	sw $a0 , 4($sp)  # Need in Workable Pointer
	sw $s1 , 8($sp)  # Need in Result : A
	sw $s2 , 12($sp) # Need in Result : B
	beq $a0 , 0 , Base_Case
	j Rec_Depth
Base_Case:
	# Base Case
	addi $v0 , $zero , 0
	addi $sp  $sp , 16
	jr $ra
Rec_Depth:
	# Move Left
	lw $a0 , 4($a0)
	# Call TreeDepth
	jal TreeDepth 
	# Load Workable Again
	lw $a0 , 4($sp)
	# Work on Result : A
	move $s1 , $v0 # 1
	# Move Right
	lw $a0 , 8($a0)
	# Call TreeDepth
	jal TreeDepth 
	# Work on Result : B
	move $s2 , $v0 # 0
	# Operation
	ble $s1 , $s2 , Increase_B	# If A <= B , Increase_B
	bgt $s1 , $s2 , Increase_A # If A > B , Increase_A
	Restore:
	# Restore from Stack
	lw $ra , 0($sp)	  # Return Call
	lw $a0 , 4($sp)  # Need in Workable Pointer
	lw $s1 , 8($sp)  # Need in Result : A
	lw $s2 , 12($sp) # Need in Result : B
	addi $sp , $sp , 16
	jr $ra
	# Increase A by one
	Increase_A:
		addi $s1 , $s1 , 1
		move $v0 , $s1
		j Restore
	# Increase B by one
	Increase_B:
		addi $s2 , $s2 , 1
		move $v0 , $s2
		j Restore

Delete:
	move $s5,$ra
	addi $a0,$zero,1
	DeleteTwo:
	jal Search # a2 is the address of the root and $a3 is the value to delete
	move $s0,$v0  # address of element
	move $s1,$v1  # address of parent
	addi $t7,$zero ,-1
	beq $v0, $t7,EEWXIT
	beq $v1,$0,Root
	Abdo:
	lw $t1,4($s0) # address of left of the element
	lw $t2,8($s0) # address of right of the element
	sne $t3,$t2,$0 # if there is right
	sne $t4,$t1,$0 # if there is left
	add $t5,$t3,$t4 # 
	beq $t5,$0,CaseOne # there is no left neither right
	beq $t4,1,CaseTwoI
	beq $t3,1,CaseTwoII
CaseOne:
	addi $s2,$s1,4
	lw $s2,0($s2)
	beq $s2,$s0,Null
	addi $s2,$s1,8
	lw $s2,0($s2)
	beq $s2,$s0,Null
	j RA
Null:
	sw $0,0($s2)
	sw $0,0($s0)
CaseTwoI:
	beq $t3,1,FinalCase
	lw $t8,4($s1) # left of the parent
	beq $t8,$s0,CaseThreeII # if the element in left of the parent
	lw $t6,4($s0)
	sw $t6,8($s1)
	j RA
CaseTwoII:
	beq $t4,1,FinalCase
	lw $t8,4($s1) # left of the parent
	beq $t8,$s0,CaseThreeI # if the element in left of the parent
	# else the element in right of the parent
	lw $t8, 8($s0)
	sw $t8, 8($s1)
	j RA
CaseThreeI:
	lw $t6,8($s0)
	sw $t6,4($s1)
	j RA
CaseThreeII:
	lw $t6,4($s0)
	sw $t6,4($s1)
	j RA
FinalCase:
	# else the element has left and right
	move $t0,$t1 # both t1 and t0 has the address of left of the element
	Loop:
		lw $t2,8($t0) # right of left of the element
		beq $t2,$0,FinalCaseII
		move $t1,$t0
		move $t0,$t2
		j Loop
	FinalCaseII:
	lw $t7,4($s0)
	beq $t7,$t0,LeftWithoutRight
	lw $t6,0($t0)
	sw $t6,0($s0)
	move $a2,$t1
	move $a3,$t6
	j DeleteTwo
LeftWithoutRight:
	beq $s1,$0,RRoot 
	sw $t0,4($s1)
	lw $t8,8($s0)
	sw $t8,8($t0)
	j RA
RRoot:
	lw $t9 ,4($s0)
	lw $s1 ,0($t9)
	sw $s1 , 0($s0)
	sw $0 ,4($s0)
	sw $0 ,0($t9)	
	move $ra,$s5
	jr $ra
Root:
	lw $t2,4($s0)
	lw $t3,8($s0)
	add $t1,$t2,$t3
	beq $t1,$0,BeforeRA
	beq $t2,$0,RootNoLeft
	beq $t3 , $0 , RootNoRight
	j Abdo
RootNoRight:
	lw $t7,0($t2)
	lw $t8,4($t2)
	lw $t9,8($t2)
	sw $t7,0($s0)
	sw $t8,4($s0)
	sw $t9,8($s0)
	sw $0, 0($t2)
	sw $0, 4($t2)
	sw $0, 8($t2)
	move $ra,$s5
	jr $ra
RootNoLeft:
	lw $t7,0($t3)
	lw $t8,4($t3)
	lw $t9,8($t3)
	sw $t7,0($s0)
	sw $t8,4($s0)
	sw $t9,8($s0)
	sw $0, 0($t3)
	sw $0, 4($t3)
	sw $0, 8($t3)
	move $ra,$s5
	jr $ra
BeforeRA:
	lw $v0 , AboAlaaWeAbdo
	addi $v0 , $v0 , 4
	sw $zero , 0($v0)
RA:
	move $ra,$s5
	sw $0,0($s0)
	sw $0,4($s0)
	sw $0,8($s0)
	jr $ra	
EEWXIT:
	move $ra,$s5
	li $v0,4
	la $a0,notDeleteMessage
	syscall 
	jr $ra	
Search:
	# Stack Store
	subu $sp, $sp, 28
    sw $a2, 0($sp) # root
    sw $a3, 4($sp) # data
    sw $s0, 8($sp) 
    sw $t0, 12($sp)
    sw $t1, 16($sp)
    sw $t7, 20($sp)
    sw $t9, 24($sp)
 
	# Conditions 
	# Check if Root is not NULL
	beq $a2 , 0 , end
	beq $s0 , 1 , end

	# Operations
		# Load Value of Data in $t0
		lw $t0 , 0($a2)
		beq $t0 , $a3 , Found
		slt $t1 , $a3 , $t0
		beq $t1 , 1 , GoLeft
		addi $t9, $a2, 0
		lw $t0 , 8($a2)
		move $a2 , $t0
		j Search
		Found:
		beq $a0 , 0, wwexit
			move $v0 , $a2 # address of element 
			move $v1, $t9# address of parent 
			j wwwexit
		wwexit: 
		addi $v1, $zero ,1
		wwwexit:
    		lw $a2, 0($sp)
    		lw $a3, 4($sp)
    		lw $s0, 8($sp)
    		lw $t0, 12($sp)
    		lw $t1, 16($sp)
    		lw $t7, 20($sp)
    	 	lw $t9, 24($sp)
    		addi $sp, $sp, 28
			jr $ra
		GoLeft:
			addi $t9, $a2, 0
			lw $t0 , 4($a2)
			move $a2 , $t0
			j Search
		end:
			addi $v0 , $zero , -1
			lw $a2, 0($sp)
    		lw $a3, 4($sp)
    		lw $s0, 8($sp)
    		lw $t0, 12($sp)
    		lw $t1, 16($sp)
    		lw $t7, 20($sp)
    		    	 	lw $t9, 24($sp)
    		addi $sp, $sp, 28
			jr $ra

NotFound:
	li $v0,4
	la $a0,printnotFound
                  	syscall	
	jal after
EmptyTree:
	li $v0,4
	la $a0,printempty
                  	syscall	
	jal after
