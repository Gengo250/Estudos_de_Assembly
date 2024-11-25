.model small
.data
    CR EQU 10
    num db 'Entre com o numero: $'
    par db CR,'numero par$'
    impar db CR, 'numero impar$'
.code
main PROC
   mov ax,@data
   mov ds,ax
   mov ah, 09
   lea dx, num
   int 21h
   mov ah,01
   int 21h
   and al, 0Fh
   test al,01
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