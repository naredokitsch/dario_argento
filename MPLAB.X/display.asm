processor 16F877
include <P16F877.INC>

    val1 equ 0x30
    val2 equ 0x31     

    org 0
    goto INICIO         
    org 5
    
INICIO:
    clrf PORTB
    clrf PORTD
    bsf STATUS, RP0
    bcf STATUS, RP1
    clrf TRISB
    clrf TRISD
    bcf STATUS, RP0

LOOP:     
    call INICIA_LCD
    call M1
    call LINEA2
    call M2
    goto LOOP
    
    
    
;   _____ _    _ ____  _____  _    _ _______ _____ _   _           _____ 
;  / ____| |  | |  _ \|  __ \| |  | |__   __|_   _| \ | |   /\    / ____|
; | (___ | |  | | |_) | |__) | |  | |  | |    | | |  \| |  /  \  | (___  
;  \___ \| |  | |  _ <|  _  /| |  | |  | |    | | | . ` | / /\ \  \___ \ 
;  ____) | |__| | |_) | | \ \| |__| |  | |   _| |_| |\  |/ ____ \ ____) |
; |_____/ \____/|____/|_|  \_\\____/   |_|  |_____|_| \_/_/    \_\_____/



    ;Mensaje a enviar
M1:
    movlw 'H'
    movwf PORTB
    call ENVIA
    movlw 'e'
    movwf PORTB
    call ENVIA
    movlw 'l'
    movwf PORTB
    call ENVIA
    movlw 'l'
    movwf PORTB
    call ENVIA
    movlw 'o'
    movwf PORTB
    call ENVIA
    movlw ' '
    movwf PORTB
    call ENVIA
    movlw 'W'
    movwf PORTB
    call ENVIA
    movlw 'o'
    movwf PORTB
    call ENVIA
    movlw 'r'
    movwf PORTB
    call ENVIA
    movlw 'l'
    movwf PORTB
    call ENVIA
    movlw 'd'
    movwf PORTB
    call ENVIA 
    movlw '!'
    movwf PORTB
    call ENVIA
    return      
M2:
    movlw 'I'
    movwf PORTB
    call ENVIA
    movlw 'm'
    movwf PORTB
    call ENVIA
    movlw ' '
    movwf PORTB
    call ENVIA
    movlw 'O'
    movwf PORTB
    call ENVIA
    movlw 'p'
    movwf PORTB
    call ENVIA
    movlw 'e'
    movwf PORTB
    call ENVIA
    movlw 'n'
    movwf PORTB
    call ENVIA
    movlw 'B'
    movwf PORTB
    call ENVIA
    movlw 'o' 
    movwf PORTB
    call ENVIA
    movlw 'x'
    movwf PORTB
    call ENVIA
    movlw 'e'
    movwf PORTB
    call ENVIA
    movlw 'r'
    movwf PORTB
    call ENVIA
    return     
   
;===============Subrutina para inicializar el lcd
INICIA_LCD:
    bcf PORTD,0      ; RS = 0; MODO INSTRUCCION
    movlw 0x01
    movwf PORTB      ; PORTB = 00000001 ; clear
    call COMANDO
    
    ;------------------Selecciona la primera línea
    movlw 0x0C
    movwf PORTB      ; PORTB = 00001100
    call COMANDO
    
    ;------------------Se configura el cursor
    movlw 0x3C
    movwf PORTB      ; PORTB = 00111100
    call COMANDO
    
    bsf PORTD, 0     ; Rs = 1; MODO DATO
    return

;===================Subrutina para enviar comandos
COMANDO:
    bsf PORTD, 1    ; E = 1
    call DELAY
    call DELAY
    bcf PORTD, 1    ; E = 0
    call DELAY
    return     

;====================Subrutina para enviar un dato
ENVIA:
    bsf PORTD,0     ; RS = 1 ; MODO DATO
    call COMANDO
    return

    ;Configuración Líneal 2 LCD
LINEA2:
    bcf PORTD, 0    ; RS = 0 ; MODO INSTRUCCION
    
    ;------------------Selecciona línea 2 en el LCD
    movlw 0xc0
    movwf PORTB     ; PORTB = 11000000
    call COMANDO
    return

    ; Subrutina de retardo
DELAY:         
    movlw 0xFF
    movwf val2 
ciclo:
    movlw 0xFF
    movwf val1
ciclo2:
    decfsz val1,1
    goto ciclo2
    decfsz val2,1
    goto ciclo
    return
 END
