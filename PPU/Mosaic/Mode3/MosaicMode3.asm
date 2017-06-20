// SNES Mosaic Mode3 Demo by krom (Peter Lemon):
// L Button = Decrement Mosaic Size
// R Button = Increment Mosaic Size
arch snes.cpu
output "MosaicMode3.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $18000 // Fill Upto $1FFFF (Bank 2) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  LoadVRAM(BGTiles, $0000, $8000, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGTiles + $10000, $8000, $6040, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F800, BGMap.size, 0) // Load Background Tile Map To VRAM

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 32x32, BG1 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  FadeIN() // Screen Fade In

lda.b #%00000001
sta.w REG_MOSAIC // $2106: Mosaic Size & Mosaic Enable
xba

InputLoop: 
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank
  WaitNMI() // Wait For Vertical Blank

  LButton:
    ReadJOY({JOY_L}) // Test L Button
    beq RButton      // IF (L ! Pressed) Branch Down
    xba // Decrement BG1 Mosaic Size
    sec
    sbc.b #$10
    sta.w REG_MOSAIC // $2106: Mosaic Size & Mosaic Enable
    xba

  RButton:
    ReadJOY({JOY_R}) // Test R Button
    beq Finish       // IF (R ! Pressed) Branch Down
    xba // Increment BG1 Mosaic Size
    clc
    adc.b #$10
    sta.w REG_MOSAIC // $2106: Mosaic Size & Mosaic Enable
    xba

  Finish:
    jmp InputLoop

// Character Data
// BANK 0
insert BGPal, "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap, "GFX/BG.map" // Include BG Map Data (2048 Bytes)
// BANK 1 & 2
seek($18000)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (57408 Bytes)