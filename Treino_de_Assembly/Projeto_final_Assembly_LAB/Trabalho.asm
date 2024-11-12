.MODEL SMALL
.STACK 100H

PULA_LINHA macro
    PUSH AX
    PUSH DX
    MOV AH,02
    MOV DL,10
    INT 21H
    POP DX
    POP AX
endm

.DATA
    MATRIZ DB 100 DUP(0)           ; MATRIZ 10x10 INICIALIZADA COM ZEROS (100 POSIÇÕES)
    MSG_NOME DB "Informe seu nome: $"
    MSG_POS DB "Entre com uma posicao (linha e coluna, de 0 a 9): $"
    MSG_OCUPADA DB "A posicao ja esta ocupada! Tente novamente.$"
    MSG_OK DB "Posicao marcada com sucesso!$"
    NOME DB 20 DUP(?)               ; Espaço para armazenar o nome do usuário
    LINHA DB ?                      ; Armazena a linha inserida pelo usuário
    COLUNA DB ?                     ; Armazena a coluna inserida pelo usuário

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Limpa a tela
    MOV AH, 06h                    ; Função para rolar a tela para cima
    XOR AL, AL                     ; AL = 0, rola toda a tela
    XOR CX, CX                     ; Posição inicial no canto superior esquerdo (0,0)
    MOV DX, 184FH                  ; Posição final no canto inferior direito (24,79)
    MOV BH, 07h                    ; Atributo de cor padrão (branco sobre preto)
    INT 10h                        ; Chama interrupção de vídeo para limpar a tela

    ; Exibe mensagem para o nome do usuário
    MOV AH, 9
    LEA DX, MSG_NOME
    INT 21H

    ; Recebe o nome do usuário (máx 20 caracteres)
    MOV AH, 0AH
    LEA DX, NOME
    INT 21H

    ; Loop para pedir posições 20 vezes
    MOV CX, 20

POSICAO_LOOP:
    ; Exibe mensagem para inserir a posição
    MOV AH, 9
    LEA DX, MSG_POS
    INT 21H

    ; Recebe a linha
    MOV AH, 1           ; Função para ler um caractere
    INT 21H
    SUB AL, '0'         ; Converte ASCII para valor numérico
    MOV LINHA, AL

    ; Recebe a coluna
    MOV AH, 1           ; Função para ler um caractere
    INT 21H
    SUB AL, '0'         ; Converte ASCII para valor numérico
    MOV COLUNA, AL

    ; Calcula o índice da matriz 10x10: índice = linha * 10 + coluna
    MOV AL, LINHA
    MOV BL, 10
    MUL BL              ; AL = linha * 10
    ADD AL, COLUNA      ; AL = linha * 10 + coluna
    MOV SI, AX          ; Guarda o índice na matriz

    ; Verifica se a posição já está ocupada
    MOV AL, MATRIZ[SI]
    CMP AL, 0
    JNE POSICAO_OCUPADA

    ; Marca a posição com o valor 1
    MOV MATRIZ[SI], 1

    ; Exibe mensagem de sucesso
    MOV AH, 9
    LEA DX, MSG_OK
    INT 21H
    JMP PROXIMA_ITERACAO

POSICAO_OCUPADA:
    ; Exibe mensagem de posição ocupada
    MOV AH, 9
    LEA DX, MSG_OCUPADA
    INT 21H

PROXIMA_ITERACAO:
    LOOP POSICAO_LOOP

    ; Termina o programa
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
