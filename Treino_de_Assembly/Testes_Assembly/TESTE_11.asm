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
    dividendo    db ?
    divisor      db ?
    quociente    db ?
    resto        db ?
    multiplicador_1 db ?
    multiplicador_2 db ?
    resultado    db ?
    num1         db ?
    num2         db ?

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
  

case1:
    ; Divisao
    call divisao
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
; Funções de operação e auxiliares (mesmas do código anterior)
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
; Funções auxiliares para adição, subtração e multiplicação (iguais ao código anterior)
; ----------------------------

print_msg_input proc
    mov ah, 09h
    int 21h
    ret
print_msg_input endp

read_digit proc
    mov ah, 01h    ; Ler caractere com eco
    int 21h
    sub al, '0'    ; Converte para valor numérico
    ret
read_digit endp

print_digit proc
    add al, '0'    ; Converte de volta para ASCII
    mov dl, al
    mov ah, 02h    ; Função para imprimir caractere
    int 21h
    ret
print_digit endp

main endp
end main
