title Inverter Diagonal Principal de uma Matriz e Exibir na Tela
.model small
.stack 100h

.data
    matriz db 1,0,0,0
           db 0,2,0,0
           db 0,0,3,0
           db 0,0,0,4

.code
main proc
    mov  ax, @data
    mov  ds, ax

    call inverter_diagonal
    call exibir_matriz

    mov  ah, 4Ch       ; Função para terminar o programa
    int  21h
main endp

; Procedimento para inverter a diagonal principal
inverter_diagonal proc
    lea  si, matriz       ; SI aponta para o início da matriz
    lea  di, matriz       ; DI também aponta para o início
    add  di, 15           ; DI aponta para o último elemento diagonal (offset 15)

    mov  cx, 2            ; Número de trocas necessárias (metade do tamanho da diagonal)

inverter_loop:
    ; Troca os elementos [SI] e [DI]
    mov  al, [si]         ; AL = elemento inicial
    xchg al, [di]         ; Troca AL com [DI]
    mov  [si], al         ; Armazena o valor original de [DI] em [SI]

    ; Atualiza os ponteiros
    add  si, 5            ; Move SI para o próximo elemento diagonal
    sub  di, 5            ; Move DI para o elemento diagonal anterior

    loop inverter_loop    ; Decrementa CX e repete o loop se CX != 0

    ret
inverter_diagonal endp

; Procedimento para exibir a matriz formatada
exibir_matriz proc
    lea  si, matriz       ; SI aponta para o início da matriz
    mov  cx, 4            ; Contador para as linhas da matriz

exibir_linha:
    push cx               ; Salva o contador externo

    mov  cx, 4            ; Contador para as colunas da matriz

exibir_coluna:
    mov  dl, [si]         ; Carrega o elemento atual em DL
    add  dl, '0'          ; Converte para ASCII

    mov  ah, 2            ; Função para imprimir caractere
    int  21h              ; Imprime o caractere

    mov  dl, ' '          ; Espaço entre os elementos
    mov  ah, 2
    int  21h              ; Imprime o espaço

    inc  si               ; Próximo elemento da matriz
    loop exibir_coluna     ; Repete para as colunas

    ; Quebra de linha após cada linha da matriz
    mov  dl, 13           ; Carriage Return
    mov  ah, 2
    int  21h              ; Imprime CR

    mov  dl, 10           ; Line Feed
    mov  ah, 2
    int  21h              ; Imprime LF

    pop  cx               ; Recupera o contador externo
    loop exibir_linha      ; Repete para as linhas

    ret
exibir_matriz endp

end main
