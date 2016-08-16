// SNES SPC700 Italo Disco Test Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "ItaloTest.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

constant BassDrumC9Pitch($8000)
constant SnareC9Pitch($8000)
constant HihatClosedC9Pitch($8000)
constant TomtomFloorC9Pitch($8000)
constant BassGuitarC9Pitch($A820)
constant BassSynthC9Pitch($B2C8)
constant ElectroSynthC9Pitch($8610)
constant SynthC9Pitch($FB00)
constant HandClapC9Pitch($8000)

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00)  // Reset Key Off Flags
  WDSP(DSP_MVOLL,127) // Master Volume Left
  WDSP(DSP_MVOLR,127) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,12)   // Echo Delay
  WDSP(DSP_EON,%11110000) // Echo On Flags
  WDSP(DSP_FLG,0)    // Enable Echo Buffer Writes
  WDSP(DSP_EFB,50)   // Echo Feedback
  WDSP(DSP_FIR0,12)  // Echo FIR Filter Coefficient 0
  WDSP(DSP_FIR1,33)  // Echo FIR Filter Coefficient 1
  WDSP(DSP_FIR2,43)  // Echo FIR Filter Coefficient 2
  WDSP(DSP_FIR3,43)  // Echo FIR Filter Coefficient 3
  WDSP(DSP_FIR4,19)  // Echo FIR Filter Coefficient 4
  WDSP(DSP_FIR5,-2)  // Echo FIR Filter Coefficient 5
  WDSP(DSP_FIR6,-13) // Echo FIR Filter Coefficient 6
  WDSP(DSP_FIR7,-7)  // Echo FIR Filter Coefficient 7
  WDSP(DSP_EVOLL,40) // Echo Volume Left
  WDSP(DSP_EVOLR,30) // Echo Volume Right

  WDSP(DSP_V0VOLL,64)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,64)   // Voice 0: Volume Right
  WDSP(DSP_V0SRCN,0)    // Voice 0: BassDrum
  WDSP(DSP_V0ADSR1,$FF) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$E0) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)  // Voice 0: Gain

  WDSP(DSP_V1VOLL,64)   // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,64)   // Voice 1: Volume Right
  WDSP(DSP_V1SRCN,1)    // Voice 1: Snare
  WDSP(DSP_V1ADSR1,$FF) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$E0) // Voice 1: ADSR2
  WDSP(DSP_V1GAIN,127)  // Voice 1: Gain

  WDSP(DSP_V2VOLL,48)   // Voice 2: Volume Left
  WDSP(DSP_V2VOLR,48)   // Voice 2: Volume Right
  WDSP(DSP_V2SRCN,2)    // Voice 2: HihatClosed
  WDSP(DSP_V2ADSR1,$FF) // Voice 2: ADSR1
  WDSP(DSP_V2ADSR2,$E0) // Voice 2: ADSR2
  WDSP(DSP_V2GAIN,127)  // Voice 2: Gain

  WDSP(DSP_V3VOLL,127)  // Voice 3: Volume Left
  WDSP(DSP_V3VOLR,127)  // Voice 3: Volume Right
  WDSP(DSP_V3SRCN,3)    // Voice 3: TomtomFloor
  WDSP(DSP_V3ADSR1,$FF) // Voice 3: ADSR1
  WDSP(DSP_V3ADSR2,$E0) // Voice 3: ADSR2
  WDSP(DSP_V3GAIN,127)  // Voice 3: Gain

  WDSP(DSP_V4VOLL,64)   // Voice 4: Volume Left
  WDSP(DSP_V4VOLR,64)   // Voice 4: Volume Right
  WDSP(DSP_V4SRCN,4)    // Voice 4: BassGuitar
  WDSP(DSP_V4ADSR1,$FC) // Voice 4: ADSR1
  WDSP(DSP_V4ADSR2,$FE) // Voice 4: ADSR2
  WDSP(DSP_V4GAIN,127)  // Voice 4: Gain

  WDSP(DSP_V5VOLL,127)  // Voice 5: Volume Left
  WDSP(DSP_V5VOLR,127)  // Voice 5: Volume Right
  WDSP(DSP_V5SRCN,5)    // Voice 5: BassSynth
  WDSP(DSP_V5ADSR1,$FF) // Voice 5: ADSR1
  WDSP(DSP_V5ADSR2,$F8) // Voice 5: ADSR2
  WDSP(DSP_V5GAIN,127)  // Voice 5: Gain

  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6GAIN,127)  // Voice 6: Gain

  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7GAIN,127)  // Voice 7: Gain

  SetPitch(0,A,5,BassDrumC9Pitch)
  SetPitch(1,A,5,SnareC9Pitch)
  SetPitch(2,A,6,HihatClosedC9Pitch)
  SetPitch(3,E,5,TomtomFloorC9Pitch)
  SetPitch(4,A,5,BassGuitarC9Pitch)

