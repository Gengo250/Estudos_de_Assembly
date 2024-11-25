.model small
.code
main proc
    mov ax, 00ffh
    mov cx,16
 roda:
    rol ax,1
    rcr dx,1
loop roda
mov ah,1
int 21h
mov ah,4ch
int 21h
main endp
end main