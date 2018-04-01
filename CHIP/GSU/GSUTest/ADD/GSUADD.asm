// SNES GSU Test ADD (Addition) demo by krom (Peter Lemon):
arch snes.cpu
output "GSUADD.sfc", create

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

macro PrintSFR(SRC, DEST) { // Print GSU Status Flags To VRAM
  stz.w REG_VMAIN    // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM Address

  lda.b #%00010000 // A = Overflow Flag Bit
  jsr {#}SFRFlagTest // Test SFR Flag Data

  lda.b #%00001000 // A = Sign Flag Bit
  jsr {#}SFRFlagTest // Test SFR Flag Data

  lda.b #%00000100 // A = Carry Flag Bit
  jsr {#}SFRFlagTest // Test SFR Flag Data

  lda.b #%00000010 // A = Zero Flag Bit
  jsr {#}SFRFlagTest // Test SFR Flag Data

  bra {#}SFREnd

  {#}SFRFlagTest:
    bit.b {SRC} // Test GSU Status Flag Data Bit
    bne {#}SFRFlagSet
    lda.b #$30 // A = "0"
    sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
    rts // Return From Subroutine
    {#}SFRFlagSet:
    lda.b #$31 // A = "1"
    sta.w REG_VMDATAL // Store Text To VRAM Lo Byte
    rts // Return From Subroutine

  {#}SFREnd:
}

macro GSUWait() { // Wait For GSU To Finish
{#}GSUBusy:
    lda.w GSU_SFR // X = GSU Status/Flag Register
    bit.b #GSU_SFR_GSU // Check GSU Is Running
    bne {#}GSUBusy
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_GSU.INC"    // Include GSU Definitions

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
ResultData:
  dw 0 // GSU Result Data Word
SFRFlagData:
  dw 0 // GSU Status/Flag Register Data Word

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPAL, $00, 4, 0) // Load BG Palette Data
  LoadLOVRAM(BGCHR, $0000, $3F8, 0) // Load 1BPP Tiles To VRAM Lo Bytes (Converts To 2BPP Tiles)
  ClearVRAM(BGCLEAR, $F800, $400, 0) // Clear VRAM Map To Fixed Tile Word

  // Setup Video
  lda.b #%00001000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 1, BG1 8x8 Tiles

  // Setup BG1 4 Color Background
  lda.b #%01111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2108: BG1 32x32, BG1 Map Address = $1F (VRAM Address / $400)
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

  // Copy CPU Code To WRAM
  rep #$20 // Set 16-Bit Accumulator
  lda.w #(CPURAMEnd-CPURAM)-1 // A = Length
  ldx.w #CPURAM // X = Source
  ldy.w #CPURAM // Y = Destination
  mvn $7E=$00 // Block Move Bytes To WRAM + CPURAM
  sep #$20 // Set 8-Bit Accumulator

  lda.b #$00 // A = $00
  pha // Push A To Stack
  plb // Data Bank = $00

  jml $7E0000+CPURAM // Run CPU Code From WRAM

CPURAM: // CPU Program Code To Be Run From RAM
  WaitNMI() // Wait For VSync

  // Print Title Text
  PrintText(Title, $F882, 24) // Load Text To VRAM Lo Bytes

  // Print Page Break Text
  PrintText(PageBreak, $F8C2, 30) // Load Text To VRAM Lo Bytes

  // Print Syntax/Opcode Text
  PrintText(ADDRegister, $F902, 30) // Load Text To VRAM Lo Bytes

  // Print Key Text
  PrintText(Key, $F982, 30) // Load Text To VRAM Lo Bytes

  // Print Page Break Text
  PrintText(PageBreak, $F9C2, 30) // Load Text To VRAM Lo Bytes

  // Setup GSU SNES Side
  lda.b #GSU_CLSR_21MHz // Clock Data
  sta.w GSU_CLSR // Set Operating Clock Frequency ($3039)

  lda.b #GSU_CFGR_IRQ_MASK // Config Data
  sta.w GSU_CFGR // Set Config Register ($3037)

  stz.w GSU_SCBR // Set Screen Base ($3038)
  stz.w GSU_PBR // Set Program Code Bank ($3034)
  stz.w GSU_ROMBR // Set Game PAK ROM Bank ($3036)
  stz.w GSU_RAMBR // Set Game PAK RAM Bank ($303C)

  lda.b #(GSU_RON|GSU_RAN|GSU_SCMR_2BPP|GSU_SCMR_H192) // Screen Size Mode
  sta.w GSU_SCMR // Sets RON, RAN Flag, Screen Size & Color Number ($303A)

  /////////////////////////////////////////////////////////////////
  ldx.w #GSUROM // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R1 // X = GSU R1 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR0, $FA02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass1
  Fail1:
    PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
    bra Fail1
  Pass1:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail1
    PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R1 // X = GSU R1 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR0, $FA42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass2
  Fail2:
    PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
    bra Fail2
  Pass2:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail2
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR1, $FA82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass3
  Fail3:
    PrintText(Fail, $FAB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail3
  Pass3:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail3
    PrintText(Pass, $FAB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR1, $FAC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FAD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass4
  Fail4:
    PrintText(Fail, $FAF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail4
  Pass4:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail4
    PrintText(Pass, $FAF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR2, $FB02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass5
  Fail5:
    PrintText(Fail, $FB32, 4) // Load Text To VRAM Lo Bytes
    bra Fail5
  Pass5:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail5
    PrintText(Pass, $FB32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR2, $FB42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass6
  Fail6:
    PrintText(Fail, $FB72, 4) // Load Text To VRAM Lo Bytes
    bra Fail6
  Pass6:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail6
    PrintText(Pass, $FB72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR3, $FB82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass7
  Fail7:
    PrintText(Fail, $FBB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail7
  Pass7:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail7
    PrintText(Pass, $FBB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR3, $FBC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FBD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass8
  Fail8:
    PrintText(Fail, $FBF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail8
  Pass8:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail8
    PrintText(Pass, $FBF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR4, $FC02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass9
  Fail9:
    PrintText(Fail, $FC32, 4) // Load Text To VRAM Lo Bytes
    bra Fail9
  Pass9:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail9
    PrintText(Pass, $FC32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR4, $FC42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass10
  Fail10:
    PrintText(Fail, $FC72, 4) // Load Text To VRAM Lo Bytes
    bra Fail10
  Pass10:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail10
    PrintText(Pass, $FC72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR5, $FC82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass11
  Fail11:
    PrintText(Fail, $FCB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail11
  Pass11:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail11
    PrintText(Pass, $FCB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR5, $FCC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FCD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass12
  Fail12:
    PrintText(Fail, $FCF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail12
  Pass12:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail12
    PrintText(Pass, $FCF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR6, $FD02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass13
  Fail13:
    PrintText(Fail, $FD32, 4) // Load Text To VRAM Lo Bytes
    bra Fail13
  Pass13:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail13
    PrintText(Pass, $FD32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR6, $FD42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass14
  Fail14:
    PrintText(Fail, $FD72, 4) // Load Text To VRAM Lo Bytes
    bra Fail14
  Pass14:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail14
    PrintText(Pass, $FD72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR7, $FD82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass15
  Fail15:
    PrintText(Fail, $FDB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail15
  Pass15:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail15
    PrintText(Pass, $FDB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR7, $FDC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FDD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass16
  Fail16:
    PrintText(Fail, $FDF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail16
  Pass16:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail16
    PrintText(Pass, $FDF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $200, 0) // Clear VRAM Map To Fixed Tile Word

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR8, $FA02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass17
  Fail17:
    PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
    bra Fail17
  Pass17:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail17
    PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR8, $FA42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass18
  Fail18:
    PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
    bra Fail18
  Pass18:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail18
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR9, $FA82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass19
  Fail19:
    PrintText(Fail, $FAB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail19
  Pass19:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail19
    PrintText(Pass, $FAB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR9, $FAC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FAD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass20
  Fail20:
    PrintText(Fail, $FAF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail20
  Pass20:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail20
    PrintText(Pass, $FAF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR10, $FB02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass21
  Fail21:
    PrintText(Fail, $FB32, 4) // Load Text To VRAM Lo Bytes
    bra Fail21
  Pass21:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail21
    PrintText(Pass, $FB32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR10, $FB42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass22
  Fail22:
    PrintText(Fail, $FB72, 4) // Load Text To VRAM Lo Bytes
    bra Fail22
  Pass22:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail22
    PrintText(Pass, $FB72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR11, $FB82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass23
  Fail23:
    PrintText(Fail, $FBB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail23
  Pass23:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail23
    PrintText(Pass, $FBB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR11, $FBC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FBD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass24
  Fail24:
    PrintText(Fail, $FBF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail24
  Pass24:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail24
    PrintText(Pass, $FBF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR12, $FC02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass25
  Fail25:
    PrintText(Fail, $FC32, 4) // Load Text To VRAM Lo Bytes
    bra Fail25
  Pass25:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail25
    PrintText(Pass, $FC32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR12, $FC42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass26
  Fail26:
    PrintText(Fail, $FC72, 4) // Load Text To VRAM Lo Bytes
    bra Fail26
  Pass26:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail26
    PrintText(Pass, $FC72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR13, $FC82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass27
  Fail27:
    PrintText(Fail, $FCB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail27
  Pass27:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail27
    PrintText(Pass, $FCB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR13, $FCC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FCD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass28
  Fail28:
    PrintText(Fail, $FCF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail28
  Pass28:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail28
    PrintText(Pass, $FCF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR14, $FD02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass29
  Fail29:
    PrintText(Fail, $FD32, 4) // Load Text To VRAM Lo Bytes
    bra Fail29
  Pass29:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail29
    PrintText(Pass, $FD32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR14, $FD42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass30
  Fail30:
    PrintText(Fail, $FD72, 4) // Load Text To VRAM Lo Bytes
    bra Fail30
  Pass30:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail30
    PrintText(Pass, $FD72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR15, $FD82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass31
  Fail31:
    PrintText(Fail, $FDB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail31
  Pass31:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail31
    PrintText(Pass, $FDB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADDR15, $FDC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FDD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckB
  beq Pass32
  Fail32:
    PrintText(Fail, $FDF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail32
  Pass32:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckC
    bne Fail32
    PrintText(Pass, $FDF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $200, 0) // Clear VRAM Map To Fixed Tile Word

  WaitNMI() // Wait For VSync
  
  // Print Syntax/Opcode Text
  PrintText(ADDConst, $F902, 30) // Load Text To VRAM Lo Bytes

  PrintText(HASH, $F982, 1) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD0, $FA02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass33
  Fail33:
    PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
    bra Fail33
  Pass33:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckD
    bne Fail33
    PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD0, $FA42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass34
  Fail34:
    PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
    bra Fail34
  Pass34:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckC
    bne Fail34
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD1, $FA82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass35
  Fail35:
    PrintText(Fail, $FAB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail35
  Pass35:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail35
    PrintText(Pass, $FAB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD1, $FAC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FAD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass36
  Fail36:
    PrintText(Fail, $FAF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail36
  Pass36:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail36
    PrintText(Pass, $FAF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD2, $FB02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass37
  Fail37:
    PrintText(Fail, $FB32, 4) // Load Text To VRAM Lo Bytes
    bra Fail37
  Pass37:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail37
    PrintText(Pass, $FB32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD2, $FB42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass38
  Fail38:
    PrintText(Fail, $FB72, 4) // Load Text To VRAM Lo Bytes
    bra Fail38
  Pass38:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail38
    PrintText(Pass, $FB72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD3, $FB82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass39
  Fail39:
    PrintText(Fail, $FBB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail39
  Pass39:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail39
    PrintText(Pass, $FBB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD3, $FBC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FBD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass40
  Fail40:
    PrintText(Fail, $FBF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail40
  Pass40:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail40
    PrintText(Pass, $FBF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD4, $FC02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass41
  Fail41:
    PrintText(Fail, $FC32, 4) // Load Text To VRAM Lo Bytes
    bra Fail41
  Pass41:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail41
    PrintText(Pass, $FC32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD4, $FC42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass42
  Fail42:
    PrintText(Fail, $FC72, 4) // Load Text To VRAM Lo Bytes
    bra Fail42
  Pass42:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail42
    PrintText(Pass, $FC72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD5, $FC82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass43
  Fail43:
    PrintText(Fail, $FCB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail43
  Pass43:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail43
    PrintText(Pass, $FCB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD5, $FCC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FCD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass44
  Fail44:
    PrintText(Fail, $FCF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail44
  Pass44:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail44
    PrintText(Pass, $FCF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD6, $FD02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass45
  Fail45:
    PrintText(Fail, $FD32, 4) // Load Text To VRAM Lo Bytes
    bra Fail45
  Pass45:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail45
    PrintText(Pass, $FD32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD6, $FD42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass46
  Fail46:
    PrintText(Fail, $FD72, 4) // Load Text To VRAM Lo Bytes
    bra Fail46
  Pass46:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail46
    PrintText(Pass, $FD72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD7, $FD82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass47
  Fail47:
    PrintText(Fail, $FDB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail47
  Pass47:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail47
    PrintText(Pass, $FDB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD7, $FDC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FDD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass48
  Fail48:
    PrintText(Fail, $FDF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail48
  Pass48:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail48
    PrintText(Pass, $FDF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  WaitNMI() // Wait For VSync

  ClearVRAM(BGCLEAR, $FA00, $200, 0) // Clear VRAM Map To Fixed Tile Word

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD8, $FA02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass49
  Fail49:
    PrintText(Fail, $FA32, 4) // Load Text To VRAM Lo Bytes
    bra Fail49
  Pass49:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail49
    PrintText(Pass, $FA32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD8, $FA42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FA64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass50
  Fail50:
    PrintText(Fail, $FA72, 4) // Load Text To VRAM Lo Bytes
    bra Fail50
  Pass50:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail50
    PrintText(Pass, $FA72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD9, $FA82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FA92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass51
  Fail51:
    PrintText(Fail, $FAB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail51
  Pass51:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail51
    PrintText(Pass, $FAB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD9, $FAC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FAD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FAE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass52
  Fail52:
    PrintText(Fail, $FAF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail52
  Pass52:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail52
    PrintText(Pass, $FAF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD10, $FB02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass53
  Fail53:
    PrintText(Fail, $FB32, 4) // Load Text To VRAM Lo Bytes
    bra Fail53
  Pass53:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail53
    PrintText(Pass, $FB32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD10, $FB42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FB64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass54
  Fail54:
    PrintText(Fail, $FB72, 4) // Load Text To VRAM Lo Bytes
    bra Fail54
  Pass54:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail54
    PrintText(Pass, $FB72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD11, $FB82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FB92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass55
  Fail55:
    PrintText(Fail, $FBB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail55
  Pass55:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail55
    PrintText(Pass, $FBB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD11, $FBC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FBD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FBE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass56
  Fail56:
    PrintText(Fail, $FBF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail56
  Pass56:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail56
    PrintText(Pass, $FBF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD12, $FC02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass57
  Fail57:
    PrintText(Fail, $FC32, 4) // Load Text To VRAM Lo Bytes
    bra Fail57
  Pass57:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail57
    PrintText(Pass, $FC32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD12, $FC42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FC64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass58
  Fail58:
    PrintText(Fail, $FC72, 4) // Load Text To VRAM Lo Bytes
    bra Fail58
  Pass58:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail58
    PrintText(Pass, $FC72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD13, $FC82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FC92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass59
  Fail59:
    PrintText(Fail, $FCB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail59
  Pass59:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail59
    PrintText(Pass, $FCB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD13, $FCC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FCD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FCE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass60
  Fail60:
    PrintText(Fail, $FCF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail60
  Pass60:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail60
    PrintText(Pass, $FCF2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD14, $FD02, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD12, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD24) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass61
  Fail61:
    PrintText(Fail, $FD32, 4) // Load Text To VRAM Lo Bytes
    bra Fail61
  Pass61:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail61
    PrintText(Pass, $FD32, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD14, $FD42, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD52, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FD64) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass62
  Fail62:
    PrintText(Fail, $FD72, 4) // Load Text To VRAM Lo Bytes
    bra Fail62
  Pass62:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail62
    PrintText(Pass, $FD72, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD15, $FD82, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FD92, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDA4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckA
  beq Pass63
  Fail63:
    PrintText(Fail, $FDB2, 4) // Load Text To VRAM Lo Bytes
    bra Fail63
  Pass63:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckA
    bne Fail63
    PrintText(Pass, $FDB2, 4) // Load Text To VRAM Lo Bytes

  /////////////////////////////////////////////////////////////////
  ldx.w GSU_R15 // Program Address
  stx.w GSU_R15 // Sets Program Counter ($301E)
  GSUWait() // Wait For GSU To Finish

  // Store Result & GSU Status Flag Data
  ldx.w GSU_R0 // X = GSU R0 (Result)
  stx.b ResultData // Store Result To Memory
  ldx.w GSU_SFR // X = GSU SFR (Status/Flag)
  stx.b SFRFlagData // Store GSU Status Flag Data To Memory

  WaitNMI() // Wait For VSync
  PrintText(ADD15, $FDC2, 7) // Load Text To VRAM Lo Bytes

  // Print Result & GSU Status Flag Data
  PrintValue(ResultData, $FDD2, 2) // Print Result Data
  PrintSFR(SFRFlagData, $FDE4) // Print GSU Status Flag Data

  // Check Result & GSU Status Flag Data
  ldx.b ResultData // X = Result Data
  cpx.w ADDResultCheckC
  beq Pass64
  Fail64:
    PrintText(Fail, $FDF2, 4) // Load Text To VRAM Lo Bytes
    bra Fail64
  Pass64:
    lda.b SFRFlagData // A = GSU Status Flag Data
    cmp.w SFRResultCheckB
    bne Fail64
    PrintText(Pass, $FDF2, 4) // Load Text To VRAM Lo Bytes

Loop:
  bra Loop
CPURAMEnd:

Title:
  db "GSU Test ADD (Addition):"

PageBreak:
  db "------------------------------"

Key:
  db "Rn/Op | Result | VSCZ | Test |"

ADDR0:
  db "R0/$50 "
ADDR1:
  db "R1/$51 "
ADDR2:
  db "R2/$52 "
ADDR3:
  db "R3/$53 "
ADDR4:
  db "R4/$54 "
ADDR5:
  db "R5/$55 "
ADDR6:
  db "R6/$56 "
ADDR7:
  db "R7/$57 "
ADDR8:
  db "R8/$58 "
ADDR9:
  db "R9/$59 "
ADDR10:
  db "R10/$5A"
ADDR11:
  db "R11/$5B"
ADDR12:
  db "R12/$5C"
ADDR13:
  db "R13/$5D"
ADDR14:
  db "R14/$5E"
ADDR15:
  db "R15/$5F"

HASH:
  db "#"
ADD0:
  db "#0/$50 "
ADD1:
  db "#1/$51 "
ADD2:
  db "#2/$52 "
ADD3:
  db "#3/$53 "
ADD4:
  db "#4/$54 "
ADD5:
  db "#5/$55 "
ADD6:
  db "#6/$56 "
ADD7:
  db "#7/$57 "
ADD8:
  db "#8/$58 "
ADD9:
  db "#9/$59 "
ADD10:
  db "#10/$5A"
ADD11:
  db "#11/$5B"
ADD12:
  db "#12/$5C"
ADD13:
  db "#13/$5D"
ADD14:
  db "#14/$5E"
ADD15:
  db "#15/$5F"

Fail:
  db "FAIL"
Pass:
  db "PASS"

ADDRegister:
  db "ADD register   (Opcode: $5n)  "
ADDConst:
  db "ADD #const     (Opcode: $3E5n)"

ADDResultCheckA:
  dw $0000
SFRResultCheckA:
  db $06

ADDResultCheckB:
  dw $FFFE
SFRResultCheckB:
  db $18
SFRResultCheckC:
  db $08

SFRResultCheckD:
  db $02

ADDResultCheckC:
  dw $8000

// GSU Code
// BANK 0
GSUROM:
  include "GSUADD_gsu.asm" // Include GSU ROM Data

// BG Data
BGCHR:
  include "Font8x8.asm" // Include BG 1BPP 8x8 Tile Font Character Data (1016 Bytes)
BGPAL:
  dw $7800, $7FFF // Blue / White Palette (4 Bytes)
BGCLEAR:
  dw $0020 // BG Clear Character Space " " Fixed Word