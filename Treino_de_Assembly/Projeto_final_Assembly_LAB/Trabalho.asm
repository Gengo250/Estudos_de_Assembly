TITLE BATTLE SHIP GAME 
.MODEL SMALL
.STACK 100h

PULA_LINHA MACRO
    PUSH AX
    PUSH DX
    MOV  AH, 02h
    MOV  DL, 10
    INT  21h
    POP  DX
    POP  AX
ENDM

PUSH_T MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
ENDM

POP_T MACRO
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

.DATA
    COLUNAS      DB "   0|1|2|3|4|5|6|7|8|9$"
         
    ESPACE       DB 10,13,"$"
    MSG_LINHA    DB "DIGITE UMA LINHA (0 a 9): $"
    MSG_COLUNA   DB "DIGITE UMA COLUNA (0 a 9): $"
    ACERTO       DB "ACERTOU! $"
    ERROU        DB "ERROU! $"
    MSG_FIM      DB "Jogo terminado! Todos os navios foram afundados! $"
    MSG_REPETIDO DB "Voce ja digitoou essa posicao, digite outra $"
    MATRIZ_1    DB '0', '1', '1', '0', '0', '0', '0', '1', '0', '0'    ; Linha 1 sub
                DB '0', '0', '0', '0', '0', '0', '0', '1', '1', '0'    ; Linha 2 hidro
                DB '0', '0', '0', '0', '0', '0', '0', '1', '0', '0'    ; Linha 3
                DB '0', '0', '0', '1', '1', '1', '1', '0', '0', '0'    ; Linha 4 Encouraçado
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 5
                DB '0', '0', '0', '0', '0', '1', '1', '1', '0', '0'    ; Linha 6 Fragnata
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 7
                DB '0', '0', '0', '0', '0', '0', '1', '0', '0', '0'    ; Linha 8
                DB '0', '1', '1', '0', '0', '0', '1', '1', '0', '0'    ; Linha 9 submarino // hidro
                DB '0', '0', '0', '0', '0', '0', '1', '0', '0', '0'    ; Linha 10
                   
    MATRIZ_2    DB '0', '0', '0', '0', '0', '0', '1', '1', '1', '1'    ; Linha 1 encouracado
                DB '0', '0', '1', '1', '1', '0', '0', '0', '0', '0'    ; Linha 2 fragnata
                DB '0', '0', '0', '0', '0', '0', '0', '1', '1', '0'    ; Linha 3 submarino
                DB '0', '1', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 4 submarino
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 5
                DB '0', '0', '0', '0', '1', '0', '0', '0', '0', '0'    ; Linha 6
                DB '0', '0', '0', '0', '1', '1', '0', '0', '0', '0'    ; Linha 7 hidro
                DB '0', '1', '0', '0', '1', '0', '0', '0', '0', '0'    ; Linha 8
                DB '0', '1', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 9 hidro  
                DB '0', '1', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 10 

    MATRIZ_3    DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 1 
                DB '0', '0', '0', '1', '1', '0', '1', '1', '0', '0'    ; Linha 2 submarino e submarino
                DB '1', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 3 
                DB '1', '1', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 4 hidro
                DB '1', '0', '0', '1', '1', '1', '1', '0', '0', '0'    ; Linha 5 encouracado
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 6
                DB '0', '1', '1', '1', '0', '0', '0', '0', '0', '0'    ; Linha 7 fragnata
                DB '1', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 8
                DB '1', '1', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 9 hidro  
                DB '1', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 10

    MATRIZ_4    DB '0', '0', '0', '0', '0', '0', '0', '1', '1', '1'    ; Linha 1 fragnata
                DB '0', '0', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 2 
                DB '0', '0', '1', '1', '0', '1', '1', '0', '0', '0'    ; Linha 3 submarino e hidro
                DB '0', '0', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 4 
                DB '1', '1', '0', '0', '0', '0', '0', '0', '1', '0'    ; Linha 5 submarino
                DB '0', '0', '0', '0', '0', '0', '0', '0', '1', '1'    ; Linha 6 hidro
                DB '0', '0', '0', '0', '0', '0', '0', '0', '1', '0'    ; Linha 7 
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 8
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 9  
                DB '1', '1', '1', '1', '0', '0', '0', '0', '0', '0'    ; Linha 10 encouracado
    MATRIZ_INICIAL  DB 10 DUP(10 DUP('X'))                                              ; Inicializa uma matriz 10x10 com '*'
    CONTADOR_O   DB 19                                                               ; Inicializa o contador de 'O' (25 'O' na MATRIZ_1)

    MSG_BEM_VINDO DB 'BEM-VINDO AO JOGO DE GUERRA NAVAL!$'
    MSG_AUTORES1 DB 'Desenvolvido por:$'
    MSG_AUTORES2 DB 'Miguel Gengo RA:24009007$'
    MSG_AUTORES3 DB 'Ramon Batista RA:24787061$'
    MSG_CONTINUE DB 'Pressione qualquer tecla para continuar...$'

    MSG_ACERTOU DB 'ACERTOU!'
    MSG_ERROU DB 'ERROU'

