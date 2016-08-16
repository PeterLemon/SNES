// SNES SPC700 Play Two Song Demo (CPU Code) by krom (Peter Lemon):
arch snes.cpu
output "PlayTwoSong.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $10000 // Fill Upto $FFFF (Bank 1) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_INPUT.INC"  // Include Input Macros
include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

InputLoop:
  PressA:
    ReadJOY({JOY_A}) // Test A Button
    beq PressB // "A" Not Pressed? Branch Down

    lda.b $01 // Uses "1" For Reset Check
    sta.w REG_APUIO0 // Run A Handshake Between CPU<->APU

    SPCWaitBoot() // Wait For SPC To Boot
    TransferBlockSPC(SPCROM1, SPCRAM, SPCROM1.size) // Load SPC File To SMP/DSP
    SPCExecute(SPCRAM) // Execute SPC At $0200

  PressB:
    ReadJOY({JOY_B}) // Test B Button
    beq Finish // "B" Not Pressed? Branch Down

    lda.b $01 // Uses "1" For Reset Check
    sta.w REG_APUIO0 // Run A Handshake Between CPU<->APU

    SPCWaitBoot() // Wait For SPC To Boot
    TransferBlockSPC(SPCROM2, SPCRAM, SPCROM2.size) // Load SPC File To SMP/DSP
    SPCExecute(SPCRAM) // Execute SPC At $0200

Finish:
  jmp InputLoop

// SPC Code
// BANK 0
insert SPCROM1, "PlayTwoSong1.spc"
// BANK 1
seek($18000)
insert SPCROM2, "PlayTwoSong2.spc"