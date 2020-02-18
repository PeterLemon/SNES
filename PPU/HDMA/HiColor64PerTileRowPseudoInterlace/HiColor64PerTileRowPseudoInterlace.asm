// SNES Hi Color (64 Per Tile Row) Pseudo Interlace Using 4BPP BG Mode Demo by krom (Peter Lemon):
arch snes.cpu
output "HiColor64PerTileRowPseudoInterlace.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $18000 // Fill Upto $1FFFF (Bank 2) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Setup Video
  lda.b #%00001001 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 1, Priority 1, BG2 8x8 Tiles

  lda.b #%00001000 // Pseudo Horizontal High-Resolution
  sta.w REG_SETINI // $2133: Screen Mode Select

  // Setup BG1 & BG2 16 Colour Background
  lda.b #%01000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0000, BG2 Tile Address = $8000 (VRAM Address / $1000)
  lda.b #%00111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 32x32, BG2 Map Address = $7800 (VRAM Address / $400)
  sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $7800 (VRAM Address / $400)

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos Low Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos High Byte

  lda.b #31 // Scroll BG2 31 Pixels Up
  sta.w REG_BG1VOFS // Store A into BG1 Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store zero into BG1 Scroll Pos High Byte
  sta.w REG_BG2VOFS // Store A into BG2 Scroll Pos Low Byte
  stz.w REG_BG2VOFS // Store zero into BG2 Scroll Pos High Byte

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM     // $212C: BG1 To Main Screen Designation

  lda.b #%00000010 // Enable BG2
  sta.w REG_TS     // $212D: BG2 To Sub Screen Designation

  lda.b #$02
  sta.w REG_CGWSEL // $2130: Enable Subscreen Color ADD/SUB
    
  lda.b #%01100001
  sta.w REG_CGADSUB // $2131: Colour Addition On BG1 And Backdrop Colour, Result / 2

  LoadVRAM(BG1Tiles, $0000, BG1Tiles.size, 0)  // Load Background Tile Map To VRAM
  LoadVRAM(BG2Tiles, $8000, BG2Tiles.size, 0)  // Load Background Tile Map To VRAM
  LoadVRAM(BGMap, $7900, 1792, 0)              // Load Background Tile Map To VRAM

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
  lda.b #200         // Value Depends On How Long Horizontal IRQ Takes To Start DMA
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
  ldx.w #256       // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w REG_DAS0L  // $4305: DMA Transfer Size/HDMA
  lda.b #%00000001 // Start DMA Transfer (Channel 0)
  sta.w REG_MDMAEN // $420B: DMA Enable
  stz.w REG_CGADD  // $2121: Palette CGRAM Address = 0
  ldy.w #224 // Y = Scanline Counter
  rti

HTIMERIRQ:
  lda.w REG_TIMEUP // $4211: H/V-Timer IRQ Flag (Read/Ack) (Clear IRQ Line)
  iny // Scanline Counter++

  cpy.w #261 // Compare Scanline Counter To 261 (Vertical Counter End NTSC)
  beq StartPaletteUpload 

  cpy.w #8 // Compare Scanline Counter To 8
  bmi SkipDMA

  cpy.w #217 // Compare Scanline Counter To 217
  bpl SkipDMA

  tya // A = Scanline Counter
  and.b #$F // A &= $F
  cmp.b #$8 // Compare A To 8
  bne DMAPAL // IF (Scanline Count != Muliple Of 8) DMA Palette, ELSE Reset Palette Address
  stz.w REG_CGADD // $2121: Palette CGRAM Address = 0

  DMAPAL:
    ldx.w #16        // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
    stx.w REG_DAS0L  // $4305: DMA Transfer Size/HDMA
    lda.b #%00000001 // Start DMA Transfer (Channel 0)
    sta.w REG_MDMAEN // $420B: DMA Enable

  SkipDMA:
  rti

  StartPaletteUpload:
  ldy.w #0 // Scanline Counter = 0
  rti

BGMap:
  include "TileMap4PAL64ColPerTileRow256x224.asm" // Include BG Map Data (1792 Bytes)

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Tile Row 00 Palette Data (3584 Bytes)
// BANK 1
seek($18000)
insert BG1Tiles, "GFX/BG1.pic" // Include BG Tile Data (28672 Bytes)
// BANK 2
seek($28000)
insert BG2Tiles, "GFX/BG2.pic" // Include BG Tile Data (28672 Bytes)