//===========
// SNES MSU1
//===========

// MSU1 Read Registers
constant MSU_STATUS($2000)   // MSU1 Status Register        1B/R
constant MSU_READ($2001)     // MSU1 Read Register          1B/R
constant MSU_ID($2002)       // MSU1 ID Register ("S-MSU1") 6B/R

// MSU1 Write Registers
constant MSU_SEEK($2000)     // MSU1 Seek Register          2B/W
constant MSU_SEEKBANK($2002) // MSU1 Seek Bank Register     2B/W
constant MSU_TRACK($2004)    // MSU1 Track Register         2B/W
constant MSU_VOLUME($2006)   // MSU1 Volume Register        1B/W
constant MSU_CONTROL($2007)  // MSU1 Control Register       1B/W

macro MSUWaitAudioBusy() {
  -
    bit.w MSU_STATUS // $2000: MSU1 Status Register
    bvs - // Wait For MSU1 Audio Busy Flag Status Bit To Clear
}

macro MSUWaitDataBusy() {
  -
    bit.w MSU_STATUS // $2000: MSU1 Status Register
    bmi - // Wait For MSU1 Data Busy Flag Status Bit To Clear
}

//=============================================================
// MSULoadPAL - Load Palette Data To CGRAM (Seek Position Set)
//=============================================================
// DEST: 9-Bit CGRAM Destination Address (Color # To Start On)
// SIZE: Size Of Data (# Of Colors To Copy)
// CHAN: DMA Channel To Transfer Data (0..7)
macro MSULoadPAL(DEST, SIZE, CHAN) {
  lda.b #{DEST}   // Set CGRAM Destination
  sta.w REG_CGADD // $2121: CGRAM

  lda.b #$08
  sta.w REG_DMAP{CHAN} // Set DMA Mode (Write Byte, Fixed Source) ($43X0: DMA Control)
  lda.b #$22           // Set Destination Register ($2122: CGRAM Write)
  sta.w REG_BBAD{CHAN} // $43X1: DMA Destination
  ldx.w #MSU_READ      // Set Source Offset
  stx.w REG_A1T{CHAN}L // $43X2: DMA Source
  stz.w REG_A1B{CHAN}  // Set Source Bank To Zero ($43X4: Source Bank)
  ldx.w #{SIZE}        // Set Size In Bytes To DMA Transfer (2 Bytes For Each Color)
  stx.w REG_DAS{CHAN}L // $43X5: DMA Transfer Size/HDMA

  lda.b #$01 << {CHAN} // Start DMA Transfer On Channel
  sta.w REG_MDMAEN     // $420B: DMA Enable
}

//=========================================================
// MSULoadVRAM - Load GFX Data To VRAM (Seek Position Set)
//=========================================================
// DEST: 16-Bit VRAM Destination Address (WORD Address)
// SIZE: Size Of Data (BYTE Size)
// CHAN: DMA Channel To Transfer Data (0..7)
macro MSULoadVRAM(DEST, SIZE, CHAN) {
  lda.b #$80         // Set Increment VRAM Address After Accessing Hi Byte
  sta.w REG_VMAIN    // $2115: Video Port Control
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM

  lda.b #$09           // Set DMA Mode (Write Word, Fixed Source)
  sta.w REG_DMAP{CHAN} // $43X0: DMA Control
  lda.b #$18           // Set Destination Register ($2118: VRAM Write)
  sta.w REG_BBAD{CHAN} // $43X1: DMA Destination
  ldx.w #MSU_READ      // Set Source Offset
  stx.w REG_A1T{CHAN}L // $43X2: DMA Source
  stz.w REG_A1B{CHAN}  // Set Source Bank To Zero ($43X4: Source Bank)
  ldx.w #{SIZE}        // Set Size In Bytes To DMA Transfer
  stx.w REG_DAS{CHAN}L // $43X5: DMA Transfer Size/HDMA

  lda.b #$01 << {CHAN} // Start DMA Transfer On Channel
  sta.w REG_MDMAEN     // $420B: DMA Enable
}

//=================================================================
// MSULoadM7VRAM - Load Mode7 GFX Data To VRAM (Seek Position Set)
//=================================================================
//      DEST: 16-Bit VRAM Destination (WORD Address)
//   SIZEMAP: Size Of Map Data (BYTE Size)
// SIZETILES: Size Of Tile Data (BYTE Size)
//      CHAN: DMA Channel To Transfer Data (0..7)
macro MSULoadM7VRAM(DEST, SIZEMAP, SIZETILES, CHAN) {
  // Load Mode7 Map Data To VRAM
  stz.w REG_VMAIN    // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM

  lda.b #$08           // Set DMA Mode (Write Byte, Fixed Source)
  sta.w REG_DMAP{CHAN} // $43X0: DMA Control
  lda.b #$18           // Set Destination Register ($2118: VRAM Write)
  sta.w REG_BBAD{CHAN} // $43X1: DMA Destination
  ldx.w #MSU_READ      // Set Source Offset (Map)
  stx.w REG_A1T{CHAN}L // $43X2: DMA Source
  stz.w REG_A1B{CHAN}  // Set Source Bank To Zero ($43X4: Source Bank)
  ldx.w #{SIZEMAP}     // Set Size In Bytes To DMA Transfer
  stx.w REG_DAS{CHAN}L // $43X5: DMA Transfer Size/HDMA

  lda.b #$01 << {CHAN} // Start DMA Transfer On Channel
  sta.w REG_MDMAEN     // $420B: DMA Enable

  // Load Mode7 Tile Data To VRAM (Needs To Be On Same Bank As Map)
  lda.b #$80         // Set Increment VRAM Address After Accessing Hi Byte
  sta.w REG_VMAIN    // $2115: Video Port Control
  ldx.w #{DEST} >> 1 // Set VRAM Destination
  stx.w REG_VMADDL   // $2116: VRAM

  lda.b #$19           // Set Destination Register ($2119: VRAM Write)
  sta.w REG_BBAD{CHAN} // $43X1: DMA Destination
  ldx.w #MSU_READ      // Set Source Offset (Tiles)
  stx.w REG_A1T{CHAN}L // $43X2: DMA Source
  ldx.w #{SIZETILES}   // Set Size In Bytes To DMA Transfer
  stx.w REG_DAS{CHAN}L // $43X5: DMA Transfer Size/HDMA

  lda.b #$01 << {CHAN} // Start DMA Transfer On Channel
  sta.w REG_MDMAEN     // $420B: DMA Enable
}