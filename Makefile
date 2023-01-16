CP := cp
RM := rm -rf
MKDIR := mkdir -pv

SRC_PATH := src/
BUILD_PATH := build/
BIN = kernel
CFG = $(SRC_PATH)grub.cfg
ISO_PATH := iso
BOOT_PATH := $(ISO_PATH)/boot
GRUB_PATH := $(BOOT_PATH)/grub

.PHONY: all
all: bootloader kernel linker iso
	@echo Make has completed.

bootloader: $(SRC_PATH)boot.asm
	nasm -f elf32 $(SRC_PATH)boot.asm -o $(BUILD_PATH)boot.o

kernel: $(SRC_PATH)kernel.c
	gcc -m32 -c $(SRC_PATH)kernel.c -o $(BUILD_PATH)kernel.o

linker: $(SRC_PATH)linker.ld $(BUILD_PATH)boot.o $(BUILD_PATH)kernel.o
	ld -m elf_i386 -T $(SRC_PATH)linker.ld -o $(BUILD_PATH)$(BIN) $(BUILD_PATH)boot.o $(BUILD_PATH)kernel.o

iso: kernel
	$(MKDIR) $(GRUB_PATH)
	$(CP) $(BUILD_PATH)$(BIN) $(BOOT_PATH)
	$(CP) $(CFG) $(GRUB_PATH)
	grub-file --is-x86-multiboot $(BOOT_PATH)/$(BIN)
	grub-mkrescue -o $(BUILD_PATH)nicekernel.iso $(ISO_PATH)

.PHONY: clean
clean:
	$(RM) $(BUILD_PATH)* *.o $(BIN) *iso