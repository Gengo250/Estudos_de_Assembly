title Soma dos elementos da diagonal de uma matriz
.model small
.stack 100h
.data
    matriz db 2,0,0,0
           db 0,2,0,0
           db 0,0,3,0
           db 0,0,0,4
.code
main proc
    mov  ax, @data
    mov  ds, ax

    call imprime_Diagonal

    mov  ah, 4Ch
    int  21h
main endp

imprime_Diagonal proc
    lea  si, matriz    ; SI aponta para o início da matriz
    mov  cx, 4         ; Contador para o loop (4 elementos)
    mov  ax, 0         ; Inicializa o acumulador AX com zero

loop_Diagonal:
    mov  bl, [si]      ; Carrega o elemento atual em BL
    add  ax, bx        ; Soma o elemento ao acumulador AX
    add  si, 5         ; Move para o próximo elemento diagonal
    loop loop_Diagonal

    ; Conversão do valor em AX para ASCII e impressão
    mov  bx, 10        ; Divisor para obter os dígitos
    xor  dx, dx        ; Limpa DX para a divisão

    div  bx            ; Divide AX por 10, quociente em AL, resto em DX

    add  al, '0'       ; Converte o quociente para ASCII
    push dx            ; Salva o resto na pilha

    mov  dl, al        ; Prepara DL para impressão
    mov  ah, 2         ; Função de impressão de caractere
    int  21h           ; Imprime o dígito das dezenas

    pop  dx            ; Recupera o resto
    add  dl, '0'       ; Converte o resto para ASCII

    mov  ah, 2         ; Função de impressão de caractere
    int  21h           ; Imprime o dígito das unidades

    ret
imprime_Diagonal endp
end main
