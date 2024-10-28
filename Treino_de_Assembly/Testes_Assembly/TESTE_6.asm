.model SMALL
.stack 100h 
.DATA
.code 
main proc 

   mov cx, 26
   mov dl, 'a'

   minuscula: 
    mov ah, 2 
    int 21h 
    inc dl
    Loop minuscula

    ; Move para a próxima linha
    mov dl, 10        ; Retorno de carro (CR)
    mov ah, 2
    int 21h

    mov dl, 13    
    mov ah, 2 ;carry return
    int 21h

    mov cx, 26
    mov dl, 'A'

    maiuscula:
        mov ah, 2 
        int 21h
        inc dl
        loop maiuscula

    mov ah, 4Ch
    int 21h      
    
main endp 
end main 