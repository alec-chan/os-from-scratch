;
;Boot sector that prints 'Hello' using the scrolling teletype BIOS routine
;

mov ah, 0x00		;set video mode interrupt routine
mov al, 0x13		;0x10 reads al for video mode 13h=256 colors, 1page
int 0x10

mov ah, 0x0e		;set high byte of register A to scrolling teletype routine

mov bl, 0x04
mov al, 'H'		;set low byte of register A to 'H' 
int 0x10		;BIOS interrupt call 0x10 passes al to the routine set in ah

mov bl, 0x0a		;0x10 checks bl for a color code to use for character color
mov al, 'e'
int 0x10

mov bl, 0x07
mov al, 'l'
int 0x10

mov bl, 0x01
mov al, 'l'
int 0x10

mov bl, 0x03
mov al, 'o'
int 0x10

jmp $			;jump to the current address forever


;
;padding + magic number
;

times 510-($-$$) db 0

dw 0xaa55
