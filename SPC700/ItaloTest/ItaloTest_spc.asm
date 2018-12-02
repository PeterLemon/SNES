// SNES SPC700 Italo Disco Test Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "ItaloTest.spc", create

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
constant MaxQuant(120) // Maximum Quantization ms
constant PatternSize(64) // Pattern Size (1..256)
constant ChannelCount(10) // Channel Count (1 For Each Sample)

// Setup Zero Page RAM
constant PATTERN($00) // Pattern Zero Page RAM Address
constant PATTERNOFS($02) // Pattern Offset Zero Page RAM Address

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

  WDSP(DSP_V6VOLL,32)   // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,32)   // Voice 6: Volume Right
  WDSP(DSP_V6SRCN,6)    // Voice 6: ElectroSynth
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$F0) // Voice 6: ADSR2
  WDSP(DSP_V6GAIN,127)  // Voice 6: Gain

  WDSP(DSP_V7VOLL,8)    // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,8)    // Voice 7: Volume Right
  WDSP(DSP_V7SRCN,5)    // Voice 7: BassSynth
  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2
  WDSP(DSP_V7GAIN,127)  // Voice 7: Gain

StartSong: // Each Bar = 1920ms, Each Beat = 480ms, 3/4 Beat = 360ms, 1/2 Beat = 240ms, 1/4 Beat 120ms
  lda #PATTERNLIST    // A = Pattern List (LSB)
  ldy #PATTERNLIST>>8 // Y = Pattern List (MSB)
  stw PATTERNOFS      // Store YA To Zero Page RAM

  ldy #0 // Y = 0 (Pattern Offset Index)

LoopSong:
  ChannelPattern(0, 0, BassDrumPitchTable)     // Channel 1  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(1, 1, SnarePitchTable)        // Channel 2  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(2, 2, HihatClosedPitchTable)  // Channel 3  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(3, 3, TomtomFloorPitchTable)  // Channel 4  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(4, 4, BassGuitarPitchTable)   // Channel 5  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(5, 5, BassSynthPitchTable)    // Channel 6  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(6, 6, ElectroSynthPitchTable) // Channel 7  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(7, 7, BassSynthPitchTable)    // Channel 8  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(8, 6, SynthPitchTable)        // Channel 9  Pattern Calculation: Channel, Voice, Pitch Table
  ChannelPattern(9, 7, HandClapPitchTable)     // Channel 10 Pattern Calculation: Channel, Voice, Pitch Table

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

  PatternIncrement: // Channel 1..10 Pattern Increment
  ldy #0  // Y = 0
  lda #ChannelCount * 2 // YA = Channel Count * 2
  adw PATTERNOFS // YA += Pattern Offset
  stw PATTERNOFS // Pattern Offset = YA

  // Compare Pattern List Change Address
  lda #PATTERNLISTCHANGE    // A = Pattern List Change (LSB)
  ldy #PATTERNLISTCHANGE>>8 // Y = Pattern List Change (MSB)
  cpw PATTERNOFS            // Compare YA To Zero Page RAM
  bne PatternCmpEnd         // IF (Pattern Offset != Pattern List Change Offset) Pattern Compare End, ELSE Set Pattern Change Offset

  WDSP(DSP_KOFF,%11000000) // DSP Register Data = Key Off Flags

  // Set Synth (Channel 6)
  WDSP(DSP_V6SRCN,7)    // Voice 6: Synth
  WDSP(DSP_V6VOLL,40)   // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,40)   // Voice 6: Volume Right
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$F8) // Voice 6: ADSR2

  // Set Synth (Channel 7)
  WDSP(DSP_V7SRCN,8)    // Voice 7: Hand Clap
  WDSP(DSP_V7VOLL,64)   // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,64)   // Voice 7: Volume Right
  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2

  PatternCmpEnd: // Compare Pattern List End Address
  lda #PATTERNLISTEND    // A = Pattern List End (LSB)
  ldy #PATTERNLISTEND>>8 // Y = Pattern List End (MSB)
  cpw PATTERNOFS         // Compare YA To Zero Page RAM
  bne PatternIncEnd      // IF (Pattern Offset != Pattern List End Offset) Pattern Increment End, ELSE Set Pattern Loop Offset

  // Set Pattern Loop Offset
  lda #PATTERNLISTLOOP    // A = Pattern List Loop (LSB)
  ldy #PATTERNLISTLOOP>>8 // Y = Pattern List Loop (MSB)
  stw PATTERNOFS          // Store YA To Zero Page RAM

  WDSP(DSP_KOFF,%11000000) // DSP Register Data = Key Off Flags

  // Set Electro Synth (Channel 6)
  WDSP(DSP_V6SRCN,6)    // Voice 6: ElectroSynth
  WDSP(DSP_V6VOLL,32)   // Voice 6: Volume Left
  WDSP(DSP_V6VOLR,32)   // Voice 6: Volume Right
  WDSP(DSP_V6ADSR1,$FF) // Voice 6: ADSR1
  WDSP(DSP_V6ADSR2,$F0) // Voice 6: ADSR2

  // Set Bass Synth (Channel 7)
  WDSP(DSP_V7SRCN,5)    // Voice 7: BassSynth
  WDSP(DSP_V7VOLL,8)    // Voice 7: Volume Left
  WDSP(DSP_V7VOLR,8)    // Voice 7: Volume Right
  WDSP(DSP_V7ADSR1,$FF) // Voice 7: ADSR1
  WDSP(DSP_V7ADSR2,$E0) // Voice 7: ADSR2

  PatternIncEnd:
    ldy #0 // Y = 0 (Pattern Index Offset)

  PatternEnd:
    jmp LoopSong // GOTO Loop Song

