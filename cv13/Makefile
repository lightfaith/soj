# cool makefile
TARGET=main

all: $(TARGET)

%.o: %.asm
	nasm -g -f elf64 $<

clean:
	rm -rf $(TARGET) *.o

# $^ - all dependencies
$(TARGET): *.o main.c
	g++ -g $^ -o $(TARGET)

