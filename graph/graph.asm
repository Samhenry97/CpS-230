.model small
.386
.stack 100h

.data

last_tick	word	?

; Smooth-blending 256 color palette
; generated by a Python script
; (RGB values in the range 0-63)
palette	byte	0, 0, 0
	byte	1, 0, 0
	byte	2, 0, 0
	byte	3, 0, 0
	byte	4, 0, 0
	byte	5, 0, 0
	byte	6, 0, 0
	byte	7, 0, 0
	byte	8, 0, 0
	byte	9, 0, 0
	byte	10, 0, 0
	byte	11, 0, 0
	byte	12, 0, 0
	byte	13, 0, 0
	byte	14, 0, 0
	byte	15, 0, 0
	byte	16, 0, 0
	byte	17, 0, 0
	byte	18, 0, 0
	byte	19, 0, 0
	byte	20, 0, 0
	byte	21, 0, 0
	byte	22, 0, 0
	byte	23, 0, 0
	byte	24, 0, 0
	byte	25, 0, 0
	byte	26, 0, 0
	byte	27, 0, 0
	byte	28, 0, 0
	byte	29, 0, 0
	byte	30, 0, 0
	byte	31, 0, 0
	byte	32, 0, 0
	byte	33, 0, 0
	byte	34, 0, 0
	byte	35, 0, 0
	byte	36, 0, 0
	byte	37, 0, 0
	byte	38, 0, 0
	byte	39, 0, 0
	byte	40, 0, 0
	byte	41, 0, 0
	byte	42, 0, 0
	byte	43, 0, 0
	byte	44, 0, 0
	byte	45, 0, 0
	byte	46, 0, 0
	byte	47, 0, 0
	byte	48, 0, 0
	byte	49, 0, 0
	byte	50, 0, 0
	byte	51, 0, 0
	byte	52, 0, 0
	byte	53, 0, 0
	byte	54, 0, 0
	byte	55, 0, 0
	byte	56, 0, 0
	byte	57, 0, 0
	byte	58, 0, 0
	byte	59, 0, 0
	byte	60, 0, 0
	byte	61, 0, 0
	byte	62, 0, 0
	byte	63, 0, 0
	byte	63, 0, 0
	byte	63, 1, 0
	byte	63, 2, 0
	byte	63, 3, 0
	byte	63, 4, 0
	byte	63, 5, 0
	byte	63, 6, 0
	byte	63, 7, 0
	byte	63, 8, 0
	byte	63, 9, 0
	byte	63, 10, 0
	byte	63, 11, 0
	byte	63, 12, 0
	byte	63, 13, 0
	byte	63, 14, 0
	byte	63, 15, 0
	byte	63, 16, 0
	byte	63, 17, 0
	byte	63, 18, 0
	byte	63, 19, 0
	byte	63, 20, 0
	byte	63, 21, 0
	byte	63, 22, 0
	byte	63, 23, 0
	byte	63, 24, 0
	byte	63, 25, 0
	byte	63, 26, 0
	byte	63, 27, 0
	byte	63, 28, 0
	byte	63, 29, 0
	byte	63, 30, 0
	byte	63, 31, 0
	byte	63, 32, 0
	byte	63, 33, 0
	byte	63, 34, 0
	byte	63, 35, 0
	byte	63, 36, 0
	byte	63, 37, 0
	byte	63, 38, 0
	byte	63, 39, 0
	byte	63, 40, 0
	byte	63, 41, 0
	byte	63, 42, 0
	byte	63, 43, 0
	byte	63, 44, 0
	byte	63, 45, 0
	byte	63, 46, 0
	byte	63, 47, 0
	byte	63, 48, 0
	byte	63, 49, 0
	byte	63, 50, 0
	byte	63, 51, 0
	byte	63, 52, 0
	byte	63, 53, 0
	byte	63, 54, 0
	byte	63, 55, 0
	byte	63, 56, 0
	byte	63, 57, 0
	byte	63, 58, 0
	byte	63, 59, 0
	byte	63, 60, 0
	byte	63, 61, 0
	byte	63, 62, 0
	byte	63, 63, 0
	byte	63, 63, 0
	byte	63, 63, 1
	byte	63, 63, 2
	byte	63, 63, 3
	byte	63, 63, 4
	byte	63, 63, 5
	byte	63, 63, 6
	byte	63, 63, 7
	byte	63, 63, 8
	byte	63, 63, 9
	byte	63, 63, 10
	byte	63, 63, 11
	byte	63, 63, 12
	byte	63, 63, 13
	byte	63, 63, 14
	byte	63, 63, 15
	byte	63, 63, 16
	byte	63, 63, 17
	byte	63, 63, 18
	byte	63, 63, 19
	byte	63, 63, 20
	byte	63, 63, 21
	byte	63, 63, 22
	byte	63, 63, 23
	byte	63, 63, 24
	byte	63, 63, 25
	byte	63, 63, 26
	byte	63, 63, 27
	byte	63, 63, 28
	byte	63, 63, 29
	byte	63, 63, 30
	byte	63, 63, 31
	byte	63, 63, 32
	byte	63, 63, 33
	byte	63, 63, 34
	byte	63, 63, 35
	byte	63, 63, 36
	byte	63, 63, 37
	byte	63, 63, 38
	byte	63, 63, 39
	byte	63, 63, 40
	byte	63, 63, 41
	byte	63, 63, 42
	byte	63, 63, 43
	byte	63, 63, 44
	byte	63, 63, 45
	byte	63, 63, 46
	byte	63, 63, 47
	byte	63, 63, 48
	byte	63, 63, 49
	byte	63, 63, 50
	byte	63, 63, 51
	byte	63, 63, 52
	byte	63, 63, 53
	byte	63, 63, 54
	byte	63, 63, 55
	byte	63, 63, 56
	byte	63, 63, 57
	byte	63, 63, 58
	byte	63, 63, 59
	byte	63, 63, 60
	byte	63, 63, 61
	byte	63, 63, 62
	byte	63, 63, 63
	byte	63, 63, 63
	byte	63, 63, 63
	byte	62, 62, 62
	byte	61, 61, 61
	byte	60, 60, 60
	byte	59, 59, 59
	byte	58, 58, 58
	byte	57, 57, 57
	byte	56, 56, 56
	byte	55, 55, 55
	byte	54, 54, 54
	byte	53, 53, 53
	byte	52, 52, 52
	byte	51, 51, 51
	byte	50, 50, 50
	byte	49, 49, 49
	byte	48, 48, 48
	byte	47, 47, 47
	byte	46, 46, 46
	byte	45, 45, 45
	byte	44, 44, 44
	byte	43, 43, 43
	byte	42, 42, 42
	byte	41, 41, 41
	byte	40, 40, 40
	byte	39, 39, 39
	byte	38, 38, 38
	byte	37, 37, 37
	byte	36, 36, 36
	byte	35, 35, 35
	byte	34, 34, 34
	byte	33, 33, 33
	byte	32, 32, 32
	byte	31, 31, 31
	byte	30, 30, 30
	byte	29, 29, 29
	byte	28, 28, 28
	byte	27, 27, 27
	byte	26, 26, 26
	byte	25, 25, 25
	byte	24, 24, 24
	byte	23, 23, 23
	byte	22, 22, 22
	byte	21, 21, 21
	byte	20, 20, 20
	byte	19, 19, 19
	byte	18, 18, 18
	byte	17, 17, 17
	byte	16, 16, 16
	byte	15, 15, 15
	byte	14, 14, 14
	byte	13, 13, 13
	byte	12, 12, 12
	byte	11, 11, 11
	byte	10, 10, 10
	byte	9, 9, 9
	byte	8, 8, 8
	byte	7, 7, 7
	byte	6, 6, 6
	byte	5, 5, 5
	byte	4, 4, 4
	byte	3, 3, 3
	byte	2, 2, 2
	byte	1, 1, 1

