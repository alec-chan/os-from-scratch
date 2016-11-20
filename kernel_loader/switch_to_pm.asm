[bits 16]

switch_to_pm:
	cli		;switch off interrups until pm is entered

	lgdt [gdt_descriptor]	;load GDT

	mov eax, cr0	;set first bit of CR0 to control register
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_pm	;jump to 32-bit code, flushes instructions from CPU cache

[bits 32]

init_pm:
	mov ax, DATA_SEG	;point segment regs to GDT data selector
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	;move stack position to top of freespace
	mov esp, ebp
	call BEGIN_PM
