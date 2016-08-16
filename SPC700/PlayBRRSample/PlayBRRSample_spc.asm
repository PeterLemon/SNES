// SNES SPC700 Play BRR Sample Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "PlayBRRSample.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,5)    // Echo Delay
  WDSP(DSP_EON,%00000001) // Echo On Flags
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
  WDSP(DSP_V0PITCHL,$00)      // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$10)      // Voice 0: Pitch (Upper Byte)
  WDSP(DSP_V0SRCN,0)          // Voice 0: Sample
  WDSP(DSP_V0ADSR1,%11111010) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,%11100000) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)        // Voice 0: Gain
  WDSP(DSP_KON,%00000001) // Play Voice 0

Loop:
  jmp Loop

seek($0300); sampleDIR:
  dw BRRSample, BRRSample + ((2032 / 16) * 9) // BRR Sample Offset, Loop Point

seek($0400) // Sample Data
  insert BRRSample, "test.brr"