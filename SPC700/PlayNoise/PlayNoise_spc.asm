// SNES SPC700 Play Noise Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "PlayNoise.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,5)    // Echo Delay
  WDSP(DSP_EON,%00000001) // Echo On Flags
  WDSP(DSP_NON,%00000001) // Noise On Flags
  WDSP(DSP_FLG,0)    // Enable Echo Buffer Writes
  WDSP(DSP_EFB,80)   // Echo Feedback
  WDSP(DSP_FIR0,127) // Echo FIR Filter Coefficient 0
  WDSP(DSP_FIR1,0)   // Echo FIR Filter Coefficient 1
  WDSP(DSP_FIR2,0)   // Echo FIR Filter Coefficient 2
  WDSP(DSP_FIR3,0)   // Echo FIR Filter Coefficient 3
  WDSP(DSP_FIR4,0)   // Echo FIR Filter Coefficient 4
  WDSP(DSP_FIR5,0)   // Echo FIR Filter Coefficient 5
  WDSP(DSP_FIR6,0)   // Echo FIR Filter Coefficient 6
  WDSP(DSP_FIR7,0)   // Echo FIR Filter Coefficient 7
  WDSP(DSP_EVOLL,25) // Echo Volume Left
  WDSP(DSP_EVOLR,25) // Echo Volume Right

SongStart:
  WDSP(DSP_V0VOLL,127)        // Voice 0; Volume Left
  WDSP(DSP_V0VOLR,127)        // Voice 0; Volume Right
  WDSP(DSP_V0GAIN,127)        // Voice 0: Gain

Loop:
// Kick
  WDSP(DSP_FLG,14)   // Enable Echo Buffer Writes, Noise Frequency = 14Hz
  WDSP(DSP_V0ADSR1,%10001110) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11110110) // Voice 0: ADSR2
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(240,1) // Wait 240*2 ms

// Hi-Hat Closed
  WDSP(DSP_FLG,30)   // Enable Echo Buffer Writes, Noise Frequency = 16kHz
  WDSP(DSP_V0ADSR1,%10101111) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111100) // Voice 0: ADSR2
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(240) // Wait 240 ms

// Hi-Hat Open
  WDSP(DSP_FLG,30)   // Enable Echo Buffer Writes, Noise Frequency = 16kHz
  WDSP(DSP_V0ADSR1,%10001100) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%10011100) // Voice 0: ADSR2
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(240) // Wait 240 ms

// Snare
  WDSP(DSP_FLG,29)   // Enable Echo Buffer Writes, Noise Frequency = 8kHz
  WDSP(DSP_V0ADSR1,%11111010) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11111000) // Voice 0: ADSR2
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(240,2) // Wait 240*4 ms

  jmp Loop