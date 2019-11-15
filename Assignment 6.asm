comment #

This program prompts user to enter an input, then it passes it to
a procedure that goes from number 2 until the input. The procedure 
calculates if the current number is a prime number. The procedure
outputs all prime numbers between 2 and the input

#


INCLUDE Irvine32.inc



.data
	prompt BYTE "Please enter a number: ",0
	primesFound BYTE "Primes found until the given number: ", 0
	number DWORD ?

.code
main PROC
	
	mov edx, OFFSET prompt		;prompt user for input
	call writeString

	call readInt				;save input
	mov number, eax

	mov edi, eax				;storing the original number 

	mov edx, OFFSET primesFound
	call writeString			;print out the prime number string

	mov ecx, 2					

;	int original;
;	int i = 2;
;	ebx = isPrime(ecx);
;	while (ecx === edi){
;	pass = original/2;
;	ebx = isPrime(pass);
;	cout << ecx << " ";
;	ecx++;
;	if (ebx == 0);
;	break;
;	if (ecx==original)
;	continue
;	}

L1: 
	mov esi, ecx				;this number is passed to function isPrime
	call isPrime				;procedure to take input and check if prime
	cmp ebx, 0					;ebx is the flag determining if number 
	JE Finish					;is prime

	mov eax, esi				;move the original number back to the eax

	call writeDec

	mov al, ' '					;space between the integers
	call writeChar			


Finish: 
	inc ecx						
	cmp ecx, edi				;check if the original number is the 
								;same as counter
	JNE L1						;then go to the L1 loop 


	exit
main ENDP






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;This procedures takes a number, divides it by two and sets the quotient
;as a loop counter. Then it checks if the original number is divisible 
;by any number of the counter.
;This procedure receives number 2, where it starts the prime 
;number sequence and the original input number to compare
;Procedure returns 1 or 0 if number is/isnt prime and every
;prime number smaller than input to the stack
;-------------------------------------------------------------

isPrime PROC

	push eax
	push ecx
	push edx
	push esi

	xor edx, edx				;clear out edx before preforming arithmetic
	mov eax, esi				;saving in variable to retrieve in loop
	mov ebx, 2
	div ebx
	
	mov ecx, eax				;0.5 * input number = the loop counter

;	for (i = ecx, ecx > 1; i--)
;	edx = 0;
;	passed = original / ecx;
;	if(edx != 0)
;	return 0;
;	
;	return 1;
;}


L2:	
	cmp ecx, 1					;don't preform division if counter is 1		
	JE PRIMES					;because the value is prime

	xor edx, edx
	mov eax, esi				;move input number to eax for division
	div ecx

	cmp edx, 0					;check if there is a remainder
	JE L3

	dec ecx
	cmp ecx, 1
	JNE L2

	mov ebx, 1
	JMP Primes

L3:	
	xor ebx, ebx				;flag for not prime

PRIMES:							;if the number is prime
	pop esi						;popping back in the stack in ;opposite order
	pop edx
	pop ecx
	pop eax		
	
	ret
isPrime ENDP

END main



comment #
SAMPLE RUN

Please enter a number: 198
Primes found until the given number: 2 3 5 7 11 13 17 19 23 29 31 37
41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131
137 139 149 151 157 163 167 173 179 181 191 193 197
C:\Users\Debug\Project.exe (process 3756) exited with code 0.
Press any key to close this window . . .




#