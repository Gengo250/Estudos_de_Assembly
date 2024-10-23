TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2 ; Define o vetor com 6 elementos
.CODE
MAIN PROC
MOV AX, @DATA ; Move os dados de @DATA em AX
MOV DS,AX ;Inicializa os dados em AX movendo-os a partir de DS

XOR DL, DL ; Zera o registrador DL

MOV CX,6 ; Inicializa CX com 6 (número de elementos do vetor)
LEA SI, VETOR ; Carrega o endereço do vetor em SI

VOLTA: ; Loop para a manipulação do vetor

MOV DL, [SI] ; Copia o valor armazenado do índice SI para DL (incialmente posição 0)

INC SI ; Incrementa SI com a finalidade de passar para a próxima posição do vetor
ADD DL, 30H ; Converte número em caractere

MOV AH, 02 ; Função para exibir caractere
INT 21H ; Executa a função

LOOP VOLTA ; LOOP volta para "VOLTA"

MOV AH,4CH ; Finaliza o programa
INT 21H ;saida para o DOS
MAIN ENDP
END MAIN
