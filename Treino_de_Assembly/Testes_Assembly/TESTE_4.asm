TITLE ASSEMBLY-PROVA
.MODEL SMALL 
.DATA
        MSG1 db 'ax eh maior', 13,10,'$'
        MSG2 db 'bx eh maior', 13,10, '$'

.CODE
MAIN PROC
        mov ax, @DATA
        mov ds, ax
        mov ax, 7FFFH
        mov bx, 8000H
        mov cx, ax
        cmp ax, bx
        jg maior
        lea dx, MSG2
        mov ah, 09h
        int 21h
        mov cx,bx
        jmp exit

        maior:
                lea dx, MSG1
                mov ah, 09h
                int 21h 
        exit:
                mov ah, 4Ch
                int 21h        

       
    
MAIN ENDP
END MAIN 
