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
        message byte "Hello World!", 13, 10, "Press any key to exit.", 0

.code
main proc
        mov  ax, @data          ; @data is the data segment that DOS sets up.
        mov  ds, ax             ; These two lines are required for all programs

        ; your code starts here

        mov  dx, offset message
        call WriteString        ; Print the message.
        call ReadChar           ; Read a character from the keyboard.

        ; your code ends here

        exit                    ; Terminate the program.
main endp

end main