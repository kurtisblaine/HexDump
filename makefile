go:lab0x01-hexdump.asm lab0x01-hexdump.o
	nasm -f elf32 -g -F dwarf lab0x01-hexdump.asm
	ld -m elf_i386 lab0x01-hexdump.o -o go
	
debug: 


clean:
