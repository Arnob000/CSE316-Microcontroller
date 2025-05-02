.MODEL SMALL
.STACK 100H
.DATA
 ARR DW 100 DUP(?)  
 ARR2 DW 100 DUP(?) 
 SPACE DB 20H
 T DW 10   
 X DW 0
 Y DW 0  
 N DW ?
 CR EQU 0DH
 LF EQU 0AH
 NUMBER_STRING DB '$$$$$$'  
 
 
.CODE   
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
                
    LEA SI,ARR
    CALL ARR_INP 
    
    LEA SI,ARR2
    CALL ARR_INP
     
    
    ;COMPARE
    TOP:
       
    
    
    MOV AX, N
    CALL PRINT
    
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP

            



ARR_INP PROC
    PUSH AX
    PUSH BX
    PUSH CX
    
    MOV CX,0
    
    INPUT:
      MOV AX,0
      PUSH AX
      INNER: 
        MOV AH,1
        INT 21H
        CMP AL,CR  
        JE EXIT_INPUT
        CMP AL,SPACE
        JNE NE
        POP [SI]
        ADD SI,2
        INC CX
        JMP INPUT
     NE:   
        MOV AH,0 
        SUB AL,'0'
        MOV BX,AX
        POP AX
        MUL T
        ADD AX,BX  
        PUSH AX 
        JMP INNER
        
    EXIT_INPUT: 
        MOV X,CX
        POP CX
        POP BX
        POP AX 
   RET

ARR_INP ENDP

        
   
    
    


    
  


PRINT PROC
    
    LEA SI, NUMBER_STRING
    ADD SI, 5
    
    PRINT_LOOP:
        DEC SI
        
        MOV DX, 0
        ; DX:AX = 0000:AX
        
        MOV CX, 10
        DIV CX
        
        ADD DL, '0'
        MOV [SI], DL
        
        CMP AX, 0
        JNE PRINT_LOOP
    
    MOV DX, SI
    MOV AH, 9
    INT 21H
    
    RET

PRINT ENDP

END MAIN