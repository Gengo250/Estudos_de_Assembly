.model small
.stack 0100h
.data
    numeros db 10,13,"entre com os numeros= $"
    soma db 10,13,"somatoria =$"

.code
main proc
    mov ax,@data
    mov ds,ax
    xor cl,cl
    mov ah,9
    lea dx, numeros
    int 21h
    mov ah,01
ler:
    int 21h
    cmp al,13
    je imprime
    and al,0fh
    add cl,al
    jmp ler
imprime:
    mov ah,9
    lea dx,soma
    int 21h
    mov ah,02
    mov dl,cl
    or dl,30h
    int 21h
    mov ah,4ch
    int 21h
main endp
end main