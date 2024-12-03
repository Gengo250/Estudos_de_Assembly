;------------------------------------------------------------
; Programa em Assembly x86 de 16 bits para calcular a média
; dos elementos de um vetor e exibir o resultado na tela
;------------------------------------------------------------
.MODEL SMALL
.STACK 100h

.DATA
    ; Definição do vetor de 5 elementos
    VETOR DW 10, 20, 30, 40, 50  ; Vetor com 5 elementos

    ; Tamanho do vetor
    TAMANHO DW 5                 ; Número de elementos no vetor

    ; Mensagens para exibição
    msgInicio DB 13,10, 'Calculando a média dos elementos do vetor...', 13,10, '$'
    msgMedia DB 13,10, 'A media dos elementos e: $'

    ; Buffer para conversão de números em strings
    buffer DB 6 DUP('$')         ; Buffer para armazenar a string da média

.CODE
MAIN PROC
    ; Inicialização do segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibir mensagem inicial
    LEA DX, msgInicio
    MOV AH, 09h
    INT 21h

    ; Inicializar registradores para soma
    XOR AX, AX        ; AX = 0 (soma baixa)
    XOR DX, DX        ; DX = 0 (soma alta, para somas que excedem 16 bits)

    ; Configurar ponteiro para o vetor
    LEA SI, VETOR      ; SI aponta para o início do vetor

    ; Carregar o tamanho do vetor em CX
    MOV CX, TAMANHO    ; CX = número de elementos no vetor

SomarLoop:
    ; Adicionar o elemento atual à soma
    ADD AX, [SI]        ; AX = AX + VETOR[i]
    ADC DX, 0           ; DX = DX + carry (para somas que excedem 16 bits)

    ; Avançar para o próximo elemento
    ADD SI, 2           ; Próximo elemento (cada DW ocupa 2 bytes)

    ; Decrementar o contador e verificar se continua
    LOOP SomarLoop      ; Decrementa CX e repete se CX != 0

    ; Agora AX:DX contém a soma total dos elementos
    ; Precisamos dividir a soma por TAMANHO para obter a média

    ; Converter a soma para uma única variável de 32 bits se necessário
    ; Neste caso, como a soma máxima é 50*5=250, que cabe em 16 bits, podemos usar apenas AX

    ; Calcular a média: Média = Soma / TAMANHO
    ; AX já contém a soma, e TAMANHO está em TAMANHO

    ; Carregar o tamanho do vetor em BX para divisão
    MOV BX, TAMANHO     ; BX = 5

    ; Executar a divisão: AX = AX / BX, DX = AX % BX
    ; Como estamos lidando apenas com a soma em AX, podemos usar o registrador AX para a média
    XOR DX, DX          ; Limpar DX antes da divisão
    DIV BX              ; AX = AX / BX, DX = AX % BX

    ; Agora, AX contém a média

    ; Converter a média para string
    CALL WordToString    ; Resultado em AX será convertido para string em buffer

    ; Exibir a mensagem da média
    LEA DX, msgMedia
    MOV AH, 09h
    INT 21h

    ; Exibir o buffer com a média
    LEA DX, buffer
    MOV AH, 09h
    INT 21h

    ; Adicionar nova linha após a média
    MOV AH, 02h
    MOV DL, 13          ; Carriage Return
    INT 21h
    MOV DL, 10          ; Line Feed
    INT 21h

    ; Terminar o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedimento para converter uma palavra em AX para uma string em buffer
;------------------------------------------------------------
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    ; Inicializar ponteiros e registradores
    LEA DI, buffer          ; DI aponta para o início do buffer
    MOV CX, 0               ; Contador de dígitos
    MOV BX, 10              ; Divisor para conversão decimal

    ; Verificar se AX é zero
    CMP AX, 0
    JNE ConvertNumber
    MOV BYTE PTR [DI], '0'  ; Armazenar '0' no buffer
    INC DI
    JMP ConvertDone

ConvertNumber:
    ; Dividir AX por 10 repetidamente para extrair os dígitos
ConvertLoop:
    XOR DX, DX              ; Zerar DX antes da divisão
    DIV BX                  ; AX = AX / 10, DX = AX % 10
    PUSH DX                 ; Armazenar o dígito na pilha
    INC CX                  ; Incrementar o contador de dígitos
    CMP AX, 0
    JNE ConvertLoop

    ; Desempilhar os dígitos e armazenar no buffer
DesempilhaLoop:
    POP DX                  ; Recuperar o dígito
    ADD DL, '0'             ; Converter para ASCII
    MOV [DI], DL            ; Armazenar no buffer
    INC DI
    LOOP DesempilhaLoop     ; Repetir até que CX seja zero

ConvertDone:
    ; Adicionar o terminador de string
    MOV BYTE PTR [DI], '$'

    ; Restaurar registradores
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WordToString ENDP

END MAIN
