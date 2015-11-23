;       Program: Print Hex, Decimal, and Binary
;   Description: This program takes a key press from the user and displays info
;					about it. The info includes the character, ASCII value, hex
;					value, and binary value
;        Author: Sam Henry
;          Date: 10/28/15
; Help Received: None

include irvine16.inc    ; Include Irvine's code definitions.

.data
	esc_key byte 01bh			; ASCII code for the escape key, for readability
	newline_char byte 0dh, 0ah  ; ASCII values for carriage return and newline

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax

	read:
		call read_char			
		cmp al, [esc_key]		; Makes sure the user did not press the escape key
		jz terminate			; Exit the program if the user pressed escape
		
		mov ah, 0eh				; Print the character to the screen
		int 10h					
		call print_space
		
		movzx eax, al			; Put the character in eax, since eax is used in the procedures
		
		call print_hex			; Print hexadecimal version of the ASCII value
		call print_space
		
		call print_udec			; Print decimal version of the ASCII value
		call print_space
		
		call print_bin			; Print binary version of the ASCII value
		call print_newline
		jmp read
		
	terminate:
		exit
main endp

;************************************************************************
; Function: Reads a character from the user and stores it in al
; Receives: Nothing
;  Returns: The ASCII value of the character in al
; Requires: Nothing at all
; Clobbers: Only ax for reading the character
read_char proc
		mov ah, 10h
		int 16h
		ret
read_char endp

;************************************************************************
; Function: Prints a hexadecimal number, one nibble at a time.
; Receives: The 32-bit number in eax to print out
;  Returns: Nothing
; Requires: Just a number inside of eax
; Clobbers: Nothing
print_hex proc
		pushad					; Store the values of the registers
		
		mov cx, 8				; The loop counter for each nibble in eax
	
	rotate_hex:					; Loops through each nibble and prints out
								;     the corresponding hex value
		rol eax, 4				; Puts the next nibble in the lower half of al
		call print_nibble_hex	; Prints that nibble
		loopw rotate_hex
		
		popad
		ret
print_hex endp

;************************************************************************
; Function: Prints the hexadecimal number corresponding with
; 			the nibble in the lower half of al
; Receives: eax for the number in al
;  Returns: Nothing
; Requires: A number to print out in al
; Clobbers: Nothing
print_nibble_hex proc
		pushd eax
		push cx
		
		mov cx, 4				; The loop counter
	make_al_nibble:				; Loop through al and make it look like [0000xxxx]
		clc
		rcl al, 1
		loopw make_al_nibble
		
		rol al, 4				; Returns al back to where it was
		
		cmp al, 10
		jl print_num			; If the number is between 0-9, print the ASCII value
		jge print_letter		; If it is between 10-15, print the ASCII value A-F
		
	print_num:					; Prints the number corresponding with the lower half of al
		add al, 30h				; Convert to ASCII number
		mov ah, 0eh
		int 10h
		jmp print_nibble_hex_exit
		
	print_letter:				; Prints the hex letter corresponding with the lower half of al
		add al, 37h				; Convert the number to the correct letter
		mov ah, 0eh
		int 10h
		jmp print_nibble_hex_exit
		
	print_nibble_hex_exit:
		pop cx
		pop eax
		ret
print_nibble_hex endp

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
; Function: Prints the binary version of what is inside of eax
; Receives: The number to print in eax
;  Returns: Nothing
; Requires: A valid number in eax
; Clobbers: Nothing
print_bin proc
		pushad
		
		mov cx, 4					; Set the loop counter
	
	rotate_bin:						; Prints the binary number by each byte
		rol eax, 8					; Each byte is rolled into al
		call print_byte_bin			; Prints al
		cmp cx, 1					; If you're not on the last loop, print an underscore
		jnz print_ 
		loopw rotate_bin
		jmp exit_print_bin
		
	print_:							; Prints the underscore
		pushd eax
		mov al, '_'
		mov ah, 0eh
		int 10h
		pop eax
		loopw rotate_bin
		
	exit_print_bin:
		popad
		ret
print_bin endp

;************************************************************************
; Function: Prints the 1's and 0's of a byte
; Receives: A byte in al
;  Returns: Nothing
; Requires: A valid number in al
; Clobbers: Nothing
print_byte_bin proc
		push cx
		push ax
		mov cx, 8
		
	testbit:			; Tests whether the bit is 1 or 0
		rol al, 1		; Put the next bit in the carry flag
		jc print1
		jnc print0
		jmp exittest
		
	print1:				; Prints a 1
		push ax
		mov al, '1'
		mov ah, 0eh
		int 10h
		pop ax
		loopw testbit	; Goes to the next bit
		jmp exittest
		
	print0:				; Prints a 0
		push ax
		mov al, '0'
		mov ah, 0eh
		int 10h
		pop ax
		loopw testbit	; Goes to the next bit
		jmp exittest
		
	exittest:
		pop ax
		pop cx
		ret
print_byte_bin endp

;************************************************************************
; Function: Prints a space to the screen
; Receives: Nothing
;  Returns: Nothing
; Requires: Nothing
; Clobbers: Nothing
print_space proc
		push ax
		mov al, ' '
		mov ah, 0eh
		int 10h
		pop ax
		ret
print_space endp

;************************************************************************
; Function: Prints a newline to the screen
; Receives: Nothing
;  Returns: Nothing
; Requires: Nothing
; Clobbers: Nothing
print_newline proc
		push ax
		mov al, [newline_char]
		mov ah, 0eh
		int 10h
		mov al, [newline_char + 1]
		mov ah, 0eh
		int 10h
		pop ax
		ret
print_newline endp

end main