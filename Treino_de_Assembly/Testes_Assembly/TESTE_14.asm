.model small
.stack 100h 
.DATA
    array db 1,2,3 
.code
main proc
    mov ax, @DATA
    mov ds, ax

    mov si, offset array 

    mov cx, 3

    l1:
        mov bx, [si]
        add bx, '0'
        push bx 
        inc si 
        loop l1

        mov cx, 3
    l2: 
        pop dx
        mov ah, 2
        int 21h 
        loop l2 

    mov ah, 4Ch
    int 21h 


main endp 
end main