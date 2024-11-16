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

LIMPA_TELA macro
    MOV AH, 06h                    ; Função para rolar a tela para cima
    XOR AL, AL                     ; AL = 0, rola toda a tela
    XOR CX, CX                     ; Posição inicial no canto superior esquerdo (0,0)
    MOV DX, 184FH                  ; Posição final no canto inferior direito (24,79)
    MOV BH, 07h                    ; Atributo de cor padrão (branco sobre preto)
    INT 10h                        ; Chama interrupção de vídeo para limpar a tela
endm

PUSH_ALL MACRO
             PUSH AX
             PUSH BX
             PUSH CX
             PUSH DX
ENDM

.DATA

     MATRIZ_INICIAL  DB 10 DUP(10 DUP("X")) ; Matriz inicial


     MATRIZ     DB '0', '0', '0', '0', '0', '0', '0', '1', '1', '1'    ; Linha 1 fragnata
                DB '0', '0', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 2 
                DB '0', '0', '1', '1', '0', '1', '1', '0', '0', '0'    ; Linha 3 submarino e hidro
                DB '0', '0', '1', '0', '0', '0', '0', '0', '0', '0'    ; Linha 4 
                DB '1', '1', '0', '0', '0', '0', '0', '0', '1', '0'    ; Linha 5 submarino
                DB '0', '0', '0', '0', '0', '0', '0', '0', '1', '1'    ; Linha 6 hidro
                DB '0', '0', '0', '0', '0', '0', '0', '0', '1', '0'    ; Linha 7 
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 8
                DB '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'    ; Linha 9  
                DB '1', '1', '1', '1', '0', '0', '0', '0', '0', '0'    ; Linha 10 encouracado

        ;Segundo Mapa

     MATRIZ_2   DB 0, 0, 0, 0, 0, 0, 1, 1, 1, 1    ; Linha 1 encouracado
                DB 0, 0, 1, 1, 1, 0, 0, 0, 0, 0    ; Linha 2 fragnata
                DB 0, 0, 0, 0, 0, 0, 0, 1, 1, 0    ; Linha 3 submarino
                DB 0, 1, 1, 0, 0, 0, 0, 0, 0, 0    ; Linha 4 submarino
                DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 5
                DB 0, 0, 0, 0, 1, 0, 0, 0, 0, 0    ; Linha 6
                DB 0, 0, 0, 0, 1, 1, 0, 0, 0, 0    ; Linha 7 hidro
                DB 0, 1, 0, 0, 1, 0, 0, 0, 0, 0    ; Linha 8
                DB 0, 1, 1, 0, 0, 0, 0, 0, 0, 0    ; Linha 9 hidro  
                DB 0, 1, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 10

        ;Terceiro Mapa

    MATRIZ_3    DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 1 
                DB 0, 0, 0, 1, 1, 0, 1, 1, 0, 0    ; Linha 2 submarino e submarino
                DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 3 
                DB 1, 1, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 4 hidro
                DB 1, 0, 0, 1, 1, 1, 1, 0, 0, 0    ; Linha 5 encouracado
                DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 6
                DB 0, 1, 1, 1, 0, 0, 0, 0, 0, 0    ; Linha 7 fragnata
                DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 8
                DB 1, 1, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 9 hidro  
                DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 10

        ;Quarto Mapa

    MATRIZ_4    DB 0, 0, 0, 0, 0, 0, 0, 1, 1, 1    ; Linha 1 fragnata
                DB 0, 0, 1, 0, 0, 0, 0, 0, 0, 0    ; Linha 2 
                DB 0, 0, 1, 1, 0, 1, 1, 0, 0, 0    ; Linha 3 submarino e hidro
                DB 0, 0, 1, 0, 0, 0, 0, 0, 0, 0    ; Linha 4 
                DB 1, 1, 0, 0, 0, 0, 0, 0, 1, 0    ; Linha 5 submarino
                DB 0, 0, 0, 0, 0, 0, 0, 0, 1, 1    ; Linha 6 hidro
                DB 0, 0, 0, 0, 0, 0, 0, 0, 1, 0    ; Linha 7 
                DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 8
                DB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    ; Linha 9  
                DB 1, 1, 1, 1, 0, 0, 0, 0, 0, 0    ; Linha 10 encouracado




    MSG_NOME DB "Informe seu nome: $"
    MSG_POS DB "Entre com uma posicao (linha e coluna, de 0 a 9): $"
    MSG_OCUPADA DB "Voce ja digito essa posicao, digite outra posicao! $"
    MSG_OK DB "ACERTOU! $"
    NOME DB 20 DUP(0)               ; Espaço para armazenar o nome do usuário
    LINHA DB ?                      ; Armazena a linha inserida pelo usuário
    COLUNA DB ?                     ; Armazena a coluna inserida pelo usuário
    MSG_BEM_VINDO DB 'BEM-VINDO AO JOGO DE GUERRA NAVAL!$'
    MSG_AUTORES1 DB 'Desenvolvido por:$'
    MSG_AUTORES2 DB 'Miguel Gengo RA:24009007$'
    MSG_AUTORES3 DB 'Ramon Batista RA:24787061$'
    MSG_CONTINUE DB 'Pressione qualquer tecla para continuar...$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LIMPA_TELA
    CALL APRESENTACAO
    CALL PEDE_NOME


    ; Loop para pedir posições 20 vezes
    MOV CX, 20


