
; Global Descriptor Table
gdt_start:

gdt_null: ; mandatory null descriptor

    dd 0x00
    dd 0x00

gdt_code: ; code segment descriptor

    ; base = 0x0, limit = 0xfffff,
    ; 1st flags: (present)1 (privelege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)1 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff    ; Limit (bits 0-15)
    dw 0x00      ; Base (bits 0-15)
    db 0x00      ; Base (bits 16-23)
    db 10011010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, Limit (bits 16-19)
    db 0x00      ; Base (bits 24-31)

gdt_data: ; data segment descriptor

    ; Same as the code segment except for the type flags:
    ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff    ; Limit (bits 0-15)
    dw 0x00      ; Base (bits 0-15)
    db 0x00      ; Base (bits 16-23)
    db 10010010b ; 1st flags, type flags
    db 11001111b ; 2nd flags, Limit (bits 16-19)
    db 0x00      ; Base (bits 24-31)

gdt_end: ; The reason for putting a label at the end of the
         ; GDT is so we can have the assembler calculate
         ; the size of the GDT for the GDT descriptor (below)

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Size of our GDT, always less one
                               ; of the true size (?)
    dd gdt_start               ; Start address of our GDT

; Define some handy constants for the GDT segment descriptor offsets, which
; are what segment registers must contain when in protected mode.  For example,
; when we set DS = 0x10 in PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA) (?)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
