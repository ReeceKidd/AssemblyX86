*----------------------------------------------------------------------
* Programmer: Reece Kidd
* Class Account: cssc0215
* Assignment or Title: Recursive String Reversal Main
* Filename: recursiveStringReversalMain.s
* Date completed: 05/03/2017
*----------------------------------------------------------------------
* Problem statement: Reverse a string inputted by the user. 
* Input: String 
* Output: Reversed String
* Error conditions tested: Tested if the string was empty. 
* Included files: prog4.s, reverse.s 
* Method and/or pseudocode: 
* Understanding that I would have to push the parameters onto the stack, 
* call the recursive sub routine anf then pop the garbage of the stack I 
* began working.
* To begin with I gathered all the code from the lectures on recursion and 
* subroutines. 
* I sketched out the pseudocode of the recursion first of all,
* followed by a rough outline of what I believed I would need for prog4.s
* With the rough pseudcode I began the assembly code. The main problem was 
* understanding how the stack works, and making it work recursively. 
* It was then mostly trial and error to get the program to work. 
* References: CS237 Programming Assignment #4 Specification. 
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
	
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*

reverse:EQU	$6000		*Location of the reverse sub routine. 

start:	initIO			*Initialize IO.
	setEVT			*Error handling routines.

	lineout title   	*Prints program information. 
begin:	lineout	prompt		*Prompts user to enter string to be reversed. 
	linein  buffer		*Stores users input. 
	
	tst.w	D0		*Tests if D0 is empty. 
	beq	EMPTY		*If it is empty prompt error message. 
	bra	PUSH		*Branch to PUSH label.
	
EMPTY:	lineout	eErr		*Prompt empty error message. 
	bra	begin		*Goes back to the start of the program. 
	
				*Push onto the stack. 
		
PUSH:	move.w	D0,-(SP)	*Places length of users input on the stack. (Count parameter).  
	pea 	reverStr	*Push effective address of the reversed string on the stack. (Out parameter).
	pea 	buffer		*Push effective address of the buffer on the stack. (In parameter). 
	
	jsr	reverse		*Jumps to the reverse string sub routine.  
	
				*Pop of the stack. 
	
	adda.l	#10,SP		*Pop's 10 bytes of the stack because of two addresses, and a word being pushed. 
	
	movea.l	#reverStr,A0  	*Moves address of reversed string into A0.
	adda.l	D0,A0		*Sets A0 to the end of the reversed string. 
	clr.b	(A0) 		*Null terminates string. 
	lineout	answer		*Prints answer message. 
	lineout	reverStr		*Prints the reversed string. 
	
	break			*End program
	
*
*----------------------------------------------------------------------
*       Storage declarations
title:	dc.b	'Program #4, Reece Kidd, cssc0215',0
prompt:	dc.b	'Enter a string:',0
eErr:	dc.b	'Please enter a string, not an empty value.',0
buffer:	ds.b	82
answer:	dc.b	'Here is the string backwards:',0
reverStr: ds.b	82

	end	
	 		
