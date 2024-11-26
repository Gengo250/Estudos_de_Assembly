TITLE MatrizMaxMin
.MODEL SMALL
.STACK 100h

.DATA
    ; Definição da matriz 4x4 de palavras (16 bits)
    matriz  DW  12, 7, 3, 15     ; Linha 1
            DW  8, 22, 14, 5     ; Linha 2
            DW  19, 2, 11, 6     ; Linha 3
            DW  10, 9, 4, 20     ; Linha 4

    ; Variáveis para armazenar o maior e o menor valor
    maiorValor DW ?
    menorValor DW ?

    ; Mensagens para exibição
    msgMaior  DB 13,10, 'Maior valor na matriz: ', '$'
    msgMenor  DB 13,10, 'Menor valor na matriz: ', '$'

    ; Buffers para armazenar as strings dos valores
    bufferMaior DB 6 DUP('$')   ; Até 5 dígitos + terminador
    bufferMenor DB 6 DUP('$')

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Chama o procedimento para encontrar o maior e o menor valor
    CALL FindMaxMin

    ; Converte o maior valor para string e armazena em bufferMaior
    MOV AX, maiorValor
    LEA DI, bufferMaior
    CALL WordToString

    ; Exibe a mensagem e o maior valor
    MOV AH, 09h               ; Função DOS para exibir string
    LEA DX, msgMaior
    INT 21h
    LEA DX, bufferMaior
    INT 21h

    ; Converte o menor valor para string e armazena em bufferMenor
    MOV AX, menorValor
    LEA DI, bufferMenor
    CALL WordToString

    ; Exibe a mensagem e o menor valor
    MOV AH, 09h               ; Função DOS para exibir string
    LEA DX, msgMenor
    INT 21h
    LEA DX, bufferMenor
    INT 21h

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

; Procedimento para encontrar o maior e o menor valor na matriz
FindMaxMin PROC
    ; Inicializa o ponteiro e os registradores
    LEA SI, matriz     ; SI aponta para o início da matriz
    MOV CX, 16         ; 4x4 elementos = 16 elementos
    MOV AX, [SI]       ; Carrega o primeiro elemento em AX

    ; Inicializa maiorValor e menorValor com o primeiro elemento
    MOV maiorValor, AX
    MOV menorValor, AX

    ADD SI, 2          ; Avança para o próximo elemento
    DEC CX             ; Decrementa CX pois já processamos o primeiro elemento

LoopValores:
    MOV AX, [SI]       ; Carrega o próximo elemento em AX

    ; Verifica se AX é maior que maiorValor
    MOV DX, maiorValor
    CMP AX, DX
    JLE VerificaMenor
    MOV maiorValor, AX

VerificaMenor:
    ; Verifica se AX é menor que menorValor
    MOV DX, menorValor
    CMP AX, DX
    JGE ProximoElemento
    MOV menorValor, AX

ProximoElemento:
    ADD SI, 2          ; Avança para o próximo elemento
    LOOP LoopValores

    RET
FindMaxMin ENDP

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
    DIV BX             ; AX / 10; AX = quociente, DX = resto
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

END MAIN