.CODE
MAIN PROC
    
    MOV  AX, @DATA
    MOV  DS, AX

    CALL LIMPAR
    CALL APRESENTACAO                          
    CALL IMPRIME1

    MOV  CX, 30  ; O jogador tem 30 chances de acertar os navios
LOOP_PRINCIPAL:                                  
    CALL COMPARA_MATRIZ
     PULA_LINHA
    CALL IMPRIME1
     PULA_LINHA

    ; Verifica se a partida acabou
    MOV  AL, CONTADOR_O
    CMP  AL, 0
    JE   FIM_DE_JOGO

    LOOP LOOP_PRINCIPAL

FIM_DE_JOGO:          
    ; Exibe mensagem de fim de jogo
    MOV  AH, 09H
    LEA  DX, MSG_FIM
    INT  21H
    MOV  AH, 4Ch
    INT  21H
MAIN ENDP

IMPRIME1 PROC
    PUSH_T

    ; Zera SI
    XOR SI, SI
    ; Linha
    MOV CH, 10

    ; Imprime os números das colunas
    MOV AH, 09h
    LEA DX, COLUNAS
    INT 21h

    PULA_LINHA

LACO_FORA1:
    ; Coluna
    MOV CL, 10
    ; Zera BX
    XOR BX, BX

    ; Imprime número da linha
    MOV AH, 2
    MOV DL, 10
    SUB DL, CH
    ADD DL, '0'
    INT 21h

    ; Espaço
    MOV DL, ' '
    INT 21h

    ; Separador de coluna (opcional)
     MOV DL, '|'
    INT 21h

LACO_DENTRO1:
    ; Atribui a DL um dos elementos da matriz
    MOV DL, MATRIZ_INICIAL[SI + BX]

    ; Verifica o valor e imprime
    CMP DL, 'X'     ; Posição não escolhida
    JE IMPRIME_X

    CMP DL, '1'     ; Acerto
    JE IMPRIME_1

    CMP DL, '0'     ; Erro
    JE IMPRIME_0

    JMP CONTINUA1

IMPRIME_X:
    ; Imprime 'X'
    MOV AH, 2
    MOV DL, 'X'
    INT 21h
    JMP CONTINUA1

IMPRIME_1:
    ; Imprime '1' (acerto)
    MOV AH, 2
    MOV DL, '1'
    INT 21h
    JMP CONTINUA1

IMPRIME_0:
    ; Imprime '0' (erro)
    MOV AH, 2
    MOV DL, '0'
    INT 21h
    JMP CONTINUA1

CONTINUA1:
    ; Espaço entre colunas
    MOV DL, ' '
    INT 21h

    ; Próxima coluna
    INC BX
    ; Decrementa o contador CL
    DEC CL
    ; Se CL não for igual a zero, salta para LACO_DENTRO1
    JNZ LACO_DENTRO1

     PULA_LINHA
    ; Próxima linha
    ADD SI, 10
    ; Decrementa o contador CH
    DEC CH
    ; Se CH não for igual a zero, salta para LACO_FORA1
    JNZ LACO_FORA1

    POP_T
    RET
IMPRIME1 ENDP

COMPARA_MATRIZ PROC
    PUSH_T

