ENTRY(_start)

SECTIONS {
	. = 1M;

	.boot :
	{
		*(.multiboot)
	}

	.text : {
		*(.text)
	}

	.data : {
		*(.dtata)
	}

	.bss : {
		*(.bss)
	}
}
