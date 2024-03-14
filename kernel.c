void print(const char* str) {
	volatile char* video = (volatile char*)0xB8000;
	while (*str) {
		*video++ = *str++;
		*video++ = 0x07;
	}
}

void kernel_main() {
	print("My First Kernel");
	while (1) {}
}
