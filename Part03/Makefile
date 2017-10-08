NASM=nasm
MBR=mbr.s
MBR_IMG=$(MBR:.s=.img)
QEMU=qemu-system-x86_64

.PHONY: all run clean

all: $(MBR_IMG)

run: all
	$(QEMU) $(FINAL)

$(MBR_IMG): $(MBR)
	nasm -fbin $(MBR) -o $@

clean:
	rm -f $(MBR_IMG) $(FINAL)
