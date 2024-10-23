; Lab06_02.ASM
; Programa que lê caracteres até encontrar um CR e imprime tantos '*' quanto o número de caracteres lidos
; Implementado usando um loop REPEAT (do-while)

.model small
.stack 100h

.data
    newline db 13,10,'$'  ; Sequência para nova linha

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 0      ; Inicializa o contador de caracteres em CX

read_loop:
    ; Corpo do loop - executado pelo menos uma vez
    mov ah, 01h    ; Função 01h - Ler caractere com eco
    int 21h
    inc cx         ; Incrementa o contador de caracteres

    cmp al, 13     ; Verifica se o caractere é CR (ASCII 13)
    jne read_loop  ; Se não for CR, continua o loop

    ; Após ler CR, sai do loop e decrementa o contador para não contar o CR
    dec cx

print_asterisks:
    cmp cx, 0
    jz end_program ; Se nenhum caractere foi lido, termina o programa

    mov bx, cx     ; Copia o contador para BX

print_loop:
    mov dl, '*'
    mov ah, 02h    ; Função 02h - Imprimir caractere
    int 21h
    dec bx
    jnz print_loop ; Continua imprimindo '*' até BX chegar a zero

    ; Imprime uma nova linha
    mov dx, offset newline
    mov ah, 09h    ; Função 09h - Imprimir string
    int 21h

end_program:
    mov ah, 4Ch    ; Termina o programa
    int 21h
    
main endp
end main

;Qual a diferença entre este e o programa da PARTE 1?

;Resposta: 

;A principal diferença entre o programa da PARTE 1 e o da PARTE 2 está na implementação do loop de repetição:

;PARTE 1 (WHILE loop): O loop verifica a condição antes de executar o corpo do loop. Se a condição não for satisfeita, o corpo do loop pode não ser executado nenhuma vez.

;read_loop:
    ;mov ah, 01h    ; Função 01h - Ler caractere com eco
    ;int 21h
    ;cmp al, 13     ; Verifica se o caractere é CR (ASCII 13)
    ;je print_asterisks
    ;inc cx         ; Incrementa o contador de caracteres
    ;jmp read_loop  ; Continua lendo caracteres

;PARTE 2 (REPEAT loop): O loop executa o corpo pelo menos uma vez e verifica a condição após a execução do corpo. Isso corresponde a um loop do-while.

;read_loop:
    ;mov ah, 01h    ; Função 01h - Ler caractere com eco
    ;int 21h
    ;inc cx         ; Incrementa o contador de caracteres
    ;cmp al, 13     ; Verifica se o caractere é CR (ASCII 13)
    ;jne read_loop  ; Se não for CR, continua o loop

