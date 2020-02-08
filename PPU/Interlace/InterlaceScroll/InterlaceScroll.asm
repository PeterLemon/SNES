// SNES Interlace Scroll Demo by krom (Peter Lemon):
arch snes.cpu
output "InterlaceScroll.sfc", create

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
  LoadVRAM(BGMap, $4000, BGMap.size, 0) // Load Background Tile Map To VRAM
  LoadVRAM(BGTiles, $8000, BGTiles.size, 0) // Load Background Tiles To VRAM

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
  lda.b #%00001101 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 5, Priority 1, BG1 16x8 tiles

  lda.b #%00000001 // Sets Interlace Mode On
  sta.w REG_SETINI // $2133: Screen Mode Select

  // Setup BG1 16 Color Background
  lda.b #%00100011  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x64, BG1 Map Address = $4000 (VRAM Address / $400)
  lda.b #%00000100  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $8000 (VRAM Address / $1000)

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation
  sta.w REG_TS // $212D: BG1 To Sub Screen Designation (Needed To Show Interlace GFX)

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte

  FadeIN() // Screen Fade In

ldx.w #$0000 // Reset BG X Position
ldy.w #$0000 // Reset BG Y Position

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  Up:
    ReadJOY({JOY_UP}) // Test Joypad UP Button
    beq Down          // IF (UP ! Pressed) Branch Down
    BGScroll8I(y, REG_BG1VOFS, de) // Decrement BG1 Vertical Scroll Position

  Down:
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq Left            // IF (DOWN ! Pressed) Branch Down
    BGScroll8I(y, REG_BG1VOFS, in) // Increment BG1 Vertical Scroll Position

  Left:
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq Right           // IF (LEFT ! Pressed) Branch Down
    BGScroll8I(x, REG_BG1HOFS, de) // Decrement BG1 Horizontal Scroll Position

  Right:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish           // IF (RIGHT ! Pressed) Branch Down
    BGScroll8I(x, REG_BG1HOFS, in) // Increment BG1 Horizontal Scroll Position

  Finish:
    jmp InputLoop

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Palette Data (32 Bytes)
insert BGMap,   "GFX/BG.map" // Include BG Map Data (8192 Bytes)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (128 Bytes)