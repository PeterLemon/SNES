// SNES Controller Latency Demo by krom (Peter Lemon):
// Pushing any button turns the screen white
// When no buttons are pushed screen is black

arch snes.cpu
output "ControllerLatency.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  stz.w REG_TM // $212C: Main Screen Designation

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

InputLoop:  
  - // Wait For Vertical Blank
    bit.w REG_RDNMI // $4210: Read NMI Flag Register
    bpl - // Wait For NMI Flag
  - // Read Controller
    bit.w REG_HVBJOY // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bmi - // Wait Until Joypad Is Ready

  ldx.w REG_JOY1L // Read Joypad Register Word
  beq DrawBlack // IF (Any Button Is Pressed) Draw White, ELSE Draw Black

  // Load White Background Palette Color
  stz.w REG_CGADD  // $2121: CGRAM Address
  lda.b #%11111111 // Load White Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%01111111 // Load White Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte
  bra InputLoop

  DrawBlack:
  // Load Black Background Palette Color
  stz.w REG_CGADD  // $2121: CGRAM Address
  lda.b #%00000000 // Load White Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%00000000 // Load White Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte
  bra InputLoop