.model small
.stack 100h
.DATA
    var1 db 100 dup('$'); string de até 100 caracteres 
.code
main proc
    mov ax, @DATA
    mov ds, ax  ;inicializa a string (array)
    mov si, offset var1

    l1: 

    mov ah, 1; lê os caracters digitados e salva em AL 
    int 21h 

    cmp al, 13; compara o conteúdo de al com 13 ascii (botão/comando enter) assim apos o usuario clicar enter encerra o loop
    je programed; salte se AL=13 
    
    mov [si], al; move o conteúdo de al para dentro do array 
    inc si; incrementa si (ou seja, adiciona mais "casas"/"posições" dentro do array
    jmp l1; 

    programed:

        mov dx, offset var1
        mov ah, 9; exibe a string com os caracteres atualizados pelo usuário 
        int 21h 

        mov ah, 4Ch ;encerra o programa 
        int 21h



main endp
end main 