disk_load:
	push dx		;store dx on stack to recall number of requested sectors

	mov ah, 0x02	;BIOS sector reading function
	mov al, dh	;read dh
	mov ch, 0x00	;select cyl0
	mov dh, 0x00	;select head0
	mov cl, 0x02	;start reading from after boot sector

	int 0x13	;interrupt
	jc disk_error	;jump on error

	pop dx		;restore dx
	cmp dh, al	;if(al!=dh)
	jne disk_error	;throw error
	ret

disk_error:

	mov bx, ERROR_MSG
	call print_string
	jmp $

ERROR_MSG db "Disk read error..", 0
