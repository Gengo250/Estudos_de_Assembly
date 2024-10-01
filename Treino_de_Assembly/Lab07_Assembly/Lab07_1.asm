.model small
.stack 100h

.data
    msgDividendo db 'Digite o dividendo: $'
    msgDivisor   db 'Digite o divisor: $'
    msgQuociente db 'Quociente: $'
    msgResto     db 'Resto: $'

    dividendo    db ?
    divisor      db ?
    quociente    db ?
    resto        db ?

.code
main proc
    ; Início do programa
    mov ax, @data           ; Inicializa o segmento de dados
    mov ds, ax

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Solicita o dividendo
    mov ah, 09h             ; Função de exibir string
    lea dx, msgDividendo    ; Carrega a mensagem do dividendo
    int 21h                 ; Interrupção de saída de string

    ; Lê o dividendo
    mov ah, 01h             ; Função de leitura de um caractere
    int 21h                 ; Interrupção de leitura
    sub al, '0'             ; Converte de ASCII para valor numérico
    mov dividendo, al       ; Armazena o dividendo

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Solicita o divisor
    mov ah, 09h             ; Função de exibir string
    lea dx, msgDivisor       ; Carrega a mensagem do divisor
    int 21h                 ; Interrupção de saída de string
    
    ; Lê o divisor
    mov ah, 01h             ; Função de leitura de um caractere
    int 21h                 ; Interrupção de leitura
    sub al, '0'             ; Converte de ASCII para valor numérico
    mov divisor, al         ; Armazena o divisor

    ; Inicializa quociente e resto
    mov al, dividendo       ; Carrega o dividendo em AL
    mov bl, divisor         ; Carrega o divisor em BL
    xor ch, ch              ; CH = 0, quociente
    mov cl, al              ; CL = dividendo (para cálculo do resto)

div_loop:
    cmp al, bl              ; Compara dividendo com divisor
    jl fim_divisao          ; Se AL < BL, fim da divisão
    sub al, bl              ; AL = AL - BL (subtração sucessiva)
    inc ch                  ; Incrementa quociente
    jmp div_loop            ; Volta para o loop

    

fim_divisao:

    mov quociente, ch       ; Armazena o quociente
    mov resto, al           ; Armazena o resto

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Exibe o quociente
    mov ah, 09h             ; Função de exibir string
    lea dx, msgQuociente    ; Carrega a mensagem do quociente
    int 21h                 ; Interrupção de saída de string
    mov al, quociente       ; Pega o valor do quociente
    add al, '0'             ; Converte de valor numérico para ASCII
    mov dl, al
    mov ah, 02h             ; Função de exibir caractere
    int 21h                 ; Exibe o quociente

    MOV AH,2
    MOV DL,10               ; Exibe o caracter Line Feed (move o cursor para a linha seguinte) 
    INT 21h

    ; Exibe o resto
    mov ah, 09h             ; Função de exibir string
    lea dx, msgResto         ; Carrega a mensagem do resto
    int 21h                 ; Interrupção de saída de string
    mov al, resto           ; Pega o valor do resto
    add al, '0'             ; Converte de valor numérico para ASCII
    mov dl, al
    mov ah, 02h             ; Função de exibir caractere
    int 21h                 ; Exibe o resto

    ; Finaliza o programa
    mov ah, 4Ch             ; Função para terminar o programa
    int 21h
    
main endp 
end main
