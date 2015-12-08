// SNES Plot Line Mode7 Demo by krom (Peter Lemon):
arch snes.cpu
output "PlotLineMode7.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB\SNES.INC"        // Include SNES Definitions
include "LIB\SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB\SNES_GFX.INC"    // Include Graphics Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
X0:
  dw 0 // Line X Coord 0 Word (X0)
Y0:
  db 0 // Line Y Coord 0 Byte (Y0)
X1:
  db 0 // Line X Coord 1 Byte (X1)
Y1:
  db 0 // Line Y Coord 1 Byte (Y1)

DX:
  db 0 // Line Distance X Byte (DX)
DY:
  db 0 // Line Distance Y Byte (DY)

SX:
  db 0 // Line Signed Change X Byte (SX)
SY:
  db 0 // Line Signed Change Y Byte (SY)

Error:
  db 0 // Line Error Byte (Error)

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, 4, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  ClearLOVRAM(BGTiles, $0000, 16384, 0) // Clear Background Map In VRAM To Static Byte
  LoadHIVRAM(BGTiles, $0000, 16384, 0)  // Load Background Tiles To VRAM
    
  // Setup Mode7 128x128 Linear Screen
  lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: Set BG1 To Main Screen Designation

  stz.w REG_M7SEL // $211A: MODE7 Settings

  lda.b #$04 // Set Mode7 X Scale
  stz.w REG_M7A // $211B: MODE7 COSINE A Lo Byte
  sta.w REG_M7A // $211B: MODE7 COSINE A Hi Byte

  stz.w REG_M7B // $211C: MODE7 SINE A Lo Byte
  stz.w REG_M7B // $211C: MODE7 SINE A Hi Byte

  stz.w REG_M7C // $211D: MODE7 SINE B Lo Byte
  stz.w REG_M7C // $211D: MODE7 SINE B Hi Byte

  lda.b #$90 // Set Mode7 Y Scale
  sta.w REG_M7D // $211E: MODE7 COSINE B Lo Byte
  lda.b #$04
  sta.w REG_M7D // $211E: MODE7 COSINE B Hi Byte

  stz.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
  stz.w REG_M7X // $211F: Mode7 Center Position X Hi Byte
  stz.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  stz.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte

  stz.w REG_VMAIN  // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)

  // Setup Variable Data
  ldx.w #40  // X = Line X Coord 0 (X0)
  stx.b X0   // WRAM: Line X Coord 0 (X0) = X (16-Bit)
  lda.b #48  // A = Line Y Coord 0 (Y0)
  sta.b Y0   // WRAM: Line Y Coord 0 (Y0) = A (8-Bit)
  lda.b #116 // A = Line X Coord 1 (X1)
  sta.b X1   // WRAM: Line X Coord 1 (X1) = A (8-Bit)
  lda.b #112 // A = Line Y Coord 1 (Y1)
  sta.b Y1   // WRAM: Line Y Coord 1 (Y1) = A (8-Bit)

  // Plot Line
  lda.b X0 // A = Line X Coord 0 (X0)
  cmp.b X1 // Compare X0 To X1
  bmi X1X0DX  // IF (X0 > X1) DX = (X0 - X1)
    sec       // Subtract X1 From X0 (DX)
    sbc.b X1  // A = DX (X0 - X1)
    sta.b DX  // WRAM: Line Distance X (DX) = A
    lda.b #-1 // SX = -1
    bra DXEnd // GOTO DX End
  X1X0DX:    // ELSE DX = (X1 - X0)
    lda.b X1 // A = Line X Coord 1 (X1)
    sec      // Subtract X0 From X1 (DX)
    sbc.b X0 // A = DX (X1 - X0)
    sta.b DX // WRAM: Line Distance X (DX) = A
    lda.b #1 // SX = 1
  DXEnd:
    sta.b SX // WRAM: Line Signed Change X (SX) = A

  lda.b Y0 // A = Line Y Coord 0 (Y0)
  cmp.b Y1 // Compare Y0 To Y1
  bmi Y1Y0DY  // IF (Y0 > Y1) DY = (Y0 - Y1)
    sec       // Subtract Y1 From Y0 (DY)
    sbc.b Y1  // A = DY (Y0 - Y1)
    sta.b DY  // WRAM: Line Distance Y (DY) = A
    lda.b #-1 // SY = -1
    bra DYEnd // GOTO DY End
  Y1Y0DY:    // ELSE DY = (Y1 - Y0)
    lda.b Y1 // A = Line Y Coord 1 (Y1)
    sec      // Subtract Y0 From Y1 (DY)
    sbc.b Y0 // A = DY (Y1 - Y0)
    sta.b DY // WRAM: Line Distance Y (DY) = A
    lda.b #1 // SY = 1
  DYEnd:
    sta.b SY // WRAM: Line Signed Change Y (SY) = A

  lda.b DX // A = Line Distance X (DX)
  cmp.b DY // Compare DX To DY
  bmi YError    // IF (DX > DY) Error = DX / 2
    lsr         // A = DX / 2
    sta.b Error // WRAM: Line Error (Error) = A
    bra LoopX   // GOTO Loop X
  YError:       // ELSE Error = DY / 2
    lda.b DY    // A = Line Distance Y (DY)
    lsr         // A = DY / 2
    sta.b Error // WRAM: Line Error (Error) = A
    bra LoopY   // GOTO Loop Y

  LoopX: // X Line Drawing
    jsr PlotPixel // GOTO Plot Pixel Subroutine

    lda.b X0 // A = Line X Coord 0 (X0)
    cmp.b X1 // While (X0 != X1)
    beq LineEnd // IF (X0 == X1) Branch To Line End
    lda.b Error // A = Line Error (Error)
    sec         // Subtract DY From Error (Error -= DY)
    sbc.b DY    // A = Error - DY
    sta.b Error // WRAM: Line Error (Error) = A

    bpl LoopXEnd // IF (Error >= 0) GOTO Loop X End
    lda.b Y0 // A = Line Y Coord 0 (Y0)
    clc      // ELSE Add SY To Y0 (Y0 += SY)
    adc.b SY // A += SY
    sta.b Y0 // WRAM: Line Y Coord 0 (Y0) = A
    lda.b Error // A = Line Error (Error)
    clc         // Add DX To Error (Error += DX)
    adc.b DX    // A += DX
    sta.b Error // WRAM: Line Error (Error) = A

    LoopXEnd:
      lda.b X0 // A = Line X Coord 0 (X0)
      clc      // Add SX To X0 (X0 += SX)
      adc.b SX // A += SX
      sta.b X0 // WRAM: Line X Coord 0 (X0) = A
    bra LoopX  // GOTO X Line Drawing

  LoopY: // Y Line Drawing
    jsr PlotPixel // GOTO Plot Pixel Subroutine

    lda.b Y0 // A = Line Y Coord 0 (Y0)
    cmp.b Y1 // While (Y0 != Y1)
    beq LineEnd // IF (Y0 == Y1) Branch To Line End
    lda.b Error // A = Line Error (Error)
    sec         // Subtract DX From Error (Error -= DX)
    sbc.b DX    // A = Error - DX
    sta.b Error // WRAM: Line Error (Error) = A

    bpl LoopYEnd // IF (Error >= 0) GOTO Loop Y End
    lda.b X0 // A = Line X Coord 0 (X0)
    clc      // ELSE Add SX To X0 (X0 += SX)
    adc.b SX // A += SX
    sta.b X0 // WRAM: Line X Coord 0 (X0) = A
    lda.b Error // A = Line Error (Error)
    clc         // Add DY To Error (Error += DY)
    adc.b DY    // A += DY
    sta.b Error // WRAM: Line Error (Error) = A

    LoopYEnd:
      lda.b Y0 // A = Line Y Coord 0 (Y0)
      clc      // Add SY To Y0 (Y0 += SY)
      adc.b SY // A += SY
      sta.b Y0 // WRAM: Line Y Coord 0 (Y0) = A
    bra LoopY  // GOTO Y Line Drawing

  LineEnd: // End of Line Drawing

  lda.b #$F // Turn On Screen, Full Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop

