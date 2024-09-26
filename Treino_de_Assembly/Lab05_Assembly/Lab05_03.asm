Title Lab05_03.asm
.model small
.stack 100h
.data

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Exibe todas as letras maiúsculas (A-Z)
    mov cx, 26          ; 26 letras maiúsculas
    mov dl, 'A'         ; Inicia com 'A' 

UppercaseLoop:
    mov ah, 02h         ; Função DOS para exibir caractere
    int 21h             ; Exibe o caractere em DL
    inc dl              ; Incrementa DL para o próximo caractere
    loop UppercaseLoop  ; Decrementa CX e repete o loop se CX != 0

    ; Move para a próxima linha
    mov dl, 0Dh         ; Retorno de carro (CR)
    mov ah, 02h
    int 21h

    mov dl, 0Ah       
    mov ah, 02h
    int 21h

    ; Exibe todas as letras minúsculas (a-z)
    mov cx, 26          ; 26 letras minúsculas
    mov dl, 'a'         ; Inicia com 'a'

LowercaseLoop:
    mov ah, 02h         ; Função DOS para exibir caractere
    int 21h             ; Exibe o caractere em DL
    inc dl              ; Incrementa DL para o próximo caractere
    loop LowercaseLoop  ; Decrementa CX e repete o loop se CX != 0

    ; Termina o programa
    mov ah, 4Ch         ; Função DOS para encerrar o programa
    int 21h

main endp
end main