POSICAO_LOOP:

    PUSH_ALL

    CALL APAGA
    CALL IMPRIMIR
    ; Exibe mensagem para inserir a posição


    MOV AH, 9
    LEA DX, MSG_POS
    INT 21H
    PULA_LINHA

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

    ; Verifica se a posição já está ocupada na matriz que eh exibida
    MOV AL, MATRIZ_INICIAL[SI]
    CMP AL, "1"
    JE POSICAO_OCUPADA


     ; Matriz livre, e verfica se o usuaaio acertout
    MOV AL, MATRIZ[SI]
    CMP AL, "1"
    JE ACERTOU
    JNE ERROU

ACERTOU:
    MOV MATRIZ_INICIAL[SI], 1
    MOV AH, 9
    LEA DX, MSG_OK
    INT 21H
    JMP PROXIMA_ITERACAO

ERROU:
    MOV MATRIZ_INICIAL[SI], 0
    MOV AH, 9
    LEA DX, MSG_OK
    INT 21H
    JMP PROXIMA_ITERACAO


POSICAO_OCUPADA:
    ; Exibe mensagem que o usuario ja digitou esse numero
    MOV AH, 9
    LEA DX, MSG_OCUPADA
    INT 21H
    JMP POSICAO_LOOP


    

PROXIMA_ITERACAO:
    LOOP POSICAO_LOOP

    ; Termina o programa
    MOV AH, 4CH
    INT 21H

MAIN ENDP

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

; Função para gerar uma posição aleatória entre 0 e 99
GERA_POSICAO PROC
    MOV AH, 0                     ; Lê o contador de ticks do relógio do sistema
    INT 1AH
    MOV AX, DX                    ; Usa o valor de DX como base para o número aleatório
    MOV CX, 100                   ; Define o divisor para o valor máximo (100 para 0-99)
    XOR DX, DX                    ; Limpa DX antes da divisão
    DIV CX                        ; AX = Quociente; DX = Resto
    MOV AX, DX                    ; O valor aleatório está agora em AX
    RET
GERA_POSICAO ENDP


PEDE_NOME PROC 
     ; Exibe mensagem para o nome do usuário
    MOV NOME, 20
    MOV AH, 9
    LEA DX, MSG_NOME
    INT 21H

    ; Recebe o nome do usuário (máx 20 caracteres)
    MOV AH, 0AH
    LEA DX, NOME
    INT 21H
    RET
PEDE_NOME ENDP


IMPRIMIR PROC
    XOR SI, SI
    XOR BX, BX
    MOV CH, 10
IMPRIMECOLUNA:
    MOV CL, 10

ESCREVELINHA:
    MOV DL, MATRIZ_INICIAL[SI+BX]
    OR DL, 30H
    MOV AH, 2
    INT 21H
    MOV DL, ' '
    INT 21H 
    MOV DL, ' ' 
    INT 21H                         
    INC SI
    DEC CL
    JNZ ESCREVELINHA
    PULA_LINHA
    ADD BX, 4
    XOR SI, SI

    DEC CH
    JNZ IMPRIMECOLUNA
    RET
IMPRIMIR ENDP

APAGA PROC                                                       ;Funcao feita para a limpeza de telas
                          MOV         AH,0
                          MOV         AL,3
                          INT         10H
                          RET
APAGA ENDP


COMPARA PROC
    


COMPARA ENDP

END MAIN