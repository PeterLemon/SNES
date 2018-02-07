// SNES Plot Line Mode7 Demo by krom (Peter Lemon):
arch snes.cpu
output "PlotLineMode7.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
X1:
  dw 0 // Line Point 1 X Word (X1)
Y1:
  dw 0 // Line Point 1 Y Byte (Y1)
X2:
  dw 0 // Line Point 2 X Word (X2)
Y2:
  dw 0 // Line Point 2 Y Byte (Y2)

DX:
  dw 0 // Line Delta X Byte (DX)
DY:
  dw 0 // Line Delta Y Byte (DY)

SX:
  dw 0 // Line Signed Change X Word (SX)
SY:
  dw 0 // Line Signed Change Y Word (SY)

P1:
  dw 0 // Point Start Word (P1)

Count:
  dw 0 // Line Count X/Y Byte (Count)

Error:
  dw 0 // Line Error X/Y Byte (Error)

seek($8000); Start:
  SNES_INIT(FASTROM) // Run SNES Initialisation Routine

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
  ldx.w #0   // X = Line Point 1 X (X1)
  stx.b X1   // Store X1
  ldx.w #0   // X = Line Point 1 Y (Y1)
  stx.b Y1   // Store Y1
  ldx.w #64 // X = Line Point 2 X (X2)
  stx.b X2   // Store X2
  ldx.w #127  // X = Line Point 2 Y (Y2)
  stx.b Y2   // Store Y2

  // Plot Line
  rep #%00100000 // A Set To 16-Bit
  lda.b X2 // A = Line Point 2 X (X2)
  sec // Set Carry
  sbc.b X1 // A = X2 - X1 (DX)
  bmi DXNEG
    ldx.w #1 // X = 1 (SX)
    bra DXSX
  DXNEG:
    eor.w #$FFFF // A ^= $FFFF
    inc // A = ABS(DX)
    ldx.w #-1 // X = -1 (SX)
  DXSX:
    sta.b DX // Store DX
    stx.b SX // Store SX

  lda.b Y2 // A = Line Point 2 Y (Y2)
  sec // Set Carry
  sbc.b Y1 // A = Y2 - Y1 (DY)
  bmi DYNEG
    ldx.w #128 // X = 128 (SY)
    bra DYSY
  DYNEG:
    eor.w #$FFFF // A ^= $FFFF
    inc // A = ABS(DY)
    ldx.w #-128 // X = -128 (SY)
  DYSY:
    sta.b DY // Store DY
    stx.b SY // Store SY

  lda.b Y1 // A = Line Point 1 Y
  xba // A *= 256
  and.w #$FF00 // Clear A
  lsr // A /= 2 (Line Point 1 Y * 128)
  adc.b X1 // A += Line Point 1 X
  sta.b P1 // Store Point Start (P1)

  lda.b DX // A = Delta X (DX)
  cmp.b DY // Compare DX To DY
  bmi YError    // IF (DX > DY) X Error = DX / 2
    sta.b Count // Store X Count
    lsr         // A = DX / 2
    sta.b Error // Store X Error
    bra LoopX   // Loop X
  YError:       // ELSE Y Error = DY / 2
    lda.b DY    // A = Delta Y (DY)
    sta.b Count // Store Y Count
    lsr         // A = DY / 2
    sta.b Error // Store Y Error
    bra LoopY   // Loop Y

  LoopX: // X Line Drawing
    lda.b P1 // A = Point Start (P1)
    sta.w REG_VMADDL // $2116: VRAM Address Write (16-Bit)
    clc // Clear Carry
    adc.b SX // P1 += SX
    sta.b P1 // Store P1
    sep #%00100000 // A Set To 8-Bit
    lda.b #1 // A = Pixel Color White
    sta.w REG_VMDATAL // $2118: VRAM Data Write (Lo 8-Bit)
    rep #%00100000 // A Set To 16-Bit
    dec.b Count // X Count--, Compare X Count To Zero
    bmi LineEnd // IF (X Count < 0) Line End

    lda.b Error // A = X Error
    sec // Set Carry
    sbc.b DY // X Error -= DY, Compare X Error To Zero
    sta.b Error // Store X Error
    bpl LoopX // Loop X
    clc // Clear Carry
    adc.b DX // IF (X Error < 0) X Error += DX
    sta.b Error // Store X Error
    lda.b P1 // A = Point Start (P1)
    clc // Clear Carry
    adc.b SY // IF (X Error < 0) Point Start += SY
    sta.b P1 // Store Point Start (P1)
    bra LoopX  // Loop X

  LoopY: // Y Line Drawing
    lda.b P1 // A = Point Start (P1)
    sta.w REG_VMADDL // $2116: VRAM Address Write (16-Bit)
    clc // Clear Carry
    adc.b SY // P1 += SY
    sta.b P1 // Store P1
    sep #%00100000 // A Set To 8-Bit
    lda.b #1 // A = Pixel Color White
    sta.w REG_VMDATAL // $2118: VRAM Data Write (Lo 8-Bit)
    rep #%00100000 // A Set To 16-Bit
    dec.b Count // Y Count--, Compare Y Count To Zero
    bmi LineEnd // IF (Y Count < 0) Line End

    lda.b Error // A = Y Error
    sec // Set Carry
    sbc.b DX // Y Error -= DX, Compare Y Error To Zero
    sta.b Error // Store Y Error
    bpl LoopY // Loop Y
    clc // Clear Carry
    adc.b DY // IF (Y Error < 0) Y Error += DY
    sta.b Error // Store X Error
    lda.b P1 // A = Point Start (P1)
    clc // Clear Carry
    adc.b SX // IF (Y Error < 0) Point Start += SX
    sta.b P1 // Store Point Start (P1)
    bra LoopY  // Loop Y

  LineEnd: // End of Line Drawing
  sep #%00100000 // A Set To 8-Bit

  lda.b #$F // Turn On Screen, Full Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop

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