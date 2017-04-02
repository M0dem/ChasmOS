
switch_to_pm:

    cli ; Switch off interupts until we have set-up protected mode.

    lgdt [gdt_descriptor] ; Load our Global Descriptor Table

    mov eax, cr0 ; To switch to protected mode, we set the
    or eax, 01b ; first bit of CR0, a control register
    mov cr0, eax

    jmp CODE_SEG:init_pm ; Make a far jump (i.e. to a new segment) to our 32-bit
                         ; code.  This also forces the CPU to flush its cache of
                         ; pre-fetched and real-mode decoded instructions, which
                         ; can cause problems

[BITS 32]

; Initialize registers and the stack once in PM
init_pm:

    mov ax, DATA_SEG ; Now in PM, our old segments are meaningless
    mov ds, ax       ; so we point our segment registers to the
    mov ss, ax       ; data selector we defined in our GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; Update our stack position so it is right
    mov esp, ebp     ; at the top of the free space.

    call BEGIN_PM
