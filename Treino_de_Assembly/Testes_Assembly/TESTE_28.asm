TITLE SumMatrix
.MODEL SMALL
.STACK 100h

.DATA
    ; Define a matriz 4x4 de palavras (16 bits) armazenada em ordem linha-major
    matrizOriginal DW 1, 2, 3, 4
                  DW 5, 6, 7, 8
                  DW 9, 10, 11, 12
                  DW 13, 14, 15, 16

    ; Arrays para armazenar as somas das linhas e colunas
    somaLinhas      DW 4 DUP(0)
    somaColunas     DW 4 DUP(0)

    ; Mensagens para exibição
    msgOriginal     DB 'Matriz Original:$'
    msgSomaLinhas   DB 13, 10, 'Somas das Linhas: $'
    msgSomaColunas  DB 13, 10, 'Somas das Colunas: $'

    ; Buffer para exibir elementos e somas
    buffer          DB 10 DUP('$')    ; Buffer aumentado para acomodar "Linha X$"

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a matriz original
    LEA DX, msgOriginal
    MOV AH, 09h
    INT 21h

    LEA SI, matrizOriginal
    MOV CX, 4                       ; Número de linhas
    CALL DisplayMatrix

    ; Calcula a soma das linhas
    CALL SumRows

    ; Exibe as somas das linhas
    LEA DX, msgSomaLinhas
    MOV AH, 09h
    INT 21h

    MOV AH, 02h
    MOV DL, 13                      ; Carriage Return
    INT 21h
    MOV DL, 10                      ; Line Feed
    INT 21h

    LEA SI, somaLinhas
    MOV CX, 4                       ; Número de somas de linhas
    CALL DisplaySums

    ; Calcula a soma das colunas
    CALL SumColumns

    ; Exibe as somas das colunas
    LEA DX, msgSomaColunas
    MOV AH, 09h
    INT 21h

    LEA SI, somaColunas
    MOV CX, 4                       ; Número de somas de colunas
    CALL DisplaySums

    ; Termina o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedimento para exibir a matriz 4x4
; Entrada: SI aponta para a matriz, CX = número de linhas
;------------------------------------------------------------
DisplayMatrix PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    ; Inicializa o contador de linhas
    MOV DI, 1                       ; DI = número da linha (1 a 4)

DisplayMatrixLoop:
    ; Prepara a mensagem "Linha X: $"
    MOV AX, 0
    MOV BYTE PTR [buffer], 'L'
    MOV BYTE PTR [buffer+1], 'i'
    MOV BYTE PTR [buffer+2], 'n'
    MOV BYTE PTR [buffer+3], 'h'
    MOV BYTE PTR [buffer+4], 'a'
    MOV BYTE PTR [buffer+5], ' '
    ; Converter DI para ASCII
    MOV BL, DL                      ; BL = número da linha
    ADD BL, '0'                     ; Converte para caractere ASCII
    MOV BYTE PTR [buffer+6], BL
    MOV BYTE PTR [buffer+7], ':'
    MOV BYTE PTR [buffer+8], ' '
    MOV BYTE PTR [buffer+9], '$'

    ; Exibe a mensagem da linha
    LEA DX, buffer
    MOV AH, 09h
    INT 21h

    ; Exibe os elementos da linha
    MOV BX, 4                       ; Número de elementos por linha
DisplayElementsLoop:
    MOV AX, [SI]                    ; Carrega o elemento
    LEA DI, buffer
    CALL WordToString               ; Converte para string
    
    ; Exibe o número
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Exibe espaço
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ADD SI, 2                       ; Move para o próximo elemento
    DEC BX
    JNZ DisplayElementsLoop

    ; Nova linha após cada linha da matriz
    MOV AH, 02h
    MOV DL, 13                      ; Carriage Return
    INT 21h
    MOV DL, 10                      ; Line Feed
    INT 21h

    INC DI                          ; Incrementa o número da linha
    LOOP DisplayMatrixLoop

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplayMatrix ENDP