BassDrumPitchTable:
  WritePitchTable($8000) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
SnarePitchTable:
  WritePitchTable($8000) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
HihatClosedPitchTable:
  WritePitchTable($8000) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
TomtomFloorPitchTable:
  WritePitchTable($8000) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
BassGuitarPitchTable:
  WritePitchTable($A820) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
BassSynthPitchTable:
  WritePitchTable($B2C8) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
ElectroSynthPitchTable:
  WritePitchTable($8610) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
SynthPitchTable:
  WritePitchTable($FB00) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
HandClapPitchTable:
  WritePitchTable($8000) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)

PATTERN00: // Pattern 00: Rest (Channel 1..10)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 1
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 2
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 3
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 4

PATTERN01: // Pattern 01: Sustain (Channel 1..10)
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 1
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 2
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 3
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 4

PATTERN02: // Pattern 02: Bass Drum (Channel 1)
  db A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST // 1
  db A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST // 2
  db A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST // 3
  db A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST, A5,   SUST, SUST, SUST // 4

PATTERN03: // Pattern 03: Snare (Channel 2)
  db SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST // 1
  db SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST // 2
  db SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST // 3
  db SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, A5,   SUST, SUST, SUST // 4

PATTERN04: // Pattern 04: Hihat Closed (Channel 3)
  db A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST // 1
  db A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST // 2
  db A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST // 3
  db A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST, A6,   SUST // 4

PATTERN05: // Pattern 05: Tomtom Floor (Channel 4)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 25
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 26
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 27
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, E5,   SUST, SUST, SUST, SUST, SUST // 28

PATTERN06: // Pattern 06: Bass Guitar (Channel 5)
  db A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5   // 1
  db A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5   // 2
  db A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5   // 3
  db A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5,   A5   // 4

PATTERN07: // Pattern 07: Bass Synth (Channel 6)
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 5
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 6
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 7
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 8
PATTERN08: // Pattern 08: Bass Synth (Channel 6)
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 9
  db C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST // 10
  db E3,   SUST, E4,   SUST, E3,   SUST, E4,   SUST, E3,   SUST, E4,   SUST, E3,   SUST, E4,   SUST // 11
  db G4,   SUST, G5,   SUST, G4,   SUST, G5,   SUST, G4,   SUST, G5,   SUST, G4,   SUST, G5,   SUST // 12
PATTERN09: // Pattern 09: Bass Synth (Channel 6)
  db A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST, A3,   SUST, A4,   SUST // 17
  db C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST, C4,   SUST, C5,   SUST // 18
  db G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST // 19
  db G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST // 20
