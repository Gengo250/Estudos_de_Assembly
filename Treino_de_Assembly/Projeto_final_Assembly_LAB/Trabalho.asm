.MODEL SMALL
.STACK 100H

PULA_LINHA macro
    PUSH AX
    PUSH DX
    MOV AH,02h
    MOV DL,13      ; Caractere de nova linha (CR)
    INT 21h
    MOV DL,10      ; Caractere de nova linha (LF)
    INT 21h
    POP DX
    POP AX
endm

LIMPA_TELA macro
    MOV AH, 06h                    ; Função para rolar a tela para cima
    XOR AL, AL                     ; AL = 0, rola toda a tela
    XOR CX, CX                     ; Posição inicial no canto superior esquerdo (0,0)
    MOV DX, 184Fh                  ; Posição final no canto inferior direito (24,79)
    MOV BH, 07h                    ; Atributo de cor padrão (branco sobre preto)
    INT 10h                        ; Chama interrupção de vídeo para limpar a tela
endm

.DATA

    ; Tabuleiros
    TABULEIRO1 DB 100 DUP(0)       ; Tabuleiro do jogador
    TABULEIRO2 DB 100 DUP(0)       ; Tabuleiro do oponente (computador)

    ; Mapas predefinidos para o oponente
    ; Os mapas estão definidos com valores numéricos 0 e 1
    MATRIZ     DB 0,1,1,0,0,0,0,1,0,0, 0,0,0,0,0,0,0,1,1,0, 0,0,0,0,0,0,0,1,0,0, 0,0,0,1,1,1,1,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,1,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,1,0,0,0, 0,1,1,0,0,0,1,1,0,0, 0,0,0,0,0,0,1,0,0,0
    MATRIZ_2   DB 0,0,0,0,0,0,1,1,1,1, 0,0,1,1,1,0,0,0,0,0, 0,0,0,0,0,0,0,1,1,0, 0,1,1,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0,0,0, 0,0,0,0,1,1,0,0,0,0, 0,1,0,0,1,0,0,0,0,0, 0,1,1,0,0,0,0,0,0,0, 0,1,0,0,0,0,0,0,0,0
    MATRIZ_3   DB 0,0,0,0,0,0,0,0,0,0, 0,0,0,1,1,0,1,1,0,0, 1,0,0,0,0,0,0,0,0,0, 1,1,0,0,0,0,0,0,0,0, 1,0,0,1,1,1,1,0,0,0, 0,0,0,0,0,0,0,0,0,0, 0,1,1,1,0,0,0,0,0,0, 1,0,0,0,0,0,0,0,0,0, 1,1,0,0,0,0,0,0,0,0, 1,0,0,0,0,0,0,0,0,0
    MATRIZ_4   DB 0,0,0,0,0,0,0,1,1,1, 0,0,1,0,0,0,0,0,0,0, 0,0,1,1,0,1,1,0,0,0, 0,0,1,0,0,0,0,0,0,0, 1,1,0,0,0,0,0,0,1,0, 0,0,0,0,0,0,0,0,1,1, 0,0,0,0,0,0,0,0,1,0, 0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0, 1,1,1,1,0,0,0,0,0,0

    ; Variáveis do jogo
    INFOS DB 0,20 ; INFOS[0]: acertos do jogador, INFOS[1]: tentativas restantes
    LETRA_NUMERO DB 2 DUP(?)      ; Armazena as coordenadas inseridas pelo jogador

    ; Mensagens
    MSG_NOME DB "Informe seu nome: $"
    MSG_POS DB "Entre com uma posicao (coluna letra A-J e linha numero 0-9): $"
    MSG_OCUPADA DB "ERROU! $"
    MSG_OK DB "ACERTOU! $"
    MSG_BEM_VINDO DB 'BEM-VINDO AO JOGO DE GUERRA NAVAL!$'
    MSG_AUTORES1 DB 'Desenvolvido por:$'
    MSG_AUTORES2 DB 'Miguel Gengo RA:24009007$'
    MSG_AUTORES3 DB 'Ramon Batista RA:24787061$'
    MSG_CONTINUE DB 'Pressione qualquer tecla para continuar...$'
    MSG_TENTATIVAS DB "Tentativas restantes: $"
    MSG_ACERTOS DB "Acertos: $"
    MSG_VITORIA DB "Voce venceu! Parabens!$"
    MSG_DERROTA DB "Voce perdeu! Tente novamente.$"
    MSG_JA_ATIROU DB "Voce ja atirou nesta posicao!$"

    NOME DB 20 DUP(0)               ; Espaço para armazenar o nome do usuário

    ; Caracteres para exibir o tabuleiro
    NUMEROS DB '  A B C D E F G H I J $'
    LINHA DB 13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LIMPA_TELA
    CALL APRESENTACAO
    CALL PEDE_NOME

    ; Inicializa variáveis do jogo
    MOV INFOS[0], 0      ; Acertos
    MOV INFOS[1], 20     ; Tentativas restantes

    ; Seleciona um dos mapas aleatoriamente
    CALL SELECIONA_MAPA

    ; Inicia o jogo
    CALL JOGO

    ; Termina o programa
    MOV AH, 4CH
    INT 21H

