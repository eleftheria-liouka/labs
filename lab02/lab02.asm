# Palindrome detection in MIPS assembly using MARS
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
     
main:
        la	$s1, mesg         # get address of mesg to $s1
        addu	$s2, $s1, $zero	  # $s2=$s1
        add	$t1,$t1,$zero     #Give to temporary t1 the value 0
        
loop:
        addi	$t1,$t1,1         #Count the length of the string
        addiu	$s2, $s2,   1     # $s2=$s2 + 1
        lbu	$t0, 0($s2)       # get next character
        bne	$t0, $zero, loop  # repeat if char not '\0'
        # end of loop here
	
	addiu	$s2, $s2,  -1     # Adjust $s2 to point to last char
	
	lbu	$t2, 0($s1)       # Get the character from s1
	lbu	$t3, 0($s2)       # Get the character from s2
	bne	$t2,$t3, not_palindrome    #If the first and last characters aren't equal then exit
	
	add	$t2,$t1,$zero	  # Keep the length of the string to make calculations
	
	#Check if lenght is even or odd
	andi	$t0,$t1,0x1
	beq	$t0,$zero,loop_even	#If length which is in t1 is even go to loop_even
        
loop_odd:
	addiu   $s1,$s1,1		# $s1=$s1 + 1
	addiu   $s2,$s2,-1		# $s2=$s2 - 1
	addiu	$t2,$t2,-2		# In every loop we subtract the number 2 because this is the number of steps we did, one for s1 and one for s2
	beq	$t2,1,palindrome	# Reached the middle character, so it is palindrome
	lbu     $t3, 0($s1)       	# Get the character from s1
	lbu     $t4, 0($s2)      	# Get the character from s2
	beq     $t3,$t4, loop_odd	# If the two characters are equal loop_odd
	# end of loop here
	
	j not_palindrome		# If the two characters aren't equal then the word is not palindrome
	
loop_even:       
	addiu	$t2,$t2,-2		# In every loop we subtract the number 2 because this is the number of steps we did, one for s1 and one for s2
	beq	$t2,0,even_last		# Reached the two last characters, We have to compare them to see if it is palindrome
	addiu   $s1,$s1,1		# $s1=$s1 + 1
	addiu   $s2,$s2,-1		# $s2=$s2 - 1
	lbu     $t3, 0($s1)       	# Get the character from s1
	lbu     $t4, 0($s2)      	# Get the character from s2
	beq     $t3,$t4, loop_even	# If the two characters are equal loop_even
	# end of loop here
	
	j not_palindrome		# If the two characters aren't equal then the word is not palindrome
	
	
even_last:				# This case is only for even words to compare the last two characters
	lbu     $t3, 0($s1)       	# Get the character from s1
	lbu     $t4, 0($s2)      	# Get the character from s2
	beq     $t3,$t4, palindrome	# If the two characters are equal the word is palindrome
	j not_palindrome
	
palindrome:
	add	$a0,$a0,$zero		# The word is palindrome, we put value 0 to a0
	j exit				# Then exit
	
not_palindrome:
	add	$a0,$a0,$zero		# The word is not palindrome, we put value 1 to a0
	addi	$a0,$a0,1		# Then exit
	j exit
	
exit: 
        addiu   $v0, $zero, 10		# system service 10 is exit
        syscall                 	# we are outta here.
        
###############################################################################

        .data
mesg:   .asciiz "racecar"