;------------------------------------------------------------
; Procedimento para calcular a soma de cada linha da matriz
;------------------------------------------------------------
SumRows PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    PUSH DI

    LEA SI, matrizOriginal        ; SI aponta para a matriz
    LEA DI, somaLinhas            ; DI aponta para o array de somas das linhas
    MOV CX, 4                      ; Número de linhas

SumRowsLoop:
    XOR AX, AX                     ; AX = 0 (soma da linha)
    MOV BX, 4                      ; Número de elementos por linha

SumRowsInnerLoop:
    ADD AX, [SI]                   ; AX += elemento atual
    ADD SI, 2                      ; Próximo elemento
    DEC BX
    JNZ SumRowsInnerLoop

    MOV [DI], AX                   ; Armazena a soma da linha
    ADD DI, 2                      ; Próxima posição no array de somas
    LOOP SumRowsLoop

    POP DI
    POP SI
    POP CX
    POP BX
    POP AX
    RET
SumRows ENDP

;------------------------------------------------------------
; Procedimento para calcular a soma de cada coluna da matriz
;------------------------------------------------------------
SumColumns PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    LEA DI, somaColunas           ; DI aponta para o array de somas das colunas
    MOV CX, 4                      ; Número de colunas

SumColumnsLoop:
    XOR AX, AX                     ; AX = 0 (soma da coluna)

    ; Calcula o deslocamento para a coluna atual
    ; Coluna atual = CX -1 (de 3 a 0)
    MOV BX, CX
    DEC BX                         ; BX = coluna atual (0 a 3)
    SHL BX, 1                      ; BX = coluna * 2 (cada elemento ocupa 2 bytes)

    LEA SI, matrizOriginal         ; SI aponta para o início da matriz
    ADD SI, BX                      ; SI aponta para o primeiro elemento da coluna

    MOV BX, 4                      ; Número de linhas

SumColumnsInnerLoop:
    ADD AX, [SI]                   ; AX += elemento atual
    ADD SI, 8                      ; Move para o próximo elemento na mesma coluna (4 elementos por linha * 2 bytes = 8)
    DEC BX
    JNZ SumColumnsInnerLoop

    MOV [DI], AX                   ; Armazena a soma da coluna
    ADD DI, 2                      ; Próxima posição no array de somas das colunas
    LOOP SumColumnsLoop

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SumColumns ENDP

;------------------------------------------------------------
; Procedimento para exibir as somas das linhas ou colunas
; Entrada: SI aponta para o array de somas, CX = número de somas
;------------------------------------------------------------
DisplaySums PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    ; Exibe cada soma
DisplaySumsLoop:
    MOV AX, [SI]                ; Carrega a soma
    LEA DI, buffer
    CALL WordToString           ; Converte para string

    ; Exibe o número
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Exibe espaço
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ADD SI, 2                   ; Move para a próxima soma
    LOOP DisplaySumsLoop

    ; Nova linha após exibir todas as somas
    MOV AH, 02h
    MOV DL, 13                  ; Carriage Return
    INT 21h
    MOV DL, 10                  ; Line Feed
    INT 21h

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplaySums ENDP

;------------------------------------------------------------
; Procedimento para converter uma palavra em AX para uma string em DI
;------------------------------------------------------------
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    ; Inicializa variáveis
    MOV SI, DI                      ; SI aponta para o buffer
    MOV CX, 0                       ; Contador de dígitos

    ; Verifica se AX é zero
    CMP AX, 0
    JNE ConvertLoop
    MOV BYTE PTR [SI], '0'
    INC SI
    JMP ConvertEnd

ConvertLoop:
    MOV BX, 10
DivideLoop:
    XOR DX, DX                      ; Zera DX
    DIV BX                          ; AX / 10
    PUSH DX                         ; Empilha o resto
    INC CX                          ; Incrementa o contador de dígitos
    CMP AX, 0
    JNE DivideLoop

; Desempilha dígitos e armazena no buffer
PopDigits:
    POP DX
    ADD DL, '0'
    MOV [SI], DL
    INC SI
    LOOP PopDigits

ConvertEnd:
    ; Termina a string
    MOV BYTE PTR [SI], '$'

    ; Restaura registradores
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WordToString ENDP

END MAIN
