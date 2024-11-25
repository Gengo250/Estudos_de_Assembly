.model small
.data
   msg db 10,13,'entre com uma letra maiuscula $',13,10
   ordem db 10,13,'as letras em ordem alfabetica: $'
.code
main proc
    mov ax,@data
    mov ds,ax
    mov ah,09
    lea dx, msg
    int 21h
    mov ah,01
    int 21h
    mov bl,al
    mov ah,09
    lea dx, msg
    int 21h
    mov ah,01
    int 21h
    mov bh,al
    mov ah,09
    lea dx,ordem
    int 21h
    mov ah,02
    cmp bl,bh
    jae maior
    mov dl,bl
    int 21h
    mov dl,bh
    int 21h
    jmp fim
maior:
    mov dl,bh
    int 21h
    mov dl,bl
    int 21h
fim:
    mov ah,4ch  ; fim programa
    int 21h
main endp
end main

