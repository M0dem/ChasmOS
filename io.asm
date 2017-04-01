
get_char:
    mov ah, 0x00
    int 0x16

    ret

print_char:
    mov ah, 0x0e
    int 0x10

    ret
