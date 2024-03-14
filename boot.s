section .multiboot
align 4
dd 0x1BADB002		; multiboot header
dd 0x00			; flag
dd -(0x1BADB002 + 0x00)	; checksum

extern kernel_main

section .text
global _start
_start:
	cli			; disable interrupt
	mov esp, kernel_stack
	call kernel_main
	hlt			; stop cpu

section .bss
resb 4096		; kernel stack
kernel_stack:
