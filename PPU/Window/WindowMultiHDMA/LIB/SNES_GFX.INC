//===============
// SNES Graphics
//===============

macro WaitNMI() {
  -
    bit.w {REG_RDNMI} // $4210: Read NMI Flag Register
    bpl - // Wait For NMI Flag
}

macro WaitHV() {
  -
    bit.w {REG_TIMEUP} // $4210: Read H/V-Timer IRQ Flag
    bpl - // Wait For H/V Timer IRQ Flag
}

macro WaitHVB() {
  -
    bit.w {REG_HVBJOY} // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bpl - // Wait For V-Blank Period Flag
}

macro FadeIN() { // Increment Screen Brightness From 0..15 (VSYNC Timing)
  ldx.w #$0000 // Set X To Mininmum Brightness Level
  -
    bit.w {REG_RDNMI} // $4210: Read NMI Flag Register
    bpl - // Wait For NMI Flag

  inx                 // Increments Brightness Level
  txa                 // Swap 16-Bit X To 8-Bit A
  sta.w {REG_INIDISP} // $2100: Turn Screen To Brightness Level
  cmp.b #$0F // Compare With Maximum Brightness Level (15)
  bne -      // IF (Screen != Maximum Brightness Level) Loop
}

macro FadeOUT() { // Decrement Screen Brightness From 15..0 (VSYNC Timing)
  ldx.w #$000F // Set X To Maximum Brightness Level
  -
    bit.w {REG_RDNMI} // $4210: Read NMI Flag Register
    bpl - // Wait For NMI Flag

  dex                 // Decrement Brightness Level
  txa                 // Swap 16-Bit X To 8-Bit A
  sta.w {REG_INIDISP} // $2100: Turn Screen To Brightness Level
  cmp.b #$00 // Compare With Minimum Brightness Level
  bne -      // IF (Screen != Minimum Brightness Level) Loop
}

