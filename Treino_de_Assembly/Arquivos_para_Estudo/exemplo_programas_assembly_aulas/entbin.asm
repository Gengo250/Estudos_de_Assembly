.model small
.code
    main proc                
        MOV CX,16		;inicializa contador de dígitos
        XOR BX,BX		;zera BX -> terá o resultado
		MOV AH,1h		;função DOS para entrada pelo teclado
		INT 21h			;entra, caractere está no AL
;while
TOPO:	CMP AL,0Dh		;é CR?
		JE  FIM			;se sim, termina o WHILE
		AND AL,0Fh		;se não, elimina 30h do caractere
		SHL	BL,1		;abre espaço para o novo dígito
		OR 	BL,AL		;insere o dígito no LSB de BL
		INT 21h			;entra novo caractere
		LOOP  TOPO		;controla o máximo de 16 dígitos
;end_while
FIM:
    main endp
end main