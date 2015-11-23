; **************************************************************
;       Program: Program 3, Average
;   Description: This program averages 5 numbers from keyboard input
;        Author: Sam Henry
;          Date: October 9, 2015
; Help Received: None
; **************************************************************

include irvine16.inc    ; Include Irvine's code definitions.

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs
				
		mov bl, 0				; Clear the sum register
		mov al, 0				; Clear the keyboard input register
		mov ecx, 5				; Set the loop counter to loop 5 times, reading and adding 5 characters
		
		call sum				; Call the method that reads and adds 5 characters from the keyboard
		
		movzx ax, bl			; Move the sum into the ax register for dividing (dividend)
		mov bl, 5				; Set the divisor
		
		div bl					; Divide ax by bl
		mov ah, 0				; Clear any remainder from the dividing
		
		call WriteInt			; Print the average (al) to the screen

        exit                    ; Terminate the program.
main endp

; Loops and reads a character from the keyboard, adding
; The number to the bl register (sum)
; Receiving ecx for looping
; Returns the sum in bl
; Requires nothing
; Clobbers ah, al and bl
sum proc
		mov ah, 10h				; Sets the interrupt to read a character
		int 16h					; Read a character from the keyboard
		sub al, 30h				; Convert the ASCII value to decimal (ASCII - 48 or 30h)
		add bl, al				; Add the number to the total sum, bl
		loopw sum				; Add the next character from keyboard until ecx == 0
		ret						; Go back to the main method
sum endp

end main