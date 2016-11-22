; GDT - the GDT essentially maps out all the memory segments needed for program execution
; and assigns them certain characteristics

gdt_start:	;placeholder for the start of the GDT for size calculation
gdt_null:
	dd 0x0
	dd 0x0
gdt_code: ; the  code  segment  descriptor
	; base=0x0, limit=0xfffff ,
	; 1st  flags: (present )1 (privilege )00 (descriptor  type)1 -> 1001b
	; type  flags: (code)1 (conforming )0 (readable )1 (accessed )0 -> 1010b
	; 2nd  flags: (granularity )1 (32-bit  default )1 (64-bit  seg)0 (AVL)0 -> 1100b
	dw 0xffff     	; Limit (bits  0-15)
	dw 0x0         	; Base (bits  0-15)
	db 0x0         	; Base (bits  16 -23)
	db  10011010b 	; 1st flags , type  flags
	db  11001111b 	; 2nd flags , Limit (bits  16-19)
	db 0x0         	; Base (bits  24 -31)
gdt_data: 	;data  segment  descriptor
		; Same as code  segment  except  for  the  type  flags:
		; type  flags: (code)0 (expand  down)0 (writable )1 (accessed )0 -> 0010b
	dw 0xffff     	; Limit (bits  0-15)
	dw 0x0         	; Base (bits  0-15)
	db 0x0         	; Base (bits  16 -23)
	db  10010010b 	; 1st flags , type  flags
	db  11001111b 	; 2nd flags , Limit (bits  16-19)
	db 0x0         	; Base (bits  24 -31)


gdt_end:         	;Add a label for the end of the GDT so that the assembler
			;can calculate the size of the GDT for the GDT descriptor

gdt_descriptor:	;holds information about the gdt
	dw  gdt_end  - gdt_start  - 1   ; Size of GDT , always  less  one
					; of the  true  size
	dd  gdt_start                   ; Start  address  of  GDT




; Constants for calculating offsets from beginning of GDT
CODE_SEG  equ  gdt_code  - gdt_start
DATA_SEG  equ  gdt_data  - gdt_start
