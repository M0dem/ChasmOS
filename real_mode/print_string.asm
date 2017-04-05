
; params: (ax)*str
print_string: ; Routine: output string in SI to screen

	pusha ; preserve all registers

	mov bx, ax

	mov ax, 0 ; temporary byte (char) storage (al)
repeat:
	mov al, [bx] ; load byte from string at bx
	inc bx ; increment to next byte
	cmp al, 0
	je done ; if al byte (char) is 0 -> end of string
	call print_char
	jmp repeat
;repeat:
;	lodsb ; (load str byte) from [si] to al
;	cmp al, 0
;	je done ; if al byte (char) is 0 -> end of string.
;	call print_char
;	;int 0x10 ; "print char" interrupt
;	jmp repeat
done:
	popa
	ret
