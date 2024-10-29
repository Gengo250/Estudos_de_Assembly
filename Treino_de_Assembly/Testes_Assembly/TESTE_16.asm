.model small 
.stack 100h
.data
    pularlinha macro

    mov dl, 10
    mov ah, 2
    int 21h

    mov dl, 13 
    mov ah, 2
    int 21h
    
    endm 

.code 
main proc

    mov ax, @data 
    mov ds, ax 
    
    mov bx, 1 
    mov cx, 10

   l1:
    push cx 
    mov cx, bx 

    l2:
    mov dl, '!'
    mov ah, 2
    int 21h 
    loop l2 

    pularlinha


    pop cx 
    inc bx 
    loop l1 

    mov ah, 4ch
    int 21h 
main endp 
end main  