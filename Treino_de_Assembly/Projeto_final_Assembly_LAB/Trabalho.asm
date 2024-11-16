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
    COLUNAS      DB "  [0][1][2][3][4][5][6][7][8][9] $"
         
    ESPACE       DB 10,13,"$"
    MSG_LINHA    DB "ESCOLHA A LINHA (0 a 9): $"
    MSG_COLUNA   DB "ESCOLHA A COLUNA (0 a 9): $"
    ACERTO       DB "ACERTOU $"
    ERROU        DB "ERROU $"
    MSG_FIM      DB "Jogo terminado! Todos os navios foram afundados! $"
    MSG_REPETIDO DB "Insira outra posicao, posicao ja escolhida $"
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
    MATRIZ_TIRO  DB 10 DUP(10 DUP('X'))                                              ; Inicializa uma matriz 10x10 com '*'
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
    CALL IMPRIMIR_MASCARADA
                     

    MOV  CX, 30  ; O jogador tem 30 chances de acertar o navio
    LOOP_PRINCIPAL:                                  
        CALL COMPARA_MATRIZ
        pula_linha
        CALL IMPRIMIR_MASCARADA
        pula_linha

        ; Verifica se a partida acabou
        MOV  AL, CONTADOR_O
        CMP  AL, 0
        ; Se ele acertar todas as posicoes, em menos de 30 chances, ele ganha.
        LOOP LOOP_PRINCIPAL

    FIM_DE_JOGO:          
    ; Exibe mensagem de fim de jogo
    MOV  AH, 09H
    LEA  DX, MSG_FIM
    INT  21H
    MOV  AH, 4Ch
    INT  21H
MAIN ENDP

IMPRIMIR_MASCARADA PROC
    PUSH_T

    XOR BX, BX
    MOV CX, 10                      

    ; Exibe a mensagem de colunas apenas uma vez
    MOV AH, 09H
    LEA DX, COLUNAS
    INT 21H

    ; Pula uma linha antes de imprimir a matriz
    pula_linha

    LINHA:                
                          CALL        IMPRIMIR_NUMERO_LINHA       ; Chama a função para imprimir o número da linha

    ; Exibe a matriz de jogo
                          XOR         SI, SI                      ; Redefine SI para 0 no início de cada linha
                          MOV         CX, 10                      ; Configura o contador para 10 colunas por linha

    LINHA_IMPRIMIR:       
                          MOV         AH, 02H
                          MOV         DL, MATRIZ_TIRO[BX + SI]    ; Carrega o valor atual da matriz em DL
                          INT         21H                         ; Exibe o caractere

    ; Adiciona mais espaço após cada caractere
                          MOV         DL, ' '                     ; Caractere de espaço
                          INT         21H                         ; Exibe o espaço

    ; Adiciona um espaço extra para aumentar a distância entre as colunas
                          MOV         DL, ' '                     ; Caractere de espaço extra
                          INT         21H                         ; Exibe o espaço extra
                     
                          INC         SI                          ; Incrementa SI para acessar a próxima coluna
                          LOOP        LINHA_IMPRIMIR              ; Repete até que todas as 10 colunas sejam exibidas

    ; Adiciona espaçamento extra entre as linhas
                          pula_linha                              ; Pula para a próxima linha
                     
                          ADD         BX, 10                      ; Passa para a próxima linha na matriz (10 elementos à frente)
                          CMP         BX, 100                     ; Verifica se todas as linhas foram exibidas
                          JL          LINHA                       ; Se não, continua para a próxima linha

                          POP_T
                          RET

IMPRIMIR_MASCARADA ENDP

    ; Nova função para imprimir o número da linha
IMPRIMIR_NUMERO_LINHA PROC
    ; Divide BX por 10 para obter o número da linha
                          MOV         AX, BX
                          MOV         CX, 10
                          XOR         DX, DX                      ; Limpa DX antes da divisão
                          DIV         CX                          ; AX = BX / 10, DX = resto (não usado)

    ; O resultado da divisão está agora em AL
                          MOV         DL, AL                      ; Carrega o número da linha em DL
                          ADD         DL, '0'                     ; Converte para caractere ASCII
                          MOV         AH, 02H
                          INT         21H                         ; Exibe o número da linha

    ; Adiciona espaçamento horizontal entre a linha e a matriz
                          MOV         DL, ' '                     ; Caractere de espaço
                          INT         21H                         ; Exibe o espaço

    ; Adiciona mais espaços para garantir o alinhamento
                          MOV         DL, ' '                     ; Caractere de espaço
                          INT         21H                         ; Exibe o espaço
                    

                          RET