MAIN ENDP

; ----------------------------------------------
APRESENTACAO PROC
    ; Posiciona o cursor para a mensagem de boas-vindas (linha 10, coluna 22)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 3      ; Linha 3
    MOV DL, 22        ; Coluna 22
    INT 10h

    ; Exibe mensagem de boas-vindas
    MOV AH, 9
    LEA DX, MSG_BEM_VINDO
    INT 21H

    ; Posiciona o cursor para os nomes dos autores (linha 12, coluna 14)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 12        ; Linha 12
    MOV DL, 16       ; Coluna 16
    INT 10h

   ; Posiciona o cursor para a mensagem "Desenvolvido por:" (linha 10, coluna 30)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 10        ; Linha 10
    MOV DL, 30        ; Coluna 30
    INT 10h

    ; Exibe "Desenvolvido por:"
    MOV AH, 9
    LEA DX, MSG_AUTORES1
    INT 21H

    ; Posiciona o cursor para o primeiro autor (linha 12, coluna 26)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 12        ; Linha 12
    MOV DL, 26        ; Coluna 26
    INT 10h

    ; Exibe nome e RA do primeiro autor
    MOV AH, 9
    LEA DX, MSG_AUTORES2
    INT 21H

    ; Posiciona o cursor para o segundo autor (linha 14, coluna 26)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 14        ; Linha 14
    MOV DL, 26        ; Coluna 26
    INT 10h

    ; Exibe nome e RA do segundo autor
    MOV AH, 9
    LEA DX, MSG_AUTORES3
    INT 21H

    ; Posiciona o cursor para a mensagem de continuar (linha 14, coluna 18)
    MOV AH, 02h
    MOV BH, 0
    MOV DH, 18     ; Linha 18
    MOV DL, 18        ; Coluna 18
    INT 10h

    ; Exibe mensagem para continuar
    MOV AH, 9
    LEA DX, MSG_CONTINUE
    INT 21H

    ; Aguarda qualquer tecla
    MOV AH, 1
    INT 21H

    ; Limpa a tela
    MOV AH, 06h                    ; Função para rolar a tela para cima
    XOR AL, AL                     ; AL = 0, rola toda a tela
    XOR CX, CX                     ; Posição inicial no canto superior esquerdo (0,0)
    MOV DX, 184FH                  ; Posição final no canto inferior direito (24,79)
    MOV BH, 07h                    ; Atributo de cor padrão (branco sobre preto)
    INT 10h                        ; Chama interrupção de vídeo para limpar a tela

    RET
APRESENTACAO ENDP

; ----------------------------------------------
; Procedimento para pedir o nome do jogador
PEDE_NOME PROC 
    ; Exibe mensagem para o nome do usuário
    MOV AH, 9
    LEA DX, MSG_NOME
    INT 21H

    ; Recebe o nome do usuário (máx 20 caracteres)
    MOV AH, 0Ah
    LEA DX, NOME
    INT 21H
    RET
PEDE_NOME ENDP

