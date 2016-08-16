// SNES MSU1 Video 15 Frames Per Second 16 Color 8 Palette Demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "VIDEO15FPS16Col8Pal.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_MSU1.INC"   // Include MSU1 Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
FrameCount:
  dw 0 // Frame Count Word

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  SPCWaitBoot() // Wait For SPC To Boot
  TransferBlockSPC(SPCROM, SPCRAM, SPCROM.size) // Load SPC File To SMP/DSP
  SPCExecute(SPCRAM) // Execute SPC At $0200

  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG2 8x8 Tiles

  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos Low Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos High Byte

  lda.b #31 // Scroll BG2 31 Pixels Up
  sta.w REG_BG2VOFS // Store A into BG Scroll Pos Low Byte
  stz.w REG_BG2VOFS // Store zero into BG Scroll Pos High Byte

  lda.b #$02   // Enable BG2
  sta.w REG_TM // $212C: BG2 To Main Screen Designation

  LoadVRAM(BGMap, $7900, 1792, 0) // Load Frame 1 Background Tile Map To VRAM
  LoadVRAM(BGMap, $F900, 1792, 0) // Load Frame 2 Background Tile Map To VRAM

RestartVid:
  // Audio
  lda.b #$FF       // Load Audio Volume Byte
  sta.w MSU_VOLUME // $2006: MSU1 Volume Register

  ldx.w #$0000    // Load Track Number 0
  stx.w MSU_TRACK // $2004: MSU1 Track Register
  MSUWaitAudioBusy() // Wait For MSU1 Audio Busy Flag Status Bit To Clear

  lda.b #%00000011  // Play & Repeat Sound (%000000RP R = Repeat On/Off, P = Play On/Off)
  sta.w MSU_CONTROL // $2007: MSU1 Control Register

  // Video
  ldx.w #$0000       // Seek To $0000:0000, In The Data .MSU File
  stx.w MSU_SEEK     // $2000: MSU1 Seek Register
  ldx.w #$0000       // Set Seek Bank Register
  stx.w MSU_SEEKBANK // $2002: MSU1 Seek Bank Register     
  MSUWaitDataBusy() // Wait For MSU1 Data Busy Flag Status Bit To Clear

  // Setup Tile DMA On Channel 0
  lda.b #$09
  sta.w REG_DMAP0 // Set DMA Mode (Word, Normal Non Increment) ($4300: DMA Control)
  lda.b #$18      // Set Destination Register ($2118: VRAM Write)
  sta.w REG_BBAD0 // $4301: DMA Destination
  ldx.w #MSU_READ // Source Data
  stx.w REG_A1T0L // Store Data Offset Into DMA Source Offset ($4302: DMA Source)
  stz.w REG_A1B0  // Store Zero Into DMA Source Bank ($4304: Source Bank)

  // Setup Palette DMA On Channel 1
  lda.b #$08
  sta.w REG_DMAP1 // Set DMA Mode (Byte, Normal Non Increment) ($4310: DMA Control)
  lda.b #$22      // Set Destination Register ($2122: CGRAM Write)
  sta.w REG_BBAD1 // $4311: DMA Destination
  ldx.w #MSU_READ // Source Data
  stx.w REG_A1T1L // Store Data Offset Into DMA Source Offset ($4312: DMA Source)
  stz.w REG_A1B1  // Store Zero Into DMA Source Bank ($4314: Source Bank)

  WaitNMI() // Wait For Vertical Blank Before Starting HDMA

  // Screen Display HDMA Channel 2     
  lda.b #%00000000   // HMDA: Write 1 Byte Each Scanline
  sta.w REG_DMAP2    // $4320: DMA2 DMA/HDMA Parameters
  lda.b #REG_INIDISP // $00: Start Screen Display ($2100)
  sta.w REG_BBAD2    // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable   // HMDA Table Address
  stx.w REG_A1T2L    // $4322: DMA2 DMA/HDMA Table Start Address
  lda.b #0           // HDMA Table Bank
  sta.w REG_A1B2     // $4324: DMA2 DMA/HDMA Table Start Address (Bank)
  lda.b #%00000100   // HDMA Channel Select (Channel 2)
  sta.w REG_HDMAEN   // $420C: Select H-Blank DMA (H-DMA) Channels 

  ldx.w #1529>>1 // Load Frame Count / 2
  stx.b FrameCount // Store Frame Count