ESCOLHER_COORDENADA:  
    ; Exibe mensagem para escolher a linha
    MOV AH, 09H
    LEA DX, MSG_LINHA
    INT 21H

    ; Entrada para linha
    MOV AH, 01H
    INT 21H
    SUB AL, '0'                     ; Ajusta para índice (0 a 9)
    CMP AL, 9
    JA ESCOLHER_COORDENADA          ; Se AL > 9, entrada inválida
    MOV BL, AL                      ; Armazena linha em BL

    ; Calcula o índice de linha na matriz
    MOV BH, 0                       ; Limpa BH para usar BX como índice de 16 bits
    MOV AX, BX
    MOV CX, 10
    MUL CX                          ; Multiplica linha por 10 (AX = linha * 10)
    MOV BX, AX                      ; Coloca o resultado em BX

    PULA_LINHA
    ; Exibe mensagem para escolher a coluna
    MOV AH, 09H
    LEA DX, MSG_COLUNA
    INT 21H

    ; Entrada para coluna
    MOV AH, 01H
    INT 21H
    SUB AL, '0'                     ; Ajusta para índice (0 a 9)
    CMP AL, 9
    JA ESCOLHER_COORDENADA          ; Se AL > 9, entrada inválida
    MOV DL, AL                      ; Armazena coluna em DL

    ADD BX, DX                      ; Adiciona a coluna ao índice de linha em BX

    ; Verifica se a coordenada já foi escolhida
    MOV AL, MATRIZ_INICIAL[BX]
    CMP AL, 'X'
    JNE COORDENADA_REPETIDA

    ; Carrega o valor da matriz principal para verificar acerto/erro
    MOV AL, MATRIZ_1[BX]            ; Carrega o valor da MATRIZ_1 no índice calculado

    ; Verifica o conteúdo em MATRIZ_1 e registra em MATRIZ_INICIAL
    CMP AL, '1'                     ; Verifica se é um navio ('1')
    CALL LIMPAR
    JE ACERTOU
    JMP ERRADO

ERRADO:               
    MOV MATRIZ_INICIAL[BX], '0'        ; Marca como erro (água) na MATRIZ_INICIAL
    MOV AH, 09H
    LEA DX, ERROU
    INT 21H
    JMP FIM

ACERTOU:              
    MOV MATRIZ_INICIAL[BX], '1'        ; Marca acerto na MATRIZ_INICIAL
    DEC CONTADOR_O                  ; Decrementa o contador de navios
    MOV AH, 09H
    LEA DX, ACERTO
    INT 21H

FIM:                  
    POP_T
    RET

COORDENADA_REPETIDA:  ; Exibe mensagem de coordenada repetida
    PULA_LINHA
    MOV AH, 09H
    LEA DX, MSG_REPETIDO
    INT 21H
    JMP ESCOLHER_COORDENADA
    PULA_LINHA

COMPARA_MATRIZ ENDP

APRESENTACAO PROC
    ; Posiciona o cursor para a mensagem de boas-vindas (linha 3, coluna 22)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 3      ; Linha 3
    MOV DL, 22     ; Coluna 22
    INT 10h

    ; Exibe mensagem de boas-vindas
    MOV AH, 09h
    LEA DX, MSG_BEM_VINDO
    INT 21h

    ; Posiciona o cursor para "Desenvolvido por:" (linha 10, coluna 30)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 10     ; Linha 10
    MOV DL, 30     ; Coluna 30
    INT 10h

    ; Exibe "Desenvolvido por:"
    MOV AH, 09h
    LEA DX, MSG_AUTORES1
    INT 21h

    ; Posiciona o cursor para o primeiro autor (linha 12, coluna 26)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 12     ; Linha 12
    MOV DL, 26     ; Coluna 26
    INT 10h

    ; Exibe nome e RA do primeiro autor
    MOV AH, 09h
    LEA DX, MSG_AUTORES2
    INT 21h

    ; Posiciona o cursor para o segundo autor (linha 14, coluna 26)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 14     ; Linha 14
    MOV DL, 26     ; Coluna 26
    INT 10h

    ; Exibe nome e RA do segundo autor
    MOV AH, 09h
    LEA DX, MSG_AUTORES3
    INT 21h

    ; Posiciona o cursor para a mensagem de continuar (linha 18, coluna 18)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 18     ; Linha 18
    MOV DL, 18     ; Coluna 18
    INT 10h

    ; Exibe mensagem para continuar
    MOV AH, 09h
    LEA DX, MSG_CONTINUE
    INT 21h

    ; Aguarda qualquer tecla
    MOV AH, 01h
    INT 21h

    ; Limpa a tela
    MOV AH, 06h                    ; Função para rolar a tela para cima
    XOR AL, AL                     ; AL = 0, rola toda a tela
    XOR CX, CX                     ; Posição inicial no canto superior esquerdo (0,0)
    MOV DX, 184Fh                  ; Posição final no canto inferior direito (24,79)
    MOV BH, 07h                    ; Atributo de cor padrão (branco sobre preto)
    INT 10h                        ; Chama interrupção de vídeo para limpar a tela

    RET
APRESENTACAO ENDP

LIMPAR PROC
    MOV AH, 0
    MOV AL, 3
    INT 10H
    RET
LIMPAR ENDP
END MAIN
