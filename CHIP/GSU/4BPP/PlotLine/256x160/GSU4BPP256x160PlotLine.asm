// SNES GSU 4BPP 256x160 Plot Line Demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "GSU4BPP256x160PlotLine.sfc", create

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

  // Load White Palette Color (Plot Pixel Color)
  lda.b #%11111111 // Load White Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%01111111 // Load White Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  LoadVRAM(BGMap, $F800, $800, 0) // Load Background Tile Map To VRAM

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG2 8x8 Tiles

  // Setup BG2 16 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG2 Tile Address = $0 (VRAM Address / $1000)

  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos Low Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos High Byte
  stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Scroll Pos Low Byte
  stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Pos High Byte

  lda.b #%00000010 // Enable BG2
  sta.w REG_TM // $212C: BG2 To Main Screen Designation

  // Setup GSU SNES Side
  lda.b #GSU_CLSR_21MHz // Clock Data
  sta.w GSU_CLSR // Set Operating Clock Frequency ($3039)

  lda.b #GSU_CFGR_IRQ_MASK // Config Data
  sta.w GSU_CFGR // Set Config Register ($3037)

  stz.w GSU_SCBR // Set Screen Base ($3038)
  stz.w GSU_PBR // Set Program Code Bank ($3034)
  stz.w GSU_ROMBR // Set Game PAK RAM Bank ($3036)
  stz.w GSU_RAMBR // Set Game PAK RAM Bank ($303C)

  lda.b #(GSU_RON|GSU_RAN|GSU_SCMR_4BPP|GSU_SCMR_H160) // Screen Size Mode
  sta.w GSU_SCMR // Sets RON, RAN Flag, Screen Size & Color Number ($303A)

  ldx.w #GSUROM // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)

  LoopGSU:
    lda.w GSU_SFR // X = GSU Status/Flag Register
    bit.b #GSU_SFR_GSU // Check GSU Is Running
    beq LoopGSU

  WaitNMI() // Wait For Vertical Blank Before Starting HDMA

  // Screen Display HDMA Channel 1    
  lda.b #%00000000   // HMDA: Write 1 Byte Each Scanline
  sta.w REG_DMAP1    // $4310: DMA1 DMA/HDMA Parameters
  lda.b #REG_INIDISP // $00: Start Screen Display ($2100)
  sta.w REG_BBAD1    // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable   // HMDA Table Address
  stx.w REG_A1T1L    // $4312: DMA1 DMA/HDMA Table Start Address
  lda.b #0           // HDMA Table Bank
  sta.w REG_A1B1     // $4314: DMA1 DMA/HDMA Table Start Address (Bank)
  lda.b #%00000010   // HDMA Channel Select (Channel 1)
  sta.w REG_HDMAEN   // $420C: Select H-Blank DMA (H-DMA) Channels

  // Setup DMA On Channel 0
  lda.b #$80       // Set Increment VRAM Address After Accessing Hi Byte
  sta.w REG_VMAIN  // $2115: Video Port Control

  lda.b #$01      // Set DMA Mode (Write Word, Increment Source)
  sta.w REG_DMAP0 // $4300: DMA0 Control
  lda.b #$18      // Set Destination Register ($2118: VRAM Write)
  sta.w REG_BBAD0 // $4301: DMA0 Destination
  lda.b #$70      // Set Source Bank
  sta.w REG_A1B0  // $4304: Source Bank

  ldx.w #$2800 // Set Size In Bytes To DMA Transfer
  lda.b #%00000011 // Initiate DMA Transfer (Channel 0 & 1)

Refresh:
  ldy.w #$0000 // Set VRAM Destination
  sty.w REG_VMADDL // $2116: VRAM
  sty.w REG_A1T0L // $4302: DMA0 Source
  ldy.w #2 // Y = 2
  LoopGSUSRAM:
    stx.w REG_DAS0L // $4305: DMA0 Transfer Size/HDMA
    WaitNMI()
    sta.w REG_MDMAEN // $420B: DMA Enable
    dey // Y--
    bne LoopGSUSRAM
  bra Refresh
CPURAMEnd:

// GSU Code
// BANK 0
GSUROM:
  include "GSU4BPP256x160PlotLine_gsu.asm" // Include GSU ROM Data
BGMap:
  include "GSU256x160Map.asm" // Include GSU 256x160 BG Map (2048 Bytes)
HDMATable:
  db 31, %10000000 // Repeat 31 Scanlines, Turn Off Screen, Zero Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db  1, %10000000 // Repeat  1 Scanline, Turn Off Screen, Zero Brightness
  db $00 // End Of HDMA