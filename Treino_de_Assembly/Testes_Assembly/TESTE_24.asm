TITLE CountGreaterThan15
.MODEL SMALL
.STACK 100h

.DATA
    ; Vetor de números a serem analisados
    numbers DB 10, 20, 5, 16, 8, 25, 30, 12, 7, 22 ; Exemplo com 10 elementos

    ; Mensagens a serem exibidas
    msg1    DB 13,10, 'There are ', '$'            ; Mensagem inicial com CR LF
    msg2    DB ' numbers greater than 15.', 13,10, '$' ; Mensagem final com CR LF

    ; Buffer para armazenar a contagem como string
    buffer  DB '00', '$'                           ; Buffer para contagem (2 dígitos)

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Inicializa registradores
    LEA SI, numbers      ; SI aponta para o primeiro elemento do vetor
    MOV CX, 10           ; Número de elementos
    XOR BX, BX           ; Zera BX para contar as ocorrências

COUNT_LOOP:
    MOV AL, [SI]         ; Carrega o elemento atual em AL
    CMP AL, 15
    JLE SKIP_INC
    INC BX               ; Incrementa a contagem se >15
SKIP_INC:
    INC SI
    LOOP COUNT_LOOP

    ; Agora, BX contém o número de ocorrências
    ; Converter BX para string ASCII

    ; Zera buffer
    MOV BYTE PTR buffer, '0'
    MOV BYTE PTR buffer+1, '0'
    MOV BYTE PTR buffer+2, '$'

    ; Converte a contagem em BX para string ASCII no buffer
    MOV AL, BL           ; Move a contagem para AL (assumindo que a contagem <= 255)
    MOV AH, 0            ; Zera AH para a operação de divisão

    ; Calcula a dezena
    MOV BL, 10           ; Divisor 10
    DIV BL               ; AX / BL -> AL = dezenas, AH = unidades
    ADD AL, '0'          ; Converte para caractere ASCII
    MOV buffer, AL       ; Armazena a dezena no buffer

    ; Calcula a unidade
    ADD AH, '0'          ; Converte para caractere ASCII
    MOV buffer+1, AH     ; Armazena a unidade no buffer

    ; Remove zeros à esquerda (exemplo: '05' -> '5')
    CMP buffer, '0'      ; Verifica se a dezena é '0'
    JNE SKIP_ZERO_LEFT
    ; Move a unidade para a posição das dezenas
    MOV AL, [buffer+1]   ; Carrega buffer+1 (unidade) em AL
    MOV [buffer], AL     ; Move AL para buffer
    MOV BYTE PTR [buffer+1], '$' ; Termina a string
SKIP_ZERO_LEFT:

    ; Exibir mensagem inicial (msg1)
    MOV AH, 09h          ; Função DOS para exibir string
    LEA DX, msg1         ; Carrega o endereço da string msg1 em DX
    INT 21h              ; Chama a interrupção DOS

    ; Exibir a contagem
    MOV AH, 09h          ; Função DOS para exibir string
    LEA DX, buffer       ; Carrega o endereço do buffer em DX
    INT 21h              ; Chama a interrupção DOS

    ; Exibir mensagem final (msg2)
    MOV AH, 09h          ; Função DOS para exibir string
    LEA DX, msg2         ; Carrega o endereço da string msg2 em DX
    INT 21h              ; Chama a interrupção DOS

    ; Terminar o programa e retornar ao DOS
    MOV AH, 4Ch          ; Função DOS para terminar programa
    INT 21h              ; Chama a interrupção DOS
MAIN ENDP

END MAIN
