// SNES SPC700 Play Two Song Demo, Song 1 (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "PlayTwoSong1.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - {SPCRAM})
  base offset
}

include "LIB\SNES_SPC700.INC" // Include SPC700 Definitions & Macros

define HarpC9Pitch($C900)

seek({SPCRAM}); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP({DSP_DIR},sampleDIR >> 8) // Sample Directory Offset

  WDSP({DSP_KOFF},$00) // Reset Key Off Flags
  WDSP({DSP_MVOLL},63) // Master Volume Left
  WDSP({DSP_MVOLR},63) // Master Volume Right

  SPCRAMClear($8800,$78) // Clear Echo Buffer RAM
  WDSP({DSP_ESA},$88)    // Echo Source Address
  WDSP({DSP_EDL},15)     // Echo Delay
  WDSP({DSP_EON},%11111111) // Echo On Flags
  WDSP({DSP_FLG},0)    // Enable Echo Buffer Writes
  WDSP({DSP_EFB},100)  // Echo Feedback
  WDSP({DSP_FIR0},127) // Echo FIR Filter Coefficient 0
  WDSP({DSP_FIR1},0)   // Echo FIR Filter Coefficient 1
  WDSP({DSP_FIR2},0)   // Echo FIR Filter Coefficient 2
  WDSP({DSP_FIR3},0)   // Echo FIR Filter Coefficient 3
  WDSP({DSP_FIR4},0)   // Echo FIR Filter Coefficient 4
  WDSP({DSP_FIR5},0)   // Echo FIR Filter Coefficient 5
  WDSP({DSP_FIR6},0)   // Echo FIR Filter Coefficient 6
  WDSP({DSP_FIR7},0)   // Echo FIR Filter Coefficient 7
  WDSP({DSP_EVOLL},25) // Echo Volume Left
  WDSP({DSP_EVOLR},25) // Echo Volume Right

  WDSP({DSP_V0VOLL},25)   // Voice 0: Volume Left
  WDSP({DSP_V0VOLR},25)   // Voice 0: Volume Right
  WDSP({DSP_V0SRCN},0)    // Voice 0: Harp
  WDSP({DSP_V0ADSR1},$FF) // Voice 0: ADSR1
  WDSP({DSP_V0ADSR2},$F0) // Voice 0: ADSR2
  WDSP({DSP_V0GAIN},127)  // Voice 0: Gain

  WDSP({DSP_V1VOLL},25)   // Voice 1: Volume Left
  WDSP({DSP_V1VOLR},25)   // Voice 1: Volume Right
  WDSP({DSP_V1SRCN},0)    // Voice 1: Harp
  WDSP({DSP_V1ADSR1},$FF) // Voice 1: ADSR1
  WDSP({DSP_V1ADSR2},$F0) // Voice 1: ADSR2
  WDSP({DSP_V1GAIN},127)  // Voice 1: Gain

  WDSP({DSP_V2VOLL},25)   // Voice 2: Volume Left
  WDSP({DSP_V2VOLR},25)   // Voice 2: Volume Right
  WDSP({DSP_V2SRCN},0)    // Voice 2: Harp
  WDSP({DSP_V2ADSR1},$FF) // Voice 2: ADSR1
  WDSP({DSP_V2ADSR2},$F0) // Voice 2: ADSR2
  WDSP({DSP_V2GAIN},127)  // Voice 2: Gain

  WDSP({DSP_V3VOLL},25)   // Voice 3: Volume Left
  WDSP({DSP_V3VOLR},25)   // Voice 3: Volume Right
  WDSP({DSP_V3SRCN},0)    // Voice 3: Harp
  WDSP({DSP_V3ADSR1},$FF) // Voice 3: ADSR1
  WDSP({DSP_V3ADSR2},$F0) // Voice 3: ADSR2
  WDSP({DSP_V3GAIN},127)  // Voice 3: Gain

  WDSP({DSP_V4VOLL},25)   // Voice 4: Volume Left
  WDSP({DSP_V4VOLR},25)   // Voice 4: Volume Right
  WDSP({DSP_V4SRCN},0)    // Voice 4: Harp
  WDSP({DSP_V4ADSR1},$FF) // Voice 4: ADSR1
  WDSP({DSP_V4ADSR2},$F0) // Voice 4: ADSR2
  WDSP({DSP_V4GAIN},127)  // Voice 4: Gain

  WDSP({DSP_V5VOLL},25)   // Voice 5: Volume Left
  WDSP({DSP_V5VOLR},25)   // Voice 5: Volume Right
  WDSP({DSP_V5SRCN},0)    // Voice 5: Harp
  WDSP({DSP_V5ADSR1},$FF) // Voice 5: ADSR1
  WDSP({DSP_V5ADSR2},$F0) // Voice 5: ADSR2
  WDSP({DSP_V5GAIN},127)  // Voice 5: Gain

  WDSP({DSP_V6VOLL},25)   // Voice 6: Volume Left
  WDSP({DSP_V6VOLR},25)   // Voice 6: Volume Right
  WDSP({DSP_V6SRCN},0)    // Voice 6: Harp
  WDSP({DSP_V6ADSR1},$FF) // Voice 6: ADSR1
  WDSP({DSP_V6ADSR2},$F0) // Voice 6: ADSR2
  WDSP({DSP_V6GAIN},127)  // Voice 6: Gain

SongStart:
  jsr ResetCheck
  SetPitch(0,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{A},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{A},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms


  jsr ResetCheck
  SetPitch(0,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms


  jsr ResetCheck
  SetPitch(0,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms


  jsr ResetCheck
  SetPitch(0,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms


  jsr ResetCheck
  SetPitch(0,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{A},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{A},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{G},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms


  jsr ResetCheck
  SetPitch(0,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000001) // Play Voice 0
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(1,{F},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000010) // Play Voice 1
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(2,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00000100) // Play Voice 2
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(3,{E},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00001000) // Play Voice 3
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(4,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00010000) // Play Voice 4
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(5,{D},5,{HarpC9Pitch})
  WDSP({DSP_KON},%00100000) // Play Voice 5
  SPCWaitMS(255) // Wait 255 Ms

  jsr ResetCheck
  SetPitch(6,{C},5,{HarpC9Pitch})
  WDSP({DSP_KON},%01000000) // Play Voice 6
  SPCWaitMS(255) // Wait 255 Ms
  SPCWaitMS(255) // Wait 255 Ms

jmp SongStart

ResetCheck:
  lda #$00
  cmp {REG_CPUIO0} // Wait For Echo
  bne PlaySong // IF (!= 0) PlaySong, ELSE Run Boot ROM

  WDSP({DSP_KON},$00)  // Reset Key On Flags
  WDSP({DSP_KOFF},$FF) // Set Key Off Flags
  SPCBoot() // Reboot SPC
PlaySong:
  rts

seek($0B00); sampleDIR:
  dw Harp, Harp + 927 // 0

seek($0C00) // Sample Data
  insert Harp, "BRR\034. Harp (Loop=927,AD=$FF,SR=$F0,Echo)(C9Freq=$C900).brr"