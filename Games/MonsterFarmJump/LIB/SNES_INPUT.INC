//============
// SNES Input
//============
define JOY_R(REG_JOY1L, %00010000)
define JOY_L(REG_JOY1L, %00100000)
define JOY_X(REG_JOY1L, %01000000)
define JOY_A(REG_JOY1L, %10000000)
define JOY_RIGHT(REG_JOY1H, %00000001)
define JOY_LEFT(REG_JOY1H, %00000010)
define JOY_DOWN(REG_JOY1H, %00000100)
define JOY_UP(REG_JOY1H, %00001000)
define JOY_START(REG_JOY1H, %00010000)
define JOY_SELECT(REG_JOY1H, %00100000)
define JOY_Y(REG_JOY1H, %01000000)
define JOY_B(REG_JOY1H, %10000000)

//================================
// ReadJOY - Read Joypad Register
//================================
// JOYREG: Joypad Register
// JOYINP: Joypad Button Code (BYSSUDLR = REG_JOY1H, AXLR---- = REG_JOY1L)
macro ReadJOY(JOYREG, INPUT) {
  -
    bit.w REG_HVBJOY // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bmi - // Wait Until Joypad Is Ready

  lda.w {JOYREG} // Read Joypad Register Byte
  and.b #{INPUT} // Test Button Bit
}

//=====================================================
// ReadXBAND - Read X-Band Keyboard Scancodes Register
//=====================================================
// Uses 16 Bytes Of WRAM ($00..$0F)
// Byte $00 = ID/NUM, Bytes $01..$0F = Keyboard Scancodes
macro ReadXBAND() {
  lda.b #$7F // Set IOBIT = 0
  sta.w REG_WRIO // $4201: Programmable I/O Port (Open-Collector Output)

  // ID = GETBITS(8) // Read ID Byte, Must Be $78 ("x")
  ldy.w #4 // GETBITS(N)
  {#}ReadIDBits: // FOR I=1 TO N/2 // Read 2 Bits At Once (LSB First)
    lda.w REG_JOYB // X = (X SHR 2) OR ([$4017] SHL 6)
    asl
    asl
    asl
    asl
    asl
    asl // A = [$4017] SHL 6
    lsr.b $00 // MEM[$00] >> 1
    lsr.b $00 // MEM[$00] >> 1
    ora.b $00 // A = (X SHR 2) OR ([$4017] SHL 6)
    sta.b $00 // Store X
    dey // Decrement N/2
    bne {#}ReadIDBits // NEXT
  eor.b #$FF // X = (X XOR $FF) SHR (8-N) // Invert & Move Result To LSBs
  sta.b $00  // MEM[$00] = ID

  lda.b #$FF // IF CAPS=OFF [$4201]=$FF // Set IOBIT=1 (When CAPS=OFF) (CAPS LED)
  sta.w REG_WRIO // $4201: Programmable I/O Port (Open-Collector Output)

  // NUM = GETBITS(4) // Read NUMber Of Scancodes
  ldy.w #2 // GETBITS(N)
  {#}ReadNUMBits: // FOR I=1 TO N/2 // Read 2 Bits At Once (LSB First)
    lda.w REG_JOYB // X = (X SHR 2) OR ([$4017] SHL 6)
    asl
    asl
    asl
    asl
    asl
    asl // A = [$4017] SHL 6
    lsr.b $00 // MEM[$00] >> 1
    lsr.b $00 // MEM[$00] >> 1
    ora.b $00 // A = (X SHR 2) OR ([$4017] SHL 6)
    sta.b $00 // Store X
    dey // Decrement N/2
    bne {#}ReadNUMBits // NEXT
  eor.b #$FF // X = (X XOR $FF) SHR (8-N) // Invert & Move Result To LSBs
  lsr
  lsr
  lsr
  lsr
  sta.b $00  // MEM[$00] = NUM

  beq {#}SkipScanCodes // IF NUM>0 THEN FOR I=1 TO NUM

  ldx.w #14 //  Clear Keyboard Buffer (15 Bytes)
  {#}ClearKBUF:
    stz.b $01,x
    dex
    bne {#}ClearKBUF

  ldx.w #0  // X = DST Offset
  {#}NextScanCode: // DST = GETBITS(8) // Read Scancodes
    ldy.w #4 // GETBITS(N)
    {#}ReadDSTBits: // FOR I=1 TO N/2 // Read 2 Bits At Once (LSB First)
      lda.w REG_JOYB // X = (X SHR 2) OR ([$4017] SHL 6)
      asl
      asl
      asl
      asl
      asl
      asl // A = [$4017] SHL 6
      lsr.b $01,x // MEM[$01+DST Offset] >> 1
      lsr.b $01,x // MEM[$01+DST Offset] >> 1
      ora.b $01,x // A = (X SHR 2) OR ([$4017] SHL 6)
      sta.b $01,x // Store X
      dey // Decrement N/2
      bne {#}ReadDSTBits // NEXT
    eor.b #$FF // X = (X XOR $FF) SHR (8-N) // Invert & Move Result To LSBs
    sta.b $01,x // MEM[$01+DST Offset] = DST

    inx // DST Offset++
    dec.b $00 // NUM--
    bne {#}NextScanCode

  {#}SkipScanCodes:
  lda.b #$FF // Set IOBIT=1
  sta.w REG_WRIO // $4201: Programmable I/O Port (Open-Collector Output)
}