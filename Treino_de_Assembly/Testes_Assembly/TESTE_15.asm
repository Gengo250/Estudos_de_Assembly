TITLE Inversão de Vetores com Procedimentos
.MODEL SMALL
.STACK 100h
.DATA 
    VETOR DB 0, 0, 0, 0, 0, 0, 0 ; Vetor de 7 elementos
    MSG DB "Digite um vetor de 7 posicoes: $"
    MSG2 DB 0Dh, 0Ah, "O vetor invertido eh: $" ; Mensagem com nova linha

.CODE
MAIN PROC
    MOV AX, @DATA    ; Inicializa o segmento de dados AX, DS
    MOV DS, AX

    ; Chama procedimento para leitura do vetor
    CALL LeituraVetor

    ; Chama procedimento para inversão do vetor
    CALL InverterVetor

    ; Chama procedimento para impressão do vetor
    CALL ImprimirVetor

    ; Encerrar o programa
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; Procedimento para ler o vetor
LeituraVetor PROC
    PUSH CX          ; Salva CX na pilha
    PUSH BX          ; Salva BX na pilha

    LEA DX, MSG         ; Aponta para a mensagem de entrada
    MOV AH, 09H         ; Função para exibir string (INT 21H)
    INT 21H             ; Imprime a mensagem

    XOR BX, BX          ; BX será o índice do vetor
    MOV CX, 7           ; Número de elementos do vetor

LeituraLoop:
    MOV AH, 01H         ; Função de leitura de caractere (INT 21H)
    INT 21H             ; Lê um caractere do teclado
    SUB AL, 30H         ; Converte o caractere de ASCII para valor numérico (0-9)
    MOV [VETOR + BX], AL; Armazena o valor no vetor
    INC BX              ; Incrementa o índice do vetor
    LOOP LeituraLoop    ; Decrementa CX e continua se CX != 0

    POP BX              ; Restaura BX da pilha
    POP CX              ; Restaura CX da pilha

    RET                 ; Retorna ao procedimento principal
LeituraVetor ENDP

; Procedimento para inverter o vetor usando PUSH e POP
InverterVetor PROC
    PUSH CX             ; Salva CX na pilha
    PUSH SI             ; Salva SI na pilha

    ; Empilha todos os elementos do vetor
    MOV CX, 7           ; Número de elementos
    XOR SI, SI          ; SI = 0 (início do vetor)

PushLoop:
    MOV AL, [VETOR + SI] ; Carrega o valor do vetor em AL
    XOR AH, AH           ; Limpa AH para empilhar um WORD válido
    PUSH AX              ; Empilha o valor (AX) na pilha
    INC SI               ; Próximo elemento
    LOOP PushLoop        ; Decrementa CX e repete se CX != 0

    ; Desempilha os elementos de volta para o vetor (em ordem inversa)
    MOV CX, 7
    XOR SI, SI          ; SI = 0 (início do vetor)

PopLoop:
    POP AX               ; Desempilha o valor para AX
    MOV [VETOR + SI], AL ; Armazena AL no vetor
    INC SI               ; Próximo elemento
    LOOP PopLoop         ; Decrementa CX e repete se CX != 0

    POP SI              ; Restaura SI da pilha
    POP CX              ; Restaura CX da pilha

    RET                 ; Retorna ao procedimento principal
InverterVetor ENDP

; Procedimento para imprimir o vetor
ImprimirVetor PROC
    PUSH CX             ; Salva CX na pilha
    PUSH SI             ; Salva SI na pilha

    LEA DX, MSG2        ; Aponta para a mensagem de saída
    MOV AH, 09H         ; Função para exibir string (INT 21H)
    INT 21H             ; Imprime a mensagem

    MOV CX, 7           ; Número de elementos do vetor
    XOR SI, SI          ; SI = 0 (início do vetor)

ImprimirLoop:
    MOV DL, [VETOR + SI]; Carrega o valor do vetor em DL
    ADD DL, 30H         ; Converte o valor numérico para caractere ASCII
    MOV AH, 02H         ; Função de saída de caractere (INT 21H)
    INT 21H             ; Imprime o caractere

    MOV DL, ' '         ; Prepara para imprimir um espaço
    INT 21H             ; Imprime o espaço

    INC SI              ; Próximo elemento
    LOOP ImprimirLoop   ; Decrementa CX e repete se CX != 0

    POP SI              ; Restaura SI da pilha
    POP CX              ; Restaura CX da pilha

    RET                 ; Retorna ao procedimento principal
ImprimirVetor ENDP

END MAIN
