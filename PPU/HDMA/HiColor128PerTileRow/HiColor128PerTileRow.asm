// SNES Hi Color (128 Per Tile Row) Using 4BPP BG & Sprites Demo by krom (Peter Lemon):
arch snes.cpu
output "HiColor128PerTileRow.sfc", create

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

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG2 8x8 Tiles

  // Setup BG2 16 Colour Background
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG2 Tile Address = $0000 (VRAM Address / $1000)
  lda.b #%00111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $7800 (VRAM Address / $400)

  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos Low Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos High Byte

  lda.b #31 // Scroll BG2 31 Pixels Up
  sta.w REG_BG2VOFS // Store A into BG Scroll Pos Low Byte
  stz.w REG_BG2VOFS // Store zero into BG Scroll Pos High Byte

  lda.b #%00010010 // Enable BG2 & Sprites
  sta.w REG_TM     // $212C: BG2 & Sprites To Main Screen Designation

  LoadVRAM(BGOBJTiles, $0000, BGOBJTiles.size, 0) // Load Background/Object Tile Data To VRAM
  LoadVRAM(BGMap, $7900, 1792, 0) // Load Background Tile Map To VRAM

  // Clear OAM
  ldx.w #$0000 // X = $0000
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0080
  lda.b #$E0
  -
    sta.w REG_OAMDATA // OAM Data Write 1st Write = $E0 (Lower 8-Bit) ($2104)
    sta.w REG_OAMDATA // OAM Data Write 2nd Write = $E0 (Upper 8-Bit) ($2104)
    stz.w REG_OAMDATA // OAM Data Write 1st Write = 0 (Lower 8-Bit) ($2104)
    stz.w REG_OAMDATA // OAM Data Write 2nd Write = 0 (Upper 8-Bit) ($2104)
    dex
    bne -

  ldx.w #$0020
  -
    stz.w REG_OAMDATA // OAM Data Write 1st/2nd Write = 0 (Lower/Upper 8-Bit) ($2104)
    dex
    bne -

  // Copy OAM Info
  ldx.w #$0000 // X = $0000
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  -
    lda.w OAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$00A0
    bne -

  // Copy OAM Extra Info
  ldy.w #$0100 // Y = $0100
  sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  -
    lda.w OAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$00AA
    bne -

  // DMA Palette Data On Interrupt (DMA Channel 0)
  lda.b #%00000000  // DMA: Write 1 Byte, Increment Source
  sta.w REG_DMAP0   // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_CGDATA // $22: Start At Palette CGRAM Address ($2122)
  sta.w REG_BBAD0   // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  lda.b #BGOBJPal >> 16 // DMA Source Bank
  sta.w REG_A1B0    // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

  // HDMA OAM Size & Object Base (HDMA Channel 1)
  lda.b #%00000000 // HDMA: Write 1 Bytes Each Scanline
  sta.w REG_DMAP1  // $4310: DMA1 DMA/HDMA Parameters
  lda.b #REG_OBSEL // $01: Start At Object Size & Object Base ($2101)
  sta.w REG_BBAD1  // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #OAMHDMATable // HDMA Table Address
  stx.w REG_A1T1L  // $4312: DMA1 DMA/HDMA Table Start Address
  lda.b #OAMHDMATable >> 16 // HDMA Table Bank
  sta.w REG_A1B1   // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

  lda.b #%00000010 // HDMA Channel Select (Channel 1)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

  lda.b #$0F
  sta.w REG_INIDISP // $80: Turn On Screen, Full Brightness ($2100)

  // IRQ
  lda.b #170         // Value Depends On How Long Horizontal IRQ Takes To Start DMA
  sta.w REG_HTIMEL   // $4207: H-Count Timer Setting (Lower 8-Bit)
  lda.b #%10010000   // NMI & Horizontal IRQ
  sta.w REG_NMITIMEN // $4200: Interrupt Enable & Joypad Request (Enable NMI)

  WaitNMI() // Wait For Vertical Blank
  cli // Enable Interrupts

loop:
  wai
  jmp loop

VBLANKIRQ:
  stz.w REG_CGADD  // $2121: Palette CGRAM Address = 0
  ldx.w #BGOBJPal  // DMA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  ldx.w #256       // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w REG_DAS0L  // $4305: DMA Transfer Size/HDMA
  lda.b #%00000001 // Start DMA Transfer (Channel 0)
  sta.w REG_MDMAEN // $420B: DMA Enable
  rti

