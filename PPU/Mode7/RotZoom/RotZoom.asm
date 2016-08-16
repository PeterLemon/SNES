// SNES Mode7 Rotation & Zoom Demo by krom (Peter Lemon):
arch snes.cpu
output "RotZoom.sfc", create

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
Mode7Angle:
  db 0 // Mode7 Angle Byte
Mode7A:
  dw 0 // Mode7 COS A Word
Mode7B:
  dw 0 // Mode7 SIN A Word
Mode7C:
  dw 0 // Mode7 SIN B Word
Mode7D:
  dw 0 // Mode7 COS B Word
Mode7ScaleX:
  dw 0 // Mode7 Scale X Word
Mode7ScaleY:
  dw 0 // Mode7 Scale Y Word
Mode7PosX:
  dw 0 // Mode7 Center Position X Word
Mode7PosY:
  dw 0 // Mode7 Center Position Y Word
BG1ScrPosX:
  dw 0 // Mode7 BG1 Scroll Position X Word
BG1ScrPosY:
  dw 0 // Mode7 BG1 Scroll Position Y Word

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
  sta.w REG_TM // $212C: Set BG1 To Main Screen Designation

  stz.w REG_M7SEL // $211A: Mode7 Settings

  stz.b Mode7Angle // Reset Angle

  ldx.w #$0000     // Reset BG Position
  stx.b BG1ScrPosX
  stx.b BG1ScrPosY

  ldx.w #$0100     // Reset Scale
  stx.b Mode7ScaleX
  stx.b Mode7ScaleY

  ldx.w #$0080     // Reset Mode7 Center Position
  stx.b Mode7PosX
  stx.b Mode7PosY

  lda.b #$80
  sta.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
  stz.w REG_M7X // $211F: Mode7 Center Position X Hi Byte
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  stz.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  lda.b #$F // Turn On Screen, Full Brightness
  sta.w REG_INIDISP // $2100: Screen Display

InputLoop: 
  WaitNMI() // Wait For Vertical Blank
  Mode7CALC(Mode7A, Mode7B, Mode7C, Mode7D, Mode7Angle, Mode7ScaleX, Mode7ScaleY, SINCOS256) // Calculate Mode 7 matrix

  lda.b BG1ScrPosX
  sta.w REG_BG1HOFS // $210D: BG1 Position X Lo Byte
  lda.b BG1ScrPosX + 1
  sta.w REG_BG1HOFS // $210D: BG1 Position X Hi Byte

  lda.b BG1ScrPosY
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
  lda.b BG1ScrPosY + 1
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

  lda.b Mode7PosX
  sta.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
  lda.b Mode7PosX + 1
  sta.w REG_M7X // $211F: Mode7 Center Position X Hi Byte

  lda.b Mode7PosY
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  lda.b Mode7PosY + 1
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  JoyA:
    ReadJOY({JOY_A}) // Test A Button
    beq JoyB // IF (A ! Pressed) Branch Down
    ldx.w Mode7ScaleX
    inx
    stx.w Mode7ScaleX
    stx.w Mode7ScaleY

  JoyB:
    ReadJOY({JOY_B}) // Test B Button
    beq JoyL // IF (B ! Pressed) Branch Down
    ldx.w Mode7ScaleX
    dex
    stx.w Mode7ScaleX
    stx.w Mode7ScaleY

  JoyL:
    ReadJOY({JOY_L}) // Test L Button
    beq JoyR // IF (L ! Pressed) Branch Down
    dec.b Mode7Angle

  JoyR:
    ReadJOY({JOY_R}) // Test R Button
    beq JoyUp // IF (R ! Pressed) Branch Down
    inc.b Mode7Angle

  JoyUp:
    ReadJOY({JOY_UP}) // Test Joypad UP Button
    beq JoyDown // IF (UP ! Pressed) Branch Down
    ldx.b BG1ScrPosY // Decrement BG1 Y Pos
    dex
    stx.b BG1ScrPosY

    ldx.b Mode7PosY // Decrement Mode7 Y Pos
    dex
    stx.b Mode7PosY

  JoyDown:
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq JoyLeft // IF (DOWN ! Pressed) Branch Down
    ldx.b BG1ScrPosY // Increment BG1 Y Pos
    inx
    stx.b BG1ScrPosY

    ldx.b Mode7PosY // Increment Mode7 Y Pos
    inx
    stx.b Mode7PosY

  JoyLeft:
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq JoyRight // IF (LEFT ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Decrement BG1 X Pos
    dex
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Decrement Mode7 X Pos
    dex
    stx.b Mode7PosX

  JoyRight:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish // IF (RIGHT ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Increment BG1 X Pos
    inx
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Increment Mode7 X Pos
    inx
    stx.b Mode7PosX

Finish:
  jmp InputLoop

// Const Data
SINCOS256: // 256 SINE Values Ranging From -127 To 127 (Add 64 To Offset To Get COS)
  db    0,    3,    6,    9,   12,   16,   19,   22
  db   25,   28,   31,   34,   37,   40,   43,   46
  db   48,   51,   54,   57,   60,   62,   65,   68
  db   70,   73,   75,   78,   80,   83,   85,   87
  db   90,   92,   94,   96,   98,  100,  102,  104
  db  105,  107,  109,  110,  112,  113,  115,  116
  db  117,  118,  119,  120,  121,  122,  123,  124
  db  124,  125,  126,  126,  126,  127,  127,  127
  db  127,  127,  127,  127,  126,  126,  126,  125
  db  125,  124,  123,  123,  122,  121,  120,  119
  db  118,  116,  115,  114,  112,  111,  109,  108
  db  106,  104,  102,  101,   99,   97,   95,   93
  db   90,   88,   86,   84,   81,   79,   76,   74
  db   71,   69,   66,   63,   61,   58,   55,   52
  db   49,   47,   44,   41,   38,   35,   32,   29
  db   26,   23,   20,   17,   14,   10,    7,    4
  db    1,   -2,   -5,   -8,  -11,  -14,  -17,  -21
  db  -24,  -27,  -30,  -33,  -36,  -39,  -42,  -45
  db  -47,  -50,  -53,  -56,  -59,  -61,  -64,  -67
  db  -69,  -72,  -75,  -77,  -80,  -82,  -84,  -87
  db  -89,  -91,  -93,  -95,  -97,  -99, -101, -103
  db -105, -107, -108, -110, -111, -113, -114, -115
  db -117, -118, -119, -120, -121, -122, -123, -124
  db -124, -125, -125, -126, -126, -127, -127, -127
  db -127, -127, -127, -127, -127, -126, -126, -125
  db -125, -124, -124, -123, -122, -121, -120, -119
  db -118, -117, -116, -114, -113, -111, -110, -108
  db -107, -105, -103, -101,  -99,  -97,  -95,  -93
  db  -91,  -89,  -87,  -84,  -82,  -80,  -77,  -75
  db  -72,  -70,  -67,  -64,  -62,  -59,  -56,  -53
  db  -51,  -48,  -45,  -42,  -39,  -36,  -33,  -30
  db  -27,  -24,  -21,  -18,  -15,  -12,   -8,   -5

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap,   "GFX/BG.map" // Include BG Map Data (16384 Bytes)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (10944 Bytes)