; **************************************************************
;       Program: Program 5, Print String
;   Description: This program prints a string to the screen
;                  using a procedure created by me.
;        Author: Sam Henry
;         Notes: In order for the printstring to work, you must
;                   store the address of the string in dx and
;                   call printstring
;          Date: October 13, 2015
; Help Received: None
; **************************************************************

include irvine16.inc

.data
		string1 byte 0
		string2 byte "cout << ", 22h, "Hello world!", 22h, " << endl;", 0dh, 0ah, 0
		string3 byte 11 dup(0b2h), 0dh, 0ah, 0
		string4 byte 0b2h, 0c9h, 0cdh, 0d1h, 0cdh, 0cbh, 0cdh, 0d1h, 0cdh, 0bbh, 0b2h, 0dh, 0ah, 0
		string5 byte 0b2h, 0c7h, 0c4h, 0c5h, 0c4h, 0d7h, 0c4h, 0c5h, 0c4h, 0b6h, 0b2h, 0dh, 0ah, 0
		string6 byte 0b2h, 0c8h, 0cdh, 0cfh, 0cdh, 0cah, 0cdh, 0cfh, 0cdh, 0bch, 0b2h, 0dh, 0ah, 0
		
.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs
				
		mov dx, offset string1	; Move the address of the string into dx
		call printstring		; Print the string using the first address, dx
		
		mov dx, offset string2
		call printstring
		
		mov dx, offset string3
		call printstring
		
		mov dx, offset string4
		call printstring
		
		mov dx, offset string5
		call printstring
		
		mov dx, offset string6
		call printstring
		
		mov dx, offset string3
		call printstring

        exit                    ; Terminate the program.
main endp

; Function: Prints a string with a null terminator, 0
; Receives: The dx register containing the address of the string
;  Returns: Nothing at all
; Requires: A null terminator, 0, at the end of the string and the
;             address of the string stored in dx
; Clobbers: Only the ax register for printing each character - ax is
;             being used by the interrupt calls
printstring proc
		mov al, [edx]
		cmp al, 0
		jz return			;If the character in al is 0, the null terminator, then exit the function
		
		mov ah, 0eh
		int 10h				;Print the character of the string
		inc edx				;Move to the next character's address
		jmp printstring		;Goes back to the beginning with the next character's address in edx
		
	return:
		ret
printstring endp

end main