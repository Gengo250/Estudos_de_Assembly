title Contar a Quantidade de Caracteres 'a' Digitados pelo Usuário
.model small
.stack 100h

.DATA
    var1 db 100 dup('$')        ; String de até 100 caracteres, inicializada com '$'
    countA db 0                  ; Contador de 'a's inicializado com 0
    msg db 13,10,"Quantidade de 'a'eh: $"

.CODE
main proc
    mov ax, @data
    mov ds, ax                  ; Inicializa o segmento de dados
    mov si, offset var1          ; Aponta SI para o início de var1
    mov countA, 0                ; Inicializa o contador de 'a's

l1: 
    mov ah, 1                    ; Função para ler um caractere do teclado
    int 21h                      ; Chama a interrupção do DOS

    cmp al, 13                   ; Verifica se o caractere é Enter (ASCII 13)
    je programed                 ; Se for Enter, salta para finalizar o loop

    mov [si], al                 ; Armazena o caractere lido na string
    cmp al, 'a'                  ; Compara se o caractere é 'a'
    je incrementa_a              ; Se for 'a', salta para incrementar o contador
    cmp al, 'A'                  ; Compara se o caractere é 'A'
    je incrementa_a              ; Se for 'A', salta para incrementar o contador
    jmp nao_incrementa           ; Caso contrário, continua

incrementa_a:
    inc countA                   ; Incrementa o contador de 'a's
nao_incrementa:
    inc si                       ; Avança para a próxima posição na string
    jmp l1                       ; Repete o loop

programed:


    ; Exibe a string digitada pelo usuário
    mov dx, offset var1
    mov ah, 9                    ; Função para exibir uma string terminada em '$'
    int 21h                      ; Chama a interrupção do DOS

    ; Exibe a mensagem "Quantidade de 'a's: "
    mov dx, offset msg
    mov ah, 9                    ; Função para exibir uma string terminada em '$'
    int 21h                      ; Chama a interrupção do DOS

    ; Converte o contador de 'a's para ASCII e exibe
    mov al, countA               ; Move o valor do contador para AL
    add al, '0'                  ; Converte o valor numérico para caractere ASCII
    mov dl, al                   ; Move o caractere para DL para impressão
    mov ah, 2                    ; Função para imprimir um caractere
    int 21h                      ; Chama a interrupção do DOS

    ; Finaliza o programa
    mov ah, 4Ch                  ; Função para terminar o programa
    int 21h                      ; Chama a interrupção do DOS

main endp
end main
