*----------------------------------------------------------------------
* Programmer: Reece Kidd
* Class Account: cssc0215
* Assignment or Title: recursiveStringReversalSubRoutine
* Filename: recursiveStringReversalSubRoutine.s
* Class Account: cssc0215
* Date completed: 05/03/2017
*----------------------------------------------------------------------
* Method and/or pseudocode:
* 
* Code given in instructions:
* void reverse(char *in, char *out, int count) {
*    if(count == 0)
*        return;
*    reverse(in+1,out,--count);
*    *(out+count) = *in;
*    }
*
* Using the code given in class, I was able to translate the code from 
* the triangles number reverse call, to make it applicable with 
* reversing a string. 
*
* Changing the necessary elements to match the code given in the instructors. 
* I wrote it out in plain English, before creating pseudocode for the task. 
* I had a few problems managing the stack but after the lecture I got the
* recursive call working. 
* 
* 
*-----------------------------------------------------------------------

	ORG	$6000		*Start at location 6000 in memory. 
	
				
reverse:link	A6,#0		*Puts old A6 onto the stack. 
	movem.l	A0-A2/D1,-(SP)	*Puts values onto the stack.  
	
	move.l	8(A6),A1	*Moves 'in' parameter from stack and places it in register A1. 
	move.l	12(A6),A2	*Moves 'out' parameter from stack and places it in register A2. 
	move.w	16(A6),D1	*Moves the 'count' parameter from stack and places it in D1. 
	
	tst.w	D1		*Check if count is equal to 0. 
	beq	FIN		*If count is == 0 branch to finish.  
						
	move.l	A1,A0		*Duplicates A1 and stores in A0. 
	addq.l	#1,A0		*Moves down to next recursion.  
	subq.w	#1,D1		*Takes one from the string count. 
	
	move.w	D1,-(SP)	*Moves next count parameter onto the stack. 
	pea	(A2)		*Places new "out" parameter onto the stack. 
	pea	(A0)		*Places new "in" parameter onto the stack. 
	
	JSR 	reverse		*Recursive call to reverse sub routine. 
	
	adda.l	#10,SP		*Pops parameters of the stack as it's two longwords and a word.  
	
	ext.l	D1		*Extends the word in D1(count) to a longword. 
	adda.l	D1,A2		*Adds address of D1, TO A2. 
	move.b	(A1),(A2)	*Moves byte from A1 to A2
	
FIN:	movem.l	(SP)+,A0-A2/D1	*Restores the registers
	
	unlk	A6		*Unlinks A6 - removing the old A6 from the stack.  
	rts			*Removes return address from the stack
	 
END:	end 			*Ends the reverse.s sub routine. 
	
*---------------------------------------------------------------------------
	
 
	
