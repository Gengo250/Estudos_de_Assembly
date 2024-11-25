.model small
.data
    CR equ 10
    num db 'Entre com o numero: $'
    par db CR,'paridade par$'
    impar db CR, 'paridade impar$'
.code
main PROC
   mov ax,@data
   mov ds,ax
   lea dx, num
   mov ah,09
   int 21h
   xor bl,bl
   mov ah,01
   int 21h
   and al, 0Fh
   mov cx,8
volta:
   shl al,1
   jnc salta
   inc bl
salta:
   loop volta
   test bl,01
   jz ehpar
   lea dx,impar
   jmp imprime
ehpar:
    lea dx,par
imprime:
    mov ah,09
    int 21h
    mov ah, 4ch
    int 21h 
main ENDP
END main