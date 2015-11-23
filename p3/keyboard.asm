; **************************************************************
;       Program: Program 2, Keyboard Sums
;   Description: This program adds 5 numbers from keyboard input
;        Author: Sam Henry
;          Date: October 7, 2015
; Help Received: None
; **************************************************************

include irvine16.inc    ; Include Irvine's code definitions.

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs
				
		mov bl, 0				; Clear the sum register
		mov al, 0				; Clear the keyboard input register
		mov ecx, 5				; Set the loop counter
		
		call sum				; Call the method that reads and adds 5 characters from the keyboard
		
		mov al, bl				; Move the sum into al so WriteInt prints it to the screen
		mov ah, 0				; Clear the top half of the ax register since WriteInt prints ax
		
		call WriteInt			; Print the sum to the screen

        exit                    ; Terminate the program.
main endp

sum:
		call ReadChar			; Reads a character from keyboard and stores it in al
		sub al, 30h				; Convert the ASCII value to decimal (ASCII - 48 or 30h)
		add bl, al				; Add the number to the total sum, bl
		loop sum				; Add the next character from keyboard
		ret						; Go back to the main method

end main