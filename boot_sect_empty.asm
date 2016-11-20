;
;Boot sector that loops indefinitely
;

loop:			;define label loop

jmp loop		;jump back to loop

times 510-($-$$) db 0	;pad the program with 510 zero bytes leaving the last two for the "magic number"


dw 0xaa55		;define 0xaa and 0x55 as "magic number" to indicate end of boot sector
