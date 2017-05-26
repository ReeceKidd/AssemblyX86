*----------------------------------------------------------------------
* Programmer:Reece Kidd
* Class Account:cssc0215
* Assignment or Title: American Date Convertor
* Filename: americanDateConvertor.s
* Date completed:03/01/2017
*----------------------------------------------------------------------
* Problem statement:Convert a string of MM/DD/YYYY to name of month, plus date, *plus year
* Input:MM/DD/YYYY
* Output: A String
* Error conditions tested:None
* Included files:
* Method and/or pseudocode: 
* References: 
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
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
	initF			* For floating point macros only	

	lineout	title
	lineout	skipln
	lineout	prompt
	linein	buffer
	cvta2	buffer,#2
	subi.l	#1,D0		*Index, not Month.
	move.l	D0,D1		*Copy of index used by length.
	mulu	#4,D1		*Offset for length.
	mulu	#10,D0		*Offset for month.
	lea	month,A0
	adda.l	D0,A0		*Add offset to point to the right month
	move.l	(A0)+,date	*Copy month to output.
	move.l	(A0)+,date+4
	move.w	(A0)+,date+8
	lea	date,A0		*Load output buffer.
	lea	length,A1	*Length of each month in array.
	adda.l	D1,A1		*Add offset to select correct length.
	adda.l	(A1),A0		*Move down pointer to correct month
				*add it to length array, add that length to 						*output.
	move.b	#' ',(A0)+
	move.b	buffer+3,(A0)+	*Puts day in output.
	move.b	buffer+4,(A0)+
	suba.l	#2,A0		*Reset pointer to beginning.
	stripp	(A0),#2		*Remove leading zeros.
	adda.l	D0,A0		*Move down past day.
	move.b	#',',(A0)+
	move.b	#' ',(A0)+
	move.b	buffer+6,(A0)+	*Copy year to output.
	move.b	buffer+7,(A0)+
	move.b	buffer+8,(A0)+
	move.b	buffer+9,(A0)+
	move.b	#'.',(A0)+
	clr.b	(A0)		*Null Terminate.
	lineout	answer


        break                   *Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
month:	dc.b	'January   '
	dc.b	'February  '
	dc.b	'March     '
	dc.b	'April     '
	dc.b	'May       '
	dc.b	'June      '
	dc.b	'July      '
	dc.b	'August    '
	dc.b	'September '
	dc.b	'October   '
	dc.b	'November  '
	dc.b	'December  '
length:	dc.l	7,8,5,5,3,4,4,6,9,7,8,8
title:	dc.b	'Program #1, Reece Kidd, cssc0215',0
skipln:	dc.b	0,0
prompt:	dc.b	'Enter a date in the form of MM/DD/YYYY',0
answer:	dc.b	'The date entered is '
date:	ds.b	24
buffer:	ds.b	82
	end				

