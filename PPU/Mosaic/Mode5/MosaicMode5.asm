// SNES Mosaic Mode5 Demo by krom (Peter Lemon):
// L Button = Decrement Mosaic Size
// R Button = Increment Mosaic Size
arch snes.cpu
output "MosaicMode5.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
  LoadVRAM(BGTiles, $0000, BGTiles.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F200, BGMap.size, 0) // Load Background Tile Map To VRAM

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
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

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte

  lda.b #62 // Scroll BG 62 Pixels Up
  sta.w REG_BG1VOFS // Store A To BG Scroll Vertical Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG Scroll Vertical Position Hi Byte

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
insert BGPal,   "GFX/BG.pal" // Include BG Palette Data (32 Bytes)
insert BGMap,   "GFX/BG.map" // Include BG Map Data (3584 Bytes)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (16576 Bytes)