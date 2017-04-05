
; params: (ax)hex_dword
print_hex:

	push ax ; save a copy for later...

	; --- SECOND BYTE ----
	call split_byte

	call nibble_to_ascii
	mov [hex_str + 5], al
	mov al, ah

	call nibble_to_ascii
	mov [hex_str + 4], al
	; --------------------

	; ---- FIRST BYTE ----
	pop ax
	mov al, ah

	call split_byte

	call nibble_to_ascii
	mov [hex_str + 3], al
	mov al, ah

	call nibble_to_ascii
	mov [hex_str + 2], al
	; --------------------

	mov ax, hex_str
	call print_string

	ret

; params: al=hex_byte
; return: ah=hex_nibble_1, al=hex_nibble_0
split_byte: ; split a byte into two nibbles

	mov ah, al

	shr ah, 4 ; |5c| -> |05|

	shl al, 4 ; |5c| -> |c0|
	shr al, 4 ; |c0| -> |0c|

	ret

; params: al=hex_nibble
; return: al=ascii_code
nibble_to_ascii: ; convert a nibble to ascii

	cmp al, 0x09
	jle is_number
	jg is_letter
is_number:
	add al, 0x30

	ret
is_letter:
	add al, 0x57 ; upper-case: 0x37, lower-case: 0x57

	ret


	; ---- DATA ----


	hex_str db "0x", 0, 0, 0, 0, 0x0a, 0x0d, 0
