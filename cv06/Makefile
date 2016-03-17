# cool makefile
# nasm -hf
TARGET=main

all: $(TARGET)

%.o: %.asm
	nasm -g -f elf64 $<

clean:
	rm -rf $(TARGET) *.o

# $^ - all dependencies
$(TARGET): *.o main.c
	gcc -g -std=c99 $^ -o $(TARGET)

