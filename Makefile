CC=gcc
NASM=nasm
LD=ld

CFLAGS= -m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra
NASMFLAGS= -f elf32
LDFLAGS= -m elf_i386 -T link.ld

all: mykernel.iso

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

boot.o: boot.s
	$(NASM) $(NASMFLAGS) boot.s -o boot.s

mykernel.bin: kernel.o boot.o link.ld
	$(LD) $(LDFLAGS) -o mykernel.bin boot.o kernel.o

mykernel.iso: mykernel.bin
	mkdir -p isodir/boot/grub
	cp mykernel.bin isodir/boot/mykernel.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o mykernel.iso isodir

clean:
	rm- rf *.o mykernel.bin mykernel.iso isodir
