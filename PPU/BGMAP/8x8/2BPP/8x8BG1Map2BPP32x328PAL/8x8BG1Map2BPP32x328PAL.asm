// SNES PPU BG1 8x8 2BPP 32x32 8 Palette Demo by krom (Peter Lemon):
arch snes.cpu
output "8x8BG1Map2BPP32x328PAL.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 32 Colors)
  LoadVRAM(BGTiles, $0000, BGTiles.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F800, 1792, 0) // Load Background Tile Map To VRAM

  // Setup Video
  lda.b #%00000000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 0, BG1 8x8 Tiles

  // Setup BG1 4 Colour Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 32x32, BG2 Map Address = $F800 (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM     // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

// Character Data
// BANK 0
insert BGPal, "GFX\BG.pal" // Include BG Palette Data ($64 Bytes)
BGMap:
  include "TileMap8PAL256x224.asm" // Include BG Map Data (1792 Bytes)
insert BGTiles, "GFX\BG.pic" // Include BG Tile Data ($14336 Bytes)