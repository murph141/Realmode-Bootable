NASM=nasm
KERNEL=kernel.s
MBR=mbr.s
MBR_IMG=$(MBR:.s=.img)
KERNEL_IMG=$(KERNEL:.s=.img)
FINAL=final.img
QEMU=qemu-system-x86_64

.PHONY: all combine run clean

all: $(KERNEL_IMG) $(MBR_IMG) combine

run: all
	$(QEMU) $(FINAL)

$(KERNEL_IMG): $(KERNEL)
	nasm -fbin $(KERNEL) -o $@

$(MBR_IMG): $(MBR)
	nasm -fbin $(MBR) -o $@

combine:
	cat $(MBR_IMG) $(KERNEL_IMG) > $(FINAL)

clean:
	rm -f $(KERNEL_IMG) $(MBR_IMG) $(FINAL)
