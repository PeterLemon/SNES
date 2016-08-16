// SNES SPC700 Pitch Modulation Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "PitchMod.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

constant CelloC9Pitch($8BB0)

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00)  // Reset Key Off Flags
  WDSP(DSP_MVOLL,127) // Master Volume Left
  WDSP(DSP_MVOLR,127) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,15)   // Echo Delay
  WDSP(DSP_EON,%00000010) // Echo On Flags
  WDSP(DSP_FLG,0)    // Enable Echo Buffer Writes
  WDSP(DSP_EFB,100)  // Echo Feedback
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

  WDSP(DSP_V0SRCN,0) // Voice 0: Sine Wave
  WDSP(DSP_V1SRCN,1) // Voice 1: Strings
  WDSP(DSP_PMON,%00000010) // Pitch Modulation

SongStart:
  WDSP(DSP_V0VOLL,0)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,0)   // Voice 0: Volume Right
  WDSP(DSP_V0GAIN,2)   // Voice 0: Gain

  WDSP(DSP_V1VOLL,127) // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,127) // Voice 1: Volume Right
  WDSP(DSP_V1GAIN,127) // Voice 1: Gain

  WDSP(DSP_V0PITCHL,$03) // Voice 0: Pitch (Lower Byte)
  WDSP(DSP_V0PITCHH,$00) // Voice 0: Pitch (Upper Byte)

  SetPitch(1,C,5,CelloC9Pitch)
  WDSP(DSP_KON,%00000010) // Play Voices
  SPCWaitSHIFTMS(250, 2) // Wait 250*4 ms

  WDSP(DSP_KON,%00000001) // Play Voices

seek($0400); sampleDIR:
  dw sineWave, sineWave   // DIR 0: Sine Wave
  dw Cello, Cello+4167 // DIR 1: Strings Wave

seek($0500) // Sample Data
  sineWave:
    db $C3, $77, $99, $77, $99, $77, $99, $77, $99
  insert Cello, "BRR/032. Cello (Loop=4167,AD=$FF,SR=$E8,Echo)(C9Pitch=$8BB0).brr"