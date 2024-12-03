TITLE CommonElements
.MODEL SMALL
.STACK 100h

.DATA
    ; Define os vetores V1 e V2 com 7 elementos cada
    V1 DW 1, 3, 5, 7, 0, 9, 13
    V2 DW 2, 3, 5, 8, 9, 10, 13

    ; Array para armazenar os elementos comuns (máximo 7)
    CommonElements DW 7 DUP(0)

    ; Variável para contar o número de elementos comuns
    Count DW 0

    ; Mensagens para exibição
    msgV1        DB 'Vetor V1: $'
    msgV2        DB 13, 10, 'Vetor V2: $'
    msgCommon    DB 13, 10, 'Elementos Comuns: $'
    msgNone      DB 13, 10, 'Nenhum elemento em comum encontrado.$'

    ; Buffer para conversão de números para strings
    buffer DB 6 DUP('$')    ; Suporta números de até 5 dígitos + terminador '$'

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe o vetor V1
    LEA DX, msgV1
    MOV AH, 09h
    INT 21h

    LEA SI, V1
    MOV CX, 7               ; Número de elementos em V1
    CALL DisplayVector

    ; Exibe o vetor V2
    LEA DX, msgV2
    MOV AH, 09h
    INT 21h

    LEA SI, V2
    MOV CX, 7               ; Número de elementos em V2
    CALL DisplayVector

    ; Encontra os elementos comuns entre V1 e V2
    CALL FindCommonElements

    ; Verifica se algum elemento comum foi encontrado
    CMP Count, 0
    JE NoCommonElements

    ; Exibe os elementos comuns
    LEA DX, msgCommon
    MOV AH, 09h
    INT 21h

    LEA SI, CommonElements
    MOV CX, Count           ; Número de elementos comuns
    CALL DisplayCommonElements
    JMP EndProgram

NoCommonElements:
    ; Exibe a mensagem de nenhum elemento comum
    LEA DX, msgNone
    MOV AH, 09h
    INT 21h

EndProgram:
    ; Termina o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedimento para exibir os elementos de um vetor
; Entrada: SI aponta para o vetor, CX = número de elementos
;------------------------------------------------------------
DisplayVector PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

DisplayVectorLoop:
    MOV AX, [SI]                ; Carrega o elemento atual em AX
    LEA DI, buffer
    CALL WordToString           ; Converte AX para string em buffer

    ; Exibe o número
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Exibe um espaço
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ADD SI, 2                   ; Move para o próximo elemento
    LOOP DisplayVectorLoop

    ; Nova linha após o vetor
    MOV AH, 02h
    MOV DL, 13                  ; Carriage Return
    INT 21h
    MOV DL, 10                  ; Line Feed
    INT 21h

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplayVector ENDP

;------------------------------------------------------------
; Procedimento para encontrar elementos comuns entre V1 e V2
; Armazena os elementos comuns em CommonElements e atualiza Count
;------------------------------------------------------------
FindCommonElements PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    LEA SI, V1                 ; SI aponta para V1
    MOV CX, 7                  ; CX = número de elementos em V1

FindCommonOuterLoop:
    MOV AX, [SI]               ; AX = V1[i]
    PUSH CX                    ; Salva CX (contador externo)
    
    ; Verifica se AX já está em CommonElements
    MOV DX, Count
    CMP DX, 0
    JE CompareWithV2           ; Se Count = 0, pula a verificação

    LEA DI, CommonElements
    MOV BX, DX                 ; BX = Count

CheckDuplicate:
    CMP AX, [DI]               ; Compara AX com CommonElements[j]
    JE DuplicateFound          ; Se encontrado, não adiciona
    ADD DI, 2                  ; Próximo elemento em CommonElements
    DEC BX
    JNZ CheckDuplicate         ; Continua a verificação se ainda houver elementos

CompareWithV2:
    LEA DI, V2                 ; DI aponta para V2
    MOV BX, 7                  ; Número de elementos em V2

FindCommonInnerLoop:
    CMP AX, [DI]               ; Compara AX com V2[j]
    JE AddToCommon             ; Se encontrado, adiciona a CommonElements
    ADD DI, 2                  ; Próximo elemento em V2
    DEC BX
    JNZ FindCommonInnerLoop    ; Continua a busca

    JMP RestoreAndNext         ; Elemento não encontrado em V2

AddToCommon:
    ; Adiciona AX a CommonElements
    LEA DI, CommonElements
    MOV BX, Count              ; Carrega Count
    SHL BX, 1                  ; BX = Count * 2 (calculando o deslocamento)
    ADD DI, BX                 ; DI = CommonElements + Count*2
    MOV [DI], AX               ; Armazena o elemento comum
    INC Count                  ; Incrementa o contador de elementos comuns

RestoreAndNext:
    POP CX                     ; Restaura CX
    ADD SI, 2                  ; Próximo elemento em V1
    LOOP FindCommonOuterLoop    ; Decrementa CX e repete se não for zero
    JMP EndFindCommon

DuplicateFound:
    POP CX                     ; Restaura CX
    ADD SI, 2                  ; Próximo elemento em V1
    LOOP FindCommonOuterLoop    ; Decrementa CX e repete se não for zero

EndFindCommon:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
FindCommonElements ENDP

;------------------------------------------------------------
; Procedimento para exibir os elementos comuns
; Entrada: SI aponta para CommonElements, CX = número de elementos comuns
;------------------------------------------------------------
DisplayCommonElements PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

DisplayCommonLoop:
    MOV AX, [SI]                ; Carrega o elemento comum
    LEA DI, buffer
    CALL WordToString           ; Converte AX para string em buffer

    ; Exibe o número
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; Exibe um espaço
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ADD SI, 2                   ; Move para o próximo elemento comum
    LOOP DisplayCommonLoop

    ; Nova linha após os elementos comuns
    MOV AH, 02h
    MOV DL, 13                  ; Carriage Return
    INT 21h
    MOV DL, 10                  ; Line Feed
    INT 21h

    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
DisplayCommonElements ENDP

;------------------------------------------------------------
; Procedimento para converter uma palavra em AX para uma string em buffer
;------------------------------------------------------------
WordToString PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI

    ; Inicializa variáveis
    MOV SI, DI                  ; SI aponta para o buffer
    MOV CX, 0                   ; Contador de dígitos

    ; Verifica se AX é zero
    CMP AX, 0
    JNE ConvertLoop
    MOV BYTE PTR [SI], '0'
    INC SI
    JMP ConvertEnd

ConvertLoop:
    MOV BX, 10
DivideLoop:
    XOR DX, DX                  ; Zera DX
    DIV BX                      ; AX / 10 -> AX = quociente, DX = resto
    PUSH DX                     ; Empilha o resto (dígito)
    INC CX                      ; Incrementa o contador de dígitos
    CMP AX, 0
    JNE DivideLoop

; Desempilha dígitos e armazena no buffer
PopDigits:
    POP DX                      ; Recupera o dígito
    ADD DL, '0'                 ; Converte para ASCII
    MOV [SI], DL
    INC SI
    LOOP PopDigits

ConvertEnd:
    ; Termina a string com '$'
    MOV BYTE PTR [SI], '$'

    ; Restaura registradores
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
WordToString ENDP

END MAIN
