// SNES MSU1 Audio Demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "AUDIO.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros
include "LIB/SNES_MSU1.INC"   // Include MSU1 Definitions & Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  SPCWaitBoot() // Wait For SPC To Boot
  TransferBlockSPC(SPCROM, SPCRAM, SPCROM.size) // Load SPC File To SMP/DSP
  SPCExecute(SPCRAM) // Execute SPC At $0200

  lda.b #$FF       // Load Audio Volume Byte
  sta.w MSU_VOLUME // $2006: MSU1 Volume Register

  ldx.w #$0000    // Load Track Number 0
  stx.w MSU_TRACK // $2004: MSU1 Track Register
  MSUWaitAudioBusy() // Wait For MSU1 Audio Busy Flag Status Bit To Clear

  lda.b #%00000011  // Play & Repeat Sound (%000000RP R = Repeat On/Off, P = Play On/Off)
  sta.w MSU_CONTROL // $2007: MSU1 Control Register

Loop:
  jmp Loop

// SPC Code
// BANK 0
insert SPCROM, "AUDIO.spc"