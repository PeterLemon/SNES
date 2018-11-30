// SNES SPC700 Axel-F Song Demo (SPC Code) by krom (Peter Lemon):
arch snes.smp
output "Axel-F.spc", create

macro seek(variable offset) { // Set SPC700 Memory Map
  origin (offset - SPCRAM)
  base offset
}

macro ChannelPattern(CHANNEL, PITCHTABLE) { // Channel Pattern Calculation
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
  bra {#}KEYON  // ELSE GOTO Channel 1: Key On

  {#}KEYOFF: // Key Off
    WDSP(DSP_KOFF,1<<{CHANNEL}) // DSP Register Data = Key Off Flags
    bra {#}KEYEND // GOTO Key End

  {#}KEYON: // Key On
    tax // X = A (Sample Pitch Table Offset)
    str REG_DSPADDR=#DSP_V{CHANNEL}PITCHL // DSP Register Index = Voice Pitch (LSB)
    lda.w {PITCHTABLE},x // A = Voice Pitch (LSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    str REG_DSPADDR=#DSP_V{CHANNEL}PITCHH // DSP Register Index = Voice Pitch (MSB)
    inx // X++ (Increment Sample Pitch Table Offset)
    lda.w {PITCHTABLE},x // A = Voice Pitch (MSB)
    sta.b REG_DSPDATA // DSP Register Data = A

    WDSP(DSP_KOFF,%00000000) // DSP Register Data = Key Off Flags
    WDSP(DSP_KON,1<<{CHANNEL})  // DSP Register Data = Key On Flags
  {#}KEYEND: // Key End
}

include "LIB/SNES_SPC700.INC" // Include SPC700 Definitions & Macros

// Constants
constant MaxQuant(128) // Maximum Quantization ms
constant PatternSize(64) // Pattern Size (1..256)
constant ChannelCount(6) // Channel Count (1..8)

// Setup Zero Page RAM
constant PATTERN($00) // Pattern Zero Page RAM Address
constant PATTERNOFS($02) // Pattern Offset Zero Page RAM Address

seek(SPCRAM); Start:
  SPC_INIT() // Run SPC700 Initialisation Routine

  WDSP(DSP_DIR,sampleDIR >> 8) // Sample Directory Offset

  WDSP(DSP_KOFF,$00) // Reset Key Off Flags
  WDSP(DSP_MVOLL,63) // Master Volume Left
  WDSP(DSP_MVOLR,63) // Master Volume Right

  SPCRAMClear($C000,$40) // Clear Echo Buffer RAM
  WDSP(DSP_ESA,$C0)  // Echo Source Address
  WDSP(DSP_EDL,8)    // Echo Delay
  WDSP(DSP_EON,%00001011) // Echo On Flags
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

  WDSP(DSP_V3VOLL,80)   // Voice 3: Volume Left
  WDSP(DSP_V3VOLR,80)   // Voice 3: Volume Right
  WDSP(DSP_V3SRCN,2)    // Voice 3: Clap
  WDSP(DSP_V3ADSR1,$FF) // Voice 3: ADSR1
  WDSP(DSP_V3ADSR2,$F0) // Voice 3: ADSR2
  WDSP(DSP_V3GAIN,127)  // Voice 3: Gain

  WDSP(DSP_V4VOLL,127)  // Voice 4: Volume Left
  WDSP(DSP_V4VOLR,127)  // Voice 4: Volume Right
  WDSP(DSP_V4SRCN,3)    // Voice 4: KickDrum
  WDSP(DSP_V4ADSR1,$FF) // Voice 4: ADSR1
  WDSP(DSP_V4ADSR2,$F0) // Voice 4: ADSR2
  WDSP(DSP_V4GAIN,127)  // Voice 4: Gain

  WDSP(DSP_V5VOLL,127)  // Voice 5: Volume Left
  WDSP(DSP_V5VOLR,127)  // Voice 5: Volume Right
  WDSP(DSP_V5SRCN,4)    // Voice 5: Snare
  WDSP(DSP_V5ADSR1,$FF) // Voice 5: ADSR1
  WDSP(DSP_V5ADSR2,$F0) // Voice 5: ADSR2
  WDSP(DSP_V5GAIN,127)  // Voice 5: Gain

StartSong: // Each Bar = 2048ms, Each Beat = 512ms, 3/4 Beat = 384ms, 1/2 Beat = 256ms, 1/4 Beat 128ms
  lda #PATTERNLIST    // A = Pattern List (LSB)
  ldy #PATTERNLIST>>8 // Y = Pattern List (MSB)
  stw PATTERNOFS      // Store YA To Zero Page RAM

  ldy #0 // Y = 0 (Pattern Offset Index)

LoopSong:
  ChannelPattern(0, SawToothPitchTable)       // Channel 1 Pattern Calculation
  ChannelPattern(1, SawToothDetunePitchTable) // Channel 2 Pattern Calculation
  ChannelPattern(2, SynthBassPitchTable)      // Channel 3 Pattern Calculation
  ChannelPattern(3, ClapPitchTable)     // Channel 4 Pattern Calculation
  ChannelPattern(4, KickDrumPitchTable) // Channel 5 Pattern Calculation
  ChannelPattern(5, SnarePitchTable)    // Channel 6 Pattern Calculation

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

  PatternIncrement: // Channel 1..6 Pattern Increment
  ldy #0  // Y = 0
  lda #ChannelCount * 2 // YA = Channel Count * 2
  adw PATTERNOFS // YA += Pattern Offset
  stw PATTERNOFS // Pattern Offset = YA

  // Compare Pattern List Change Address
  lda #PATTERNLISTCHANGE    // A = Pattern List Change (LSB)
  ldy #PATTERNLISTCHANGE>>8 // Y = Pattern List Change (MSB)
  cpw PATTERNOFS            // Compare YA To Zero Page RAM
  bne PatternCmpEnd         // IF (Pattern Offset != Pattern List Change Offset) Pattern Compare End, ELSE Set Pattern Change Offset

  // Set Staccato Saw Tooth (Channel 1)
  WDSP(DSP_V0VOLL,100)  // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,100)  // Voice 0: Volume Right
  WDSP(DSP_V0ADSR1,$FE) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$2F) // Voice 0: ADSR2

  // Set Staccato Saw Tooth Detune (Channel 2)
  WDSP(DSP_V1VOLL,100)  // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,100)  // Voice 1: Volume Right
  WDSP(DSP_V1ADSR1,$FE) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$2F) // Voice 1: ADSR2
  
  PatternCmpEnd: // Compare Pattern List End Address
  lda #PATTERNLISTEND    // A = Pattern List End (LSB)
  ldy #PATTERNLISTEND>>8 // Y = Pattern List End (MSB)
  cpw PATTERNOFS         // Compare YA To Zero Page RAM
  bne PatternIncEnd      // IF (Pattern Offset != Pattern List End Offset) Pattern Increment End, ELSE Set Pattern Loop Offset

  // Set Pattern Loop Offset
  lda #PATTERNLISTLOOP    // A = Pattern List Loop (LSB)
  ldy #PATTERNLISTLOOP>>8 // Y = Pattern List Loop (MSB)
  stw PATTERNOFS          // Store YA To Zero Page RAM

  // Set Saw Tooth (Channel 1)
  WDSP(DSP_V0VOLL,50)   // Voice 0: Volume Left
  WDSP(DSP_V0VOLR,50)   // Voice 0: Volume Right
  WDSP(DSP_V0ADSR1,$FA) // Voice 0: ADSR1
  WDSP(DSP_V0ADSR2,$F0) // Voice 0: ADSR2

  // Set Saw Tooth Detune (Channel 2)
  WDSP(DSP_V1VOLL,50)   // Voice 1: Volume Left
  WDSP(DSP_V1VOLR,50)   // Voice 1: Volume Right
  WDSP(DSP_V1ADSR1,$FA) // Voice 1: ADSR1
  WDSP(DSP_V1ADSR2,$F0) // Voice 1: ADSR2

  PatternIncEnd:
    ldy #0 // Y = 0 (Pattern Index Offset)

  PatternEnd:
    jmp LoopSong // GOTO Loop Song

SawToothPitchTable:
  WritePitchTable($8868) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
SawToothDetunePitchTable:
  WritePitchTable($8748) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
SynthBassPitchTable:
  WritePitchTable($8868) // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
ClapPitchTable:
  dw $9468 // Write Sample Pitch Table
KickDrumPitchTable:
  dw $8868 // Write Sample Pitch Table
SnarePitchTable:
  dw $9668 // Write Sample Pitch Table

PATTERN00: // Pattern 00: Rest (Channel 1..8)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 1
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 2
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 3
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 4

PATTERN01: // Pattern 01: Saw Tooth / Saw Tooth Detune (Channel 1 & 2)
  db F5,   SUST, SUST, SUST, G5s,  SUST, SUST, F5,   SUST, F5,   A5s,  SUST, F5,   SUST, D5s,  SUST // 1
  db F5,   SUST, SUST, SUST, C6,   SUST, SUST, F5,   SUST, F5,   C6s,  SUST, C6,   SUST, G5s,  SUST // 2
  db F5,   SUST, C6,   SUST, F6,   SUST, F5,   D5s,  SUST, D5s,  C5,   SUST, G5,   SUST, F5,   SUST // 3
  db SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST // 4

PATTERN02: // Pattern 02: Bass (Channel 3)
  db F3,   SUST, SUST, SUST, F4,   SUST, SUST, D3s,  SUST, D4s,  C3,   SUST, C4,   SUST, D3s,  SUST // 9
  db F3,   SUST, SUST, SUST, F4,   SUST, SUST, SUST, SUST, C3,   C4,   SUST, D4s,  SUST, F4,   SUST // 10
  db C3s,  SUST, SUST, SUST, C4s,  SUST, SUST, D3s,  SUST, D4s,  C3,   SUST, C4,   SUST, D3s,  SUST // 11
  db F3,   SUST, SUST, SUST, SUST, SUST, SUST, SUST, SUST, F4,   C4,   SUST, A3s,  SUST, G3s,  SUST // 12
PATTERN03: // Pattern 03: Bass (Channel 3)
  db F3,   SUST, SUST, SUST, F4,   SUST, SUST, D3s,  SUST, D4s,  C3,   SUST, C4,   SUST, D3s,  SUST // 21
  db F3,   SUST, SUST, SUST, F4,   SUST, SUST, SUST, SUST, C3,   C4,   SUST, D4s,  SUST, F4,   SUST // 22
  db C3s,  SUST, SUST, SUST, C4s,  SUST, SUST, D3s,  SUST, SUST, SUST, SUST, D4s,  SUST, SUST, SUST // 23
  db F3,   SUST, SUST, SUST, F4,   SUST, SUST, SUST, SUST, F4,   C4,   SUST, A3s,  SUST, G3s,  SUST // 24

PATTERN04: // Pattern 04: Clap (Channel 4)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 9
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 10
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 11
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, HIT,  HIT,  SUST, HIT,  SUST, HIT,  SUST // 12
PATTERN05: // Pattern 05: Clap (Channel 4)
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 13
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, HIT,  SUST, HIT,  SUST, HIT,  SUST // 14
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST, REST // 15
  db REST, REST, REST, REST, REST, REST, REST, REST, REST, HIT,  HIT,  SUST, HIT,  SUST, HIT,  SUST // 16

PATTERN06: // Pattern 06: Kick Drum (Channel 5)
  db HIT,  SUST, SUST, SUST, SUST, SUST, SUST, HIT,  SUST, HIT,  HIT,  SUST, SUST, SUST, SUST, SUST // 13
  db HIT,  SUST, SUST, SUST, HIT,  SUST, SUST, SUST, SUST, HIT,  HIT,  SUST, SUST, SUST, SUST, SUST // 14
  db HIT,  SUST, SUST, SUST, HIT,  SUST, SUST, HIT,  SUST, HIT,  HIT,  SUST, HIT,  SUST, HIT,  SUST // 15
  db HIT,  SUST, SUST, SUST, HIT,  SUST, SUST, SUST, SUST, HIT,  HIT,  SUST, HIT,  SUST, HIT,  SUST // 16

PATTERN07: // Pattern 07: Snare (Channel 6)
  db REST, REST, REST, REST, HIT,  SUST, SUST, SUST, SUST, SUST, SUST, SUST, HIT,  SUST, SUST, SUST // 17
  db REST, REST, REST, REST, HIT,  SUST, SUST, SUST, SUST, SUST, SUST, SUST, HIT,  SUST, SUST, SUST // 18
  db REST, REST, REST, REST, HIT,  SUST, SUST, SUST, SUST, SUST, SUST, SUST, HIT,  SUST, SUST, SUST // 19
  db REST, REST, REST, REST, HIT,  SUST, SUST, SUST, SUST, SUST, SUST, SUST, HIT,  SUST, SUST, SUST // 20

PATTERN08: // Pattern 08: Staccato Saw Tooth (Channel 1)
  db REST, REST, F5,   SUST, SUST, SUST, F5,   G5,   SUST, G5,   SUST, G5,   F5,   SUST, F5,   SUST // 21
  db SUST, SUST, F5,   SUST, F5,   SUST, F5,   G5,   SUST, G5,   F5,   SUST, F5,   SUST, SUST, SUST // 22
  db SUST, SUST, C5s,  SUST, C5s,  SUST, C5s,  SUST, C5s,  D5s,  SUST, D5s,  SUST, D5s,  SUST, D5s  // 23
  db D5s,  SUST, F5,   SUST, F5,   SUST, F5,   SUST, D5s,  F5,   SUST, F5,   SUST, SUST, SUST, SUST // 24
PATTERN09: // Pattern 09: Staccato Saw Tooth Detune (Channel 2)
  db REST, REST, C6,   SUST, SUST, SUST, C6,   D6s,  SUST, D6s,  SUST, D6s,  D6,   SUST, D6,   SUST // 21
  db SUST, SUST, C6,   SUST, C6,   SUST, C6,   D6s,  SUST, D6s,  D6,   SUST, C6,   SUST, SUST, SUST // 22
  db SUST, SUST, G5s,  SUST, G5s,  SUST, G5s,  SUST, G5s,  A5s,  SUST, A5s,  SUST, A5s,  SUST, A5s  // 23
  db A5s,  SUST, C6,   SUST, C6,   SUST, C6,   SUST, A5s,  C6,   SUST, C6,   SUST, SUST, SUST, SUST // 24

PATTERNLIST:
  dw PATTERN01,PATTERN00,PATTERN00,PATTERN00,PATTERN00,PATTERN00 // Channel 1..6 Pattern Address List
  dw PATTERN01,PATTERN01,PATTERN00,PATTERN00,PATTERN00,PATTERN00 // Channel 1..6 Pattern Address List
  dw PATTERN00,PATTERN00,PATTERN02,PATTERN04,PATTERN00,PATTERN00 // Channel 1..6 Pattern Address List
  dw PATTERN00,PATTERN00,PATTERN02,PATTERN05,PATTERN06,PATTERN00 // Channel 1..6 Pattern Address List
PATTERNLISTLOOP:
  dw PATTERN01,PATTERN01,PATTERN02,PATTERN04,PATTERN06,PATTERN07 // Channel 1..6 Pattern Address List
  dw PATTERN01,PATTERN01,PATTERN02,PATTERN04,PATTERN06,PATTERN07 // Channel 1..6 Pattern Address List
PATTERNLISTCHANGE:
  dw PATTERN08,PATTERN09,PATTERN03,PATTERN04,PATTERN06,PATTERN07 // Channel 1..6 Pattern Address List
  dw PATTERN08,PATTERN09,PATTERN03,PATTERN04,PATTERN06,PATTERN07 // Channel 1..6 Pattern Address List
PATTERNLISTEND:

seek($2A00); sampleDIR:
  dw SawTooth, SawTooth + 2691 // 0
  dw SynthBass, 0              // 1
  dw Clap, 0                   // 2
  dw KickDrum, 0               // 3
  dw Snare, 0                  // 4

seek($2B00) // Sample Data
  insert SawTooth, "BRR/MSAWTOOF(Loop=2691,AD=$FA,SR=$F0,Echo)(C9Pitch=$8868).brr"
  insert SynthBass, "BRR/SYNBSS3(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"
  insert Clap, "BRR/CLAPTRAP(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"
  insert KickDrum, "BRR/KICK5(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"
  insert Snare, "BRR/SNAREA13(AD=$FF,SR=$F0)(C9Pitch=$8868).brr"