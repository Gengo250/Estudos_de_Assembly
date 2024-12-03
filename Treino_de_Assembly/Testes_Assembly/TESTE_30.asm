TITLE RemoveElement
.MODEL SMALL
.STACK 100h

.DATA
    ARRAY DW 1,2,3,4,5,6      ; Vetor inicial
    ArraySize DW 6            ; Tamanho inicial do vetor
    X DW 4, 5                    ; Elemento a remover
    msgOriginal DB 13,10,'Vetor Original: $'
    msgModified DB 13,10,'Vetor Modificado: $'
    buffer DB 6 DUP('$')      ; Para conversão de números em strings

.CODE
MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe o vetor original
    LEA DX, msgOriginal
    MOV AH, 09h
    INT 21h

    LEA SI, ARRAY
    MOV CX, ArraySize          ; CX = tamanho do vetor
    CALL DisplayArray

    ; Remove o elemento 'X' do vetor
    CALL RemoveElement

    ; Exibe o vetor modificado
    LEA DX, msgModified
    MOV AH, 09h
    INT 21h

    LEA SI, ARRAY
    MOV CX, ArraySize          ; CX = tamanho atualizado do vetor
    CALL DisplayArray

    ; Termina o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;------------------------------------------------------------
; Procedimento para exibir os elementos de um vetor
; Entrada: SI aponta para o vetor, CX = número de elementos
;------------------------------------------------------------
DisplayArray PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

DisplayArrayLoop:
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
    LOOP DisplayArrayLoop

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
DisplayArray ENDP

;------------------------------------------------------------
; Procedimento para remover o elemento 'X' do vetor 'ARRAY'
;------------------------------------------------------------
RemoveElement PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI

    LEA SI, ARRAY              ; SI aponta para ARRAY
    MOV CX, ArraySize          ; CX = tamanho do vetor
    MOV BX, X                  ; BX = valor a remover
    XOR DI, DI                 ; DI = índice = 0

SearchLoop:
    CMP CX, 0
    JE EndRemove               ; Se CX for zero, sai
    MOV AX, [SI]               ; AX = ARRAY[DI]
    CMP AX, BX                 ; Compara AX com X
    JE ElementFound            ; Se igual, pula para ElementFound
    ADD SI, 2                  ; Move para o próximo elemento
    INC DI                     ; Índice = Índice + 1
    DEC CX
    JMP SearchLoop             ; Repete o loop

    ; Se chegar aqui, X não foi encontrado
    JMP EndRemove              ; Sai do procedimento

ElementFound:
    ; SI aponta para o elemento a remover
    ; DI é o índice do elemento
    ; Calcula o número de elementos a mover
    MOV AX, ArraySize
    SUB AX, DI
    DEC AX                     ; AX = ArraySize - DI - 1
    CMP AX, 0
    JLE DecreaseSize           ; Se não houver elementos para mover, pula

    MOV CX, AX                 ; CX = número de elementos a mover

    LEA SI, [SI]               ; SI já aponta para o elemento a remover
    LEA DI, [SI+2]             ; DI aponta para o próximo elemento após o que será removido

MoveLoop:
    MOV DX, [DI]
    MOV [SI], DX
    ADD SI, 2
    ADD DI, 2
    LOOP MoveLoop

DecreaseSize:
    DEC ArraySize              ; Decrementa o tamanho do vetor em 1

EndRemove:
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
RemoveElement ENDP

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
