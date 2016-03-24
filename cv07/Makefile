# cool makefile
TARGET=main32
TARGET64=main64

all: $(TARGET) $(TARGET64)

%32.o: %32.asm
	nasm -g -f elf $<

%64.o: %64.asm
	nasm -g -f elf64 $<

clean:
	rm -rf $(TARGET) $(TARGET64) *.o

# $^ - all dependencies
$(TARGET): *32.o main32.c
	gcc -g -m32 -std=c99 $^ -o $(TARGET)

$(TARGET64): *64.o main64.c
	gcc -g -std=c99 $^ -o $(TARGET64)
