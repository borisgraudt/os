org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

; --------------------------------------------------
puts:
    push si
    push ax

.loop:
    lodsb           ; AL = [SI], SI++
    or al, al
    jz .done
    mov ah, 0x0e    ; BIOS teletype function
    mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret
; --------------------------------------------------

main:
    ; set up data segments
    mov ax, 0x0000
    mov ds, ax
    mov es, ax

    ; set up stack
    mov ss, ax
    mov sp, 0x7C00

    ; print message
    mov si, msg_hello
    call puts

    ; hang
.halt:
    hlt
    jmp .halt

; message
msg_hello: db 'Hello World!', ENDL, 0

; boot signature
times 510-($-$$) db 0
dw 0xAA55