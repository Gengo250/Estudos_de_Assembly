.model small
.stack 100h

.data
    msg_prompt db 'Escolha uma opcao (1, 2, ou 3): $'
    msg1 db 13, 10, 'Opcao 1 escolhida', 13, 10, '$'
    msg2 db 13, 10, 'Opcao 2 escolhida', 13, 10, '$'
    msg3 db 13, 10, 'Opcao 3 escolhida', 13, 10, '$'
    msgInvalid db 13, 10, 'Opcao invalida', 13, 10, '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Exibe mensagem de prompt
    mov dx, offset msg_prompt
    mov ah, 09h
    int 21h

    ; Leitura da entrada do usuário
    mov ah, 01h    ; Função 01h - Ler caractere com eco
    int 21h        ; O valor digitado pelo usuário será retornado em AL

    ; Subtraí '0' (ASCII 48) para converter o caractere para um valor numérico
    sub al, '0'

    ; Simulando o switch-case com CMP e JE
    cmp al, 1
    je case1    ; Se AL == 1, vai para 'case1'

    cmp al, 2
    je case2    ; Se AL == 2, vai para 'case2'

    cmp al, 3
    je case3    ; Se AL == 3, vai para 'case3'

    ; Se nenhuma condição for atendida, vai para o default
    jmp default

case1:
    ; Mostra mensagem para opção 1
    mov dx, offset msg1
    jmp print_msg

case2:
    ; Mostra mensagem para opção 2
    mov dx, offset msg2
    jmp print_msg

case3:
    ; Mostra mensagem para opção 3
    mov dx, offset msg3
    jmp print_msg

default:
    ; Mostra mensagem de opção inválida
    mov dx, offset msgInvalid

print_msg:
    mov ah, 09h    ; Função do DOS para imprimir string
    int 21h

    ; Fim do programa
    mov ah, 4Ch
    int 21h

main endp
end main
