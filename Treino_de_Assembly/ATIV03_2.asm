.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB 10,13, "Digite um caractere: $"
    MSG2 DB 10,13, "O caractere digitado eh um numero. $"
    MSG3 DB 10,13, "O caractere digitado eh uma letra. $"
    MSG4 DB 10,13, "O caractere digitado eh um caractere desconhecido. $"

.CODE

MAIN PROC
    ; Inicializa o segmento de dados
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem para o usuário
    MOV AH, 9
    MOV DX, OFFSET MSG1
    INT 21H

    ; Lê um caractere da entrada padrão
    MOV AH, 1
    INT 21H

    ; Copia o caractere lido para BL
    MOV BL, AL

    ; Verifica se o caractere é um número (0-9)
    CMP BL, 30h       ; 30h é o valor ASCII para '0'
    JB NAOENUMERO
    CMP BL, 39h       ; 39h é o valor ASCII para '9'
    JA NAOENUMERO

    ; Se o caractere é um número, exibe a mensagem correspondente
    MOV AH, 9
    MOV DX, OFFSET MSG2
    INT 21H
    JMP FIM

    NAOENUMERO:
    ; Verifica se o caractere é uma letra (A-Z ou a-z)
    CMP BL, 41h       ; 41h é o valor ASCII para 'A'
    JB DESCONHECIDO
    CMP BL, 5Ah       ; 5Ah é o valor ASCII para 'Z'
    JBE LETRA
    CMP BL, 61h       ; 61h é o valor ASCII para 'a'
    JB DESCONHECIDO
    CMP BL, 7Ah       ; 7Ah é o valor ASCII para 'z'
    JBE LETRA

    DESCONHECIDO:
    ; Se o caractere não é letra nem número, exibe a mensagem de desconhecido
    MOV AH, 9
    MOV DX, OFFSET MSG4
    INT 21H
    JMP FIM

    LETRA:
    ; Se o caractere é uma letra, exibe a mensagem correspondente
    MOV AH, 9
    MOV DX, OFFSET MSG3
    INT 21H
    JMP FIM

    FIM:
    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
