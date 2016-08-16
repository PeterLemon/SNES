// SNES Blend Hi Color (575 On Screen) Myst Demo by krom (Peter Lemon):
arch snes.cpu
output "HiColor575Myst.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $18000 // Fill Upto $17FFF (Bank 2) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPalBGR, $00, BGPalBGR.size, 0) // Load 2 BG Palettes (BG Palettes Use 240 & 16 Colors)
  LoadVRAM(BGTiles241, $0000, $8000, 0) // Load BG1 256 Tiles To VRAM
  LoadVRAM(BGTiles241+$10000, $8000, $2000, 0) // Load BG1 256 Tiles To VRAM
  LoadVRAM(BGTiles16, $C000, BGTiles16.size, 0) // Load BG2 16  Tiles To VRAM
  LoadVRAM(BGMap241, $B900, BGMap241.size, 0) // Load BG1 256 Tile Map To VRAM
  LoadVRAM(BGMap16, $F900, BGMap16.size, 0) // Load BG2 16 Tile Map To VRAM

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 & BG2 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%01011100 // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC  // $2107: BG1 32x32, BG1 Map Address = $B900 (VRAM Address / $400)

  // Setup BG2 16 Color Background
  lda.b #%11111100 // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC  // $2107: BG2 32x32, BG2 Map Address = $F900 (VRAM Address / $400)

  lda.b #%01100000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0000, BG2 Tile Address = $C000 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM     // $212C: BG1 To Main Screen Designation

  lda.b #%00000010 // Enable BG2
  sta.w REG_TS     // $212D: BG2 To Sub Screen Designation

  lda.b #$02
  sta.w REG_CGWSEL // $2130: Enable Subscreen Color ADD/SUB
    
  lda.b #%00100001
  sta.w REG_CGADSUB // $2131: Colour Addition On BG1 And Backdrop Colour

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Lo Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Hi Byte

  lda.b #31 // Scroll BG1 & BG2 31 Pixels Up
  sta.w REG_BG1VOFS // Store A To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte
  sta.w REG_BG2VOFS // Store A To BG2 Vertical Scroll Position Lo Byte
  stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Scroll Position Hi Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

// Character Data
// BANK 0
insert BGPalBGR,  "GFX/BGR256.pal" // Include 2 BG Palette Data (512 Bytes)
insert BGMap241,  "GFX/GR241.map"  // Include BG Map Data (1792 Bytes)
insert BGMap16,   "GFX/B16.map"    // Include BG Map Data (1792 Bytes)
insert BGTiles16, "GFX/B16.pic"    // Include BG Tile Data (14560 Bytes)
// BANK 1 & 2
seek($18000)
insert BGTiles241, "GFX/GR241.pic" // Include BG Tile Data (40960 Bytes)