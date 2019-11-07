comment !
	
	Nov 6, 2019

	This program takes two integers as an input from a user,
	displays the sum and difference of the integers in the middle
	of the screen. Program repeats this process three times.
 
!


INCLUDE Irvine32.inc

.data

	prompt BYTE "Please enter an integer: ", 0
	sumIs BYTE "The sum of the two integers is: ", 0
	diffIs BYTE "The difference between integers is: ", 0
	keyprompt BYTE "Press any key...", 0

	first DWORD ?
	second DWORD ?

.code

main PROC					;main procedure
	mov ecx, 3				;setting loop counter to 3	

L1:							;asking for input three times
	call Locate				;calling first procedure
	loop L1

	exit
main ENDP



Locate PROC		
;	This procedure locates the cursor to the middle of 
;	the screen and calls Input procedure
;---------------------------------------------------------
	call clrscr
	mov   dh,14			; row 14
	mov   dl,40			; column 40
	call  Gotoxy		; locate cursor
	
	call Input
	ret
Locate ENDP

Input PROC
;	This procedure prompts user to enter two inputs 
;	and stores them in two variables 
;	then calls the DisplaySum procedure
;--------------------------------------------------------

	sub eax, eax
	
	mov edx, OFFSET prompt
	call writeString
	call readInt
	mov first, eax

	mov   dh, 15			; row 10
	mov   dl, 40			; column 20
	call  Gotoxy; locate cursor

	mov edx, OFFSET prompt
	call writeString
	call readInt
	mov second, eax

	call DisplaySum
	ret
Input ENDP


DisplaySum PROC
;	This procedure calculates and displays the sum 
;	of the two previously entered integers 
;	then calls the DisplayDiff procedure
;---------------------------------------------------------
	
	mov eax, first
	mov ebx, second
	add eax, ebx

	mov   dh, 16			; row 10
	mov   dl, 40			; column 20
	call  Gotoxy; locate cursor

	mov edx, OFFSET sumIs
	call writeString
	call writeInt

	call crlf

	call DisplayDiff
	ret
DisplaySum ENDP 


DisplayDiff PROC
;	This procedure calculates and displays the difference 
;	of the two integers then calls the WaitForKey function
;-----------------------------------------------------------

	mov   dh, 17			; row 10
	mov   dl, 40			; column 20
	call  Gotoxy; locate cursor

	mov edx, OFFSET diffIs
	call writeString

	mov eax, first
	mov ebx, second
	sub eax, ebx
	call writeInt
	call crlf

	call WaitForKey
	ret
DisplayDiff ENDP

WaitForKey PROC
;	This procedure prompts user to enter any character 
;	to enter another set of integers and to exit in the third loop
;------------------------------------------------------------
	mov   dh, 18			; row 10
	mov   dl, 40			; column 20
	call  Gotoxy; locate cursor
	
	mov edx, OFFSET keyPrompt
	call writeString
	call readChar
	
	ret
WaitForKey ENDP


END main

comment !
SAMPLE OUTPUT
                                                                              Please enter an integer: 9
   Please enter an integer: -12
   The sum of the two integers is: -3
   The difference between integers is: +21
   Press any key...

!