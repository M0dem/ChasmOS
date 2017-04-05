
; params (stack)row, (stack)col, (stack)char, (stack)attr
set_video_mem:

    mov eax, dword [esp + 4] ; row
    mov edx, dword [esp + 8] ; col
    ; Char and attr are still on the stack

    ; offset = ((row * total_cols) + col) * 2
    ; multiplied by 2 ... 2-bytes per VGA mode character cell
    imul eax, TOTAL_COLS
    add eax, edx
    imul eax, 2 ; character cells are 2 bytes
    mov [offset], eax

    mov eax, dword [esp + 12] ; char
    mov edx, dword [esp + 16] ; attr

    mov ah, dl ; al=(char), ah=(attr)

    mov ecx, VIDEO_MEMORY
    mov ebx, [offset]

    mov [ecx + ebx], al
    mov [ecx + ebx + 1], dl

    ret


    ; ---- DATA ----


    ; highest offset = 3998 = 0x0f9e (2-byte word)
    offset dw 0x0000

    ;VIDEO_MEMORY equ 0xb8000
    ; 80x25 mode
    TOTAL_COLS equ 80
    TOTAL_ROWS equ 25
    ;WHITE_ON_BLACK equ 0x0f
    ;WHITE_ON_YELLOW equ 0x5f