SongStart:
  // Load Loops To Stack ($01EF)
  lda #4 // Loop5
  pha
  lda #2 // Loop4
  pha
  lda #2 // Loop3
  pha
  lda #8 // Loop2
  pha
  lda #8 // Loop1
  pha

  WDSP(DSP_KON,%00001000) // Play Voice 3
  SPCWaitMS(240) // Wait 240 ms

Loop1:
  WDSP(DSP_KON,%00010101) // Play Voice 0,2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  WDSP(DSP_KON,%00010100) // Play Voice 2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  WDSP(DSP_KON,%00010111) // Play Voice 0,1,2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  WDSP(DSP_KON,%00010100) // Play Voice 2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  pla // Check Loop Amount
  dec
  beq Loop2
  pha
  jmp Loop1

Loop2:
  SetPitch(5,A,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110111) // Play Voice 0,1,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  pla // Check Loop Amount
  dec
  beq Loop3
  pha
  jmp Loop2

Loop3:
  WDSP(DSP_V6SRCN,6) // Voice 6: ElectroSynth
  WDSP(DSP_V7SRCN,5) // Voice 7: BassSynth
  WDSP(DSP_V6VOLL,32) // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,32) // Voice 6: Volume Right
  WDSP(DSP_V7VOLL,8) // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,8) // Voice 7: Volume Right
  WDSP(DSP_V6ADSR2,$F0) // Voice 6: ADSR2
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,A,4,ElectroSynthC9Pitch)
  SetPitch(7,A,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%11110101) // Play Voice 0,2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,E,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(6,C,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,C,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(7,E,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10110101) // Play Voice 0,2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(6,A,4,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,E,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,C,5,ElectroSynthC9Pitch)
  SetPitch(7,C,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%11110101) // Play Voice 0,2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,G,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(6,E,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,E,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(7,G,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10110101) // Play Voice 0,2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(6,C,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,G,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,E,3,BassSynthC9Pitch)
  SetPitch(6,E,5,ElectroSynthC9Pitch)
  SetPitch(7,E,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%11110101) // Play Voice 0,2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,3,BassSynthC9Pitch)
  SetPitch(6,B,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,4,BassSynthC9Pitch)
  SetPitch(6,G,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,G,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,3,BassSynthC9Pitch)
  SetPitch(7,B,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10110101) // Play Voice 0,2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,4,BassSynthC9Pitch)
  SetPitch(6,E,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,3,BassSynthC9Pitch)
  SetPitch(6,B,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,E,4,BassSynthC9Pitch)
  SetPitch(7,C,6,BassSynthC9Pitch)
  WDSP(DSP_KON,%10110100) // Play Voice 2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,G,5,ElectroSynthC9Pitch)
  SetPitch(7,D,6,BassSynthC9Pitch)
  WDSP(DSP_KON,%11110101) // Play Voice 0,2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,D,6,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,5,BassSynthC9Pitch)
  SetPitch(6,B,5,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,B,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,5,BassSynthC9Pitch)
  SetPitch(6,G,5,ElectroSynthC9Pitch)
  SetPitch(7,G,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%11110100) // Play Voice 2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,D,6,ElectroSynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,5,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  pla // Check Loop Amount
  dec
  beq Loop4
  pha
  jmp Loop3

Loop4:
  WDSP(DSP_V6SRCN,7) // Voice 6: Synth
  WDSP(DSP_V7SRCN,7) // Voice 7: Synth
  WDSP(DSP_V6VOLL,40) // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,40) // Voice 6: Volume Right
  WDSP(DSP_V7VOLL,40) // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,40) // Voice 7: Volume Right
  WDSP(DSP_V6ADSR2,$F8) // Voice 6: ADSR2
  WDSP(DSP_V7ADSR2,$F8) // Voice 7: ADSR2

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,E,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(6,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,3,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,A,4,BassSynthC9Pitch)
  SetPitch(7,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%10110100) // Play Voice 2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,E,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(6,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,C,5,BassSynthC9Pitch)
  SetPitch(7,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%10110100) // Play Voice 2,4,5,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,G,3,BassSynthC9Pitch)
  SetPitch(6,B,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110111) // Play Voice 0,1,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110111) // Play Voice 0,1,2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,G,3,BassSynthC9Pitch)
  SetPitch(6,B,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(7,G,5,SynthC9Pitch)
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110111) // Play Voice 0,1,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110111) // Play Voice 0,1,2,4
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  pla // Check Loop Amount
  dec
  beq Loop5
  pha
  jmp Loop4

