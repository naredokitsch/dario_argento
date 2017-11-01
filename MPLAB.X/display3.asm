processor 16F877
include <P16F877.INC>

    val1 equ 0x30
    val2 equ 0x31
    counter equ 32

    org 0
    goto INICIO         
    org 5
INICIO:
    clrf PORTA
    clrf PORTB
    clrf PORTD
    bsf STATUS, RP0
    bcf STATUS, RP1
    clrf TRISB
    clrf TRISD
    bcf STATUS, RP0

MAIN_LOOP:   
    call INIT
   ;call MSG
    call ANIM
    goto FIN
    
    
    
;   _____ _    _ ____  _____  _    _ _______ _____ _   _           _____ 
;  / ____| |  | |  _ \|  __ \| |  | |__   __|_   _| \ | |   /\    / ____|
; | (___ | |  | | |_) | |__) | |  | |  | |    | | |  \| |  /  \  | (___  
;  \___ \| |  | |  _ <|  _  /| |  | |  | |    | | | . ` | / /\ \  \___ \ 
;  ____) | |__| | |_) | | \ \| |__| |  | |   _| |_| |\  |/ ____ \ ____) |
; |_____/ \____/|____/|_|  \_\\____/   |_|  |_____|_| \_/_/    \_\_____/


MSG:
    movlw ' '
    movwf PORTB
    call ENVIAR
    movlw 'N'
    movwf PORTB
    call ENVIAR
    movlw '0'
    movwf PORTB
    call ENVIAR
    movlw 'E'
    movwf PORTB
    call ENVIAR
    movlw ' '
    movwf PORTB
    call ENVIAR
    movlw 'M'
    movwf PORTB
    call ENVIAR
    movlw 'T'
    movwf PORTB
    call ENVIAR
    movlw 'Z'
    movwf PORTB
    call ENVIAR
    movlw ' '
    movwf PORTB
    call ENVIAR
    movlw 'N'
    movwf PORTB
    call ENVIAR
    movlw 'A'
    movwf PORTB
    call ENVIAR
    movlw 'R'
    movwf PORTB
    call ENVIAR
    movlw 'E'
    movwf PORTB
    call ENVIAR
    movlw 'D'
    movwf PORTB
    call ENVIAR
    movlw 'O'
    movwf PORTB
    call ENVIAR
    
    return     
   
;===============Subrutina para inicializar el lcd
INIT:
    ;--------------------------------Clear Display
    movlw B'00000001'
    movwf PORTB
    call EJECUTAR
    
    ;-----------------------------------Display ON
    ;-------------------------Cursor not displayed
    ;------------------------------------Not Blink
    movlw B'00001100'
    movwf PORTB
    call EJECUTAR
    
    ;---------------------------Data 8 bit lenghth
    ;----------------------------Two lines display
    ;----------------------------5x8 dot char font  
    movlw B'00111100'
    movwf PORTB
    call EJECUTAR
    
    return

 ANIM: 
    movlw 0x08
    movwf counter
    LOOP_ESPACIOS:
	movlw ' '
	movwf PORTB
	call ENVIAR
	decfsz counter
	goto LOOP_ESPACIOS
    
    
    movlw B'10111010';Imprime Puerta
    movwf PORTB
    call ENVIAR
    
    movlw B'00000010';Inicia Cursor
    movwf PORTB
    call EJECUTAR
    
    call DELAY
    
    movlw 0x08
    movwf counter
    MONITO_CAMINA:
	
	movlw B'11111100';imprime monito
	movwf PORTB
	call ENVIAR
	
	call DELAY
	
	movlw B'00010000';regresa cursor
	movwf PORTB
	call EJECUTAR
	
	movlw ' '
	movwf PORTB
	call ENVIAR
	
	decfsz counter
	goto MONITO_CAMINA
	
    movlw B'10111010';Imprime Puerta
    movwf PORTB
    call ENVIAR
    
    call DELAY
    
    movlw 0x07
    movwf counter
    OTRO_MONITO_CAMINA:
	
	movlw B'10110110';imprime monito
	movwf PORTB
	call ENVIAR
	
	call DELAY
	
	movlw B'00010000';regresa cursor
	movwf PORTB
	call EJECUTAR
	
	movlw ' '
	movwf PORTB
	call ENVIAR
	
	decfsz counter
	goto OTRO_MONITO_CAMINA     
    return
    
 MOVE_LEFT:
    CALL DELAY
    movlw 0x0F
    movwf counter
    LOOP_MOVE_LEFT:
	movlw B'00011000'
	movwf PORTB
	call EJECUTAR
	call DELAY
	decfsz counter
	goto LOOP_MOVE_LEFT
    return
    
 MOVE_RIGHT:
    CALL DELAY
    movlw 0x0F
    movwf counter
    LOOP_MOVE_RIGHT:
	movlw B'00011100'
	movwf PORTB
	call EJECUTAR
	call DELAY
	decfsz counter
	goto LOOP_MOVE_RIGHT
    return
    
;=================Subrutina para ejecutar comandos
EJECUTAR:
    bcf PORTD, 0	    ; RS = 0 ; MODO INSTRUCCION
    bsf PORTD, 1    ; E = 1
    call INMEDIATE
    bcf PORTD, 1    ; E = 0
    NOP
    return     

;====================Subrutina para enviar un dato
ENVIAR:
    bsf PORTD, 0     ; RS = 1 ; MODO DATO
    bsf PORTD, 1    ; E = 1
    call INMEDIATE
    bcf PORTD, 1    ; E = 0
    NOP
    return  


INMEDIATE:         
    movlw 0x44
    movwf val2 
ciclo:
    movlw 0x01
    movwf val1
ciclo2:
    decfsz val1,1
    goto ciclo2
    decfsz val2,1
    goto ciclo
    return

DELAY:         
    movlw 0xFF
    movwf val2 
ciclo4:
    movlw 0xFF
    movwf val1
ciclo3:
    decfsz val1,1
    goto ciclo3
    decfsz val2,1
    goto ciclo4
    return
   
 FIN:   
 END
