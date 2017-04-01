
[org 0x7c00]


	mov bp, 0x8000 ; set up our stack safe and out of the way, at 0x8000
	mov sp, bp


	mov ax, welcome_str
	call print_string

	mov ax, 0x5c70
	call print_hex

	jmp $ ; hang

;inloop:
;	call get_char
;	call print_char
;
;	cmp al, 0x08 ; backspace?
;	je backspace
;
;	cmp al, 0x0d ; carriage return?
;	je return
;
;	cmp al, 0x1b ; escape?
;	je escape
;
;	jmp inloop
;backspace:
;	mov al, " "
;	call print_char
;
;	mov al, 0x08
;	call print_char
;
;	jmp inloop
;return:
;	mov al, 0x0a
;	call print_char
;
;	jmp inloop
;escape:
;	jmp $ ; hang in space!


	%include "io.asm"
	%include "print_string.asm"
	%include "print_hex.asm"


	; ---- DATA ----


	; 0xa -> newline, 0xd -> carriage return, 0 -> string end
	welcome_str db "Welcome to ChasmOS loaded in 16-bit Real Mode!", 0x0a, 0x0d, 0

	times 510 - ($ - $$) db 0 ; pad remainder of boot sector with 0s
	dw 0xaa55 ; standard PC boot signature
