processor 16F877
   include <P16F877.INC>

    ;Variables para DELAY
val1 equ 0x30
val2 equ 0x31     

    org 0              ;Vector de RESET
    goto INICIO         
    org 5              ;Inicio del Programa
      
    ;Configuración de puertos
    
INICIO:
    clrf PORTB         ;Limpia PORTB   
    clrf PORTD         ;Limpia PORTD
    bsf STATUS, RP0    ;...
    bcf STATUS, RP1    ;Selecciona el banco 1
    clrf TRISB         ;Configura PORTB como salida
    clrf TRISD         ;Configura PORTD como salida
    bcf STATUS,RP0     ;Regresa al banco 0

START_LCD:     
    call INICIA_LCD    ;Configura el LCD
    call M1            ;Muestra Mensaje
    call LINEA2        ;Configura linea 2
    call M2            ;Muestra Mensaje
    goto START_LCD

    ;Mensaje a enviar
M1:
    movlw 'H'          ;Mueve 'H' a W
    movwf PORTB        ;Mueve lo que hay en W a PORTB
    call ENVIA         ;Imprime en LCD
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
    movlw 'I'         ;Mueve 'I' a W
    movwf PORTB       ;Mueve lo que hay en W a PORTB
    call ENVIA        ;Imprime en LCD
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
   
    ;Subrutina para inicializar el lcd
INICIA_LCD:
    bcf PORTD,0      ; RS=0 MODO INSTRUCCION
    movlw 0x01       ; El comando 0x01 limpia la pantalla en el LCD
    movwf PORTB
    call COMANDO     ; Se da de alta el comando
    movlw 0x0C       ; Selecciona la primera línea
    movwf PORTB
    call COMANDO     ; Se da de alta el comando
    movlw 0x3C       ; Se configura el cursor
    movwf PORTB
    call COMANDO     ; Se da de alta el comando
    bsf PORTD, 0     ; Rs=1 MODO DATO
    return

    ;Subrutina para enviar comandos
COMANDO:
    bsf PORTD,1     ; Pone ENABLE en 1
    call DELAY      ; Tiempo de espera
    call DELAY
    bcf PORTD, 1    ; ENABLE=0   
    call DELAY
    return     

    ;Subrutina para enviar un dato
ENVIA:
    bsf PORTD,0     ; RS=1 MODO DATO
    call COMANDO    ; Se da de alta el comando
    return

    ;Configuración Líneal 2 LCD
LINEA2:
    bcf PORTD, 0    ; RS=0 MODO INSTRUCCION
    movlw 0xc0      ; Selecciona línea 2 en el LCD
    movwf PORTB
    call COMANDO    ; Se da de alta el comando
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