.code
main proc
	mov	ax, @data
	mov	ds, ax
	cld				; DF=0; lodsb moves forward
	
	; Set VGA low-res/high-color graphics mode
	; (320x200 pixels, 256 colors, 1 byte per pixel)
	mov	ax, 0013h
	int	10h
	
	; Draw a rainbow on the screen
	; (Still using the default palette)
	mov	ax, 0A000h
	mov	es, ax
	mov	cx, 320*100
	mov	di, 0
loopy:
	mov	ax, di
	mov	al, ah
	stosw
	loopw	loopy
	
	; Turn on the mouse cursor
	mov	ax, 0001h
	int	33h
	
	; Read a key
	mov	ah, 10h
	int	16h
	
	mov	di, 0
L1:
	; Select starting color (DI) for VGA palette transformation
	; (Color transforms "wrap" around, so if we start at color
	; 200, the first 56 colors in the table will go in palette
	; slots 200-255, then the remaining 200 will go in 0-199...)
	mov	dx, 3C8h	; "starting color" port
	mov	ax, di
	xor	ah, ah
	out	dx, al
	
	; Blast the color table out to the VGA registers
	mov	cx, 256
	mov	dx, 3C9h	; "R/G/B data" port
	mov	si, offset palette
L2:
	lodsb
	out	dx, al		; Red
	lodsb
	out	dx, al		; Green
	lodsb
	out	dx, al		; Blue
	loopw	L2
	
	; Delay loop (use BIOS to detect clock tick)
	mov	ah, 0
	int	1Ah
	mov	[last_tick], dx		; Stash last tick count (least-significant WORD)
sleepy:
	mov	ah, 0
	int	1Ah
	mov	cx, [last_tick]
	cmp	dx, cx			; Compare to current tick count...
	je	sleepy			; ...if still equal, try again
	
	; Check for keystroke (without blocking/hanging)
	mov	ah, 01h
	int	16h
	jnz	breakout
	
	; Next cycle
	inc	di			; Cycle colors continuously
	jmp	L1
breakout:
	
	; Turn off the mouse cursor
	mov	ax, 0002h
	int	33h
	
	; Resume 80-column text mode
	mov	ax, 0003h
	int	10h
	
	; Quit to DOS
	mov	ah, 4Ch
	int	21h
main endp

end main