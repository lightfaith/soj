# cool makefile
TARGET=main

all: $(TARGET)

%.o: %.asm
	nasm -g -f elf $<

clean:
	rm -rf $(TARGET) *.o

# $^ - all dependencies
$(TARGET): *.o main.c
	gcc -g -m32 -std=c99 $^ -o $(TARGET)


