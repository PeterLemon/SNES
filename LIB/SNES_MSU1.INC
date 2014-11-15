//===========
// SNES MSU1
//===========

// MSU1 Read Registers
define MSU_STATUS($2000)   // MSU1 Status Register        1B/R
define MSU_READ($2001)     // MSU1 Read Register          1B/R
define MSU_ID($2002)       // MSU1 ID Register ("S-MSU1") 6B/R

// MSU1 Write Registers
define MSU_SEEK($2000)     // MSU1 Seek Register          2B/W
define MSU_SEEKBANK($2002) // MSU1 Seek Bank Register     2B/W
define MSU_TRACK($2004)    // MSU1 Track Register         2B/W
define MSU_VOLUME($2006)   // MSU1 Volume Register        1B/W
define MSU_CONTROL($2007)  // MSU1 Control Register       1B/W

//==============================================================
// MSU1LoadPAL - Load Palette Data To CGRAM (Seek Position Set)
//==============================================================
// DEST: CGRAM Destination Address (Color # To Start On)
// SIZE: Size Of Data (# Of Colors To Copy)
// CHAN: DMA Channel To Transfer Data (0..7)
macro MSU1LoadPAL(DEST, SIZE, CHAN) {
  lda.b #{DEST}     // CGRAM Destination
  sta.w {REG_CGADD} // $2121: CGRAM

  lda.b #$08
  sta.w {REG_DMAP{CHAN}} // Set DMA Mode (Byte, Normal Non Increment) ($43X0: DMA Control)
  lda.b #$22             // Set Destination Register ($2122: CGRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{MSU_READ}      // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  stz.w {REG_A1B{CHAN}}  // Store Zero To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE} * 2      // Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//==========================================================
// MSU1LoadVRAM - Load GFX Data To VRAM (Seek Position Set)
//----------------------------------------------------------
// DEST: VRAM Destination Address (WORD Address)
// SIZE: Size Of Data (BYTE Size)
// CHAN: DMA Channel To Transfer Data (0..7)
macro MSU1LoadVRAM(DEST, SIZE, CHAN) {
  ldx.w #{DEST} >> 1 // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$09
  sta.w {REG_DMAP{CHAN}} // Set DMA Mode (Word, Normal Non Increment) ($43X0: DMA Control)
  lda.b #$18             // Set Destination Register ($2118: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{MSU_READ}      // Source Data
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  stz.w {REG_A1B{CHAN}}  // Store Zero To DMA Source Bank ($43X4: Source Bank)
  ldx.w #{SIZE}          // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}

//==================================================================
// MSU1LoadM7VRAM - Load Mode7 GFX Data To VRAM (Seek Position Set)
//==================================================================
//      DEST: VRAM Destination Address (WORD Address)
//   SIZEMAP: Size Of Map Data (BYTE Size)
// SIZETILES: Size Of Tile Data (BYTE Size)
//      CHAN: DMA Channel To Transfer Data (0..7)
macro MSU1LoadM7VRAM(DEST, SIZEMAP, SIZETILES, CHAN) {
  // Load Mode7 Map Data To VRAM
  stz.w {REG_VMAIN}  // $2115: Video Port Control
  ldx.w #{DEST} >> 1 // VRAM Destination
  stx.w {REG_VMADDL} // $2116: VRAM

  lda.b #$08
  sta.w {REG_DMAP{CHAN}} // Set DMA Mode (Byte, Normal Non Increment) ($43X0: DMA Control)
  lda.b #$18             // Set Destination Register ($2118: VRAM Write)
  sta.w {REG_BBAD{CHAN}} // $43X1: DMA Destination
  ldx.w #{MSU_READ}      // Source Map
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  stz.w {REG_A1B{CHAN}}  // Store Zero To DMA Source Bank ($43X4: Source Bank)
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
  ldx.w #{MSU_READ}      // Source Tiles
  stx.w {REG_A1T{CHAN}L} // Store Data Offset To DMA Source Offset ($43X2: DMA Source)
  ldx.w #{SIZETILES}     // Size In Bytes To DMA Transfer
  stx.w {REG_DAS{CHAN}L} // Store Size Of Data ($43X5: DMA Transfer Size/HDMA)

  lda.b #$01 << {CHAN} // Initiate DMA Transfer On Channel
  sta.w {REG_MDMAEN}   // $420B: DMA Enable
}