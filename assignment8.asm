Title Assignment 8

COMMENT !

*****************
date: 11/30/2019
*****************


Description:
	This program prompts user to enter number of elements in his/her 2D
	array. Afterwards it asks for number of rows, data type of elements and
	finally all the values in the array. 
	In the end program prompts user to input number of row which he/she
	wants to sum up and returns the sum
!

include irvine32.inc
; ===============================================

.data

prompt1 BYTE "Enter how many elements in your array: ", 0
prompt2 BYTE "Enter the row size: ", 0
prompt3 BYTE "*It should divide the array into equal rows", 0
prompt4 BYTE "Enter the type of your array.", 0
prompt5 BYTE "1 for byte, 2 for word, and 3 for doubleword", 0
prompt6 BYTE "Enter an element in your array", 0
prompt7 BYTE "Enter row number that you want me to sum", 0
prompt8 BYTE "The sum is : " , 0

arr DWORD 40 dup (?)
rowIndex BYTE ?
arrSize BYTE ?
rowSize BYTE ?
dataType BYTE ?


;=================================================
.code

main proc

	mov edx, offset prompt1			;prompting user to enter arr size
	call writeString
	call crlf

	push 40							;the max size
	call getArrSize					;get input on how many elements in arr

	pop eax							;save user input
	mov arrSize, al					;save in variable

	mov edx, offset prompt2			;prompt user to enter how many elements
									;are there in a row

	call writeString
	call crlf

	mov edx, offset prompt3
	call writeString
	call crlf

	push eax						;push the input to the stack

	call getArrSize					;get how many elements in a row
	pop eax							;save in register
	mov rowSize, al					;save in a variable
		
	push 3							;three types

again: 
	
	mov edx, offset prompt4			;prompt user to enter type of variables
	call writeString
	call crlf

	mov edx, offset prompt5			;variety of types
	call writeString
	call crlf

	call getArrSize
	pop eax							;save user input in register
	mov dataType, al				;save in a variable
		

comment !
	c++ equivalent - how to decide what type of elements
	
	bool flag = true;
	while(flag)
	if(dataType == 1)
		enterEl(BYTE, offset arr, arrSize, rowSize)
		flag = false;

	else if(dataType == 2)
		enterEl(WORD, offset arr, arrSize, rowSize)
		flag = false;

	else if (dataType == 4)
		enterEl(DWORD, offset arr, arrSize, rowSize)
		flag = false;
	else 
		flag = true
!

	cmp dataType, 1			
	jne notByte

	push BYTE					;if user entered 1
	jmp type_is

notByte:
	cmp dataType, 2
	jne notWORD

	push WORD					;if user entered 2
	jmp type_is

notWORD:						;if the input isn't 1 or 2

	cmp dataType, 4				;if user entered 4
	jne notDWORD

	push DWORD
	jmp type_is		

notDWORD:						;if user didn't choose 1, 2 or 4 prompt again 

	mov dataType, 0
	xor eax, eax
	jmp again

type_is:

	push offset arr				;push the address of array to pass 

	xor eax, eax				;zero out the eax
	mov al, arrSize
	push eax					;move array size on the stack
		
	call enterEl

	mov edx, offset prompt7			;ask user which row does he/she	
	call writeString				;want to sum
	call crlf

	mov al, arrSize
	div rowSize						;saving in al how many rows are there

	dec al							;decrementing because index starts
									;with 0 not 1

	push eax						;pushing on stack to pass to function
	call getArrSize
	pop eax							;saving user input in register
	mov rowIndex, al				;saving user input in variable	

	sub esp, 4						;making space for the output


	push offset arr					;passing address of array on the stack
	mov al, rowSize					;passing the size of one row

	push eax

comment !
	
	if(dataType == 1)
		calcRowSum(offset arr, arrSize, BYTE, rowSize)

	else if(dataType == 2)
		calcRowSum(offset arr, arrSize, WORD, rowSize)
	
	else 
		calcRowSum(offset arr, arrSize, DWORD,rowSize)

!
	
	cmp dataType, 1
	jne notByte2					

	push BYTE					;if type byte
	jmp type_again


notByte2:
	cmp dataType, 2
	jne notWORD2

	push WORD						;if word
	jmp type_again


notWORD2:
	push DWORD						;if neither byte or word

type_again:        

	mov al, rowIndex
	push eax						;passing the result to the procedure


	call calcRowSum
	pop eax							;saving the output in register

	mov edx, offset prompt8			;showing user the sum
	call writeString
	call writeInt
	call crlf

exit
main endp

comment!
 ================================================
c++ equivalent to getArrSize procedure

void getArrSize(int max)			;max is 40

Input:
	max - maximum value user can input

Output:

Operation:
	read input (size of array) from user

!
; ================================================