PlotPixel: // Plot Pixel
  lda.b Y0 // A = Plot Y Coord
  rep #%00100000 // A Set To 16-Bit
  asl
  asl
  asl
  asl
  asl
  asl
  asl // A *= 128
  clc
  adc.b X0 // A += Plot X Coord (A = VRAM Address)
  sta.w REG_VMADDL // $2116: VRAM Address Write (16-Bit)
  sep #%00100000 // A Set To 8-Bit
  lda.b #1 // A = Pixel Color White
  sta.w REG_VMDATAL // $2118: VRAM Data Write (Lo 8-Bit)
  rts // Return From Subroutine

BGPal:
  dw $0000, $7FFF // Black, White (4 Bytes)

BGTiles: // Include BG Tile Data (16384 Bytes)
  define i(0)
  while {i} < 256 { // Create 256 Tiles Which Map To 256 Palette Colors
    db {i},{i},{i},{i},{i},{i},{i},{i} // Clear Tile/Pixel Color = ($00)
    db {i},{i},{i},{i},{i},{i},{i},{i} // Rest Of Colors ($01..$FF)
    db {i},{i},{i},{i},{i},{i},{i},{i}
    db {i},{i},{i},{i},{i},{i},{i},{i}
    db {i},{i},{i},{i},{i},{i},{i},{i}
    db {i},{i},{i},{i},{i},{i},{i},{i}
    db {i},{i},{i},{i},{i},{i},{i},{i}
    db {i},{i},{i},{i},{i},{i},{i},{i}
    evaluate i({i} + 1)
  }