; ----------------------------------------------
; Procedimento para selecionar um mapa aleatório para o oponente
SELECIONA_MAPA PROC
    CALL GERA_POSICAO        ; Gera um número aleatório entre 0 e 3
    MOV BX, AX
    AND BX, 03h              ; Garante que BX esteja entre 0 e 3
    CMP BX, 0
    JE MAPA1
    CMP BX, 1
    JE MAPA2
    CMP BX, 2
    JE MAPA3
    CMP BX, 3
    JE MAPA4
    JMP MAPA1                ; Por segurança, default para MAPA1

MAPA1:
    LEA SI, MATRIZ
    JMP COPIA_MAPA

MAPA2:
    LEA SI, MATRIZ_2
    JMP COPIA_MAPA

MAPA3:
    LEA SI, MATRIZ_3
    JMP COPIA_MAPA

MAPA4:
    LEA SI, MATRIZ_4

COPIA_MAPA:
    LEA DI, TABULEIRO2
    CLD                     ; Garante que a direção é crescente
    MOV CX, 100
    REP MOVSB               ; Copia 100 bytes do mapa selecionado para TABULEIRO2
    RET
SELECIONA_MAPA ENDP

; ----------------------------------------------
; Procedimento para gerar um número aleatório entre 0 e 3
GERA_POSICAO PROC
    MOV AH, 2Ch             ; Lê o relógio do sistema
    INT 21h
    MOV AL, DH              ; Usa os segundos como base para o número aleatório
    RET
GERA_POSICAO ENDP

; ----------------------------------------------
; Procedimento principal do jogo
JOGO PROC
    ; Loop principal do jogo
    MOV CX, 20              ; Número de tentativas
JOGO_LOOP:
    LIMPA_TELA
    CALL IMPRIME1           ; Imprime o tabuleiro do jogador
    CALL MOSTRA_INFOS       ; Mostra tentativas restantes e acertos
    CALL CORDENADAS         ; Lê as coordenadas do jogador
    CALL POSICIONA          ; Processa o tiro no tabuleiro do oponente

    PUSH CX                 ; Salva CX antes de chamar VERIFICA_JOGO1
    CALL VERIFICA_JOGO1     ; Verifica se o jogador ganhou
    POP CX                  ; Restaura CX

    CMP AL, 1
    JE VITORIA
    LOOP JOGO_LOOP
    JMP DERROTA

VITORIA:
    MOV AH, 9
    LEA DX, MSG_VITORIA
    INT 21H
    JMP FIM_JOGO

DERROTA:
    MOV AH, 9
    LEA DX, MSG_DERROTA
    INT 21H

FIM_JOGO:
    RET
JOGO ENDP

; ----------------------------------------------
; Procedimento para mostrar informações do jogo
MOSTRA_INFOS PROC
    ; Mostra tentativas restantes
    MOV AH, 9
    LEA DX, MSG_TENTATIVAS
    INT 21H
    MOV AL, INFOS[1]
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H
    PULA_LINHA

    ; Mostra acertos
    MOV AH, 9
    LEA DX, MSG_ACERTOS
    INT 21H
    MOV AL, INFOS[0]
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 2
    INT 21H
    PULA_LINHA
    RET
MOSTRA_INFOS ENDP

; ----------------------------------------------
; Procedimento para ler e validar as coordenadas
CORDENADAS PROC
TENTA_NOVAMENTE:
    ; Exibe mensagem para inserir a posição
    MOV AH, 9
    LEA DX, MSG_POS
    INT 21H
    PULA_LINHA

    ; Recebe a coluna (letra A-J)
    MOV AH, 1
    INT 21H
    MOV LETRA_NUMERO[0], AL
    MOV DL, AL
    CMP DL, 'A'
    JL TENTA_NOVAMENTE
    CMP DL, 'J'
    JG TENTA_NOVAMENTE
    SUB DL, 'A'        ; Converte para número 0-9
    MOV BL, DL

    ; Recebe a linha (número 0-9)
    MOV AH, 1
    INT 21H
    MOV LETRA_NUMERO[1], AL
    MOV AL, LETRA_NUMERO[1]
    SUB AL, '0'
    CMP AL, 0
    JL TENTA_NOVAMENTE
    CMP AL, 9
    JG TENTA_NOVAMENTE
    MOV BH, AL

    ; Calcula o índice na matriz
    MOV AL, BH         ; AL = linha
    MOV CL, 10
    MUL CL             ; AX = linha * 10
    MOV BL, BL         ; BL já tem a coluna
    ADD AL, BL         ; AL = linha * 10 + coluna
    MOV SI, AX         ; SI = índice na matriz

    RET
