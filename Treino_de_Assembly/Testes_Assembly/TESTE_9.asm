.model small 
.stack 100h
.DATA
    MSG1 DB 10,13,"DIGITE UM CARACTER: $"
    MSG2 DB 10,13,"O CARACTER EH UM NUMERO $"
    MSG3 DB 10,13,"O CARACTER EH UMA LETRA $"
    MSG4 DB 10,13,"O CARACTER EH DESCONHECIDO $"
.code 
main proc
    mov ax, @DATA 
    mov ds, ax

    lea dx, MSG1
    mov ah, 9
    int 21h 

    mov ah, 1
    int 21h 

    mov bl, al

    cmp bl, '0'
    jb naoehnum 
    cmp bl, '9'
    ja naoehnum 

    lea dx, MSG2
    mov ah, 9
    int 21h 

    jmp fim

    naoehnum:
        cmp bl, 'a'
        jb desconhecido
        cmp bl, 'z'
        jbe letra
        cmp bl, 'A'
        jb desconhecido
        cmp bl, 'Z'
        jbe letra 
    
    desconhecido:

        lea dx, MSG4
        mov ah, 9
        int 21h
        jmp fim 

    letra:

        lea dx, MSG3
        mov ah, 9
        int 21h 
        jmp fim 

    fim: 

        mov ah, 4Ch
        int 21h
        
        




main endp
end main 
