// SNES Bank LoROM/SlowROM demo by krom (Peter Lemon):
// 1. Jump To Bank Code
// 2. DMA Loads Palette Data To CGRAM
// 3. DMA Loads 1BPP Character Tile Data To VRAM (Converts to 2BPP Tiles)
// 4. DMA Clears VRAM Map To A Space " " Character
// 5. DMA Prints Text Characters To Lo Bytes Of Map
arch snes.cpu
output "BANKLoROMSlowROM.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset // LoROM/SlowROM
}

seek($8000); fill $10000 // Fill Upto $FFFF (Bank 1) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine
  jml Bank1 // Jump To Bank 1

// BANK 1
seek($18000); Bank1:
  LoadPAL(BGPAL, $00, 4, 0) // Load BG Palette Data
  LoadLOVRAM(BGCHR, $0000, $3F8, 0) // Load 1BPP Tiles To VRAM Lo Bytes (Converts To 2BPP Tiles)
  ClearVRAM(BGCLEAR, $F800, $400, 0) // Clear VRAM Map To Fixed Tile Word

  // Print Title Text
  LoadLOVRAM(Title, $F882, 30, 0) // Load Text To VRAM Lo Bytes

  // Print Page Break Text
  LoadLOVRAM(PageBreak, $F8C2, 30, 0) // Load Text To VRAM Lo Bytes

  // Print Text
  LoadLOVRAM(BANKTEXT, $F942, 30, 0) // Load Text To VRAM Lo Bytes

  // Setup Video
  lda.b #%00001000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 1, BG1 8x8 Tiles

  // Setup BG1 4 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2108: BG1 32x32, BG1 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

Title:
  db "Bank Test LoROM/SlowROM ($00):"

PageBreak:
  db "------------------------------"

BANKTEXT:
  db "Jump To Bank 1 ($01)    PASSED"

BGCHR:
  include "Font8x8.asm" // Include BG 1BPP 8x8 Tile Font Character Data (1016 Bytes)
BGPAL:
  dw $7800, $7FFF // Blue / White Palette (4 Bytes)
BGCLEAR:
  dw $0020 // BG Clear Character Space " " Fixed Word