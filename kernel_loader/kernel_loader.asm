
; A boot  sector  that  boots a C kernel  in 32-bit  protected  mode
[org 0x7c00]
KERNEL_OFFSET  equ 0x1000   	; This is the  memory  offset  where the kernel will be loaded
mov [BOOT_DRIVE], dl 		; BIOS stores boot drive in DL
				
mov bp, 0x9000         		; Set up the  stack.
mov sp, bp
mov bx, MSG_REAL_MODE 	; Announce  that we are  starting
call  print_string      ; booting  from 16-bit  real  mode
call  load_kernel       ; Load  kernel
call  switch_to_pm      ; Switch  to  protected  mode
jmp $


%include "print_string.asm"
%include "disk_load.asm"
%include "GDT.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"
[bits  16]
; load_kernel
load_kernel:
	mov bx, MSG_LOAD_KERNEL    ; Print a message
	call  print_string
	mov bx, KERNEL_OFFSET      ; setup  parameters  for disk_load and load first 15 sectors minus the boot sector
	mov dh, 15                 ; to KERNEL_OFFSET
	mov dl, [BOOT_DRIVE]       
	call  disk_load               
	ret

[bits  32]
; Arrive here after switching to and initializing protected mode 
BEGIN_PM:
	mov ebx , MSG_PROT_MODE ; Use 32-bit  print  routine  to
	call  print_string_pm   ; announce  we are in  protected  mode
	call  KERNEL_OFFSET     ; jump to the  address  of the  loaded
				; kernel  code
				
jmp $                      	
; Global  variables
BOOT_DRIVE       db 0
MSG_REAL_MODE    db "Started  in 16-bit  Real  Mode", 0
MSG_PROT_MODE    db "Successfully  landed  in 32-bit  Protected  Mode", 0
MSG_LOAD_KERNEL  db "Loading  kernel  into  memory.", 0
; Bootsector  padding
times  510-($-$$) db 0
dw 0xaa55
