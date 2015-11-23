; **************************************************************
;       Program: Program 2, Sums.
;   Description: This program adds 5 numbers from a byte array
;        Author: Sam Henry
;          Date: October 2, 2015
; Help Received: None
; **************************************************************

include irvine16.inc    ; Include Irvine's code definitions.

.data
        frog byte 2,3,4
		log word 1234h, 5678h

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs

		mov eax, 0
		mov ax, [log + 1]
		
		call DumpRegs			; Print all the registers to the screen.

        exit                    ; Terminate the program.
main endp

end main