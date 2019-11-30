// SNES SPC700 CPU Test INC (Increment) demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "SPC700INC.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

macro PrintText(SRC, DEST, SIZE) { // Print Text Characters To VRAM
  stz.w REG_VMAIN    // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM

  ldx.w #0 // X = 0      Number Of Text Characters To Print
  {#}LoopText:
    lda.w {SRC},x // A = Text Data
    sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
    inx // X++
    cpx.w #{SIZE}
    bne {#}LoopText // IF (X != 0) Loop Text Characters
}

macro PrintValue(SRC, DEST, SIZE) { // Print HEX Characters To VRAM
  stz.w REG_VMAIN    // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM Address

  lda.b #$24 // A = "$"
  sta.w REG_VMDATAL // Store Text To VRAM Lo Byte

  ldx.w #{SIZE} // X = Number Of Hex Characters To Print

  {#}LoopHEX:
    dex // X--
    ldy.w #0002 // Y = 2 (Char Count)

    lda.w {SRC},x // A = Result Data
    lsr // A >>= 4
    lsr
    lsr
    lsr // A = Result Hi Nibble

    {#}LoopChar:
      cmp.b #10 // Compare Hi Nibble To 9
      clc // Clear Carry Flag
      bpl {#}HexLetter
      adc.b #$30 // Add Hi Nibble To ASCII Numbers
      sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
      bra {#}HexEnd
      {#}HexLetter:
      adc.b #$37 // Add Hi Nibble To ASCII Letters
      sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
      {#}HexEnd:
  
      lda.w {SRC},x // A = Result Data
      and.b #$F // A = Result Lo Nibble
      dey // Y--
      bne {#}LoopChar // IF (Char Count != 0) Loop Char

    cpx.w #0 // Compare X To 0
    bne {#}LoopHEX // IF (X != 0) Loop Hex Characters
}

macro PrintPSW(SRC, DEST) { // Print Processor Status Flags To VRAM
  stz.w REG_VMAIN    // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM Address

  lda.b #%10000000 // A = Negative Flag Bit
  jsr {#}PSWFlagTest // Test PSW Flag Data

  lda.b #%01000000 // A = Overflow Flag Bit
  jsr {#}PSWFlagTest // Test PSW Flag Data

  lda.b #%00001000 // A = Half-carry Flag Bit
  jsr {#}PSWFlagTest // Test PSW Flag Data

  lda.b #%00000010 // A = Zero Flag Bit
  jsr {#}PSWFlagTest // Test PSW Flag Data

  lda.b #%00000001 // A = Carry Flag Bit
  jsr {#}PSWFlagTest // Test PSW Flag Data

  bra {#}PSWEnd

  {#}PSWFlagTest:
    bit.w {SRC} // Test Processor Status Flag Data Bit
    bne {#}PSWFlagSet
    lda.b #$30 // A = "0"
    sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
    rts // Return From Subroutine
    {#}PSWFlagSet:
    lda.b #$31 // A = "1"
    sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
    rts // Return From Subroutine

  {#}PSWEnd:
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPAL, $00, 4, 0) // Load BG Palette Data
  LoadLOVRAM(BGCHR, $0000, $3F8, 0) // Load 1BPP Tiles To VRAM Lo Bytes (Converts To 2BPP Tiles)
  ClearVRAM(BGCLEAR, $F800, $400, 0) // Clear VRAM Map To Fixed Tile Word

  // Setup Video
  lda.b #%00001000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 1, BG1 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2108: BG1 32x32, BG1 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

  SPCWaitBoot() // Wait For SPC To Boot
  TransferBlockSPC(SPCROM, SPCRAM, SPCROM.size) // Load SPC File To SMP/DSP
  SPCExecute(SPCRAM) // Execute SPC At $0200

  WaitNMI() // Wait For VSync

  // Print Title Text
  PrintText(Title, $F882, 25) // Load Text To VRAM Lo Bytes

  // Print Page Break Text
  PrintText(PageBreak, $F8C2, 30) // Load Text To VRAM Lo Bytes

  // Print Syntax/Opcode Text
  PrintText(INCA, $F902, 26) // Load Text To VRAM Lo Bytes

  // Print Key Text
  PrintText(Key, $F982, 30) // Load Text To VRAM Lo Bytes

  // Print Page Break Text
  PrintText(PageBreak, $F9C2, 30) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait1:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$01
    bne Wait1
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$81
  bne PASS1
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail1:
    bra Fail1
  PASS1:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait2:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$02
    bne Wait2
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$82
  bne PASS2
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail2:
    bra Fail2
  PASS2:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait3:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$03
    bne Wait3
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCAddr, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$83
  bne PASS3
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail3:
    bra Fail3
  PASS3:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait4:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$04
    bne Wait4
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$84
  bne PASS4
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail4:
    bra Fail4
  PASS4:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes



  /////////////////////////////////////////////////////////////////
  Wait5:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$05
    bne Wait5
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCDP, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$85
  bne PASS5
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail5:
    bra Fail5
  PASS5:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait6:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$06
    bne Wait6
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$86
  bne PASS6
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail6:
    bra Fail6
  PASS6:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait7:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$07
    bne Wait7
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCDPX, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$87
  bne PASS7
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail7:
    bra Fail7
  PASS7:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait8:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$08
    bne Wait8
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$88
  bne PASS8
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail8:
    bra Fail8
  PASS8:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait9:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$09
    bne Wait9
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCX, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$89
  bne PASS9
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail9:
    bra Fail9
  PASS9:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait10:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$0A
    bne Wait10
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$8A
  bne PASS10
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail10:
    bra Fail10
  PASS10:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait11:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$0B
    bne Wait11
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCY, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$8B
  bne PASS11
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail11:
    bra Fail11
  PASS11:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait12:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$0C
    bne Wait12
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 1) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$8C
  bne PASS12
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail12:
    bra Fail12
  PASS12:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes


  /////////////////////////////////////////////////////////////////
  Wait13:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$0D
    bne Wait13
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $80, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync

  // Print Syntax/Opcode Text
  PrintText(INCW, $F902, 26) // Load Text To VRAM Lo Bytes
  
  /////////////////////////////////////////////////////////////////
  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA10, 2) // Print Result Data
  PrintPSW(REG_APUIO1, $FA22) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$8D
  bne PASS13
  PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
  Fail13:
    bra Fail13
  PASS13:
  PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  Wait14:
    lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
    and.b #$7F
    cmp.b #$0E
    bne Wait14
  WaitNMI() // Wait For VSync

  // Print Result & Processor Status Flag Data
  PrintValue(REG_APUIO2, $FA50, 2) // Print Result Data
  PrintPSW(REG_APUIO1, $FA62) // Print Processor Status Flag Data

  lda.w REG_APUIO0 // Load Handshake Between CPU<->APU
  cmp.b #$8E
  bne PASS14
  PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
  Fail14:
    bra Fail14
  PASS14:
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes

Loop:
  jmp Loop

Title:
  db "SPC Test INC (Increment):"

PageBreak:
  db "------------------------------"

Key:
  db "       Result | NVHZC | Test |"
Fail:
  db "FAIL"
Pass:
  db "PASS"

INCA:
  db "INC A        (Opcode: $BC)"
INCAddr:
  db "INC addr     (Opcode: $AC)"
INCDP:
  db "INC dp       (Opcode: $AB)"
INCDPX:
  db "INC dp,X     (Opcode: $BB)"
INCX:
  db "INX          (Opcode: $3D)"
INCY:
  db "INY          (Opcode: $FC)"
INCW:
  db "INW dp       (Opcode: $3A)"

BGCHR:
  include "Font8x8.asm" // Include BG 1BPP 8x8 Tile Font Character Data (1016 Bytes)
BGPAL:
  dw $7800, $7FFF // Blue / White Palette (4 Bytes)
BGCLEAR:
  dw $0020 // BG Clear Character Space " " Fixed Word

// SPC Code
// BANK 0
insert SPCROM, "SPC700INC.spc"