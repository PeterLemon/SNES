// SNES Mode7 Perspective Demo by krom (Peter Lemon):
// Direction Pad Changes BG Mode7 X/Z Position
// L/R Buttons Rotate BG Mode7 Clockwise/Anti-Clockwise
// X/B Buttons Changes BG Mode7 FOV (Mode7 Distance)
// Y/A Buttons Changes BG Mode7 Perspective Center Position
arch snes.cpu
output "Perspective.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $20000 // Fill Upto $FFFF (Bank 3) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
Mode7PosX:
  dw 0 // Mode7 Center Position X Word
Mode7PosY:
  dw 0 // Mode7 Center Position Y Word
BG1ScrPosX:
  dw 0 // Mode7 BG1 Scroll Position X Word
BG1ScrPosY:
  dw 0 // Mode7 BG1 Scroll Position Y Word

Mode7Angle:
  db 0 // Mode7 Angle 0..15

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

  lda.b #$80
  sta.w REG_M7SEL // $211A: Mode7 Settings



  ldx.w #384 // BG1HOFS = 384
  stx.b BG1ScrPosX

  ldx.w #768 // BG1VOFS = 768
  stx.b BG1ScrPosY

  ldx.w #512 // M7X = 512
  stx.b Mode7PosX

  ldx.w #1152 // M7Y = 1152
  stx.b Mode7PosY

  stz.b Mode7Angle // Mode7 Angle = 0



  // HDMA Mode7 +COS (A) Scanline     
  lda.b #%00000010 // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_M7A   // $1B: Start At MODE7 COSINE A ($211B)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #M7COSTable0 // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #1         // HDMA Table Bank
  sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

  // HDMA Mode7 +SIN (B) Scanline
  lda.b #%00000010 // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP1  // $4310: DMA1 DMA/HDMA Parameters
  lda.b #REG_M7B   // $1C: Start At MODE7 SINE A ($211C)
  sta.w REG_BBAD1  // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #M7SINTable0 // HMDA Table Address
  stx.w REG_A1T1L  // $4312: DMA1 DMA/HDMA Table Start Address
  lda.b #2         // HDMA Table Bank
  sta.w REG_A1B1   // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

  // HDMA Mode7 -SIN (C) Scanline
  lda.b #%00000010 // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP2  // $4320: DMA2 DMA/HDMA Parameters
  lda.b #REG_M7C   // $1D: Start At MODE7 SINE B ($211D)
  sta.w REG_BBAD2  // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #M7NSINTable0 // HMDA Table Address
  stx.w REG_A1T2L  // $4322: DMA2 DMA/HDMA Table Start Address
  lda.b #3         // HDMA Table Bank
  sta.w REG_A1B2   // $4324: DMA2 DMA/HDMA Table Start Address (Bank)

  // HDMA Mode7 +COS (D) Scanline     
  lda.b #%00000010 // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP3  // $4330: DMA3 DMA/HDMA Parameters
  lda.b #REG_M7D   // $1E: Start At MODE7 COSINE B ($211E)
  sta.w REG_BBAD3  // $4331: DMA3 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #M7COSTable0 // HMDA Table Address
  stx.w REG_A1T3L  // $4332: DMA3 DMA/HDMA Table Start Address
  lda.b #1         // HDMA Table Bank
  sta.w REG_A1B3   // $4334: DMA3 DMA/HDMA Table Start Address (Bank)

  lda.b #%00001111 // HDMA Channel Select (Channel 0,1,2,3)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

  lda.b #$F // Turn On Screen, Full Brightness
  sta.w REG_INIDISP // $2100: Screen Display

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

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

  lda.b Mode7Angle // A = Mode7 Angle
  asl // A * 2
  tax // X = A
  ldy.w M7COSTable,x // HMDA Table Address
  sty.w REG_A1T0L   // $4302: DMA0 DMA/HDMA Table Start Address
  sty.w REG_A1T1L   // $4312: DMA1 DMA/HDMA Table Start Address
  sty.w REG_A1T2L   // $4322: DMA2 DMA/HDMA Table Start Address
  sty.w REG_A1T3L   // $4332: DMA3 DMA/HDMA Table Start Address

  JoyL:
    ReadJOY({JOY_L}) // Test L Button
    beq JoyR // IF (L ! Pressed) Branch Down
    lda.b Mode7Angle
    inc
    cmp.b #$30
    bne JoyLEnd
    lda.b #$00
    JoyLEnd:
    sta.b Mode7Angle

  JoyR:
    ReadJOY({JOY_R}) // Test R Button
    beq JoyUp // IF (R ! Pressed) Branch Down
    lda.b Mode7Angle
    dec
    cmp.b #$FF
    bne JoyREnd
    lda.b #$2F
    JoyREnd:
    sta.b Mode7Angle

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
    beq JoyY // IF (RIGHT ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Increment BG1 X Pos
    inx
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Increment Mode7 X Pos
    inx
    stx.b Mode7PosX

  JoyY:
    ReadJOY({JOY_Y}) // Test Y Button
    beq JoyA // IF (Y ! Pressed) Branch Down
    ldx.b Mode7PosX // Decrement Mode7 X Pos
    dex
    stx.b Mode7PosX

  JoyA:
    ReadJOY({JOY_A}) // Test A Button
    beq JoyX // IF (A ! Pressed) Branch Down
    ldx.b Mode7PosX // Increment Mode7 X Pos
    inx
    stx.b Mode7PosX

  JoyX:
    ReadJOY({JOY_X}) // Test X Button
    beq JoyB // IF (X ! Pressed) Branch Down
    ldx.b Mode7PosY // Decrement Mode7 Y Pos
    dex
    stx.b Mode7PosY

  JoyB:
    ReadJOY({JOY_B}) // Test B Button
    beq Finish // IF (B ! Pressed) Branch Down
    ldx.b Mode7PosY // Increment Mode7 Y Pos
    inx
    stx.b Mode7PosY