VIDLoop:
  ldx.w #7168 // VRAM Size In Bytes To DMA Transfer

  ////////////////////////////////////////////////////////
  ldy.w #$0000 >> 1 // VRAM Destination
  sty.w REG_VMADDL  // $2116: VRAM

  // Load Frame 1 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  lda.b #%00000001 // Initiate DMA Transfer (Channel 0)
  WaitNMI() // Wait For Frame 1 1st Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 1 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  WaitNMI() // Wait For Frame 1 2nd Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 1 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  WaitNMI() // Wait For Frame 1 3rd Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 1 Tile Data To VRAM, Followed By Palette To CGRAM
  stz.w REG_CGADD // $2121: CGRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  ldy.w #256 // CGRAM Size In Bytes To DMA Transfer (2 Bytes For Each Colour)
  sty.w REG_DAS1L // Store Size Of Data Block ($4315: DMA Transfer Size/HDMA)
  lda.b #%00000011 // Initiate DMA Transfer (Channel 0&1)
  WaitNMI() // Wait For Frame 1 4th Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Setup Frame 1 BG2 16 Colour Background
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG2 Tile Address = $0000 (VRAM Address / $1000)
  lda.b #%00111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $7800 (VRAM Address / $400)

  ////////////////////////////////////////////////////////
  ldy.w #$8000 >> 1 // VRAM Destination
  sty.w REG_VMADDL  // $2116: VRAM

  // Load Frame 2 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  lda.b #%00000001 // Initiate DMA Transfer (Channel 0)
  WaitNMI() // Wait For Frame 2 1st Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 2 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  WaitNMI() // Wait For Frame 2 2nd Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 2 Tile Data To VRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  WaitNMI() // Wait For Frame 2 3rd Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Load Frame 2 Tile Data To VRAM, Followed By Palette To CGRAM
  stz.w REG_CGADD // $2121: CGRAM
  stx.w REG_DAS0L // Store Size Of Data Block ($4305: DMA Transfer Size/HDMA)
  ldy.w #256 // CGRAM Size In Bytes To DMA Transfer (2 Bytes For Each Colour)
  sty.w REG_DAS1L // Store Size Of Data Block ($4315: DMA Transfer Size/HDMA)
  lda.b #%00000011 // Initiate DMA Transfer (Channel 0&1)
  WaitNMI() // Wait For Frame 2 4th Vertical Blank
  sta.w REG_MDMAEN // $420B: DMA Enable

  // Setup Frame 2 BG2 16 Colour Background
  lda.b #%01000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG2 Tile Address = $8000 (VRAM Address / $1000)
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $F800 (VRAM Address / $400)

  ////////////////////////////////////////////////////////

  ldx.w FrameCount
  dex
  stx.w FrameCount
  beq Restart
  jmp VIDLoop
Restart:
  jmp RestartVid

HDMATable:
  db  8, %10000000 // Repeat  8 Scanlines, Turn Off Screen, Zero Brightness
  db 24, %00001111 // Repeat 24 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db 32, %00001111 // Repeat 32 Scanlines, Turn On Screen, Full Brightness
  db  1, %10000000 // Repeat  1 Scanline, Turn Off Screen, Zero Brightness
  db $00 // End Of HDMA

BGMap:
  include "TileMap8PAL256x224.asm" // Include BG Map Data (1792 Bytes)

// SPC Code
// BANK 0
insert SPCROM, "VIDEO15FPS16Col8Pal.spc"