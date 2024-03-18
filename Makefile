CC=gcc
NASM=nasm
AS=as
LD=ld

CFLAGS= -m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra -fno-builtin -fno-stack-protector -nostdlib -nodefaultlibs
NASMFLAGS= -f elf32
ASFLAGS=--32
LDFLAGS= -m elf_i386 -T link.ld

all: mykernel.iso

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

boot.o: boot.s
	$(AS) $(ASFLAGS) boot.s -o boot.o

mykernel.bin: kernel.o boot.o link.ld
	$(LD) $(LDFLAGS) boot.o kernel.o -o mykernel.bin -nostdlib

mykernel.iso: mykernel.bin
	grub-file --is-x86-multiboot mykernel.bin
	mkdir -p isodir/boot/grub
	cp mykernel.bin isodir/boot/mykernel.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o mykernel.iso isodir

clean:
	rm -rf *.o mykernel.bin isodir

fclean: clean
	rm -rf mykernel.iso
