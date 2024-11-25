.model small
.stack 0100h
.data
    numeros dw 0,1,2,1,1,0,1,1,1,1
    soma db "soma =$"
    ;somatoria dw ?
.code
main proc
    mov ax,@data
    mov ds,ax

    ;lea bx,numeros
    mov cx,10
    xor ax,ax
    xor si,si
somar:
    add ax,numeros[si]
    ;add ax,[bx]
    add si,2
    loop somar
    push ax
    ;mov somatoria,ax
    lea dx,soma;
    mov ah,09
    int 21h
    pop dx
    ;mov dx, somatoria
    mov ah,02
    or dl,30h
    int 21h

    mov ah,4ch
    int 21h
main endp
end main