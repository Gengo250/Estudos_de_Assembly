title Contar a Quantidade de Vogais em um Vetor
.model small
.stack 100h

.DATA
    var1 db 100 dup('$')        ; String de até 100 caracteres, inicializada com '$'
    countVogais db 0             ; Contador de vogais inicializado com 0
    msg db 13,10,"Quantidade de vogais: $"

.CODE
main proc
    mov ax, @DATA
    mov ds, ax                  ; Inicializa o segmento de dados
    mov si, offset var1          ; Aponta SI para o início de var1
    mov countVogais, 0           ; Inicializa o contador de vogais

l1: 
    mov ah, 1                    ; Função para ler um caractere do teclado
    int 21h                      ; Chama a interrupção do DOS

    cmp al, 13                   ; Verifica se o caractere é Enter (ASCII 13)
    je programed                 ; Se for Enter, salta para finalizar o loop

    mov [si], al                 ; Armazena o caractere lido na string
    cmp al, 'a'                  ; Compara se o caractere é 'a'
    je incrementa_vogal          ; Se for 'a', salta para incrementar o contador
    cmp al, 'A'                  ; Compara se o caractere é 'A'
    je incrementa_vogal          ; Se for 'A', salta para incrementar o contador
    cmp al, 'e'                  ; Compara se o caractere é 'e'
    je incrementa_vogal          ; Se for 'e', salta para incrementar o contador
    cmp al, 'E'                  ; Compara se o caractere é 'E'
    je incrementa_vogal          ; Se for 'E', salta para incrementar o contador
    cmp al, 'i'                  ; Compara se o caractere é 'i'
    je incrementa_vogal          ; Se for 'i', salta para incrementar o contador
    cmp al, 'I'                  ; Compara se o caractere é 'I'
    je incrementa_vogal          ; Se for 'I', salta para incrementar o contador
    cmp al, 'o'                  ; Compara se o caractere é 'o'
    je incrementa_vogal          ; Se for 'o', salta para incrementar o contador
    cmp al, 'O'                  ; Compara se o caractere é 'O'
    je incrementa_vogal          ; Se for 'O', salta para incrementar o contador
    cmp al, 'u'                  ; Compara se o caractere é 'u'
    je incrementa_vogal          ; Se for 'u', salta para incrementar o contador
    cmp al, 'U'                  ; Compara se o caractere é 'U'
    je incrementa_vogal          ; Se for 'U', salta para incrementar o contador
    jmp nao_incrementa           ; Caso contrário, continua

incrementa_vogal:
    inc countVogais              ; Incrementa o contador de vogais
nao_incrementa:
    inc si                       ; Avança para a próxima posição na string
    jmp l1                       ; Repete o loop

programed:

    ; Exibe a string digitada pelo usuário
    mov dx, offset var1
    mov ah, 9                    ; Função para exibir uma string terminada em '$'
    int 21h                      ; Chama a interrupção do DOS

    ; Exibe a mensagem "Quantidade de vogais: "
    mov dx, offset msg
    mov ah, 9                    ; Função para exibir uma string terminada em '$'
    int 21h                      ; Chama a interrupção do DOS

    ; Converte o contador de vogais para ASCII e exibe
    mov al, countVogais          ; Move o valor do contador para AL
    add al, '0'                  ; Converte o valor numérico para caractere ASCII
    mov dl, al                   ; Move o caractere para DL para impressão
    mov ah, 2                    ; Função para imprimir um caractere
    int 21h                      ; Chama a interrupção do DOS

    ; Finaliza o programa
    mov ah, 4Ch                  ; Função para terminar o programa
    int 21h                      ; Chama a interrupção do DOS

main endp
end main
