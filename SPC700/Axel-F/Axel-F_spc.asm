// SNES SPC700 Axel-F Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "Axel-F.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB\SNES_SPC700.INC" // Include SPC700 Definitions & Macros

constant SawToothC9Pitch($8868)
constant SawToothDetuneC9Pitch($8748)
constant SynthBassC9Pitch($8868)

constant KickDrumC9Pitch($8868)
constant SnareC9Pitch($9668)

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,15)   // Echo Delay
  WDSP(DSP_EON,%00111011) // Echo On Flags
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

  WDSP(DSP_V0VOLL,50)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,50)   // Voice 0: Volume Right
  WDSP(DSP_V0SRCN,0)    // Voice 0: SawTooth
  WDSP(DSP_V0ADSR1,$FA) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$F0) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)  // Voice 0: Gain

  WDSP(DSP_V1VOLL,50)   // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,50)   // Voice 1: Volume Right
  WDSP(DSP_V1SRCN,0)    // Voice 1: SawTooth
  WDSP(DSP_V1ADSR1,$FA) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$F0) // Voice 1: ADSR2
  WDSP(DSP_V1GAIN,127)  // Voice 1: Gain

  WDSP(DSP_V2VOLL,127)  // Voice 2: Volume Left
  WDSP(DSP_V2VOLR,127)  // Voice 2: Volume Right
  WDSP(DSP_V2SRCN,1)    // Voice 2: SynthBass
  WDSP(DSP_V2ADSR1,$FF) // Voice 2: ADSR1
  WDSP(DSP_V2ADSR2,$F0) // Voice 2: ADSR2
  WDSP(DSP_V2GAIN,127)  // Voice 2: Gain


  WDSP(DSP_V6VOLL,127)  // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,127)  // Voice 6: Volume Right
  WDSP(DSP_V6SRCN,3)    // Voice 6: Snare
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$F0) // Voice 6: ADSR2
  WDSP(DSP_V6GAIN,127)  // Voice 6: Gain

  WDSP(DSP_V7VOLL,127)  // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,127)  // Voice 7: Volume Right
  WDSP(DSP_V7SRCN,2)    // Voice 7: KickDrum
  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7ADSR2,$F0) // Voice 7: ADSR2
  WDSP(DSP_V7GAIN,127)  // Voice 7: Gain

  SetPitch(6,C,9,SnareC9Pitch)
  SetPitch(7,C,9,KickDrumC9Pitch)

SongStart: // Each Bar = 2048ms, Each Beat = 512ms, 3/4 Beat = 384ms, 1/2 Beat = 256ms, 1/4 Beat 128ms
// Lead Section
  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,ASharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,CSharp,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,C,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,G,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  // Rest
  SPCWaitSHIFTMS(256, 3) // Wait 256*8 ms


// Dual Lead Section
  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  SetPitch(1,GSharp,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,ASharp,5,SawToothC9Pitch)
  SetPitch(1,ASharp,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  SetPitch(1,DSharp,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,CSharp,6,SawToothC9Pitch)
  SetPitch(1,CSharp,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  SetPitch(1,GSharp,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,6,SawToothC9Pitch)
  SetPitch(1,F,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  SetPitch(1,DSharp,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,C,5,SawToothC9Pitch)
  SetPitch(1,C,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,G,5,SawToothC9Pitch)
  SetPitch(1,G,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  // Rest
  SPCWaitSHIFTMS(256, 3) // Wait 256*8 ms


// Bass Section
  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(160, 2) // Wait 160*4 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,CSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,CSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(144, 3) // Wait 144*8 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,ASharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,GSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


// Bass Section, Kick Drum
  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(160, 2) // Wait 160*4 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000100) // Play Voice 2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,CSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(2,CSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  WDSP(DSP_KON,%10000000) // Play Voice 7
  SPCWaitSHIFTMS(160, 2) // Wait 160*4 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,ASharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,GSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms


Loop:
// Dual Lead Section, Bass Section, Kick Drum, Snare
  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  SetPitch(1,GSharp,5,SawToothDetuneC9Pitch)
  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%01000111) // Play Voice 0,1,2,6
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,ASharp,5,SawToothC9Pitch)
  SetPitch(1,ASharp,5,SawToothDetuneC9Pitch)
  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%01000111) // Play Voice 0,1,2,6
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  SetPitch(1,DSharp,5,SawToothDetuneC9Pitch)
  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000111) // Play Voice 0,1,2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%11000111) // Play Voice 0,1,2,6,7
  SPCWaitSHIFTMS(192, 1) // Wait 192*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,CSharp,6,SawToothC9Pitch)
  SetPitch(1,CSharp,6,SawToothDetuneC9Pitch)
  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%01000111) // Play Voice 0,1,2,6
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  SetPitch(1,GSharp,5,SawToothDetuneC9Pitch)
  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%00000111) // Play Voice 0,1,2
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,CSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  SetPitch(1,C,6,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,6,SawToothC9Pitch)
  SetPitch(1,F,6,SawToothDetuneC9Pitch)
  SetPitch(2,CSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%11000111) // Play Voice 0,1,2,6,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  WDSP(DSP_KON,%00000011) // Play Voice 0,1
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  SetPitch(1,DSharp,5,SawToothDetuneC9Pitch)
  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,DSharp,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,C,5,SawToothC9Pitch)
  SetPitch(1,C,5,SawToothDetuneC9Pitch)
  SetPitch(2,C,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,G,5,SawToothC9Pitch)
  SetPitch(1,G,5,SawToothDetuneC9Pitch)
  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%11000111) // Play Voice 0,1,2,6,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  SetPitch(1,F,5,SawToothDetuneC9Pitch)
  SetPitch(2,DSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000111) // Play Voice 0,1,2,7
  SPCWaitMS(256) // Wait 256 ms


  SetPitch(2,F,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  WDSP(DSP_KON,%11000000) // Play Voice 6,7
  SPCWaitSHIFTMS(160, 2) // Wait 160*4 ms

  SetPitch(2,F,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(2,C,4,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,ASharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%11000100) // Play Voice 2,6,7
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(2,GSharp,3,SynthBassC9Pitch)
  WDSP(DSP_KON,%10000100) // Play Voice 2,7
  SPCWaitMS(256) // Wait 256 ms

jmp Loop

seek($1A00); sampleDIR:
  dw SawTooth, SawTooth + 2691 // 0
  dw SynthBass, 0              // 1
  dw KickDrum, 0               // 2
  dw Snare, 0                  // 3

seek($1B00) // Sample Data
  insert SawTooth, "BRR\MSAWTOOF(Loop=2691,AD=$FA,SR=$F0,Echo)(C9Pitch=$8868).brr"
  insert SynthBass, "BRR\SYNBSS3(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"
  insert Snare, "BRR\SNAREA13(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"
  insert KickDrum, "BRR\KICK5(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"