Loop5:
  WDSP(DSP_V7SRCN,8) // Voice 7: HandClap
  WDSP(DSP_V7VOLL,64) // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,64) // Voice 7: Volume Right
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2
  SetPitch(7,C,6,HandClapC9Pitch)

  SetPitch(5,F,3,BassSynthC9Pitch)
  SetPitch(6,F,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,B,4,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,E,5,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,3,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,4,BassSynthC9Pitch)
  SetPitch(6,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%11110100) // Play Voice 2,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,3,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%11110111) // Play Voice 0,1,2,4,6,7
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%11010000) // Play Voice 4,6,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,F,4,BassSynthC9Pitch)
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms


  SetPitch(5,G,3,BassSynthC9Pitch)
  SetPitch(6,G,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110101) // Play Voice 0,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,E,5,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  SetPitch(6,C,5,SynthC9Pitch)
  WDSP(DSP_KON,%01110111) // Play Voice 0,1,2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,D,5,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,A,4,SynthC9Pitch)
  WDSP(DSP_KON,%01110100) // Play Voice 2,4,5,6
  SPCWaitMS(120) // Wait 120 ms
  SetPitch(6,E,5,SynthC9Pitch)
  WDSP(DSP_KON,%01010000) // Play Voice 4,6
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110101) // Play Voice 0,2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  SetPitch(6,G,5,SynthC9Pitch)
  WDSP(DSP_KON,%11111100) // Play Voice 2,3,4,5,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,3,BassSynthC9Pitch)
  SetPitch(6,A,5,SynthC9Pitch)
  WDSP(DSP_KON,%11110111) // Play Voice 0,1,2,4,6,7
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%10010000) // Play Voice 4,7
  SPCWaitMS(120) // Wait 120 ms

  SetPitch(5,G,4,BassSynthC9Pitch)
  WDSP(DSP_KON,%00110100) // Play Voice 2,4,5
  SPCWaitMS(120) // Wait 120 ms
  WDSP(DSP_KON,%00010000) // Play Voice 4
  SPCWaitMS(120) // Wait 120 ms

  pla // Check Loop Amount
  dec
  beq Loop6
  pha
  jmp Loop5

Loop6:

jmp SongStart

seek($3A00); sampleDIR:
  dw BassDrum, 0    // 0
  dw Snare, 0       // 1
  dw HihatClosed, 0 // 2
  dw TomtomFloor, 0 // 3
  dw BassGuitar, BassGuitar + 900 // 4
  dw BassSynth, BassSynth + 378   // 5
  dw ElectroSynth, ElectroSynth + 0 // 6
  dw Synth, Synth + 405 // 7
  dw HandClap, 0 // 8

seek($3B00) // Sample Data
  insert BassDrum,     "BRR/101. Axelay. 000. Bass Drum (AD=$FF,SR=$E0)(C9Pitch=$8000).brr"
  insert Snare,        "BRR/101. Axelay. 001. Snare (AD=$FF,SR=$E0)(C9Pitch=$8000).brr"
  insert HihatClosed,  "BRR/101. Axelay. 002. Hi-hat Closed (AD=$FF,SR=$E0)(C9Pitch=$8000).brr"
  insert TomtomFloor,  "BRR/101. Axelay. 003. Tom-tom Floor (AD=$FF,SR=$E0)(C9Pitch=$8000).brr"
  insert BassGuitar,   "BRR/101. Axelay. 020. Bass Guitar (Loop=900,AD=$F0,SR=$E2)(C9Freq=$A820).brr"
  insert BassSynth,    "BRR/102. Set Up. 014. Bass Synth (Loop=378,AD=$FF,SR=$E0)(C9Freq=$B2C8).brr"
  insert ElectroSynth, "BRR/203. Techno de Chocobo. 002. Electro Synth (Loop=0,AD=$FF,SR=$E0,Echo)(C9Freq=$8610).brr"
  insert Synth,        "BRR/01. Halken Logo. 020. Synth (Loop=405,AD=$FF,SR=$EF)(C9Freq=$FB00).brr"
  insert HandClap,     "BRR/104. Always Together. 034. Hand Clap (AD=$FF,SR=$E0)(C9Pitch=$8000).brr"