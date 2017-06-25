// SNES PPU BG3 8x8 2BPP 32x32 8 Palette Demo by krom (Peter Lemon):
arch snes.cpu
output "8x8BG3Map2BPP32x328PAL.sfc", create

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

  LoadPAL(BGPal, $40, BGPal.size, 0) // Load Background Palette (BG Palette Uses 32 Colors)
  LoadVRAM(BGTiles, $0000, BGTiles.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F800, 1792, 0) // Load Background Tile Map To VRAM

  // Setup Video
  lda.b #%00000000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 0, BG3 8x8 Tiles

  // Setup BG3 4 Colour Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG3SC   // $2107: BG2 32x32, BG3 Map Address = $F800 (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG3 Tile Address, B = BG4 Tile Address
  sta.w REG_BG34NBA // $210B: BG3 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000100 // Enable BG3
  sta.w REG_TM     // $212C: BG3 To Main Screen Designation

  stz.w REG_BG3HOFS // Store Zero To BG3 Horizontal Scroll Pos Low Byte
  stz.w REG_BG3HOFS // Store Zero To BG3 Horizontal Scroll Pos High Byte
  stz.w REG_BG3VOFS // Store Zero To BG3 Vertical Scroll Pos Low Byte
  stz.w REG_BG3VOFS // Store Zero To BG3 Vertical Pos High Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

// Character Data
// BANK 0
insert BGPal, "GFX\BG.pal" // Include BG Palette Data ($64 Bytes)
BGMap:
  include "TileMap8PAL256x224.asm" // Include BG Map Data (1792 Bytes)
insert BGTiles, "GFX\BG.pic" // Include BG Tile Data ($14336 Bytes)