//======================================
// LoadPAL - Load Palette Data To CGRAM
//======================================
//  SRC: 24-Bit Address Of Source Data
// DEST: CGRAM Destination Address (Color # To Start On)
// SIZE: Size Of Data (# Of Colors To Copy)
// CHAN: DMA Channel To Transfer Data (0..7)
macro LoadPAL(SRC, DEST, SIZE, CHAN) {
  lda.b #{DEST}     // CGRAM Destination
  sta.w {REG_CGADD} // $2121: CGRAM

  stz.w {REG_DMAP{CHAN}} // Set DMA Mode (Byte, Normal Increment) ($43X0: DMA Control)
  lda.b #$22             // Set Destination Register ($2122: CGRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRC}           // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  lda.b #{SRC} >> 16     // Source Bank
  sta.w {REG_A1B{CHAN}}  // Store Data Bank To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE}          // Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//==========================================
// UpdatePAL - Update Palette Data To CGRAM
//==========================================
//  SRC: 24-Bit Address Of Source Data
// DEST: CGRAM Destination Address (Color # To Start On)
// SIZE: Size Of Data (# Of Colors To Copy)
// CHAN: DMA Channel To Transfer Data (0..7)
macro UpdatePAL(SRC, DEST, SIZE, CHAN) {
  lda.b #{DEST}     // CGRAM Destination
  sta.w {REG_CGADD} // $2121: CGRAM

  stz.w {REG_DMAP{CHAN}} // Set DMA Mode (Byte, Normal Increment) ($43X0: DMA Control)
  lda.b #$22             // Set Destination Register ($2122: CGRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRC}           // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  lda.b #{SRC} >> 16     // Source Bank
  sta.w {REG_A1B{CHAN}}  // Store Data Bank To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE}          // Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  -
    bit.w {REG_HVBJOY} // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bpl - // Wait For V-Blank Period Flag

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//==================================
// LoadVRAM - Load GFX Data To VRAM
//==================================
//  SRC: 24-Bit Address Of Source Data
// DEST: VRAM Destination Address (WORD Address)
// SIZE: Size Of Data (BYTE Size)
// CHAN: DMA Channel To Transfer Data (0..7)
macro LoadVRAM(SRC, DEST, SIZE, CHAN) {
  ldx.w #{DEST} >> 1 // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$01
  sta.w {REG_DMAP{CHAN}} // Set DMA Mode (Word, Normal Increment) ($43X0: DMA Control)
  lda.b #$18             // Set Destination Register ($2118: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRC}           // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  lda.b #{SRC} >> 16     // Source Bank
  sta.w {REG_A1B{CHAN}}  // Store Data Bank To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE}          // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//======================================
// UpdateVRAM - Update GFX Data To VRAM
//======================================
//  SRC: 24-Bit Address Of Source Data
// DEST: VRAM Destination Address (WORD Address)
// SIZE: Size Of Data (BYTE Size)
// CHAN: DMA Channel To Transfer Data (0..7)
macro UpdateVRAM(SRC, DEST, SIZE, CHAN) {
  ldx.w #{DEST} >> 1 // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$01
  sta.w {REG_DMAP{CHAN}} // Set DMA Mode (Word, Normal Increment) ($43X0: DMA Control)
  lda.b #$18             // Set Destination Register ($2118: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRC}           // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  lda.b #{SRC} >> 16     // Source Bank
  sta.w {REG_A1B{CHAN}}  // Store Data Bank To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE}          // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  -
    bit.w {REG_HVBJOY} // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bpl - // Wait For V-Blank Period Flag

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//===========================================
// LoadM7VRAM - Load Mode 7 GFX Data To VRAM
//===========================================
//    SRCMAP: 24-Bit Address Of Source Map Data
//  SRCTILES: 24-Bit Address Of Source Tile Data
//      DEST: VRAM Destination Address (WORD Address)
//   SIZEMAP: Size Of Map Data (BYTE Size)
// SIZETILES: Size Of Tile Data (BYTE Size)
//      CHAN: DMA Channel To Transfer Data (0..7)
macro LoadM7VRAM(SRCMAP, SRCTILES, DEST, SIZEMAP, SIZETILES, CHAN) {
  // Load Mode7 Map Data To VRAM
  stz.w {REG_VMAIN}  // $2115: Video Port Control
  ldx.w #{DEST} >> 1 // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$18             // Set Destination Register ($2118: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRCMAP}        // Source Map
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  lda.b #{SRCMAP} >> 16  // Source Bank
  sta.w {REG_A1B{CHAN}}  // Store Data Bank To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZEMAP}       // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable

  // Load Mode7 Tile Data To VRAM (Needs To Be On Same Bank As Map)
  lda.b #$80
  sta.w {REG_VMAIN}  // $2115: Video Port Control
  ldx.w #{DEST}      // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$19             // Set Destination Register ($2119: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{SRCTILES}      // Source Tile
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  ldx.w #{SIZETILES}     // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//==================================
// BGScroll - Scroll GFX BG (8-Bit)
//==================================
// BGPOS: BG Position Register To Scroll
//   DIR: Direction To Scroll (de = Decrement, in = Increment)
//   REG: Register Used (x, y)
macro BGScroll(BGPOS, DIR, REG) {
  {DIR}{REG}    // Decrement Or Increment BG Scroll Position Low Byte
  t{REG}a       // Swaps 16-Bit REG To 8-Bit A
  sta.w {BGPOS} // Store A To BG Scroll Position Low Byte
  stz.w {BGPOS} // Store Zero To BG Scroll Position High Byte
}

//=====================================
// BGScroll16 - Scroll GFX BG (16-Bit)
//=====================================
// BGSCR: BG Scroll Position Word
// BGPOS: BG Pos Register To Scroll
//   DIR: Direction To Scroll (de = Decrement, in = Increment)
macro BGScroll16(BGSCR, BGPOS, DIR) {
  ldx.w {BGSCR}     // Load BG Scroll Position Word
  {DIR}x            // Decrement Or Increment BG Scroll Position Word
  stx.w {BGSCR}     // Store To BG Scroll Position Word
  lda.b {BGSCR}     // Load BG Scroll Position Low Byte
  sta.w {BGPOS}     // Store BG Scroll Position Low Byte
  lda.b {BGSCR} + 1 // Load BG Scroll Position High Byte
  sta.w {BGPOS}     // Store BG Scroll Position High Byte
}

//======================================
// Mode7CALC - Mode7 Matrix Calculation
//======================================
//      A: Mode7 COS A Word
//      B: Mode7 SIN A Word
//      C: Mode7 SIN B Word
//      D: Mode7 COS B Word
//  ANGLE: Mode7 Angle Byte
//     SX: Mode7 Scale X Word
//     SY: Mode7 Scale Y Word
// SINCOS: Mode7 SINCOS Table
macro Mode7CALC(A, B, C, D, ANGLE, SX, SY, SINCOS) {
  lda.b {ANGLE} // Load Angle To A
  tax           // Transfer A To X

  // Calculate B & C (SIN)
  // B
  lda.b {SX}       // Scale X
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.b {SX} + 1
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.w {SINCOS},x // SIN(X)
  sta.w {REG_M7B}  // $211C: MODE7 SINE A   (Multiplicand B)
  ldy.w {REG_MPYM} // $2135: Multiplication Result -> 8.8
  sty.w {B}
  // C
  lda.b {SY}       // Scale Y
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.b {SY} + 1   // High Byte
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.w {SINCOS},x // SIN(X)
  eor.b #$FF       // Make Negative
  inc
  sta.w {REG_M7B}  // $211C: MODE7 SINE A   (Multiplicand B)
  ldy.w {REG_MPYM} // $2135: Multiplication Result -> 8.8
  sty.w {C}

  // Change X Index To Point To COS Values (X + 64)
  txa       // Transfer X Index To A
  clc       // Clear Carry Flag
  adc.b #64 // Add 64 With Carry
  tax       // Transfer A To X Index

  // Calculate A & D (COS)
  // A
  lda.b {SX}       // Scale X
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.b {SX} + 1
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.w {SINCOS},x // COS(X)
  sta.w {REG_M7B}  // $211C: MODE7 SINE A   (Multiplicand B)
  ldy.w {REG_MPYM} // $2135: Multiplication Result -> 8.8
  sty.w {A}
  // D
  lda.b {SY}       // Scale Y
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.b {SY} + 1
  sta.w {REG_M7A}  // $211B: MODE7 COSINE A (Multiplicand A)
  lda.w {SINCOS},x // COS(X)
  sta.w {REG_M7B}  // $211C: MODE7 SINE A   (Multiplicand B)
  ldy.w {REG_MPYM} // $2135: Multiplication Result -> 8.8
  sty.w {D}

  // Store Result To Matrix
  lda.b {A}
  sta.w {REG_M7A} // $211B: MODE7 COSINE A (Multiplicand A)
  lda.b {A} + 1
  sta.w {REG_M7A} // $211B: MODE7 COSINE A (Multiplicand A)

  lda.b {B}
  sta.w {REG_M7B} // $211C: MODE7 SINE A   (Multiplicand B)
  lda.b {B} + 1
  sta.w {REG_M7B} // $211C: MODE7 SINE A   (Multiplicand B)

  lda.b {C}
  sta.w {REG_M7C} // $211D: MODE7 SINE B
  lda.b {C} + 1
  sta.w {REG_M7C} // $211D: MODE7 SINE B

  lda.b {D}
  sta.w {REG_M7D} // $211E: MODE7 COSINE B
  lda.b {D} + 1
  sta.w {REG_M7D} // $211E: MODE7 COSINE B
}