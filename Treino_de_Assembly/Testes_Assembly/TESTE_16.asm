.model small
.stack 100h
.data
.code
main proc
    mov ax, @data   ; Inicializa o segmento de dados
    mov ds, ax

    mov bx, 1       ; Inicializa BX com 1 (contador de asteriscos)
    mov cx, 9     ; Número total de linhas a serem impressas

l1:
    push cx         ; Salva o valor de CX na pilha
    mov cx, bx      ; Configura CX para o número atual de asteriscos

l2:
    mov dl, 'a'     ; Caractere a ser impresso
    mov ah, 2
    int 21h         ; Imprime o asterisco
    loop l2         ; Decrementa CX e repete se CX != 0

    ; Após imprimir os asteriscos, imprime a nova linha
    mov dl, 13      ; Carriage Return
    mov ah, 2
    int 21h

    mov dl, 10      ; Line Feed
    mov ah, 2
    int 21h

    inc bx          ; Incrementa BX para a próxima linha
    pop cx          ; Restaura o valor original de CX
    loop l1         ; Decrementa CX e repete o loop externo se CX != 0

    mov ah, 4Ch     ; Termina o programa
    int 21h 

main endp
end main
