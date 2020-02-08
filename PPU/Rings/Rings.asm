// SNES PPU Rings Demo by krom (Peter Lemon):
arch snes.cpu
output "Rings.sfc", create

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
BG1X:
  dw 0 // BG1 Position X Word
BG1Y:
  dw 0 // BG1 Position Y Word
BG2X:
  dw 0 // BG2 Position X Word
BG2Y:
  dw 0 // BG2 Position Y Word

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGRedPal, $00, BGRedPal.size, 0) // Load Background Palette (BG1 Palette Uses 4 Colors)
  LoadPAL(BGGreenPal, $20, BGGreenPal.size, 0) // Load Background Palette (BG2 Palette Uses 4 Colors)
  LoadVRAM(BGTiles, $0000, BGTiles.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $E000, BGMap.size, 0) // Load Background Tile Map To VRAM

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
  lda.b #%00000000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 0, BG1 & BG2 8x8 Tiles

  // Setup BG1 4 Colour Background
  lda.b #%11110011  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x64, BG1 Map Address = $E000 (VRAM Address / $400)
  
  // Setup BG2 4 Colour Background
  lda.b #%11110011  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG2SC   // $2108: BG2 64x64, BG2 Map Address = $E000 (VRAM Address / $400)

  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0, BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000011 // Enable BG1 & BG2
  sta.w REG_TM     // $212C: BG1 & BG2 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos Low Byte
  stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Pos High Byte
  stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Scroll Pos Low Byte
  stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Pos High Byte

  // Initialize Variables
  ldx.w #192
  stx.b BG1X // Store BG1 Position X Word
  WriteD16(BG1X, REG_BG1HOFS) // Write Memory To Double 8-bit (16-Bit)
  ldx.w #192
  stx.b BG1Y // Store BG1 Position Y Word
  WriteD16(BG1Y, REG_BG1VOFS) // Write Memory To Double 8-bit (16-Bit)
  ldx.w #64
  stx.b BG2X // Store BG2 Position X Word
  WriteD16(BG2X, REG_BG2HOFS) // Write Memory To Double 8-bit (16-Bit)
  ldx.w #96
  stx.b BG2Y // Store BG2 Position Y Word
  WriteD16(BG2Y, REG_BG2VOFS) // Write Memory To Double 8-bit (16-Bit)

  FadeIN() // Screen Fade In

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  Up:
    ReadJOY({JOY_UP}) // Test UP Button
    beq Down          // "UP" Not Pressed? Branch Down
    BGScroll16(BG1Y, REG_BG1VOFS, in) // Increment BG1 Y Pos

  Down:
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq Left            // "DOWN" Not Pressed? Branch Down
    BGScroll16(BG1Y, REG_BG1VOFS, de) // Decrement BG1 Y Pos

  Left:
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq Right           // "LEFT" Not Pressed? Branch Down
    BGScroll16(BG1X, REG_BG1HOFS, in) // Increment BG1 X Pos

  Right:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq XButton          // "RIGHT" Not Pressed? Branch Down
    BGScroll16(BG1X, REG_BG1HOFS, de) // Decrement BG1 X Pos

  XButton:
    ReadJOY({JOY_X}) // Test X Button
    beq BButton      // "X" Not Pressed? Branch Down
    BGScroll16(BG2Y, REG_BG2VOFS, in) // Increment BG2 Y Pos

  BButton:
    ReadJOY({JOY_B}) // Test B Button
    beq YButton      // "B" Not Pressed? Branch Down
    BGScroll16(BG2Y, REG_BG2VOFS, de) // Decrement BG2 Y Pos

  YButton:
    ReadJOY({JOY_Y}) // Test Y Button
    beq AButton      // "Y" Not Pressed? Branch Down
    BGScroll16(BG2X, REG_BG2HOFS, in) // Increment BG2 X Pos

  AButton:
    ReadJOY({JOY_A}) // Test A Button
    beq Finish       // "A" Not Pressed? Branch Down
    BGScroll16(BG2X, REG_BG2HOFS, de) // Decrement BG2 X Pos

  Finish:
    jmp InputLoop

// Character Data
// BANK 0
insert BGRedPal, "GFX\BGRed.pal" // Include BG Palette Data (8 Bytes)
insert BGGreenPal, "GFX\BGGreen.pal" // Include BG Palette Data (8 Bytes)
insert BGMap, "GFX\BG.map" // Include BG Map Data (8192 Bytes)
insert BGTiles, "GFX\BG.pic" // Include BG Tile Data (14640 Bytes)