Title Lab05_01.asm
.model small
.stack 100h
.data

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Primeiro loop: exibe '*' 50 vezes na mesma linha
    mov cx, 50          ; Define o contador do loop para 50

PrimeiroLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função DOS para exibir caractere
    int 21h             ; Chama a interrupção do DOS
    dec cx              ; Decrementa o contador CX
    jnz PrimeiroLoop    ; Salta para 'PrimeiroLoop' se CX != 0

    ; Move para a próxima linha
    mov dl, 0Dh         
    mov ah, 02h
    int 21h

    mov dl, 0Ah         ; Alimentação de linha (LF)
    mov ah, 02h
    int 21h

    ; Segundo loop: exibe '*' 50 vezes, um em cada linha
    mov cx, 50          ; Redefine o contador do loop para 50

SegundoLoop:
    mov dl, '*'         ; Caractere a ser exibido
    mov ah, 02h         ; Função DOS para exibir caractere
    int 21h

    ; Move para a próxima linha após cada '*'
    mov dl, 0Dh         
    mov ah, 02h
    int 21h

    mov dl, 0Ah         ; Alimentação de linha (LF)
    mov ah, 02h
    int 21h

    dec cx              ; Decrementa o contador CX
    jnz SegundoLoop     ; Salta para 'SegundoLoop' se CX != 0

    ; Termina o programa e retorna ao DOS
    mov ah, 4Ch         ; Função DOS para encerrar o programa
    int 21h

main endp
end main
