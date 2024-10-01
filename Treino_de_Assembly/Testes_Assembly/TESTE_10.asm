.model small
.stack 100h

.code
main proc
    mov ax, 13h          ; Seleciona o modo gráfico 13h (320x200, 256 cores)
    int 10h              ; Interrupção do BIOS para definir o modo de vídeo

    ; Desenha um pixel no meio da tela
    mov dx, 0A000h       ; Base da memória de vídeo
    mov es, dx           ; Definir ES como o segmento de memória de vídeo

    mov di, (160 * 100)  ; Calcula a posição do pixel (160, 100)
    mov al, 15           ; Cor do pixel (15 = branco)
    stosb                ; Armazena AL no endereço de ES:DI (desenha o pixel)

    ; Pausa até pressionar uma tecla
    mov ah, 00h
    int 16h              ; Função do BIOS para esperar uma tecla

    ; Retorna ao modo de texto 03h
    mov ax, 03h
    int 10h              ; Interrupção do BIOS para voltar ao modo texto

    mov ah, 4Ch
    int 21h              ; Termina o programa
main endp
end main
