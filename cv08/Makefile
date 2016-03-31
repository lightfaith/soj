# cool makefile
TARGET=main

all: main32 main64

%64.o: %64.asm
	nasm -g -f elf64 $<

%32.o: %32.asm
	nasm -g -f elf $<

clean:
	rm -rf $(TARGET) *.o

# $^ - all dependencies
main32: *32.o main32.c
	gcc -g -m32 -std=c99 $^ -o main32

main64: *64.o main64.c
	gcc -g -std=c99 $^ -o main64

