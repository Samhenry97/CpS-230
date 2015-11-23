;       Program: sample16.asm, Our first sample program
;   Description: This program just demonstrates a real-mode program. It prints
;                a string and reads a character from the keyboard.
;        Author: Aric Blumer
;          Date: 2/9/2014
;         Notes: This program needs to be assembled for real mode execution.
; Help Received: I received help from the following people on the date given.
;                John Doe help me figure out the nul-terminator (2/8/2014)
;
; NOTE: The comment block above is required on all your programs, but you
;       *must* edit it to match your situation.

include irvine16.inc    ; Include Irvine's code definitions.

.data
	random_var byte 0
.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs

        mov ax, 0003h		; Change to text graphics mode
		int 10h
		
		mov ax, 0001h
		int 10h
		
		mov ah, 4Ch  ;terminate program
		int 21h
main endp

end main