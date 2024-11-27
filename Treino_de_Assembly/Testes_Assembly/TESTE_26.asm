TITLE MatrizTransposta
.MODEL SMALL
.STACK 100h

.DATA
    ; Definição da matriz 2x2 de palavras (16 bits)
    matrizOriginal DW 1, 2   ; Linha 1: 1, 2
                  DW 3, 4   ; Linha 2: 3, 4

    ; Variável para armazenar a matriz transposta
    matrizTransposta DW 2 DUP(?) ; 2x2 matriz transposta

    ; Mensagens para exibição
    msgLinha1Original   DB 13,10, 'Matriz Original:', 13,10, '$'
    msgLinha1Transposta DB 13,10, 'Matriz Transposta:', 13,10, '$'

    ; Buffers para armazenar as strings dos valores
    bufferElemento DB 6 DUP('$') ; Até 5 dígitos + terminador

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama o procedimento para calcular a matriz transposta
    CALL TransposeMatrix

    ; Exibe a matriz transposta
    CALL DisplayMatrix

    ; Finaliza o programa
    MOV AH, 4Ch          ; Função DOS para terminar programa
    INT 21h
MAIN ENDP

; Procedimento para calcular a matriz transposta
TransposeMatrix PROC
    ; Matriz Original:
    ; [0][0] = 1    [0][1] = 2
    ; [1][0] = 3    [1][1] = 4

    ; Matriz Transposta:
    ; [0][0] = 1    [0][1] = 3
    ; [1][0] = 2    [1][1] = 4

    ; Carrega os elementos da matriz original e atribui aos transpostos
    MOV AX, [matrizOriginal]       ; AX = matrizOriginal[0][0] = 1
    MOV [matrizTransposta], AX     ; matrizTransposta[0][0] = 1

    MOV AX, [matrizOriginal+2]     ; AX = matrizOriginal[0][1] = 2
    MOV [matrizTransposta+4], AX   ; matrizTransposta[1][0] = 2

    MOV AX, [matrizOriginal+4]     ; AX = matrizOriginal[1][0] = 3
    MOV [matrizTransposta+2], AX   ; matrizTransposta[0][1] = 3

    MOV AX, [matrizOriginal+6]     ; AX = matrizOriginal[1][1] = 4
    MOV [matrizTransposta+6], AX   ; matrizTransposta[1][1] = 4

    RET
TransposeMatrix ENDP

; Procedimento para converter uma palavra em AX para string em DI
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    ; Inicializa variáveis
    MOV SI, DI         ; SI aponta para o buffer
    MOV CX, 0          ; Contador de dígitos

    ; Verifica se AX é zero
    CMP AX, 0
    JNE ConvertLoop
    MOV BYTE PTR [SI], '0'
    INC SI
    JMP ConvertEnd

ConvertLoop:
    ; Converte AX para dígitos decimais (ordem inversa)
    MOV BX, 10
DivideLoop:
    XOR DX, DX         ; Zera DX antes da divisão
    DIV BX             ; AX / BX → AL = quociente, AH = resto
    PUSH DX            ; Empilha o dígito
    INC CX             ; Incrementa o contador de dígitos
    CMP AX, 0
    JNE DivideLoop

    ; Desempilha os dígitos e armazena no buffer
PopDigits:
    POP DX             ; Recupera o dígito
    ADD DL, '0'        ; Converte para ASCII
    MOV [SI], DL
    INC SI
    LOOP PopDigits

ConvertEnd:
    ; Finaliza a string
    MOV BYTE PTR [SI], '$'

    ; Restaura registradores
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX

    RET
WordToString ENDP

; Procedimento para exibir a matriz transposta
DisplayMatrix PROC
    ;Exibe a mensagem "Matriz Original:"
    MOV AH, 09h               ; Função DOS para exibir string
    LEA DX, msgLinha1Original 
    INT 21h

     ; Linha 1
    MOV AX, [matrizOriginal]       
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Espaço entre elementos
    MOV AH, 02h               ; Função DOS para exibir caractere
    MOV DL, ' '               ; Espaço
    INT 21h

    MOV AX, [matrizOriginal+2]     
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Nova linha
    MOV AH, 02h
    MOV DL, 13                ; Carriage Return
    INT 21h
    MOV DL, 10                ; Line Feed
    INT 21h
    
    ; Linha 2
    MOV AX, [matrizOriginal+4]     
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Espaço entre elementos
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    MOV AX, [matrizOriginal+6]     
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Nova linha
    MOV AH, 02h
    MOV DL, 13                ; Carriage Return
    INT 21h
    MOV DL, 10                ; Line Feed
    INT 21h


    ; Exibe a mensagem "Matriz Transposta:"
    MOV AH, 09h               ; Função DOS para exibir string
    LEA DX, msgLinha1Transposta
    INT 21h

    ; Exibe cada elemento da matriz transposta
    ; Elementos:
    ; [0][0], [0][1]
    ; [1][0], [1][1]

    ; Linha 1
    MOV AX, [matrizTransposta]       ; AX = matrizTransposta[0][0]
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Espaço entre elementos
    MOV AH, 02h               ; Função DOS para exibir caractere
    MOV DL, ' '               ; Espaço
    INT 21h

    MOV AX, [matrizTransposta+2]     ; AX = matrizTransposta[0][1]
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Nova linha
    MOV AH, 02h
    MOV DL, 13                ; Carriage Return
    INT 21h
    MOV DL, 10                ; Line Feed
    INT 21h

    ; Linha 2
    MOV AX, [matrizTransposta+4]     ; AX = matrizTransposta[1][0]
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Espaço entre elementos
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    MOV AX, [matrizTransposta+6]     ; AX = matrizTransposta[1][1]
    LEA DI, bufferElemento
    CALL WordToString
    MOV AH, 09h
    LEA DX, bufferElemento
    INT 21h

    ; Nova linha
    MOV AH, 02h
    MOV DL, 13                ; Carriage Return
    INT 21h
    MOV DL, 10                ; Line Feed
    INT 21h

    RET
DisplayMatrix ENDP

END MAIN
