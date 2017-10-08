org 0x7C00
bits 16

; Reset the disk system
mov ah, 0
int 0x13

; Read from the hard drive
mov bx, 0x8000
mov al, 1
mov ch, 0
mov dh, 0
mov cl, 2
mov ah, 2
int 0x13

jmp 0x8000
times 510-($-$$) db 0
db 0x55
db 0xAA
