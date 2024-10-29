.model SMALL
.stack 100h 
.data
    MSG1 db 13,10,"digite um numero: $"
    MSG2 db 13,10,"digite um segundo numero: $"
    MSG3 db 13,10,"Resultado: $"

    pular macro
    mov dl, 13
    mov ah, 2
    int 21h 

    mov dl, 10 
    mov ah, 2
    int 21h 
    endm 

.code 
main proc

    mov ax, @data 
    mov ds, ax 

    lea dx, MSG1
    mov ah, 9
    int 21h

    
    call lernumero1

    pular 

    lea dx, MSG2
    mov ah, 9 
    int 21h 

    call lernumero2

    pular

    lea dx, MSG3
    mov ah, 9
    int 21h 


    mov al, bh 

    add bl, al 
    or bl, '0'
    mov dl, bl
   
    mov ah, 2 
    int 21h 

    mov ah, 4ch
    int 21h 
main endp 
lernumero1 proc

        mov ah,1 
        int 21h 

        sub al, '0'
        mov bl, al

        ret 
lernumero1 endp

lernumero2 proc

        mov ah, 1
        int 21h 

        sub al, '0'
        mov bh, al

        ret 
lernumero2 endp 
end main  
