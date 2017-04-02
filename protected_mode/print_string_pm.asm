
; params: eax=*str
print_string_pm:

    ; bx=individual (char and attribute) data
    ; ecx=video memory address

    pusha ; save our current register before use them

    mov ecx, VIDEO_MEMORY
print_string_pm_loop:
    mov bl, byte [eax] ; Store the character (byte) at EAX in BL
    mov bh, byte WHITE_ON_YELLOW ;WHITE_ON_BLACK ; Store the char's attribute in BH

    cmp bl, 0
    je done

    mov [ecx], bx ; Store char AND attribute at current character cell
                  ; in Video Memory

    add eax, 1 ; Increment EAX to the next char in our string
    add ecx, 2 ; Move to the next character cell in video memory

    jmp print_string_pm_loop
print_string_pm_done:
    popa
    ret


    ; ---- DATA ----


    VIDEO_MEMORY equ 0xb8000
    WHITE_ON_BLACK equ 0x0f
    WHITE_ON_YELLOW equ 0x5f
