// SNES Green Space Demo by krom (Peter Lemon):
arch snes.cpu
output "GreenSpace.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Load Green Background Palette Color
  stz.w REG_CGADD  // $2121: CGRAM Address
  lda.b #%11100000 // Load Green Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%00000011 // Load Green Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  stz.w REG_TM // $212C: Main Screen Designation

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop