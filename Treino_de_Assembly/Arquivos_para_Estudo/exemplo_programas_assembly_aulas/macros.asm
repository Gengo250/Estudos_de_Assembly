TITLE  macros
.MODEL SMALL
SALVA_REGS  MACRO   A,B,C,D,F,G
            PUSH    A
            PUSH    B
            PUSH    C
            PUSH    D
            PUSH    F
            PUSH    G
            ENDM
            
RESTAURA_REGS  MACRO 
            POP     DI
            POP     SI
            POP     DX
            POP     CX
            POP     BX
            POP     AX
        ENDM

PULA_LINHA MACRO 
            MOV AH,2 
            MOV DL,LF     ;caracter LF para a tela
            INT 21h        ;exibe
            MOV DL,CR     ;caracter CR para a tela
            INT 21h        ;exibe
         ENDM
COPIA        MACRO   B, S, C
            LOCAL   REPETE
            ;SALVA_REGS AX.BX.CX.DX.SI,DI      ;existente na biblioteca
            ;LEA     SI,FONTE
            ;LEA     DI,DESTINO          
            ;MOV     CX,QUANTIDADE
REPETE:         
            MOV DL,[B]
            MOV [S],DL
            INC S
            INC B
            LOOP    REPETE
            RESTAURA_REGS       ;existente na biblioteca
            ENDM 
IMPRIME_STR        MACRO   VETOR, QUANTIDADE
            LOCAL   REPETE
            ;SALVA_REGS AX.BX.CX.DX.SI,DI     ;existente na biblioteca
            ;LEA     SI,VETOR   
            ;MOV     CX,QUANTIDADE
	    MOV AH,2
REPETE:         
            MOV DL,[SI]
            INC SI
            MOV AH,2
            INT 21H
            LOOP    REPETE
            RESTAURA_REGS       ;existente na biblioteca
            ENDM 
 .STACK 0100H

.DATA
    LF EQU 0AH
    CR EQU 0DH
    N EQU 11
    VET1 DB 'osc 2s2021'
    VET2 DB '11111111111$'
.CODE

MAIN PROC   
 
    MOV AX,@DATA
    MOV DS,AX
    SALVA_REGS AX,BX,CX,DX,SI,DI
    LEA BX,VET1
    LEA SI,VET2
    MOV CX,N
    COPIA SI, BX, CX
    PULA_LINHA
    IMPRIME_STR BX,CX

    MOV AH,4CH
    INT 21H

MAIN ENDP   
END MAIN
