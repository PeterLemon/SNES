// SNES GSU 8BPP 256x192 Plot Pixel Demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "GSU8BPP256x192PlotPixel.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_GSU.INC"    // Include GSU Definitions

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Copy CPU Code To WRAM
  rep #$20 // Set 16-Bit Accumulator
  lda.w #CPURAMEnd-CPURAM // A = Length
  ldx.w #CPURAM // X = Source
  ldy.w #CPURAM // Y = Destination
  mvn $7E=$00 // Block Move Bytes To WRAM + CPURAM
  sep #$20 // Set 8-Bit Accumulator

  lda.b #$00 // A = $00
  pha // Push A To Stack
  plb // Data Bank = $00

  jml $7E0000+CPURAM // Run CPU Code From WRAM

CPURAM: // CPU Program Code To Be Run From RAM
  // Load Blue Palette Color (GSU Clear Color)
  stz.w REG_CGADD  // $2121: CGRAM Address
  lda.b #%00000000 // Load Blue Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%01111100 // Load Blue Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  // Load Black Background Palette Color (Border Color)
  stz.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  stz.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  // Load White Palette Color (Plot Pixel Color)
  lda.b #%11111111 // Load White Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%01111111 // Load White Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  LoadVRAM(BGBorderTile, $C000, $40, 0) // Load Background Border Tile To VRAM
  LoadVRAM(BGMap, $F800, $800, 0) // Load Background Tile Map To VRAM

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 32x32, BG1 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

  // Setup GSU SNES Side
  lda.b #GSU_CLSR_21MHz // Clock Data
  sta.w GSU_CLSR // Set Operating Clock Frequency ($3039)

  lda.b #GSU_CFGR_IRQ_MASK // Config Data
  sta.w GSU_CFGR // Set Config Register ($3037)

  stz.w GSU_SCBR // Set Screen Base ($3038)
  stz.w GSU_PBR // Set Program Code Bank ($3034)

  lda.b #(GSU_RON|GSU_RAN|GSU_SCMR_8BPP|GSU_SCMR_H192) // Screen Size Mode
  sta.w GSU_SCMR // Sets RON, RAN Flag, Screen Size & Color Number ($303A)

  stz.w GSU_ROMBR // Set Game PAK RAM Bank ($3036)
  stz.w GSU_RAMBR // Set Game PAK RAM Bank ($303C)

  lda.b #(GSU_RON|GSU_RAN|GSU_SCMR_8BPP|GSU_SCMR_H192) // Screen Size Mode
  sta.w GSU_SCMR // Sets RON, RAN Flag, Screen Size & Color Number ($303A)

  ldx.w #GSUROM // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)

  LoopGSU:
    lda.w GSU_SFR // X = GSU Status/Flag Register
    bit.b #GSU_SFR_GSU // Check GSU Is Running
    beq LoopGSU

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  // Setup DMA on Channel 0
  lda.b #$80       // Set Increment VRAM Address After Accessing Hi Byte
  sta.w REG_VMAIN  // $2115: Video Port Control
  ldx.w #$0000     // Set VRAM Destination
  stx.w REG_VMADDL // $2116: VRAM

  lda.b #$01      // Set DMA Mode (Write Word, Increment Source)
  sta.w REG_DMAP0 // $43X0: DMA Control
  lda.b #$18      // Set Destination Register ($2118: VRAM Write)
  sta.w REG_BBAD0 // $43X1: DMA Destination
  ldx.w #$0000    // Set Source Offset
  stx.w REG_A1T0L // $43X2: DMA Source
  lda.b #$70      // Set Source Bank
  sta.w REG_A1B0  // $43X4: Source Bank
  ldx.w #$1800    // Set Size In Bytes To DMA Transfer
  stx.w REG_DAS0L // $43X5: DMA Transfer Size/HDMA

Refresh:
  ldy.w #$0000 // Set VRAM Destination
  sty.w REG_VMADDL // $2116: VRAM
  sty.w REG_A1T0L // $43X2: DMA Source
  ldy.w #8 // Y = 8
  LoopGSUSRAM:
    WaitNMI() // Wait For VSync
    stx.w REG_DAS0L // $43X5: DMA Transfer Size/HDMA
    lda.b #%00000001 // Initiate DMA Transfer (Channel 0)
    sta.w REG_MDMAEN // $420B: DMA Enable
    dey // Y--
    bne LoopGSUSRAM
  bra Refresh
CPURAMEnd:

// GSU Code
// BANK 0
GSUROM:
  include "GSU8BPP256x192PlotPixel_gsu.asm" // Include GSU ROM Data
BGMap:
  include "GSU256x192Map.asm" // Include GSU 256x192 BG Map (2048 Bytes)
BGBorderTile:
  db $FF,$00,$FF,$00,$FF,$00,$FF,$00 // Include BG Border Tile (64 Bytes)
  db $FF,$00,$FF,$00,$FF,$00,$FF,$00
  db $00,$00,$00,$00,$00,$00,$00,$00
  db $00,$00,$00,$00,$00,$00,$00,$00
  db $00,$00,$00,$00,$00,$00,$00,$00
  db $00,$00,$00,$00,$00,$00,$00,$00
  db $00,$00,$00,$00,$00,$00,$00,$00
  db $00,$00,$00,$00,$00,$00,$00,$00