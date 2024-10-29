# Makefile for GBDK project

# Set up GBDK path
GBDK_PATH := ~/gbdk
LCC := $(GBDK_PATH)/bin/lcc

# Project files
SRC := main.c
OBJ := main.o
OUTPUT := MinimalGameboyProject.gb

# Default target: build the .gb file
all: $(OUTPUT)

# Rule to compile .c files into .o object files
$(OBJ): $(SRC)
	$(LCC) -c -o $(OBJ) $(SRC)

# Rule to link the object files into a .gb ROM
$(OUTPUT): $(OBJ)
	$(LCC) -o $(OUTPUT) $(OBJ)

# Clean up generated files
clean:
	rm -f $(OUTPUT) *.asm *.lst *.ihx *.sym *.o

