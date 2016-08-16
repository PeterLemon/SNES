// SNES Interlace Simpsons HDMA Demo by krom (Peter Lemon):
arch snes.cpu
output "InterlaceSimpsonsHDMA.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $10000 // Fill Upto $FFFF (Bank 1) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
  LoadVRAM(BGTilesHI, $0000, BGTilesHI.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGTilesLO, $8000, BGTilesLO.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F200, BGMap.size, 0) // Load Background Tile Map To VRAM

SetupVideo:
  lda.b #%00001101 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 5, Priority 1, BG1 16x8 Tiles

  lda.b #%00000001 // Interlace Mode On
  sta.w REG_SETINI // $2133: Screen Mode Select

  // Setup BG1 16 Color Background
  lda.b #%01111010  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x32, BG1 Map Address = $F200 (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0000 (VRAM Address / $1000)

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation
  sta.w REG_TS // $212D: BG1 To Sub Screen Designation (Needed To Show Interlace GFX)

  // HDMA BG1 Tile Address    
  lda.b #%00000000   // HMDA: Write 1 Bytes Each Scanline
  sta.w REG_DMAP0    // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_BG12NBA // $0B: Start At BG1 Tile Address ($210B)
  sta.w REG_BBAD0    // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable   // HMDA Table Address
  stx.w REG_A1T0L    // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0           // HDMA Table Bank
  sta.w REG_A1B0     // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
  lda.b #%00000001   // HDMA Channel Select (Channel 0)
  sta.w REG_HDMAEN   // $420C: Select H-Blank DMA (H-DMA) Channels 

  stz.w REG_BG1HOFS // Store Zero To BG Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG Horizontal Scroll Position Hi Byte

  lda.b #62 // Scroll BG 62 Pixels Up
  sta.w REG_BG1VOFS // Store A To BG Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG Vertical Scroll Position Hi Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

HDMATable:
  db 112, 0 // Repeat 112 Scanlines, BG1 Tile Address = $0000
  db  32, 0 // Repeat  32 Scanlines, BG1 Tile Address = $0000
  db  80, 4 // Repeat  80 Scanlines, BG1 Tile Address = $4000
  db 0 // End Of HDMA

// Character Data
// BANK 0
insert BGPal,     "GFX/BG.pal"   // Include BG Palette Data (32 Bytes)
insert BGMap,     "GFX/BG.map"   // Include BG Map Data (3584 Bytes)
insert BGTilesLO, "GFX/BGLO.pic" // Include BG Tile Data (27776 Bytes)
// BANK 1
seek($18000)
insert BGTilesHI, "GFX/BGHI.pic" // Include BG Tile Data (29312 Bytes)