getArrSize PROC

	push ebp
	mov ebp, esp						;save the current esp

	push eax
	xor eax, eax						;clear out eax

	call readDec

whileLoop:
		cmp eax, [ebp + 8]
		ja takeInput

		cmp eax, 0
		jb takeInput

		jmp out00
	takeInput:
		call readInt
		jmp whileLoop

out00:

	mov [ebp+8], eax
	pop eax
	pop ebp

	ret
getArrSize ENDP


comment !
================================================


void enterEl(int dataType, &arr, int arrSize)


Input:
	datatype of elements
	address of array that user is going to input elements to 

	arrSize - user's input 
	rowSize number of rows
Output:
	No output
Operation:
	User will be prompt to enter every element, fill the array and 
	not return anything

================================================
!
enterEl PROC

	push ebp
	mov ebp, esp							;save current esp

	push edx
	push ebx
	push eax
	push edi


	mov edi, [ebp + 12]						;the address of arrary
	mov ebx, [ebp + 8]						;the size of array

	xor eax, eax

comment ! 
	c++ code equivalent 

	while(eax < ebx) {
		eax = readInt;
		arr[edi] = eax;
		eax++;
	}
!

inputArr:
		xor edx, edx
		mov edx, offset prompt6		;prompt user to enter the elements
		call writeString
		call crlf

		mov edx, [ebp + 16]			;refering to data type

		cmp eax, ebx
		jae out00
		push eax
		call readInt				;get user input
		mov [edi], eax				
		pop eax
		add edi, edx				;move to next element
		inc eax
		jmp inputArr

out00:

	pop edi
	pop eax
	pop ebx
	pop edx
	pop ebp
	ret 12

enterEl ENDP

; ================================================

comment !

int calcRowSum(int *arr, int rowSize, int type, int rowIndex)

Input:
	the address of array to be summed 
	rowsize - how many rows are there
	type of values
	rowIndex - user's choice

Output:
	int - the sum of chosen row

Operation:
	sums and returns row of 2D array chosen by user
!

; ================================================

calcRowSum PROC

	push ebp
	mov ebp, esp			;saving current esp

	push edi
	push edx
	push ecx
	push ebx
	push eax

	mov edi, [ebp + 20] ; the array offset
	mov ecx, [ebp + 12] ; datatype
	mov ebx, [ebp + 16 ] ; row size

comment !

	c++ equivalent
	int eax = rowSize * datatype * rowIndex;
	
	edi = edi + eax;
	eax = 0;
	ebx = 0;

	if(ecx == byte)
		while(ebx < edx) {
			al += [edi];
			edi += ecx;
			ebx++;
		}
	else if(ecx == word)
		while(ebx < edx) {
			ax += [edi];
			edi += ecx;
			ebx++;
		}
	else
		while(ebx < edx) {
			eax += [edi];
			edi += ecx;
			ebx++;
		}
	[ebp + 24] = eax;
!
	xor edx, edx
	mov eax, ecx
	mul ebx						;now eax storing an index of the beginning
								;of the array

	mov ebx, [ebp + 8]			;taking from the user input
	mul ebx						;multiplying to get to the correct row
	add edi, eax

	xor eax, eax
	mov edx, [ebp + 16] 
	xor ebx, ebx
	cmp ecx, 1
	jne notByte3

L6:
		cmp ebx, edx
		jae out01

		add al, [edi]
		add edi, ecx

		inc ebx
		jmp L6

out01:
		jmp L7

notByte3:

		cmp ecx, 2
		jne L10

L8:
		cmp ebx, edx
		jae out02
		add ax, [edi]
		add edi, ecx
		inc ebx
		jmp L8

out02:
		jmp L7

L10:
		cmp ebx, edx
		jae out03

		add eax, [edi]
		add edi, ecx
		inc ebx
		jmp L10

out03:

L7:
	mov [ebp + 24], eax					;store sum to return

	pop eax
	pop ebx
	pop ecx
	pop edx
	pop edi
	pop ebp
	ret 16
calcRowSum endp

end main




comment !
SAMPLE OUTPUT

Enter how many elements in your array:
10
Enter the row size:
*It should divide the array into equal rows
5
Enter the type of your array.
1 for byte, 2 for word, and 3 for doubleword
3
Enter the type of your array.
1 for byte, 2 for word, and 3 for doubleword
7
Enter the type of your array.
1 for byte, 2 for word, and 3 for doubleword
1
Enter an element in your array
2
Enter an element in your array
4
Enter an element in your array
6
Enter an element in your array
8
Enter an element in your array
10
Enter an element in your array
12
Enter an element in your array
14
Enter an element in your array
16
Enter an element in your array
18
Enter an element in your array
20
Enter an element in your array
Enter row number that you want me to sum
0
The sum is : +30

Press any key to close this window . . .



!

