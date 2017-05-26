*----------------------------------------------------------------------
* Programmer:Reece Kidd
* Class Account:cssc0215
* Assignment or Title: Loan Payment Calculator
* Filename: loanPaymentCalculator.s
* Date completed:03/21/2017
*----------------------------------------------------------------------
* Problem statement:Write a loan payment calculator. 
* Input:
* Principal amount borrowed - Float.
* Annual percentage rate - Float.
* Length of loan in months - Integer.
* Output: 
* "Your monthly payment will be $ + Floating point number.
* Error conditions tested:N/A
* Included files:N/A
* Method and/or pseudocode: 
* My approach was to first take all the input from the user, make sure
* all user data could be used in future equations. 
* I then ensured that all numbers I would need to convert the input to 
* numbers that could be used in the equation where present. The main problem
* here was taking the total interest and making it the monthly interest.
* With everything I needed, I split the formula up and handled the 
* individual sections. 
* From here I tested a variety of different inputs and compared it to both
* the calculator result and an online mortage calculator to compare my 
* answers.
* References:
* Floating Point Macro Documentation, Alan Riggins, 2012
* I/O Macro Documentation, Alan Riggins, 2005
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
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
start:	initIO			*Initalize input output field.
	setEVT			*Error handling routines
	initF			*For floating point macros only	
	
	lineout	title		*Displays program information
	lineout	loan		*Asks user to enter loan value.
	floatin	buffer		*Reads in ASCII total loan value.
	cvtaf	buffer,D1	*Total loan value to float point.
	lineout	perct		*Asks user for percentage.
	floatin	buffer		*Reads in ASCII total percentage.
	cvtaf	buffer,D2	*Total percentage to float point.
	lineout	len		*Asks user for loan total.
	floatin	buffer		*Reads loan length as a ASCII
	cvtaf	buffer,D3	*Total loan length is stored in D4.
	moveq	#100,D4		*100 to be converted to float.
	moveq	#12,D5		*12 to be converted to float.
	moveq	#1,D6		*1 to be converted to float.
	itof	D4,D4		*Floating point 100.
	itof	D5,D5		*Floating point 12.
	itof	D6,D6		*Floating point 1..
	fdiv	D4,D2		*Total Interest rate divided by 100.
	fdiv	D5,D2		*Result divided by 12, to get monthly interest rate.
	move.l	D2,D5		*Stores the monthly interest rate.
	fadd	D6,D2		*Adds 1 to monthly interest rate value. 
	fpow	D2,D3		*(Monthly interest rate + 1) ^ length of loan.
	move.l 	D0,D4		*Stores the Fpow result replaces #100.00
	fmul	D4,D5		*Stores the value of Fpow result multiplied by monthly interest rate.		
	fsub	D6,D4		*((l+r)^n) - 1
	fdiv	D4,D5		*(r(1 + r)^n)/((l+r)^n)-1
	fmul	D1,D5		*Multiplies result by the amount borrowed. 
	move.l	D5,D0           *Places result in D0 for use by CVTFA.
	cvtfa	result,#2	*Takes result from D0
			
	
	
	lineout	answer
 
	
	break			*Terminate Program
*
*----------------------------------------------------------------------
*       Storage declarations
title:	dc.b	'Program #2, Reece Kidd, cssc0215',0
perct:	dc.b	'Enter the annual percentage rate:',0
loan:	dc.b	'Enter the amount of the loan:',0
len:	dc.b	'Enter the length of the loan in months:',0
answer:	dc.b	'Your monthly payment will be $'
result: ds.b	32
buffer:	ds.b	82

	end				

