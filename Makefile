# Define the path to GBDK
GBDK_PATH = ~/gbdk/bin

# Define the compiler and the flags
CC = $(GBDK_PATH)/lcc
CFLAGS = -c

# Define the target executable name
TARGET = HandlingJoyadInputInGBDK.gb

# Define the object files
OBJS = main.o SimpleSprite.o

# Default rule to build the target
all: $(TARGET)

# Rule to link object files into a .gb file
$(TARGET): $(OBJS)
	$(CC) -o $@ $^

# Rule to compile .c files into .o files
%.o: %.c
	$(CC) $(CFLAGS) -o $@ $<

# Clean rule to remove generated files
clean:
	rm -f $(TARGET) *.asm *.lst *.ihx *.sym *.o

