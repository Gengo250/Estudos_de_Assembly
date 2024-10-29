TITLE Impressão de Matriz 4x4 com Procedimentos e Macros
.MODEL SMALL
.STACK 100h

.DATA
MATRIZ4X4 DB 1, 2, 3, 4    
          DB 4, 3, 2, 1
          DB 5, 6, 7, 8
          DB 8, 7, 6, 5

.CODE

; Macro para pular linha
NOVA_LINHA MACRO
    MOV DL, 13        ; Retorno de carro
    MOV AH, 2
    INT 21h
    MOV DL, 10        ; Nova linha
    INT 21h
ENDM

; Procedimento para imprimir uma linha da matriz
IMPRIMIR_LINHA PROC
    MOV CX, 4           ; Número de elementos por linha (4)
    XOR SI,SI         ; Reseta SI para usar como índice da coluna

IMPRIMIR_COLUNA:
    MOV DL, MATRIZ4X4[BX + SI] ; Acessa o elemento atual da matriz
    ADD DL, 30h                ; Converte o número para ASCII
    MOV AH, 02h                ; Função para imprimir caractere (INT 21h)
    INT 21h                    ; Imprime o caractere
    INC SI                     ; Move para a próxima coluna
    LOOP IMPRIMIR_COLUNA       ; Repete até terminar a linha

    ; Chama a macro para pular para a nova linha
    NOVA_LINHA

    RET
IMPRIMIR_LINHA ENDP

MAIN PROC
    ; Configura o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Inicializa índice
    XOR BX, BX           ; BX controla o deslocamento de cada linha (0, 4, 8, 12)

IMPRIMIR_MATRIZ:
    CALL IMPRIMIR_LINHA  ; Chama o procedimento para imprimir uma linha

    ; Incrementa BX para avançar para a próxima linha
    ADD BX, 4            ; Avança para o próximo bloco de 4 elementos
    CMP BX, 16           ; 16 bytes = fim da matriz 4x4
    JL IMPRIMIR_MATRIZ   ; Repete enquanto não atingir o fim da matriz

FINAL:
    MOV AH, 4Ch          ; Função de encerramento do programa
    INT 21h

MAIN ENDP
END MAIN