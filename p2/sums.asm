; **************************************************************
;       Program: Program 2, Sums.
;   Description: This program adds 5 numbers from a byte array
;        Author: Sam Henry
;          Date: October 2, 2015
; Help Received: None
; **************************************************************

include irvine16.inc    ; Include Irvine's code definitions.

.data
        nums byte 200, 180, 192, 244, 219 ; sum = 1035 (40Bh)

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs

        mov ax, 0				; Sum register
		
		movzx bx, [nums]		; Movzx makes the byte a word, so no overflow when adding.
		add ax, bx				; Add the value from the byte array into the sum
		
		movzx bx, [nums + 1]
		add ax, bx
		
		movzx bx, [nums + 2]
		add ax, bx
		
		movzx bx, [nums + 3]
		add ax, bx
		
		movzx bx, [nums + 4]
		add ax, bx
		
		call DumpRegs			; Print all the registers to the screen.

        exit                    ; Terminate the program.
main endp

end main