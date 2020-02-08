// SNES PPU BG 8x8 8BPP 64x32 Demo by krom (Peter Lemon):
arch snes.cpu
output "8x8BGMap8BPP64x32.sfc", create

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
  LoadVRAM(BGMap, $0000, BGMap.size, 0) // Load Background Tile Map To VRAM
  LoadVRAM(BGTiles, $2000, BGTiles.size, 0) // Load VRAM SRCDATA, DEST, SIZE, CHAN

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%00000001  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x32, BG1 Map Address = $0000 (VRAM Address / $400)
  lda.b #%00000001  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $2000 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  FadeIN() // Screen Fade In

ldx.w #$0000 // Reset BG X Position
ldy.w #$0000 // Reset BG Y Position

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  Up:
    cpy.w #$0000 // Check If At Top Of Screen
    beq Down     // Skip BG Scrolling If Top
    ReadJOY({JOY_UP}) // Test UP Button
    beq Down          // "UP" Not Pressed? Branch Down
    BGScroll8I(y, REG_BG1VOFS, de) // Decrement BG1 Y Pos

  Down:
    cpy.w #$001F // Check If At Bottom Of Screen
    beq Left     // Skip BG Scrolling If Bottom
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq Left            // "DOWN" Not Pressed? Branch Down
    BGScroll8I(y, REG_BG1VOFS, in) // Increment BG1 Y Pos

  Left:
    cpx.w #$0000 // Check If At Left Of Screen
    beq Right    // Skip BG Scrolling If Left
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq Right           // "LEFT" Not Pressed? Branch Down
    BGScroll8I(x, REG_BG1HOFS, de) // Decrement BG1 X Pos

  Right:
    cpx.w #$00FF // Check If At Right Of Screen
    beq Finish   // Skip BG Scrolling If Right
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish           // "RIGHT" Not Pressed? Branch Down
    BGScroll8I(x, REG_BG1HOFS, in) // Increment BG1 X Pos

  Finish:
    jmp InputLoop

// Character Data
// BANK 0
insert BGPal, "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap, "GFX/BG.map" // Include BG Map Data (4096 Bytes)
// BANK 1 & 2
seek($18000)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (32384 Bytes)