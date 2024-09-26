; Lab06_01.ASM
; Programa que lê 4 caracteres e troca 'a' ou 'A' por '*'

.model small
.stack 100h

.data
    newline db 13,10,'$'  ; Sequência para nova linha
    count db 4            ; Quantidade de caracteres a serem lidos

.code
main proc

    mov ax, @data
    mov ds, ax

    mov cx, 4          ; Definir o contador para ler 4 caracteres

read_loop:
    cmp cx, 0          ; Verifica se já leu os 4 caracteres
    je end_program     ; Se sim, termina o programa
    mov ah, 01h        ; Função 01h - Ler caractere com eco
    int 21h
    cmp al, 'a'        ; Verifica se é 'a'
    je replace_star
    cmp al, 'A'        ; Verifica se é 'A'
    je replace_star
    jmp print_char

replace_star:
    mov al, '*'        ; Substitui 'a' ou 'A' por '*'

print_char:
    mov dl, al         ; Carrega o caractere (ou '*' se for 'a'/'A')
    mov ah, 02h        ; Função 02h - Imprimir caractere
    int 21h

    dec cx             ; Decrementa o contador de caracteres
    jmp read_loop      ; Continua lendo o próximo caractere

end_program:
    ; Imprime uma nova linha
    mov dx, offset newline
    mov ah, 09h        ; Função 09h - Imprimir string
    int 21h

    mov ah, 4Ch        ; Termina o programa
    int 21h

main endp
end main
