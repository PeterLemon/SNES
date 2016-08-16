// SNES Mode7 HDMA Demo by krom (Peter Lemon):
arch snes.cpu
output "Mode7HDMA.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
Mode7PosX:
  dw 0 // Mode7 Center Pos X Word
BG1ScrPosX:
  dw 0 // Mode7 BG1 Scroll Position X Word

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  LoadM7VRAM(BGMap, BGTiles, $0000, BGMap.size, BGTiles.size, 0) // Load Background Map & Tiles To VRAM

  lda.b #$01 // Enable Joypad NMI Reading Interrupt
  sta.w REG_NMITIMEN

  // Setup Video
  lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_M7SEL // $211A: MODE7 Settings

  stz.w REG_M7A // $211B: MODE7 COSINE A Lo Byte
  sta.w REG_M7A // $211B: MODE7 COSINE A Hi Byte

  stz.w REG_M7B // $211B: MODE7 SINE A Lo Byte
  stz.w REG_M7B // $211B: MODE7 SINE A Hi Byte

  stz.w REG_M7C // $211B: MODE7 SINE B Lo Byte
  stz.w REG_M7C // $211B: MODE7 SINE B Hi Byte

  stz.w REG_M7D // $211E: MODE7 COSINE B Lo Byte
  sta.w REG_M7D // $211E: MODE7 COSINE B Hi Byte

  ldx.w #$0000 // Reset BG1 X Position
  stx.b BG1ScrPosX

  lda.b #$00 // Reset BG1 Y Position
  sta.w REG_BG1VOFS // $210E: BG1 Vertical Scroll Position Lo Byte
  sta.w REG_BG1VOFS // $210E: BG1 Vertical Scroll Position Hi Byte

  ldx.w #$0080 // Reset MODE7 Center X Pos
  stx.b Mode7PosX
  
  lda.b #$00 // Reset MODE7 Center Y Pos
  sta.w REG_M7Y // $2120: MODE7 Center Position Y Lo Byte
  sta.w REG_M7Y // $2120: MODE7 Center Position Y Hi Byte

  // HDMA Mode7 Scanline Zoom (X)    
  lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP0   // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_M7A    // $1B: Start At MODE7 COSINE A ($211B)
  sta.w REG_BBAD0   // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable0 // HMDA Table Address
  stx.w REG_A1T0L   // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0          // HDMA Table Bank
  sta.w REG_A1B0    // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

  // HDMA Mode7 Scanline Zoom (Y)    
  lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP1   // $4310: DMA1 DMA/HDMA Parameters
  lda.b #REG_M7D    // $1E: Start At MODE7 COSINE B ($211E)
  sta.w REG_BBAD1   // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable1 // HMDA Table Address
  stx.w REG_A1T1L   // $4312: DMA1 DMA/HDMA Table Start Address
  lda.b #0          // HDMA Table Bank
  sta.w REG_A1B1    // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

  // HDMA Mode7 Scanline Centre (Y)    
  lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP2   // $4320: DMA2 DMA/HDMA Parameters
  lda.b #REG_M7Y    // $20: Start At MODE7 Center Pos Y ($2120)
  sta.w REG_BBAD2   // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable2 // HMDA Table Address
  stx.w REG_A1T2L   // $4322: DMA2 DMA/HDMA Table Start Address
  lda.b #0          // HDMA Table Bank
  sta.w REG_A1B2    // $4324: DMA2 DMA/HDMA Table Start Address (Bank)

  lda.b #%00000111 // HDMA Channel Select (Channel 0,1,2)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  lda.b BG1ScrPosX
  sta.w REG_BG1HOFS // $210D: BG1 Horizontal Scroll Position Lo Byte
  lda.b BG1ScrPosX + 1
  sta.w REG_BG1HOFS // $210D: BG1 Horizontal Scroll Position Hi Byte

  lda.b Mode7PosX
  sta.w REG_M7X // $211F: MODE7 Center Position X Lo Byte
  lda.b Mode7PosX + 1
  sta.w REG_M7X // $211F: MODE7 Center Position X Hi Byte

  JoyLeft:
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq JoyRight // IF (LEFT ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Decrement BG1 Horizontal Scroll Position
    dex
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Decrement Mode7 X Position
    dex
    stx.b Mode7PosX

  JoyRight:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish // IF (RIGHT ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Increment BG1 Horizontal Scroll Position
    inx
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Increment Mode7 X Position
    inx
    stx.b Mode7PosX

Finish:
  jmp InputLoop

HDMATable0: // X Zoom Values
  db 32; dw $0400 // Repeat 32 Scanlines, Zoom Value 1 (Sun)
  db 32; dw $0400 // Repeat 32 Scanlines, Zoom Value 2 (Sun)
  db 32; dw $0300 // Repeat 32 Scanlines, Zoom Value 3 (Trees)
  db 24; dw $0300 // Repeat 24 Scanlines, Zoom Value 6 (Trees)
  db 24; dw $0200 // Repeat 24 Scanlines, Zoom Value 7 (Pipes)

  db  1; dw $0200 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01F8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01F0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01E8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01E0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01D8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01D0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01C8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01C0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01B8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01B0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01A8 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $01A0 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0198 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0190 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0188 // Repeat  1 Scanlines, Zoom Value 9

  db  1; dw $0180 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $017C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0178 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0174 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0170 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $016C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0168 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0164 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0160 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $015C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0158 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0154 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0150 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $014C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0148 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0144 // Repeat  1 Scanlines, Zoom Value 9

  db  1; dw $0140 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $013C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0138 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0134 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0130 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $012C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0128 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0124 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0120 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $011C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0118 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0114 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0110 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $010C // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0108 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0104 // Repeat  1 Scanlines, Zoom Value 9

  db 32; dw $0100 // Repeat 32 Scanlines, Zoom Value 10
  db $00 // End Of HDMA


HDMATable1: // Y Zoom Values
  db 32; dw $0400 // Repeat 32 Scanlines, Zoom Value 1 (Sun)
  db 32; dw $0400 // Repeat 32 Scanlines, Zoom Value 2 (Sun)
  db 32; dw $0300 // Repeat 32 Scanlines, Zoom Value 3 (Trees)
  db 24; dw $0300 // Repeat 24 Scanlines, Zoom Value 6 (Trees)
  db 24; dw $0200 // Repeat 24 Scanlines, Zoom Value 7 (Pipes)

  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9

  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9

  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9
  db  1; dw $0800 // Repeat  1 Scanlines, Zoom Value 9

  db 32; dw $0200 // Repeat 32 Scanlines, Zoom Value 10
  db $00 // End Of HDMA

HDMATable2: // MODE7 Center Y Pos Values
  db 32; dw $0000 // Repeat 32 Scanlines, Center Y Pos Value 1 (Sun)
  db 32; dw $0000 // Repeat 32 Scanlines, Center Y Pos Value 2 (Sun)
  db 32; dw $01C0 // Repeat 32 Scanlines, Center Y Pos Value 3 (Trees)
  db 24; dw $01C0 // Repeat 24 Scanlines, Center Y Pos Value 6 (Trees)
  db 24; dw $0300 // Repeat 24 Scanlines, Center Y Pos Value 7 (Pipes)

  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9

  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9

  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9
  db  1; dw $0600 // Repeat  1 Scanlines, Center Y Pos Value 9

  db 32; dw $05C0 // Repeat 32 Scanlines, Center Y Pos Value 10
  db $00 // End Of HDMA

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap,   "GFX/BG.map" // Include BG Map Data (16384 Bytes)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (10112 Bytes)