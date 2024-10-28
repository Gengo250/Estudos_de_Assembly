.model SMALL
.stack 100h
.DATA
    MSG1 DB 10,13, "o numero eh igual $"
    MSG2 DB 10,13, "O numero nao eh igual $"
    MSG3 DB 10,13, "Digite um numero: $"
.CODE
main proc 
    mov ax, @DATA
    mov ds, ax

    lea dx, MSG3
    mov ah, 9
    int 21h 

    mov ah, 1
    int 21h 

    mov dl, '3' 

    cmp al, dl
    je l1 ;caso ZF = 1 salta se igual ou zero 

    lea dx, MSG2
    mov ah, 9
    int 21h 

    mov ah, 4Ch
    int 21h 

l1:
    lea dx, MSG1
    mov ah, 9
    int 21h

    mov ah, 4Ch
    int 21h 

main endp 
end main 
