


processor 16f877
include<p16f877.inc>
;Programa Display
;first change
counter equ h'20'
;filereg1 equ h'21'
;filereg2 equ h'22'
;filereg3 equ h'23'
;twenty equ 0x20
;fifty equ 0x50
;sixty equ 0x60

org 0x00
goto inicio

org 0x05
inicio
 bsf STATUS,5
 bcf STATUS,6
 clrf TRISA
 clrf TRISB
 clrf TRISC
 bcf STATUS,5
 clrf PORTB
 clrf PORTA
 clrf PORTC

loop
;================ON
 bsf PORTC,0
 bsf PORTC,1
 movlw 0xFF
 movwf PORTB

 movlw 0x09
 movwf counter
 
 loop_on
   call delay
   decfsz counter
 goto loop_on

;=============BLINK
 movwf counter
 
 loop_blink
   clrf PORTC
   clrf PORTB
   call delay
   movlw 0xFF
   movwf PORTB
   bsf PORTC,0
   bsf PORTC,1
   call delay
   decfsz counter
 goto loop_blink

;==========ROT_LEFT
 clrf PORTC
 clrf PORTB

 bsf STATUS,0
 movlw 0x09
 movwf counter
 
 bsf PORTC,0
 call delay
 bcf PORTC,0
 call delay

 loop_rotl
   rlf PORTB
   call delay
   decfsz counter
 goto loop_rotl
 
 bsf PORTC,1
 call delay
 bcf PORTC,1
 call delay

;==========ROT_RIGHT
 clrf PORTC
 clrf PORTB

 bsf STATUS,0
 movwf counter
 
 bsf PORTC,1
 call delay
 bcf PORTC,1
 call delay

 loop_rotr
   rrf PORTB
   call delay
   decfsz counter
 goto loop_rotr
 
 bsf PORTC,0
 call delay
 bcf PORTC,0
 call delay
 
goto loop

delay
; movlw twenty
; movwf filereg1
;tres
; movlw fifty
; movwf filereg2
;dos
; movlw sixty
; movwf filereg3
;uno
; decfsz filereg3
;  goto uno
; decfsz filereg2
;  goto dos
; decfsz filereg1
;  goto tres
return

END
