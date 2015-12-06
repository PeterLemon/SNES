// SNES Plot Pixel Mode7 Demo by krom (Peter Lemon):
arch snes.cpu
output "PlotPixelMode7.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB\SNES.INC"        // Include SNES Definitions
include "LIB\SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB\SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, 4, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  LoadM7VRAM(BGMap, BGTiles, $0000, 16384, 128, 0) // Load Background Map & Tiles To VRAM
    
  // Setup Mode7 128x128 Linear Screen
  lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: Set BG1 To Main Screen Designation

  stz.w REG_M7SEL // $211A: MODE7 Settings

  lda.b #$04 // Set Mode7 X Scale
  stz.w REG_M7A // $211B: MODE7 COSINE A Lo Byte
  sta.w REG_M7A // $211B: MODE7 COSINE A Hi Byte

  stz.w REG_M7B // $211C: MODE7 SINE A Lo Byte
  stz.w REG_M7B // $211C: MODE7 SINE A Hi Byte

  stz.w REG_M7C // $211D: MODE7 SINE B Lo Byte
  stz.w REG_M7C // $211D: MODE7 SINE B Hi Byte

  lda.b #$90 // Set Mode7 Y Scale
  sta.w REG_M7D // $211E: MODE7 COSINE B Lo Byte
  lda.b #$04
  sta.w REG_M7D // $211E: MODE7 COSINE B Hi Byte

  stz.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
  stz.w REG_M7X // $211F: Mode7 Center Position X Hi Byte
  stz.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  stz.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte

  stz.w REG_VMAIN  // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)

  // Plot Pixel
  lda.b #48 // A = Plot Y Coord
  rep #%00100000 // A Set To 16-Bit
  asl
  asl
  asl
  asl
  asl
  asl
  asl // A *= 128
  clc
  adc.w #40 // A += Plot X Coord (A = VRAM Address)
  sta.w REG_VMADDL // $2116: VRAM Address Write (16-Bit)
  sep #%00100000 // A Set To 8-Bit
  lda.b #1 // A = Pixel Color White
  sta.w REG_VMDATAL // $2118: VRAM Data Write (Lo 8-Bit)

  lda.b #$F // Turn On Screen, Full Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop

BGTiles: // Include BG Tile Data (128 Bytes)
  db 0,0,0,0,0,0,0,0 // Black / Clear Pixel (0)
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0
  db 0,0,0,0,0,0,0,0

  db 1,1,1,1,1,1,1,1 // White Pixel (1)
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1
  db 1,1,1,1,1,1,1,1

BGPal:
  dw $0000, $7FFF // Black, White (4 Bytes)

BGMap:
  fill 16384 // Include BG Map Data (16384 Bytes)