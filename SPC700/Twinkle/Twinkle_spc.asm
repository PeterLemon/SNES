// SNES SPC700 Twinkle Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "Twinkle.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

macro ChannelPattern(CHANNEL, VOICE, PITCHTABLE) { // Channel Pattern Calculation
  tya // A = Y (Pattern Offset Index)
  tax // X = A (Pattern Offset Index)
  ldy #{CHANNEL}*2 // Y = CHANNEL * 2
  lda (PATTERNOFS),y // A = Pattern List (LSB)
  sta.b PATTERN      // Store A To Zero Page RAM
  iny // Y++
  lda (PATTERNOFS),y // A = Pattern List (MSB)
  sta.b PATTERN+1    // Store A To Zero Page RAM
  txa // A = X (Pattern Offset Index)
  tay // Y = A (Pattern Offset Index)

  lda (PATTERN),y // A = Pattern Byte
  cmp #REST     // Compare A To REST Byte ($FE)
  beq {#}KEYOFF // IF (A == REST) GOTO Key Off
  cmp #SUST     // Compare A To SUST Byte ($FD)
  beq {#}KEYEND // IF (A == SUST) GOTO Key End
  bra {#}KEYON  // ELSE GOTO Key On

  {#}KEYOFF: // Key Off
    WDSP(DSP_KOFF,1<<{VOICE}) // DSP Register Data = Key Off Flags
    bra {#}KEYEND // GOTO Key End

  {#}KEYON: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V{VOICE}PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w {PITCHTABLE},x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V{VOICE}PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w {PITCHTABLE},x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,1<<{VOICE})  // DSP Register Data = Key On Flags
  {#}KEYEND: // Key End
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

// Constants
constant MaxQuant(256) // Maximum Quantization ms
constant PatternSize(8) // Pattern Size (1..256)
constant ChannelCount(7) // Channel Count (1 For Each Sample)

// Setup Zero Page RAM
constant PATTERN($00) // Pattern Zero Page RAM Address
constant PATTERNOFS($02) // Pattern Offset Zero Page RAM Address

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
  WDSP(DSP_V0SRCN,0)    // Voice 0: Harp
  WDSP(DSP_V0ADSR1,$FF) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$F0) // Voice 0: ADSR2
  WDSP(DSP_V0GAIN,127)  // Voice 0: Gain

  WDSP(DSP_V1VOLL,25)   // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,25)   // Voice 1: Volume Right
  WDSP(DSP_V1SRCN,0)    // Voice 1: Harp
  WDSP(DSP_V1ADSR1,$FF) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$F0) // Voice 1: ADSR2
  WDSP(DSP_V1GAIN,127)  // Voice 1: Gain

  WDSP(DSP_V2VOLL,25)   // Voice 2: Volume Left
  WDSP(DSP_V2VOLR,25)   // Voice 2: Volume Right
  WDSP(DSP_V2SRCN,0)    // Voice 2: Harp
  WDSP(DSP_V2ADSR1,$FF) // Voice 2: ADSR1
  WDSP(DSP_V2ADSR2,$F0) // Voice 2: ADSR2
  WDSP(DSP_V2GAIN,127)  // Voice 2: Gain

  WDSP(DSP_V3VOLL,25)   // Voice 3: Volume Left
  WDSP(DSP_V3VOLR,25)   // Voice 3: Volume Right
  WDSP(DSP_V3SRCN,0)    // Voice 3: Harp
  WDSP(DSP_V3ADSR1,$FF) // Voice 3: ADSR1
  WDSP(DSP_V3ADSR2,$F0) // Voice 3: ADSR2
  WDSP(DSP_V3GAIN,127)  // Voice 3: Gain

  WDSP(DSP_V4VOLL,25)   // Voice 4: Volume Left
  WDSP(DSP_V4VOLR,25)   // Voice 4: Volume Right
  WDSP(DSP_V4SRCN,0)    // Voice 4: Harp
  WDSP(DSP_V4ADSR1,$FF) // Voice 4: ADSR1
  WDSP(DSP_V4ADSR2,$F0) // Voice 4: ADSR2
  WDSP(DSP_V4GAIN,127)  // Voice 4: Gain

  WDSP(DSP_V5VOLL,25)   // Voice 5: Volume Left
  WDSP(DSP_V5VOLR,25)   // Voice 5: Volume Right
  WDSP(DSP_V5SRCN,0)    // Voice 5: Harp
  WDSP(DSP_V5ADSR1,$FF) // Voice 5: ADSR1
  WDSP(DSP_V5ADSR2,$F0) // Voice 5: ADSR2
  WDSP(DSP_V5GAIN,127)  // Voice 5: Gain

  WDSP(DSP_V6VOLL,25)   // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,25)   // Voice 6: Volume Right
  WDSP(DSP_V6SRCN,0)    // Voice 6: Harp
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$F0) // Voice 6: ADSR2
  WDSP(DSP_V6GAIN,127)  // Voice 6: Gain

StartSong:
  lda #PATTERNLIST    // A = Pattern List (LSB)
  ldy #PATTERNLIST>>8 // Y = Pattern List (MSB)
  stw PATTERNOFS      // Store YA To Zero Page RAM

  ldy #0 // Y = 0 (Pattern Offset Index)

LoopSong:
  ChannelPattern(0, 0, HarpPitchTable) // Channel 1 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(1, 1, HarpPitchTable) // Channel 2 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(2, 2, HarpPitchTable) // Channel 3 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(3, 3, HarpPitchTable) // Channel 4 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(4, 4, HarpPitchTable) // Channel 5 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(5, 5, HarpPitchTable) // Channel 6 Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(6, 6, HarpPitchTable) // Channel 7 Pattern Calculation: Channel, Voice, Pitch Table

  // Wait For MilliSecond Amount (8kHz Timer)
  lda #MaxQuant // Granularity = 1ms, Max Wait = 256ms
  str REG_T0DIV=#8 // 8kHz Clock Divider 8 = 1024 Clock Ticks (1ms)
  str REG_CONTROL=#$01
  WaitMS:
    bbc REG_T0OUT:0=WaitMS // IF (REG_T0OUT.BIT0 == 0) Wait For Timer
    dec // A--
    bne WaitMS // IF (A != 0) Loop Timer Wait

  iny // Increment Pattern Index Offset
  cpy #PatternSize // Compare Y To Pattern Size
  beq PatternIncrement // IF (Y == Pattern Size) Pattern Increment
  jmp PatternEnd // ELSE Pattern End

  PatternIncrement: // Channel 1..8 Pattern Increment
  ldy #0  // Y = 0
  lda #ChannelCount * 2 // YA = Channel Count * 2
  adw PATTERNOFS // YA += Pattern Offset
  stw PATTERNOFS // Pattern Offset = YA

  // Compare Pattern List End Address
  lda #PATTERNLISTEND    // A = Pattern List End (LSB)
  ldy #PATTERNLISTEND>>8 // Y = Pattern List End (MSB)
  cpw PATTERNOFS         // Compare YA To Zero Page RAM
  bne PatternIncEnd      // IF (Pattern Offset != Pattern List End Offset) Pattern Increment End, ELSE Set Pattern Loop Offset

  // Set Pattern Loop Offset
  lda #PATTERNLISTLOOP    // A = Pattern List Loop (LSB)
  ldy #PATTERNLISTLOOP>>8 // Y = Pattern List Loop (MSB)
  stw PATTERNOFS          // Store YA To Zero Page RAM

  PatternIncEnd:
    ldy #0 // Y = 0 (Pattern Index Offset)

  PatternEnd:
    jmp LoopSong // GOTO Loop Song

HarpPitchTable:
  WritePitchTable($C900) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)

PATTERN00: // Pattern 00: Harp (Channel 1)
  db C5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 1
PATTERN01: // Pattern 01: Harp (Channel 1)
  db F5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 2
PATTERN02: // Pattern 02: Harp (Channel 1)
  db G5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 3

PATTERN03: // Pattern 03: Harp (Channel 2)
  db SUST, C5,   SUST, SUST, SUST, SUST, SUST, SUST // 1
PATTERN04: // Pattern 04: Harp (Channel 2)
  db SUST, F5,   SUST, SUST, SUST, SUST, SUST, SUST // 2
PATTERN05: // Pattern 05: Harp (Channel 2)
  db SUST, G5,   SUST, SUST, SUST, SUST, SUST, SUST // 3

PATTERN06: // Pattern 06: Harp (Channel 3)
  db SUST, SUST, G5,   SUST, SUST, SUST, SUST, SUST // 1
PATTERN07: // Pattern 07: Harp (Channel 3)
  db SUST, SUST, E5,   SUST, SUST, SUST, SUST, SUST // 2
PATTERN08: // Pattern 08: Harp (Channel 3)
  db SUST, SUST, F5,   SUST, SUST, SUST, SUST, SUST // 3

PATTERN09: // Pattern 09: Harp (Channel 4)
  db SUST, SUST, SUST, G5,   SUST, SUST, SUST, SUST // 1
PATTERN10: // Pattern 10: Harp (Channel 4)
  db SUST, SUST, SUST, E5,   SUST, SUST, SUST, SUST // 2
PATTERN11: // Pattern 11: Harp (Channel 4)
  db SUST, SUST, SUST, F5,   SUST, SUST, SUST, SUST // 3

PATTERN12: // Pattern 12: Harp (Channel 5)
  db SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST // 1
PATTERN13: // Pattern 13: Harp (Channel 5)
  db SUST, SUST, SUST, SUST, D5,   SUST, SUST, SUST // 2
PATTERN14: // Pattern 14: Harp (Channel 5)
  db SUST, SUST, SUST, SUST, E5,   SUST, SUST, SUST // 3

PATTERN15: // Pattern 15: Harp (Channel 6)
  db SUST, SUST, SUST, SUST, SUST, A5,   SUST, SUST // 1
PATTERN16: // Pattern 16: Harp (Channel 6)
  db SUST, SUST, SUST, SUST, SUST, D5,   SUST, SUST // 2
PATTERN17: // Pattern 17: Harp (Channel 6)
  db SUST, SUST, SUST, SUST, SUST, E5,   SUST, SUST // 3

PATTERN18: // Pattern 18: Harp (Channel 7)
  db SUST, SUST, SUST, SUST, SUST, SUST, G5,   SUST // 1
PATTERN19: // Pattern 19: Harp (Channel 7)
  db SUST, SUST, SUST, SUST, SUST, SUST, C5,   SUST // 2
PATTERN20: // Pattern 20: Harp (Channel 7)
  db SUST, SUST, SUST, SUST, SUST, SUST, D5,   SUST // 3

PATTERNLIST:
PATTERNLISTLOOP:
  dw PATTERN00,PATTERN03,PATTERN06,PATTERN09,PATTERN12,PATTERN15,PATTERN18 // Channel 1..7 Pattern Address List
  dw PATTERN01,PATTERN04,PATTERN07,PATTERN10,PATTERN13,PATTERN16,PATTERN19 // Channel 1..7 Pattern Address List
  dw PATTERN02,PATTERN05,PATTERN08,PATTERN11,PATTERN14,PATTERN17,PATTERN20 // Channel 1..7 Pattern Address List
  dw PATTERN02,PATTERN05,PATTERN08,PATTERN11,PATTERN14,PATTERN17,PATTERN20 // Channel 1..7 Pattern Address List
  dw PATTERN00,PATTERN03,PATTERN06,PATTERN09,PATTERN12,PATTERN15,PATTERN18 // Channel 1..7 Pattern Address List
  dw PATTERN01,PATTERN04,PATTERN07,PATTERN10,PATTERN13,PATTERN16,PATTERN19 // Channel 1..7 Pattern Address List
PATTERNLISTEND:

seek($0A00); sampleDIR:
  dw Harp, Harp + 927 // 0

seek($0B00) // Sample Data
  insert Harp, "BRR/034. Harp (Loop=927,AD=$FF,SR=$F0,Echo)(C9Freq=$C900).brr"