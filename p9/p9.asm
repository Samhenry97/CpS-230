;       Program: Drawing Lines
;   Description: 
;        Author: Sam Henry
;          Date: 11/23/15
; Help Received: None

.model tiny     ; Tiny model: one code/data segment (CS==DS)
.386            ; Support for 32-bit registers/instructions
.stack 100h     ; Required to avoid warnings (and actually useful, too)

ROWSIZE equ 320
COLSIZE equ 200

.code

;************************************************************************
; Function: Program Entry Point
; Receives: Nothing
; Returns: Nothing
; Requires: Nothing
; Clobbers: Any/All
main proc
		mov	ax, cs			; Set DS == CS (one segment model)
		mov	ds, ax
		
		mov ax, 0013h		; Change to text graphics mode
		int 10h
		mov ax, 0a000h
		mov es, ax
		
		push 50
		push 50
		push 50
		push 150
		push 070h
		call drawline
		
		push 0
		push 9
		push 199
		push 0
		push 0fh
		call drawline
		
		push 50
		push 100
		push 0
		push 0
		
		mov ah, 10h			; Read a character
		int 16h
		
		mov ax, 0003h					; Change back to regular video mode
		int 10h
		
		mov	ah, 4Ch						; Exit the program
		int	21h
main endp

; Parameters
X1 equ [bp + 12]
X2 equ [bp + 8]
Y1 equ [bp + 10]
Y2 equ [bp + 6]
COL equ [bp + 4]

; Local variables
DeltaY equ [bp - 2]
DeltaX equ [bp - 4]
LastY equ [bp - 6]

drawline proc ; x1, y1, x2, y2, col
		push bp
		mov bp, sp
		sub sp, 6	
		
		push X1
		push Y1
		push COL
		call drawpixel
		
		mov ax, X2
		sub ax, X1
		mov DeltaX, ax
		mov ax, Y2
		sub ax, Y1
		mov DeltaY, ax
		
		cmp word ptr DeltaX, 0
		jz draw_vertical
		
		cmp word ptr DeltaY, 0
		jz draw_horizontal
		
	draw_up_right:
		
		
	draw_down_right:
		mov cx, Y1
	loopy:
		inc cx
		cmp cx, Y2
		je epilog
		mov ax, cx
		mov bx, DeltaX
		mul bx
		cwd
		mov bx, DeltaY
		div bx
		push ax
		push cx
		push COL
		call drawpixel
		jmp loopy
		
	draw_horizontal:
		mov ax, X1
		cmp word ptr DeltaX, 0
		jl draw_dec_horizontal
		jg draw_inc_horizontal
		jz epilog
	draw_dec_horizontal:
		dec ax
		cmp ax, X2
		je epilog
		push ax
		push Y1
		push COL
		call drawpixel
		jmp draw_dec_horizontal
	draw_inc_horizontal:
		inc ax
		cmp ax, X2
		je epilog
		push ax
		push Y1
		push COL
		call drawpixel
		jmp draw_inc_horizontal
		
		
	draw_vertical:
		mov ax, Y1
		cmp word ptr DeltaY, 0
		jl draw_dec_vertical
		jg draw_inc_vertical
		jz epilog
	draw_dec_vertical:
		dec ax
		cmp ax, Y2
		je epilog
		push X1
		push ax
		push COL
		call drawpixel
		jmp draw_dec_vertical
	draw_inc_vertical:
		inc ax
		cmp ax, Y2
		je epilog
		push X1
		push ax
		push COL
		call drawpixel
		jmp draw_inc_vertical				
		
	epilog:
		add sp, 6
		pop bp
		ret 10
drawline endp

drawpixel proc ; x, y, col
		push bp
		mov bp, sp
		pusha
		
		mov ax, [bp + 6]
		mov bx, ROWSIZE
		mul bx
		mov bx, ax
		
		add bx, [bp + 8]
		
		mov al, [bp + 4]
		mov es:[bx], al
		
		popa
		pop bp
		ret 6
drawpixel endp

end main