
;xchg bx, bx ; MAGIC (BOCHS) BREAKPOINT

;[BITS 16]
[ORG 0x7c00]


	mov bp, 0x8000 ; Set up our stack out of the way in a safe place: 0x8000
	mov sp, bp


	mov ax, welcome_rm_str
	call print_string

	mov ax, 0x5c70
	call print_hex

	; set video to 80x25 text mode
	;mov al, 0x00
	;mov ah, 0x03 ; 80x25
	;int 0x10

	call switch_to_pm


	%include "real_mode/io.asm"
	%include "real_mode/print_string.asm"
	%include "real_mode/print_hex.asm"
	%include "real_mode/gdt.asm"
	%include "real_mode/switch_to_pm.asm"


[BITS 32]

	%include "protected_mode/print_string_pm.asm"
	%include "protected_mode/video_mem.asm"

BEGIN_PM:

	mov eax, welcome_pm_string
	call print_string_pm ; Use our 32-bit print routine

	push 0x04 ; attr
	push 0x58 ; char
	push 0x05 ; col
	push 0x03 ; row
	call set_video_mem
	add esp, dword 4 ; clean up

	jmp $ ; hang


	; ---- DATA ----


	; 0xa -> newline, 0xd -> carriage return, 0 -> string end
	welcome_rm_str db "Welcome to ChasmOS loaded in 16-bit Real Mode!", 0x0a, 0x0d, 0
	welcome_pm_string db "Successfully landed in 32-bit Protected Mode.", 0

	times 510 - ($ - $$) db 0 ; pad remainder of boot sector with 0s
	dw 0xaa55 ; standard PC boot signature
