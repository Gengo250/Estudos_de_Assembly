;------------------------------------------------------------
; Programa em Assembly x86 de 16 bits para trocar a 1ª linha
; com a 4ª coluna de uma matriz 4x4 e exibir corretamente
;------------------------------------------------------------
.MODEL SMALL
.STACK 100h

.DATA
    ; Definição da matriz 4x4 (elementos de 1 a 16)
    MATRIZ DW 1,  2,  3,  4
          DW 5,  6,  7,  8
          DW 9, 10, 11, 12
          DW 13,14, 15, 16

    ; Áreas temporárias para armazenar a 1ª linha e a 4ª coluna
    TEMP_ROW DW 4 DUP(0)        ; 4 elementos para a 1ª linha
    TEMP_COL DW 4 DUP(0)        ; 4 elementos para a 4ª coluna

    ; Mensagens para exibição
    msgOriginal DB 13,10,'Matriz Original: $'
    msgModified DB 13,10,'Matriz Modificada: $'
    msgEnd DB 13,10,'Operacao Concluida.$'

    ; Buffer para conversão de números em strings
    buffer DB 6 DUP('$')        ; Aumentado para acomodar números de até 4 dígitos

.CODE
MAIN PROC
    ; Inicialização do segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibir a matriz original
    LEA DX, msgOriginal
    MOV AH, 09h
    INT 21h

    LEA SI, MATRIZ              ; SI aponta para o início da MATRIZ
    MOV CX, 16                  ; Total de elementos na matriz (4x4)
    CALL DisplayMatrix

    ; Executar a troca da 1ª linha com a 4ª coluna
    CALL SwapRowColumn

    ; Exibir a matriz modificada
    LEA DX, msgModified
    MOV AH, 09h
    INT 21h

    LEA SI, MATRIZ              ; SI aponta para o início da MATRIZ novamente
    MOV CX, 16                  ; Total de elementos na matriz
    CALL DisplayMatrix

    ; Mensagem de término
    LEA DX, msgEnd
    MOV AH, 09h
    INT 21h

    ; Terminar o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedimento para exibir os elementos da matriz
; Entrada: SI aponta para a matriz, CX = número de elementos (16)
;------------------------------------------------------------
DisplayMatrix PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    MOV DI, 0                   ; Índice de coluna

DisplayLoop:
    ; Carregar o elemento atual em AX
    MOV AX, [SI]
    CALL WordToString           ; Converter AX para string em buffer

    ; Exibir o número convertido
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Exibir um espaço entre os números
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ; Incrementar SI para o próximo elemento
    ADD SI, 2

    ; Incrementar DI para gerenciar a formatação da matriz
    INC DI
    CMP DI, 4
    JNE ContinueDisplay

    ; Se chegou ao final de uma linha, pular para a próxima linha
    ; Adiciona Carriage Return e Line Feed
    MOV AH, 02h
    MOV DL, 13                  ; Carriage Return
    INT 21h
    MOV DL, 10                  ; Line Feed
    INT 21h
    MOV DI, 0                   ; Resetar índice de coluna

ContinueDisplay:
    LOOP DisplayLoop

    ; Restaurar registradores
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplayMatrix ENDP

;------------------------------------------------------------
; Procedimento para trocar a 1ª linha com a 4ª coluna
;------------------------------------------------------------
SwapRowColumn PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    ; Passo 1: Armazenar a 1ª linha em TEMP_ROW
    ; Elementos da 1ª linha: MATRIZ[0], MATRIZ[1], MATRIZ[2], MATRIZ[3]
    LEA SI, MATRIZ              ; SI aponta para MATRIZ[0]
    LEA DI, TEMP_ROW            ; DI aponta para TEMP_ROW[0]
    MOV CX, 4                   ; 4 elementos na 1ª linha

