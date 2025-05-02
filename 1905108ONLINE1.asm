.MODEL SMALL
.STACK 100H
.DATA
X DB 0
Y DB 0
ST DB 'PE','$'
SST DB 'NE','$' 

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX  
                
    MOV BL,1   
    MOV CX,0
    
    WHILE:
    MOV AH, 1
    INT 21H 
    CMP AL,0DH
    JE PROS 
    
    SUB AL,'a'
    ADD AL,1
           
    MOV AH,0      
    MUL BL
    ADD CX,AX
    INC BL 
    JMP WHILE
    
    
    PROS: 
    MOV DL,13
            MOV AH,2
            INT 21H
                     
            MOV DL,10
            MOV AH,2
            INT 21H
            MOV X, CL 
            
            
            
            ;SEC
     MOV BL,1   
    MOV CX,0
    
    WHIL:
    MOV AH, 1
    INT 21H 
    CMP AL,0DH
    JE PRS
    
    SUB AL,'a'
    ADD AL,1
           
    MOV AH,0      
    MUL BL
    ADD CX,AX
    INC BL 
    JMP WHIL
    
    
    PRS: 
    MOV DL,13
            MOV AH,2
            INT 21H
                     
            MOV DL,10
            MOV AH,2
            INT 21H
    CMP CL,X   
    JE EQ   
    LEA DX, SST
    MOV AH, 09H
    INT 21H  
    JMP FIN 
     
        
    
    
    EQ: 
    LEA DX, ST
    MOV AH, 09H
    INT 21H   
           FIN:
                 
    ;EXIT
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN