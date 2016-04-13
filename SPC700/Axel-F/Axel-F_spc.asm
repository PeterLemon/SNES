// SNES SPC700 Axel-F Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "Axel-F.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

include "LIB\SNES_SPC700.INC" // Include SPC700 Definitions & Macros

constant SawToothC9Pitch($8868)

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$88)  // Echo Source Address
  WDSP(DSP_EDL,15)   // Echo Delay
  WDSP(DSP_EON,%11111111) // Echo On Flags
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

  WDSP(DSP_V0VOLL,25)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,25)   // Voice 0: Volume Right
  WDSP(DSP_V0SRCN,0)    // Voice 0: SawTooth
  WDSP(DSP_V0ADSR1,$FA) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$F0) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)  // Voice 0: Gain

SongStart:
  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(196, 1) // Wait 196*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,ASharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(128, 1) // Wait 128*2 ms

  SetPitch(0,DSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(256, 1) // Wait 256*2 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(196, 1) // Wait 196*2 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(128) // Wait 128 ms

  SetPitch(0,CSharp,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,C,6,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(128, 1) // Wait 128*2 ms

  SetPitch(0,GSharp,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitMS(256) // Wait 256 ms

  SetPitch(0,F,5,SawToothC9Pitch)
  WDSP(DSP_KON,%00000001) // Play Voice 0
  SPCWaitSHIFTMS(128, 1) // Wait 128*2 ms

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

  SetPitch(0,DSharp,5,SawToothC9Pitch)
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
  SPCWaitSHIFTMS(256, 3) // Wait 256*8 ms
  
jmp SongStart

seek($1A00); sampleDIR:
  dw SawTooth, SawTooth + 2691 // 0

seek($1B00) // Sample Data
  insert SawTooth, "BRR\MSAWTOOF(Loop=2691,AD=$FA,SR=$F0,Echo)(C9Pitch=$8868).brr"