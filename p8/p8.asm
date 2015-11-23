;       Program: Interrupt Service Routine
;   Description: Uses int 8 to print the characters '0' thru '9' in the top
; 					left of the screen. Also, the user can type characters,
;					and they will still appear on the screen
;        Author: Sam Henry
;          Date: 11/18/15
; Help Received: None

.model tiny     ; Tiny model: one code/data segment (CS==DS)
.386            ; Support for 32-bit registers/instructions
.stack 100h     ; Required to avoid warnings (and actually useful, too)

.code

int8_off word ?		; For the interrupt 8 offset
int8_seg word ?		; For the interrupt 8 segment
char byte '0'		; The current character in the upper left corner of the screen

;************************************************************************
; Function: Program Entry Point
; Receives: Nothing
; Returns: Nothing
; Requires: Nothing
; Clobbers: Any/All
main proc
		mov	ax, cs			; Set DS == CS (one segment model)
		mov	ds, ax
		
		call install_ISR	; Install the interrupt service routine for int 8
		
		mov ax, 0003h		; Change to text graphics mode
		int 10h
		mov bx, 0b800h		; Move the frame buffer in to ES
		mov es, bx
		
	readchar:
		mov ah, 10h			; Read a character
		int 16h
		cmp al, 1bh			; Terminate if the character is ESC
		jz uninstall_ISR
		mov ah, 0eh			; Print the character to the screen
		int 10h
		jmp readchar		; Loop
main endp

;************************************************************************
; Function: This procedure is called when the timer BIOS interrupt is hit.
; 			It will print the characters from '0' to '9' in the top left
;			corner of the screen.
; Receives: Nothing
;  Returns: Nothing
; Requires: In order to be called, the procedure must be installed as an
;			interrupt service routine at vector 8
; Clobbers: Nothing
timerHit proc
		pusha				; Save registers during interrupt call
		mov dl, [char]		; Print the current character in the top left
		mov es:[0h], dl
		
		inc [char]
		cmp [char], ':'		; ':' is the character after '9' in the ASCII table
		jnz continue
		mov [char], '0'
		
	continue:
		popa
		push word ptr [int8_seg]		; Return to the chained int 8
		push word ptr [int8_off]
		retf
timerHit endp

;************************************************************************
; Function: Actually installs the interrupt service routine, and sets it
;			to interrupt vector 8. The procedure 'timerHit' is the new
;			interrupt service routine.
; Receives: Nothing
;  Returns: Nothing
; Requires: Nothing
; Clobbers: Nothing
install_ISR proc
		cli								; Clear interrupts
		
		mov bx, 0
		mov es, bx						; es == 0
		mov bx, es:[20h]				; Save the segment and offset of int 8
		mov [int8_off], bx
		mov bx, es:[22h]
		mov [int8_seg], bx
		mov es:[20h], offset timerHit	; Install interrupt handler
		mov es:[22h], cs
		
		sti
		ret
install_ISR endp

;************************************************************************
; Function: Uninstalls the interrupt service routine and sets the old 
;			routine back to where is was in es. Also changes the video
;			mode back to regular and then exits the program.
; Receives: Nothing
;  Returns: Nothing
; Requires: A interrupt offset and segment in the variables 'int8_off' and
;			'int8_seg'. The interrupt vector should be int 8
; Clobbers: Nothing
uninstall_ISR proc
		cli								; Clear interrupts
		
		mov bx, 0						; es == 0
		mov es, bx
		mov bx, [int8_off]				; Restore the vector table
		mov es:[20h], bx
		mov bx, [int8_seg]
		mov es:[22h], bx
		
		sti
		
		mov ax, 0001h					; Change back to regular video mode
		int 10h
		
		mov	ah, 4Ch						; Exit the program
		int	21h
uninstall_ISR endp

end main