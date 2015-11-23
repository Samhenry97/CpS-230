;       Program: Prime Numbers
;   Description: This program takes a number in EAX and prints a string as to
; 					whether or not the number is prime.
;        Author: Sam Henry
;          Date: 11/12/15
; Help Received: None

include irvine16.inc    ; Include Irvine's code definitions.

.data
        nopeNotPrime byte " is not prime", 13, 10, 0
		yupItsPrime byte " is prime", 13, 10, 0
		newLine byte 13, 10, 0

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs
	
	readprime:
        call ReadDec			; Read the number from the user
		mov dx, offset newLine
		call printstring
		cmp eax, 0				; If the user enters a 0, exit the program
		jz terminate
		call isPrime			; Test if the number in EAX is prime
		jmp readprime

	terminate:
        exit                    ; Terminate the program.
main endp

;************************************************************************
; Function: Finds out whether the number passed in EAX is prime. If so,
; 			prints a message saying so. If not, prints a message saying not.
; Receives: 32-bit unsigned number in EAX
;  Returns: Nothing
; Requires: A valid 32-bit unsigned number in EAX
; Clobbers: Nothing
isPrime proc
		pushad
		
		cmp eax, 3			; Test for the basic 1, 2, and 3 values
		ja moveon
		cmp eax, 1
		ja printPrime
		jmp printNotPrime
		
	moveon:
		pushd eax			; Test if divisible by 3
		mov edx, 0
		mov ebx, 3
		div ebx
		pop eax
		cmp edx, 0
		jz printNotPrime
		
		pushd eax			; Test if divisible by 2
		mov edx, 0
		mov ebx, 2
		div ebx
		pop eax
		cmp edx, 0
		jz printNotPrime
    
		mov ecx, 5			; ECX = i -- for(int i = 0; i * i < EAX; i += 6)
	testloop:
		pushd eax			; If ECX * ECX > EAX or if ECX * ECX overflows, the number is prime.
		mov eax, ecx
		mov ebx, ecx
		mul ebx
		mov ebx, eax
		pop eax
		jo printPrime		; ECX * ECX overflow
		cmp ebx, eax
		ja printPrime		; ECX * ECX > EAX
	
		pushd eax			; If EAX % ECX == 0
		mov ebx, ecx
		mov edx, 0
		div ebx
		pop eax
		cmp edx, 0
		jz printNotPrime
		
		pushd eax			; If EAx % (ECX + 2) == 0
		mov ebx, ecx
		add ebx, 2
		mov edx, 0
		div ebx
		pop eax
		cmp edx, 0
		jz printNotPrime
		
		add ecx, 6
		jmp testloop		
		
	printPrime:
		call print_udec
		mov dx, offset yupItsPrime
		call printstring
		jmp exitPrime
	
	printNotPrime:
		call print_udec
		mov dx, offset nopeNotPrime
		call printstring
		jmp exitPrime
		
	exitPrime:
		popad
		ret
isPrime endp

;************************************************************************
; Function: Read an unsigned 32-bit number as decimal using BIOS
; Receives: nothing
;  Returns: EAX = the number
; Requires: nothing
; Clobbers: EAX
ReadDec proc
		push edx
		push ebx

		mov ebx, 10         ; Multiplier
		mov edx, 0

	loop_start:
		mov ah, 10h
		int 16h

		cmp al, 0dh
		je  done
		cmp al, 0ah
		je  done

		cmp al, '0'
		jb  loop_start
		cmp al, '9'
		ja  loop_start

		mov ah, 0eh
		int 10h             ; Print the digit

		sub al, '0'

		and eax, 0ffh
		push eax

		mov eax, edx
		mul ebx
		mov edx, eax
		pop eax
		add edx, eax
		jmp loop_start

	done:

		mov eax, edx
		pop ebx
		pop edx
		ret
ReadDec endp

;************************************************************************
; Function: Prints a decimal number to the screen in eax
; Receives: The number to print in eax
;  Returns: Nothing
; Requires: An unsigned number in eax
; Clobbers: Nothing
print_udec proc
		pushad
		mov cx, 0		; Set the loop counter to 0
		mov ebx, 10		; This is the divisor
		mov edx, 0		; Set the top half of the divident to 0 (only eax needed)
		
	divide:
		inc cx			; Increment the loop counter
		div ebx
		add edx, 30h	; Put the ASCII value of the number in dx
		pushd edx		; Push the number onto the stack
		mov edx, 0		; The top half of the dividend will always be 0 now that the first divide is done
		cmp eax, 0		; If the quotient is 0, then we're done
		jnz divide
		
	print:
		pop edx			; Take the number off the stack
		mov al, dl		; Print it to the screen
		mov ah, 0eh
		int 10h
		loopw print
		
		popad			; Reload the registers so you don't clobber them
		ret
print_udec endp

;************************************************************************
; Function: Prints a string with a null terminator, 0
; Receives: The dx register containing the address of the string
;  Returns: Nothing at all
; Requires: A null terminator, 0, at the end of the string and the
;             address of the string stored in dx
; Clobbers: Nothing
printstring proc
		push ax
		pushd edx
		
	printchar:
		mov al, [edx]
		cmp al, 0
		jz return			;If the character in al is 0, the null terminator, then exit the function
		
		mov ah, 0eh
		int 10h				;Print the character of the string
		inc edx				;Move to the next character's address
		jmp printchar		;Goes back to the beginning with the next character's address in edx
		
	return:
		pop edx
		pop ax
		ret
printstring endp

end main