StoreRowLoop:
    MOV AX, [SI]                ; Carregar elemento da 1ª linha
    MOV [DI], AX                ; Armazenar em TEMP_ROW
    ADD SI, 2                   ; Próximo elemento na MATRIZ
    ADD DI, 2                   ; Próximo elemento em TEMP_ROW
    LOOP StoreRowLoop

    ; Passo 2: Armazenar a 4ª coluna em TEMP_COL
    ; Elementos da 4ª coluna: MATRIZ[0][3], MATRIZ[1][3], MATRIZ[2][3], MATRIZ[3][3]
    ; Calculando endereços:
    ; MATRIZ[0][3] = MATRIZ + 6
    ; MATRIZ[1][3] = MATRIZ + 14
    ; MATRIZ[2][3] = MATRIZ + 22
    ; MATRIZ[3][3] = MATRIZ + 30

    LEA SI, MATRIZ              ; SI aponta para MATRIZ[0]
    ADD SI, 6                   ; SI aponta para MATRIZ[0][3]
    LEA DI, TEMP_COL            ; DI aponta para TEMP_COL[0]
    MOV CX, 4                   ; 4 elementos na 4ª coluna

StoreColLoop:
    MOV AX, [SI]                ; Carregar elemento da 4ª coluna
    MOV [DI], AX                ; Armazenar em TEMP_COL
    ADD SI, 8                   ; Próximo elemento na 4ª coluna (incremento de 8 bytes)
    ADD DI, 2                   ; Próximo elemento em TEMP_COL
    LOOP StoreColLoop

    ; Passo 3: Copiar TEMP_COL para a 1ª linha
    LEA SI, TEMP_COL            ; SI aponta para TEMP_COL[0]
    LEA DI, MATRIZ              ; DI aponta para MATRIZ[0]
    MOV CX, 4                   ; 4 elementos na 1ª linha

CopyColToRowLoop:
    MOV AX, [SI]                ; Carregar elemento de TEMP_COL
    MOV [DI], AX                ; Copiar para a 1ª linha
    ADD SI, 2                   ; Próximo elemento em TEMP_COL
    ADD DI, 2                   ; Próximo elemento na MATRIZ
    LOOP CopyColToRowLoop

    ; Passo 4: Copiar TEMP_ROW para a 4ª coluna
    ; Calculando endereços novamente:
    ; MATRIZ[0][3] = MATRIZ + 6
    ; MATRIZ[1][3] = MATRIZ + 14
    ; MATRIZ[2][3] = MATRIZ + 22
    ; MATRIZ[3][3] = MATRIZ + 30

    LEA SI, TEMP_ROW            ; SI aponta para TEMP_ROW[0]
    LEA DI, MATRIZ              ; DI aponta para MATRIZ[0]
    ADD DI, 6                   ; DI aponta para MATRIZ[0][3]
    MOV CX, 4                   ; 4 elementos na 4ª coluna

CopyRowToColLoop:
    MOV AX, [SI]                ; Carregar elemento de TEMP_ROW
    MOV [DI], AX                ; Copiar para a 4ª coluna
    ADD SI, 2                   ; Próximo elemento em TEMP_ROW
    ADD DI, 8                   ; Próximo elemento na 4ª coluna (incremento de 8 bytes)
    LOOP CopyRowToColLoop

    ; Restaurar registradores
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SwapRowColumn ENDP

;------------------------------------------------------------
; Procedimento para converter uma palavra em AX para uma string em buffer
;------------------------------------------------------------
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    LEA DI, buffer              ; DI aponta para o início do buffer
    MOV BX, 10                  ; Divisor para conversão

    ; Verifica se AX é zero
    CMP AX, 0
    JNE ConvertNumber
    MOV BYTE PTR [DI], '0'
    INC DI
    JMP ConvertDone

ConvertNumber:
    MOV CX, 0                   ; Contador de dígitos

ConvertLoop:
    XOR DX, DX                  ; Zera DX antes da divisão
    DIV BX                      ; AX = AX / 10, DX = resto
    PUSH DX                     ; Armazena o dígito na pilha
    INC CX                      ; Incrementa o contador de dígitos
    CMP AX, 0
    JNE ConvertLoop

    ; Desempilha os dígitos e armazena no buffer
DesempilhaLoop:
    POP DX                      ; Recupera o dígito
    ADD DL, '0'                 ; Converte para ASCII
    MOV [DI], DL                ; Armazena no buffer
    INC DI
    LOOP DesempilhaLoop

ConvertDone:
    ; Adiciona o terminador de string
    MOV BYTE PTR [DI], '$'

    ; Restaurar registradores
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WordToString ENDP

END MAIN
