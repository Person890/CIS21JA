comment !

October 30, 2019

This program prompts user to enter 10 integers, stores them in an array,
calculates and displays the sum and mean of array, and rotates the 
elements one step forward for the entire array

!


include Irvine32.inc

.data
prompt  BYTE "Please input an integer: ", 0
orArr	BYTE "The original array is: ", 0
sumLine BYTE "The sum is: ", 0
meanLine	BYTE "The mean is: ", 0
shift	BYTE "After a rotation: ", 0
slash	BYTE "/10", 0
space	BYTE " ", 0
numArr  DWORD 10 DUP(?)			;declare 10 undefined ints in array
sum		DWORD 0					;sum of the array
meanQ	DWORD ?					;quotient of the mean
meanR	DWORD ?					;remainder of the mean
count	DWORD ?					;save counter for nested loop
counter	DWORD 0					;for the beginning of array
temp	DWORD 0


.code
main PROC
    mov esi, OFFSET numArr
    mov ecx, LENGTHOF numArr	;sets counter to 10
   
	mov ebx, sum				;move sum value to register
    mov edx,OFFSET prompt


L1: call writeString			;prompt user to enter int
    call readInt				;read int into eax
    mov [esi], eax			;store in current arr element
    add esi, TYPE SDWORD	;move to next int
    loop L1


    mov	edi, OFFSET numArr		;make edi point to the beginning of array
    mov ecx, LENGTHOF numArr	;store 10 in loop counter

L2:	mov eax, sum				;store sum in eax
	add eax, [edi]				;add current element to eax
    mov sum, eax				;save updated sum into variable
	;mov eax, [edi]				;put current element back to eax to display
    add edi, TYPE numArr		;move to next int

    loop	L2					;decrement ecx


	call	crlf				;empty line
	mov	edx, offset sumLine		;output sum line
	call writeString
	mov		eax, sum			;move sum to display it
	call	writeDec			;display sum

	mov	ecx, LENGTHOF numArr	;store 10 in ecx
	sub edx, edx				;prevent divide overflow by zeroing edx
	div ecx						;divide by the length of array 
	mov meanQ, eax				;save quotient in meanQ variable
	mov meanR, edx				;save remainder in meanR variable

	call crlf
	mov	edx, offset meanLine	;output sum line
	call writeString

	mov	eax, meanQ				;outputing the quotient
	call writeDec

	mov edx, offset space		;outputing space
	call writestring

	mov eax, meanR				;outputing remainder
	call writeDec


	mov edx, offset slash		;outputing slash
	call writeString
	call crlf

		
    mov edi, OFFSET numArr		;make edi point to the beginning of array
    mov ecx, LENGTHOF numArr	;store 10 in loop counter
	mov edx, OFFSET orArr
	call writeString			;outputing "original array"

L6: 
	mov eax, [edi]				;put current element back to eax to display
    add edi, TYPE numArr		;move to next int
    call	writeDec            ;display current eax value
	mov eax, ' '
	call writeChar

	loop L6

	mov ecx, LENGTHOF numArr -1 	;decrementing ecx for inner loop
	call crlf


L3: 
	mov edx, OFFSET shift			;outputing "after one rotation"
	call writeString
	mov count, ecx					;saving ecx because of nested loop
	mov ecx, LENGTHOF numArr

	mov ebx, ecx					;saving ecx because of other loop

	mov ecx, LENGTHOF numArr - 1	;decrementing ecx
	sub ecx, temp
	inc temp						;variable for the right side

	mov edx, OFFSET numArr + SIZEOF numArr - TYPE numArr 
	mov eax, [edx]
	

L4:
	mov esi, [edx - TYPE numArr]	;moving element with previous element
	mov [edx], esi
	sub edx, TYPE numArr

	loop L4							;looping L4

	mov [edx], eax					
	mov ecx, ebx					;continuing with saved ecx
	mov edx, offset numArr			;pointing to beginning of array

L5:									;loop printing array
	mov eax, [edx]
	call writeDec
	mov eax, ' '
	call writeChar 
	add edx, TYPE numArr			;moving to another element
	
	loop L5



	mov ecx, count					;continuing outer loop with saved ecx
	call crlf						;new line
	loop L3


exit
main ENDP
END main


comment !
SAMPLE RUN

Please input an integer: 2
Please input an integer: 4
Please input an integer: 6
Please input an integer: 8
Please input an integer: 10
Please input an integer: 11
Please input an integer: 20
Please input an integer: 12
Please input an integer: 2
Please input an integer: 3

The sum is: 78
The mean is: 7 8/10
The original array is: 2 4 6 8 10 11 20 12 2 3
After a rotation: 3 2 4 6 8 10 11 20 12 2
After a rotation: 3 2 2 4 6 8 10 11 20 12
After a rotation: 3 2 12 2 4 6 8 10 11 20
After a rotation: 3 2 12 20 2 4 6 8 10 11
After a rotation: 3 2 12 20 11 2 4 6 8 10
After a rotation: 3 2 12 20 11 10 2 4 6 8
After a rotation: 3 2 12 20 11 10 8 2 4 6
After a rotation: 3 2 12 20 11 10 8 6 2 4
After a rotation: 3 2 12 20 11 10 8 6 4 2


!