HTIMERIRQ:
  lda.w REG_TIMEUP // $4211: H/V-Timer IRQ Flag (Read/Ack) (Clear IRQ Line)

  lda.w REG_SLHV   // $2137: PPU1 Latch H/V-Counter By Software (Read=Strobe)
  lda.w REG_OPVCT  // $213D: PPU2 Vertical Counter Latch (Scanline Lo Byte)
  xba              // Exchange B & A Accumulators
  lda.w REG_OPVCT  // $213D: PPU2 Vertical Counter Latch (Scanline Hi Byte)
  and.b #$01       // A &= 1 (Bit 9 Of Vertical Counter)
  xba              // Exchange B & A Accumulators (A = Scanline Lo Byte)
  tax              // Transfer A To X Index (X = Scanline Count)

  cpx.w #216  // Compare Scanline Count To 216
  bpl SkipDMA // IF (Scanline Count < 216) Skip DMA

  ldx.w #32        // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w REG_DAS0L  // $4305: DMA Transfer Size/HDMA
  lda.b #%00000001 // Start DMA Transfer (Channel 0)
  sta.w REG_MDMAEN // $420B: DMA Enable

  SkipDMA:
  rti

OAMHDMATable:
  db 128, %11000000 // Repeat 128 Scanlines, Object Size = 16x32/32x64, Name = 0, Base = $0000
  db   1, %11000001 // Repeat   1 Scanlines, Object Size = 16x32/32x64, Name = 0, Base = $4000
  db 0 // End Of HDMA

OAM:
  // OAM Info (32x64 Sprites)
  db   0, 0,   0, %00000000 // ROW 1..7
  db  32, 0,   4, %00000010
  db  64, 0,   8, %00000100
  db  96, 0,  12, %00000110
  db 128, 0, 128, %00001000
  db 160, 0, 132, %00001010
  db 192, 0, 136, %00001100
  db 224, 0, 140, %00001110

  db   0, 64,   0, %00000001 // ROW 9..15
  db  32, 64,   4, %00000011
  db  64, 64,   8, %00000101
  db  96, 64,  12, %00000111
  db 128, 64, 128, %00001001
  db 160, 64, 132, %00001011
  db 192, 64, 136, %00001101
  db 224, 64, 140, %00001111

  db   0, 128,   0, %00000000 // ROW 17..23
  db  32, 128,   4, %00000010
  db  64, 128,   8, %00000100
  db  96, 128,  12, %00000110
  db 128, 128, 128, %00001000
  db 160, 128, 132, %00001010
  db 192, 128, 136, %00001100
  db 224, 128, 140, %00001110

  // OAM Info (16x32 Sprites)
  db   0, 192,  0, %00000001 // ROW 25..27
  db  16, 192,  2, %00000001
  db  32, 192,  4, %00000011
  db  48, 192,  6, %00000011
  db  64, 192,  8, %00000101
  db  80, 192, 10, %00000101
  db  96, 192, 12, %00000111
  db 112, 192, 14, %00000111

  db 128, 192, 64, %00001001
  db 144, 192, 66, %00001001
  db 160, 192, 68, %00001011
  db 176, 192, 70, %00001011
  db 192, 192, 72, %00001101
  db 208, 192, 74, %00001101
  db 224, 192, 76, %00001111
  db 240, 192, 78, %00001111

  // OAM Extra Info (32x64 Sprites)
  db %10101010 // ROW 1..7
  db %10101010

  db %10101010 // ROW 9..15
  db %10101010

  db %10101010 // ROW 17..23
  db %10101010

  // OAM Extra Info (16x32 Sprites)
  db %00000000 // ROW 25..27
  db %00000000

  db %00000000
  db %00000000

BGMap:
  include "TileMap8PAL128ColPerTileRow256x224.asm" // Include BG Map Data (1792 Bytes)

// Character Data
// BANK 0
insert BGOBJPal,   "GFX/BGOBJ.pal" // Include BG Tile Row 0..27 Palette Data (7168 Bytes)
// BANK 1
seek($18000)
insert BGOBJTiles, "GFX/BGOBJ.pic" // Include BG Tile Data (28672 Bytes)