//============
// SNES Input
//============
define JOY_R({REG_JOY1L}, %00010000)
define JOY_L({REG_JOY1L}, %00100000)
define JOY_X({REG_JOY1L}, %01000000)
define JOY_A({REG_JOY1L}, %10000000)
define JOY_RIGHT({REG_JOY1H}, %00000001)
define JOY_LEFT({REG_JOY1H}, %00000010)
define JOY_DOWN({REG_JOY1H}, %00000100)
define JOY_UP({REG_JOY1H}, %00001000)
define JOY_START({REG_JOY1H}, %00010000)
define JOY_SELECT({REG_JOY1H}, %00100000)
define JOY_Y({REG_JOY1H}, %01000000)
define JOY_B({REG_JOY1H}, %10000000)

//================================
// ReadJOY - Read Joypad Register
//================================
// JOYREG: Joypad Register
// JOYINP: Joypad Button Code (BYSSUDLR = REG_JOY1H, AXLR---- = REG_JOY1L)
macro ReadJOY(JOYREG, INPUT) {
  -
    bit.w {REG_HVBJOY} // $4212: Read H/V-Blank Flag & Joypad Busy Flag
    bmi - // Wait Until Joypad Is Ready

  lda.w {JOYREG} // Read Joypad Register Byte
  and.b #{INPUT} // Test Button Bit
}