Finish:
  jmp InputLoop

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap,   "GFX/BG.map" // Include BG Map Data (16384 Bytes)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (10944 Bytes)

M7COSTable:
  dw M7COSTable0
  dw M7COSTable1
  dw M7COSTable2
  dw M7COSTable3
  dw M7COSTable4
  dw M7COSTable5
  dw M7COSTable6
  dw M7COSTable7
  dw M7COSTable8
  dw M7COSTable9
  dw M7COSTable10
  dw M7COSTable11
  dw M7COSTable12
  dw M7COSTable13
  dw M7COSTable14
  dw M7COSTable15
  dw M7COSTable16
  dw M7COSTable17
  dw M7COSTable18
  dw M7COSTable19
  dw M7COSTable20
  dw M7COSTable21
  dw M7COSTable22
  dw M7COSTable23
  dw M7COSTable24
  dw M7COSTable25
  dw M7COSTable26
  dw M7COSTable27
  dw M7COSTable28
  dw M7COSTable29
  dw M7COSTable30
  dw M7COSTable31
  dw M7COSTable32
  dw M7COSTable33
  dw M7COSTable34
  dw M7COSTable35
  dw M7COSTable36
  dw M7COSTable37
  dw M7COSTable38
  dw M7COSTable39
  dw M7COSTable40
  dw M7COSTable41
  dw M7COSTable42
  dw M7COSTable43
  dw M7COSTable44
  dw M7COSTable45
  dw M7COSTable46
  dw M7COSTable47

// BANK 1
seek($18000)
include "M7COSTable.asm" // Include Mode7 +COS (A & D) Table

// BANK 2
seek($28000)
include "M7SINTable.asm" // Include Mode7 +SIN (B) Table

// BANK 3
seek($38000)
include "M7NSINTable.asm" // Include Mode7 -SIN (C) Table