CORDENADAS ENDP

; ----------------------------------------------
; Procedimento para processar o tiro no tabuleiro do oponente
POSICIONA PROC
    ; Verifica se já atirou nesta posição
    MOV AL, TABULEIRO1[SI]
    CMP AL, 2
    JE JA_ATIROU
    CMP AL, 3
    JE JA_ATIROU

    ; Verifica se acertou um navio
    MOV AL, TABULEIRO2[SI]
    CMP AL, 1
    JE ACERTOU

    ; Errou o tiro
    MOV TABULEIRO1[SI], 3    ; Marca como erro no tabuleiro do jogador
    DEC INFOS[1]             ; Decrementa tentativas restantes
    MOV AH, 9
    LEA DX, MSG_OCUPADA
    INT 21H
    JMP FIM_POSICIONA

ACERTOU:
    MOV TABULEIRO1[SI], 2    ; Marca como acerto no tabuleiro do jogador
    MOV TABULEIRO2[SI], 2    ; Marca como acertado no tabuleiro do oponente
    INC INFOS[0]             ; Incrementa acertos
    DEC INFOS[1]             ; Decrementa tentativas restantes
    MOV AH, 9
    LEA DX, MSG_OK
    INT 21H
    JMP FIM_POSICIONA

JA_ATIROU:
    ; Já atirou nesta posição
    MOV AH, 9
    LEA DX, MSG_JA_ATIROU
    INT 21H

FIM_POSICIONA:
    RET
POSICIONA ENDP

; ----------------------------------------------
; Procedimento para verificar se o jogador ganhou
VERIFICA_JOGO1 PROC
    MOV DX, 100
    MOV SI, 0
    MOV AL, 1    ; Assume que ganhou
VERIFICA_LOOP:
    MOV BL, TABULEIRO2[SI]
    CMP BL, 1
    JE NAO_GANHOU
    INC SI
    DEC DX
    JNZ VERIFICA_LOOP
    RET

NAO_GANHOU:
    MOV AL, 0    ; Não ganhou ainda
    RET
VERIFICA_JOGO1 ENDP

; ----------------------------------------------
; Procedimento para imprimir o tabuleiro do jogador
IMPRIME1 PROC
    ; Imprime o tabuleiro do jogador com números nas linhas e letras nas colunas
    PULA_LINHA
    MOV AH, 9
    LEA DX, NUMEROS
    INT 21H
    PULA_LINHA

    MOV CH, 0       ; Linha inicial (0)
    MOV SI, 0       ; Índice na matriz
IMPRIME_LINHAS:
    MOV AH, 2
    MOV DL, CH
    ADD DL, '0'
    INT 21H         ; Imprime o número da linha
    MOV CL, 10      ; Colunas (0-9)
IMPRIME_COLUNAS:
    MOV DL, ' '
    INT 21H
    MOV AL, TABULEIRO1[SI]
    CMP AL, 2
    JE MARCA_X
    CMP AL, 3
    JE MARCA_TIL
    MOV DL, '.'
    INT 21H
    JMP PROXIMA_COLUNA

MARCA_X:
    MOV DL, 'X'
    INT 21H
    JMP PROXIMA_COLUNA

MARCA_TIL:
    MOV DL, '~'
    INT 21H

PROXIMA_COLUNA:
    INC SI
    DEC CL
    JNZ IMPRIME_COLUNAS
    PULA_LINHA
    INC CH
    CMP CH, 10
    JL IMPRIME_LINHAS
    RET
IMPRIME1 ENDP

; ----------------------------------------------
END MAIN
