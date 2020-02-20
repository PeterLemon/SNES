// SNES Hi Color (64 Per Tile Row) Using 4BPP BG Mode Demo by krom (Peter Lemon):
arch snes.cpu
output "HiColor64PerTileRow.sfc", create

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

  lda.b #%00000010   // Enable BG2
  sta.w REG_TM // $212C: BG2 To Main Screen Designation

  LoadVRAM(BGTiles, $0000, BGTiles.size, 0)  // Load Background Tile Map To VRAM
  LoadVRAM(BGMap, $7900, 1792, 0)            // Load Background Tile Map To VRAM

  // DMA Palette Data On Interrupt (DMA Channel 0)
  lda.b #%00000000   // DMA: Write 1 Byte, Increment Source
  sta.w REG_DMAP0    // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_CGDATA  // $22: Start At Palette CGRAM Address ($2122)
  sta.w REG_BBAD0    // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  lda.b #BGPal >> 16 // DMA Source Bank
  sta.w REG_A1B0     // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

  lda.b #$0F
  sta.w REG_INIDISP // $80: Turn On Screen, Full Brightness ($2100)

  // IRQ
  lda.b #190         // Value Depends On How Long Horizontal IRQ Takes To Start DMA
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
  ldx.w #BGPal     // DMA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  ldx.w #128       // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
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

  and.b #$F       // A &= $F
  cmp.b #$8       // Compare A To 8
  bne DMAPAL      // IF (Scanline Count != Muliple Of 8) DMA Palette, ELSE Reset Palette Address
  stz.w REG_CGADD // $2121: Palette CGRAM Address = 0

  DMAPAL:
    ldx.w #16        // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
    stx.w REG_DAS0L  // $4305: DMA Transfer Size/HDMA
    lda.b #%00000001 // Start DMA Transfer (Channel 0)
    sta.w REG_MDMAEN // $420B: DMA Enable

  SkipDMA:
  rti

BGMap:
  include "TileMap4PAL64ColPerTileRow256x224.asm" // Include BG Map Data (1792 Bytes)

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Tile Row 00 Palette Data (3584 Bytes)
// BANK 1
seek($18000)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (28672 Bytes)