IMPRIMIR_NUMERO_LINHA ENDP
COMPARA_MATRIZ PROC
                          PUSH_T

    ; Loop para garantir que a coordenada não foi escolhida anteriormente
    ESCOLHER_COORDENADA:  
    ; Exibe mensagem para escolher a linha
                          MOV         AH, 09H
                          LEA         DX, MSG_LINHA
                          INT         21H

    ; Entrada para linha
                          MOV         AH, 01H
                          INT         21H
                          CMP         AL, '0'
                          JAE         LINHA_ENTRADA_UNICA         ; Se a primeira tecla for "0" ou maior, vai para entrada única

    ; Se a primeira tecla for menor que "0", repete a entrada
                          JMP         ESCOLHER_COORDENADA

    LINHA_ENTRADA_UNICA:  
                          SUB         AL, '0'                     ; Ajusta para índice (0 a 9)
                          MOV         BL, AL                      ; Armazena linha em BL

    ; Calcula o índice de linha na matriz
                          MOV         BH, 0                       ; Limpa BH para usar BX como índice de 16 bits
                          MOV         AX, BX
                          MOV         CX, 10
                          MUL         CX                          ; Multiplica linha por 10 (BX = linha * 10)
                          MOV         BX, AX                      ; Coloca o resultado em BX
                          pula_linha
    ; Exibe mensagem para escolher a coluna
                          MOV         AH, 09H
                          LEA         DX, MSG_COLUNA
                          INT         21H

    ; Entrada para coluna
                          MOV         AH, 01H
                          INT         21H
                          CMP         AL, '0'
                          JAE         COLUNA_ENTRADA_UNICA        ; Se a primeira tecla for "0" ou maior, vai para entrada única

    ; Se a primeira tecla for menor que "0", repete a entrada
                          JMP         ESCOLHER_COORDENADA

    COLUNA_ENTRADA_UNICA: 
                          SUB         AL, '0'                     ; Ajusta para índice (0 a 9)
                          MOV         DL, AL                      ; Armazena coluna em DL

                          ADD         BX, DX                      ; Adiciona a coluna ao índice de linha em BX

    ; Verifica se a coordenada já foi escolhida
                          MOV         AL, MATRIZ_TIRO[BX]
                          CMP         AL, '0'
                          JE          COORDENADA_REPETIDA
                          CMP         AL, '1'
                          JE          COORDENADA_REPETIDA

    ; Carrega o valor da matriz principal para verificar acerto/erro
                          MOV         AL, MATRIZ_1[BX]            ; Carrega o valor da MATRIZ_1 no índice calculado

    ; Verifica o conteúdo em MATRIZ_1 e registra em MATRIZ_TIRO
                          CMP         AL, '1'                     ; Verifica se é um navio ('O')
                          pula_linha
                          pula_linha
                          CALL        LIMPAR
                          JE          ACERTOU
                          JMP         ERRADO

    ERRADO:               
                        MOV         MATRIZ_TIRO[BX], '0'; Marca como erro (água) na MATRIZ_TIRO
                        MOV AH, 9
                        LEA DX, MSG_ERROU
                        INT 21H                                 ; Macro para mensagem de erro
                        JMP         FIM

    ACERTOU:              
                        MOV         MATRIZ_TIRO[BX], '1'        ; Marca acerto na MATRIZ_TIRO
                        DEC         CONTADOR_O
                        MOV AH, 9
                        LEA DX, MSG_ACERTOU
                        INT 21H                  ; Decrementa o contador de 'O'
                                                    ; Macro para mensagem de acerto

    FIM:                  
    
                          POP_T
                          RET

    COORDENADA_REPETIDA:  ; Exibe mensagem de coordenada repetida
        MOV AH, 09H
        LEA DX, MSG_REPETIDO
        INT 21H
        JMP ESCOLHER_COORDENADA

COMPARA_MATRIZ ENDP


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

LIMPAR PROC                                                       ;Funcao feita para a limpeza de telas
    MOV         AH,0
    MOV         AL,3
    INT         10H
    RET
LIMPAR ENDP
END MAIN