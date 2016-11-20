;[org 0x7c00]

print_string:
	push bx

	start:
		cmp byte [bx], 0
		je  stop
		mov al, [bx]
		mov ah, 0x0e
		int 0x10
		inc bx
		jmp start

	stop:
		pop bx
		ret

print_newline:
	mov al, 0
	stosb		;store string

	mov ah, 0x0e
	mov al, 0x0d
	int 0x10
	mov al, 0x0a
	int 0x10
	ret
