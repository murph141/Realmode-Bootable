org 0x7C00
BITS 16

jmp short start
nop

; The following code wasn't written by me
; it's just a Standard BIOS Parameter Block with a FAT12/FAT16 extension
; considering the comments are pretty good and already describe the use of each value
; we might just use this as it's working (which is something I had many problems with).
; Source MikeOS
; http://mikeos.sourceforge.net/
; ------------------------------------------------------------------
; Disk description table, to make it a valid floppy
; Note: some of these values are hard-coded in the source!
; Values are those used by IBM for 1.44 MB, 3.5" diskette
OEMLabel    db "Example "  ; Disk label
BytesPerSector    dw 512    ; Bytes per sector
SectorsPerCluster  db 1    ; Sectors per cluster
ReservedForBoot    dw 1    ; Reserved sectors for boot record
NumberOfFats    db 2    ; Number of copies of the FAT
RootDirEntries    dw 224    ; Number of entries in root dir
; (224 * 32 = 7168 = 14 sectors to read)
LogicalSectors    dw 2880    ; Number of logical sectors
MediumByte    db 0F0h    ; Medium descriptor byte
SectorsPerFat    dw 9    ; Sectors per FAT
SectorsPerTrack    dw 18    ; Sectors per track (36/cylinder)
Sides      dw 2    ; Number of sides/heads
HiddenSectors    dd 0    ; Number of hidden sectors
LargeSectors    dd 0    ; Number of LBA sectors
; MikeOS's bootloader didn't mention this but the FAT12/FAT16 extension starts here
DriveNo      dw 0    ; Drive No: 0
Signature    db 41    ; Drive signature: 41 for floppy
VolumeID    dd 00000000h  ; Volume ID: any number
VolumeLabel    db "Example    "; Volume Label: any 11 chars
FileSystem    db "FAT12   "  ; File system type: don't change!
start:
; ------------------------------------------------------------------

mov si, msg
call printNullTerminatedString

jmp $
hlt
ret

printCharacter:
  mov bh, 0x00
  mov bl, 0x00
  mov ah, 0x0E
  int 0x10
  ret

printNullTerminatedString:
  pusha

  .loop:
    lodsb
    test al, al
    jz .end
    call printCharacter
    jmp .loop

  .end:
    popa
    ret

msg db "Hello World!", 0

times 510-($-$$) db 0
db 0x55
db 0xAA
