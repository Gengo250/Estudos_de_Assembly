TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO SI ou DI
.MODEL SMALL
.DATA
VETOR DB 1, 1, 1, 2, 2, 2
.CODE
MAIN PROC
MOV AX, @DATA ; Move os dados de @DATA em AX
MOV DS,AX ;Inicializa os dados em AX movendo-os a partir de DS

XOR DL, DL ; Zera o registrador DL

MOV CX,6 ; Inicializa CX com 6 (número de elementos do vetor)
XOR DI, DI ; Zera o registrador DI (vai ser usado como índice para a manipulação do vetor)

VOLTA: ; Loop para a manipulação do vetor

MOV DL, VETOR[DI] ; Copia o valor armazenado do índice SI para DL (inicialmente 0)

INC DI ; Incrementa DI com a finalidade de passar para a próxima posição do vetor
ADD DL, 30H ; Converte número em caractere

MOV AH, 02 ; Função para exibir caractere
INT 21H ; Executa a função

LOOP VOLTA ; LOOP volta para "VOLTA"

MOV AH,4CH ; Finaliza o programa
INT 21H ;saida para o DOS

MAIN ENDP
END MAIN
