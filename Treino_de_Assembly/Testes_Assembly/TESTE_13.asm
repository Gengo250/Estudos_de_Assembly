TITLE PRINT DOS ELEMENTOS DE UM VETOR USANDO SI E DX 
.model small
.stack 100h 
.DATA
    array db 1,1,1,3,3,3,3,3; vetor com 8 elementos 
.code
main proc

    mov ax, @DATA
    mov ds, ax 

    mov si, offset array

    mov cx,8

    l1:
        mov dx, [si]
        add dx, '0'
        mov ah, 2 
        int 21h 
        inc si

    loop l1 

    mov ah, 4ch 
    int 21h 

main endp
end main 