PATTERN10: // Pattern 10: Bass Synth (Channel 6)
  db F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST // 25
  db G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST // 26
  db F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST, F3,   SUST, F4,   SUST // 27
  db G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST, G3,   SUST, G4,   SUST // 28

PATTERN11: // Pattern 11: Electro Synth (Channel 7)
  db A4,   SUST, SUST, SUST, E5,   SUST, C5,   SUST, SUST, SUST, A4,   SUST, E5,   SUST, SUST, SUST // 9
  db C5,   SUST, SUST, SUST, G5,   SUST, E5,   SUST, SUST, SUST, C5,   SUST, G5,   SUST, SUST, SUST // 10
  db E5,   SUST, SUST, SUST, B5,   SUST, G5,   SUST, SUST, SUST, E5,   SUST, B5,   SUST, SUST, SUST // 11
  db G5,   SUST, SUST, SUST, D6,   SUST, B5,   SUST, SUST, SUST, G5,   SUST, D6,   SUST, SUST, SUST // 12

PATTERN12: // Pattern 12: Bass Synth (Channel 8)
  db A4,   SUST, SUST, SUST, SUST, SUST, SUST, C5,   E5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 9
  db C5,   SUST, SUST, SUST, SUST, SUST, SUST, E5,   G5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 10
  db E5,   SUST, SUST, SUST, SUST, SUST, SUST, G5,   B5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST // 11
  db D6,   SUST, SUST, SUST, SUST, SUST, SUST, B5,   SUST, SUST, G5,   SUST, SUST, SUST, SUST, SUST // 12

PATTERN13: // Pattern 13: Synth (Channel 9)
  db G4,   A4,   C5,   E5,   C5,   D5,   G4,   C5,   SUST, SUST, D5,   A4,   C5,   SUST, D5,   SUST // 17
  db G4,   A4,   C5,   E5,   C5,   D5,   G4,   C5,   SUST, SUST, D5,   A4,   C5,   SUST, D5,   SUST // 18
  db B4,   C5,   D5,   G4,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 19
  db B4,   C5,   D5,   G5,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 20
PATTERN14: // Pattern 14: Synth (Channel 9)
  db F4,   B4,   C5,   E5,   C5,   D5,   A4,   SUST, SUST, SUST, C5,   SUST, D5,   C5,   D5,   SUST // 17
  db G4,   A4,   C5,   E5,   C5,   D5,   A4,   E5,   SUST, SUST, G5,   SUST, A5,   SUST, SUST, SUST // 18
  db F4,   B4,   C5,   E5,   C5,   D5,   A4,   SUST, SUST, SUST, C5,   SUST, D5,   C5,   D5,   SUST // 19
  db G4,   A4,   C5,   E5,   C5,   D5,   A4,   E5,   SUST, SUST, G5,   SUST, A5,   SUST, SUST, SUST // 20

PATTERN15: // Pattern 15: Hand Clap (Channel 10)
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, C6,   SUST, C6,   C6,   SUST, SUST // 25
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, C6,   SUST, C6,   C6,   SUST, SUST // 26
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, C6,   SUST, C6,   C6,   SUST, SUST // 27
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, C6,   SUST, C6,   C6,   SUST, SUST // 28

PATTERNLIST:
PATTERNLISTLOOP:
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN00,PATTERN00,PATTERN00,PATTERN00,PATTERN00 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN07,PATTERN00,PATTERN00,PATTERN00,PATTERN00 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN08,PATTERN11,PATTERN12,PATTERN01,PATTERN01 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN08,PATTERN11,PATTERN12,PATTERN01,PATTERN01 // Channel 1..11 Pattern Address List
PATTERNLISTCHANGE:
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN09,PATTERN01,PATTERN01,PATTERN13,PATTERN01 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN00,PATTERN06,PATTERN09,PATTERN01,PATTERN01,PATTERN13,PATTERN01 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN05,PATTERN06,PATTERN10,PATTERN01,PATTERN01,PATTERN14,PATTERN15 // Channel 1..11 Pattern Address List
  dw PATTERN02,PATTERN03,PATTERN04,PATTERN05,PATTERN06,PATTERN10,PATTERN01,PATTERN01,PATTERN14,PATTERN15 // Channel 1..11 Pattern Address List
PATTERNLISTEND:

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