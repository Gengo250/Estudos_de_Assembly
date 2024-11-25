.model small
.code
main proc
    mov ah,02
    mov dl,'?'
    int 21h
    mov ah,01
    int 21h
    mov bl,al
    mov ah,02
    mov dl, 10
    int 21h
    mov dl,'?'
    int 21h
    mov ah,01
    int 21h
    mov bh,al
    mov ah,02
    mov dl,10
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

