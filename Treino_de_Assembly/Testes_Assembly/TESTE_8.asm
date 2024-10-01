TITLE CALCULADORA
.model small
.stack 100h

.data
    ; Mensagens gerais
    msg_prompt db 'Escolha uma opcao (1-Divisao, 2-Multiplicacao, 3-Adicao, 4-Subtracao, 0-Sair): $'
    msgInvalid db 13, 10, 'Opcao invalida', 13, 10, '$'
    msgExit db 13, 10, 'Saindo do programa...', 13, 10, '$'

    ; Mensagens para divisao
    msgDividendo db 13, 10, 'Digite o dividendo: $'
    msgDivisor   db 13, 10, 'Digite o divisor: $'
    msgQuociente db 13, 10, 'Quociente: $'
    msgResto     db 13, 10, 'Resto: $'

    ; Mensagens para multiplicacao
    msgmultiplicador1 db 13, 10, 'Digite o multiplicando: $'
    msgmultiplicador2 db 13, 10, 'Digite o multiplicador: $'
    msgresultado      db 13, 10, 'Resultado: $'

    ; Mensagens para adicao e subtracao
    msgNum1 db 13, 10, 'Digite o primeiro numero: $'
    msgNum2 db 13, 10, 'Digite o segundo numero: $'

    ; Variáveis
    dividendo       db ?
    divisor         db ?
    quociente       db ?
    resto           db ?
    multiplicador_1 db ?
    multiplicador_2 db ?
    resultado       db ?
    num1            db ?
    num2            db ?

.code
main proc
    ; Inicializa o segmento de dados
    mov ax, @data
    mov ds, ax

main_loop:
    ; Exibe mensagem de prompt
    mov dx, offset msg_prompt
    mov ah, 09h
    int 21h

    ; Leitura da escolha do usuario
    mov ah, 01h    ; Função 01h - Ler caractere com eco
    int 21h
    sub al, '0'    ; Converter ASCII para valor numérico

    ; Simulando o switch-case com CMP e JE
    cmp al, 0
    je sair        ; Se AL == 0, vai para sair do programa
    cmp al, 1
    je case1       ; Se AL == 1, vai para 'case1'
    cmp al, 2
    je case2       ; Se AL == 2, vai para 'case2'
    cmp al, 3
    je case3       ; Se AL == 3, vai para 'case3'
    cmp al, 4
    je case4       ; Se AL == 4, vai para 'case4'
    jmp default    ; Opcao inválida

case1:
    ; Divisao
    call divisao
    jmp main_loop

case2:
    ; Multiplicacao
    call multiplicacao
    jmp main_loop

case3:
    ; Adicao
    call adicao
    jmp main_loop

case4:
    ; Subtracao
    call subtracao
    jmp main_loop

default:
    ; Opcao invalida
    mov dx, offset msgInvalid
    call print_msg_input
    jmp main_loop

sair:
    ; Mensagem de saída
    mov dx, offset msgExit
    call print_msg_input

    ; Finaliza o programa
    mov ah, 4Ch
    int 21h

; ----------------------------
; Rotina de Divisao
; ----------------------------
divisao proc
    ; Leitura do dividendo
    mov dx, offset msgDividendo
    call print_msg_input
    call read_digit
    mov [dividendo], al

    ; Leitura do divisor
    mov dx, offset msgDivisor
    call print_msg_input
    call read_digit
    mov [divisor], al

    ; Realiza a divisao
    mov al, [dividendo]
    mov bl, [divisor]
    xor ah, ah     ; Zera AH para divisão de 8 bits
    div bl         ; AL / BL -> Quociente em AL, Resto em AH
    mov [quociente], al
    mov [resto], ah

    ; Exibe o quociente
    mov dx, offset msgQuociente
    call print_msg_input
    mov al, [quociente]
    call print_digit

    ; Exibe o resto
    mov dx, offset msgResto
    call print_msg_input
    mov al, [resto]
    call print_digit

    ret
divisao endp

; ----------------------------
; Rotina de Multiplicacao
; ----------------------------
multiplicacao proc
    ; Leitura do multiplicando
    mov dx, offset msgmultiplicador1
    call print_msg_input
    call read_digit
    mov [multiplicador_1], al

    ; Leitura do multiplicador
    mov dx, offset msgmultiplicador2
    call print_msg_input
    call read_digit
    mov [multiplicador_2], al

    ; Realiza a multiplicacao
    mov al, [multiplicador_1]
    mov bl, [multiplicador_2]
    mul bl         ; Multiplica AL por BL, resultado em AX
    mov [resultado], al

    ; Exibe o resultado
    mov dx, offset msgresultado
    call print_msg_input
    mov al, [resultado]
    call print_digit

    ret
multiplicacao endp

; ----------------------------
; Rotina de Adicao
; ----------------------------
adicao proc
    ; Leitura do primeiro numero
    mov dx, offset msgNum1
    call print_msg_input
    call read_digit
    mov [num1], al

    ; Leitura do segundo numero
    mov dx, offset msgNum2
    call print_msg_input
    call read_digit
    mov [num2], al

    ; Realiza a adicao
    mov al, [num1]
    add al, [num2] ; Soma os valores
    mov [resultado], al

    ; Exibe o resultado
    mov dx, offset msgresultado
    call print_msg_input
    mov al, [resultado]
    call print_digit

    ret
adicao endp

; ----------------------------
; Rotina de Subtracao
; ----------------------------
subtracao proc
    ; Leitura do primeiro numero
    mov dx, offset msgNum1
    call print_msg_input
    call read_digit
    mov [num1], al

    ; Leitura do segundo numero
    mov dx, offset msgNum2
    call print_msg_input
    call read_digit
    mov [num2], al

    ; Realiza a subtracao
    mov al, [num1]
    sub al, [num2] ; Subtrai o segundo número do primeiro
    mov [resultado], al

    ; Exibe o resultado
    mov dx, offset msgresultado
    call print_msg_input
    mov al, [resultado]
    call print_digit

    ret
subtracao endp

; ----------------------------
; Funções auxiliares
; ----------------------------

; Função para exibir mensagem e esperar entrada
print_msg_input proc
    mov ah, 09h
    int 21h
    ret
print_msg_input endp

; Função para ler um dígito
read_digit proc
    mov ah, 01h    ; Ler caractere com eco
    int 21h
    sub al, '0'    ; Converte para valor numérico
    ret
read_digit endp

; Função para imprimir um dígito
print_digit proc
    add al, '0'    ; Converte de volta para ASCII
    mov dl, al
    mov ah, 02h    ; Função para imprimir caractere
    int 21h
    MOV AH,2
    MOV DL,10
    INT 21H
    ret
print_digit endp



main endp
end main
