.model small
.stack 100h

.data
    msgmultiplicador1 db 'Digite o multiplicando: $'
    msgmultiplicador2 db 'Digite o multiplicador: $'
    msgresultado      db 'Resultado: $'
   
    multiplicador_1   db ?
    multiplicador_2   db ?
    resultado         db ?

.code
main proc
    mov ax, @data           ; Inicializa o segmento de dados
    mov ds, ax

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Solicita o primeiro número (multiplicando)
    mov ah, 09h             ; Função de exibir string
    lea dx, msgmultiplicador1
    int 21h                 ; Exibe a mensagem

    ; Lê o multiplicador 1
    mov ah, 01h             ; Função de leitura de um caractere
    int 21h
    sub al, '0'             ; Converte de ASCII para valor numérico
    mov multiplicador_1, al  ; Armazena o multiplicador 1

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Solicita o segundo número (multiplicador)
    mov ah, 09h
    lea dx, msgmultiplicador2
    int 21h                 ; Exibe a mensagem

    ; Lê o multiplicador 2
    mov ah, 01h
    int 21h
    sub al, '0'             ; Converte de ASCII para valor numérico
    mov multiplicador_2, al  ; Armazena o multiplicador 2

    ; Inicializa o resultado e registradores
    xor al, al              ; Zera AL (acumulador)
    mov bl, multiplicador_1  ; Coloca o multiplicador 1 em BL
    mov cl, multiplicador_2  ; Coloca o multiplicador 2 em CL

multi_loop:
    cmp cl, 0               ; Verifica se o multiplicador chegou a 0
    je fim_multi            ; Se for 0, sai do loop
    add al, bl              ; Soma o multiplicador 1 ao acumulador (resultado)
    dec cl                  ; Decrementa o contador CL (multiplicador 2)
    jmp multi_loop          ; Volta ao loop

fim_multi:
    mov resultado, al        ; Armazena o resultado final

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Exibe o resultado
    mov ah, 09h
    lea dx, msgresultado
    int 21h                 ; Exibe a mensagem de resultado
    mov al, resultado       ; Carrega o resultado
    add al, '0'             ; Converte para ASCII
    mov dl, al
    mov ah, 02h             ; Função de exibir caractere
    int 21h                 ; Exibe o caractere do resultado

    ; Finaliza o programa
    mov ah, 4Ch             ; Função para terminar o programa
    int 21h

main endp
end main
