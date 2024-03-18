.set BOOTHEAD,	0x1BADB002
.set FLAGS,	0
.set CHECKSUM, -(BOOTHEAD + FLAGS)

.section .multiboot

.long BOOTHEAD
.long FLAGS
.long CHECKSUM

# set stack's bottom
stackBottom:
# define maximum size of stack to 512 bytes
.skip 1024

stackTop:

.section .text
.global _start
.type _start, @function

_start:

	mov $stackTop, %esp
	call kernel_entry
	cli

hltLoop:
	hlt
	jmp hltLoop

.size _start, . - _start

.section .note.GNU-stack,"",@progbits
