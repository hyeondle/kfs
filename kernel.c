#include "kernel.h"

//
// vga based word printing
// USAGE : init_vga(fore_color, back_color);
// USAGE : vga_buffer[i] = vga_entry(character, fore_color, back_color)
//

uint16 vga_entry(unsigned char ch, uint8 fore_color, uint8 back_color)
{
	uint16	ax = 0;
	uint8	ah = 0, al = 0;

	ah = back_color;
	ah <<= 4;
	ah |= fore_color;
	ax = ah;
	ax <<= 8;
	al = ch;
	ax |= al;

	return ax;
}

void clear_vga_buffer(uint16 **buffer, uint8 fore_color, uint8 back_color)
{
	uint32 i;
	for(i = 0; i < BUFSIZE; i++) {
		(*buffer)[i] = vga_entry(NULL, fore_color, back_color);
	}
}

void init_vga(uint8 fore_color, uint8 back_color)
{
	vga_buffer = (uint16*)VGA_ADDRESS;
	clear_vga_buffer(&vga_buffer, fore_color, back_color);
}

//
// fast print string function (BRIGHT_GERY, BLACK)
//

void p(const char* str)
{
	volatile char* video = (volatile char*)0xB8000;
	while (*str) {
		*video++ = *str++;
		*video++ = 0x07; // BRIGHT_GREY word, BLACK background
	}
}

//
// kernel's entry
//

void kernel_entry()
{
	//p("Begin of kfs\nHOHOKHORKO");
	
	init_vga(WHITE, BLACK);
	vga_buffer[0] = vga_entry('t', WHITE, BLACK);
	vga_buffer[1] = vga_entry('e', WHITE, BLACK);
	vga_buffer[2] = vga_entry('s', WHITE, BLACK);
	vga_buffer[3] = vga_entry('t', WHITE, BLACK);
}
