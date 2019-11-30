//============= (Key: R=Read, W=Write)
// SNES SPC700
//=============
// Memory Map
constant SPCPAGE0($0000)    // RAM Page 0 (Typically Used For CPU Pointers/Variables)  240B/RW
// $00F0..$00FF - I/O Ports (Writes Are Also Passed To RAM)
constant SPCPAGE1($0100)    // RAM Page 1 (Typically Used For CPU Stack)               256B/RW
constant SPCRAM($0200)      // RAM (Code, Data, Dir-Table, BRR-Samples, Echo-Buffer) 64960B/RW
constant SPCIPL($FFC0)      // 64-Byte IPL Boot ROM Or RAM (Selectable Via Port $00F1)  64B/RW

// I/O Ports (CPU Includes 16 Memory Mapper Ports At Address $00F0..$00FF)
constant REG_TEST($F0)      // Testing Functions                                         1B/W
constant REG_CONTROL($F1)   // Timer, I/O & ROM Control                                  1B/W
constant REG_DSPADDR($F2)   // DSP Register Index                                        1B/RW
constant REG_DSPDATA($F3)   // DSP Register Data                                         1B/RW
constant REG_CPUIO0($F4)    // CPU Input & Output Register 0                             1B/RW
constant REG_CPUIO1($F5)    // CPU Input & Output Register 1                             1B/RW
constant REG_CPUIO2($F6)    // CPU Input & Output Register 2                             1B/RW
constant REG_CPUIO3($F7)    // CPU Input & Output Register 3                             1B/RW
constant REG_AUXIO4($F8)    // External I/O Port P4 (S-SMP Pins 34-27)                   1B/RW
constant REG_AUXIO5($F9)    // External I/O Port P5 (S-SMP Pins 25-18)                   1B/RW
constant REG_T0DIV($FA)     // Timer 0 Divider  (8000Hz Clock Source)                    1B/W
constant REG_T1DIV($FB)     // Timer 1 Divider  (8000Hz Clock Source)                    1B/W
constant REG_T2DIV($FC)     // Timer 2 Divider (64000Hz Clock Source)                    1B/W
constant REG_T0OUT($FD)     // Timer 0 Output                                            1B/R
constant REG_T1OUT($FE)     // Timer 1 Output                                            1B/R
constant REG_T2OUT($FF)     // Timer 2 Output                                            1B/R

// DSP Registers (128 DSP Registers Are Indirectly Accessed Via I/O Ports $00F2/$00F3)
constant DSP_MVOLL($0C)     // Left  Channel Master Volume                               1B/RW
constant DSP_MVOLR($1C)     // Right Channel Master Volume                               1B/RW
constant DSP_EVOLL($2C)     // Left  Channel Echo   Volume                               1B/RW
constant DSP_EVOLR($3C)     // Right Channel Echo   Volume                               1B/RW
constant DSP_KON($4C)       // Voice 0..7 Key On  Flags                                  1B/W
constant DSP_KOFF($5C)      // Voice 0..7 Key Off Flags                                  1B/RW
constant DSP_FLG($6C)       // DSP Reset, Mute, Echo-Write Flags & Noise Clock           1B/RW
constant DSP_ENDX($7C)      // Voice 0..7 End Flags                                      1B/R

constant DSP_EFB($0D)       // Echo Feedback Volume                                      1B/RW
constant DSP_UNUSED($1D)    // Unused Byte (1 Byte Of General-Purpose RAM)               1B/RW
constant DSP_PMON($2D)      // Voice 0..7 Pitch Modulation Enable Flags                  1B/RW
constant DSP_NON($3D)       // Voice 0..7 Noise Enable Flags                             1B/RW
constant DSP_EON($4D)       // Voice 0..7 Echo  Enable Flags                             1B/RW
constant DSP_DIR($5D)       // Sample Table Address     (DIR * $100)                     1B/RW
constant DSP_ESA($6D)       // Echo Ring Buffer Address (ESA * $100)                     1B/RW
constant DSP_EDL($7D)       // Echo Delay (Ring Buffer Size)                             1B/RW

constant DSP_FIR0($0F)      // Echo FIR Filter Coefficient 0                             1B/RW
constant DSP_FIR1($1F)      // Echo FIR Filter Coefficient 1                             1B/RW
constant DSP_FIR2($2F)      // Echo FIR Filter Coefficient 2                             1B/RW
constant DSP_FIR3($3F)      // Echo FIR Filter Coefficient 3                             1B/RW
constant DSP_FIR4($4F)      // Echo FIR Filter Coefficient 4                             1B/RW
constant DSP_FIR5($5F)      // Echo FIR Filter Coefficient 5                             1B/RW
constant DSP_FIR6($6F)      // Echo FIR Filter Coefficient 6                             1B/RW
constant DSP_FIR7($7F)      // Echo FIR Filter Coefficient 7                             1B/RW

constant DSP_V0VOLL($00)    // Voice 0 Left  Volume                                      1B/RW
constant DSP_V0VOLR($01)    // Voice 0 Right Volume                                      1B/RW
constant DSP_V0PITCHL($02)  // Voice 0 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V0PITCHH($03)  // Voice 0 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V0SRCN($04)    // Voice 0 Source Number (0-255)                             1B/RW
constant DSP_V0ADSR1($05)   // Voice 0 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V0ADSR2($06)   // Voice 0 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V0GAIN($07)    // Voice 0 Gain Settings                                     1B/RW
constant DSP_V0ENVX($08)    // Voice 0 Current Envelope Value                            1B/R
constant DSP_V0OUTX($09)    // Voice 0 Current Sample   Value                            1B/R
constant DSP_V0UNUSEDA($0A) // Voice 0 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V0UNUSEDB($0B) // Voice 0 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V0UNUSEDC($0E) // Voice 0 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V1VOLL($10)    // Voice 1 Left  Volume                                      1B/RW
constant DSP_V1VOLR($11)    // Voice 1 Right Volume                                      1B/RW
constant DSP_V1PITCHL($12)  // Voice 1 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V1PITCHH($13)  // Voice 1 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V1SRCN($14)    // Voice 1 Source Number (0-255)                             1B/RW
constant DSP_V1ADSR1($15)   // Voice 1 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V1ADSR2($16)   // Voice 1 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V1GAIN($17)    // Voice 1 Gain Settings                                     1B/RW
constant DSP_V1ENVX($18)    // Voice 1 Current Envelope Value                            1B/R
constant DSP_V1OUTX($19)    // Voice 1 Current Sample   Value                            1B/R
constant DSP_V1UNUSEDA($1A) // Voice 1 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V1UNUSEDB($1B) // Voice 1 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V1UNUSEDC($1E) // Voice 1 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V2VOLL($20)    // Voice 2 Left  Volume                                      1B/RW
constant DSP_V2VOLR($21)    // Voice 2 Right Volume                                      1B/RW
constant DSP_V2PITCHL($22)  // Voice 2 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V2PITCHH($23)  // Voice 2 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V2SRCN($24)    // Voice 2 Source Number (0-255)                             1B/RW
constant DSP_V2ADSR1($25)   // Voice 2 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V2ADSR2($26)   // Voice 2 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V2GAIN($27)    // Voice 2 Gain Settings                                     1B/RW
constant DSP_V2ENVX($28)    // Voice 2 Current Envelope Value                            1B/R
constant DSP_V2OUTX($29)    // Voice 2 Current Sample   Value                            1B/R
constant DSP_V2UNUSEDA($2A) // Voice 2 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V2UNUSEDB($2B) // Voice 2 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V2UNUSEDC($2E) // Voice 2 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V3VOLL($30)    // Voice 3 Left  Volume                                      1B/RW
constant DSP_V3VOLR($31)    // Voice 3 Right Volume                                      1B/RW
constant DSP_V3PITCHL($32)  // Voice 3 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V3PITCHH($33)  // Voice 3 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V3SRCN($34)    // Voice 3 Source Number (0-255)                             1B/RW
constant DSP_V3ADSR1($35)   // Voice 3 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V3ADSR2($36)   // Voice 3 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V3GAIN($37)    // Voice 3 Gain Settings                                     1B/RW
constant DSP_V3ENVX($38)    // Voice 3 Current Envelope Value                            1B/R
constant DSP_V3OUTX($39)    // Voice 3 Current Sample   Value                            1B/R
constant DSP_V3UNUSEDA($3A) // Voice 3 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V3UNUSEDB($3B) // Voice 3 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V3UNUSEDC($3E) // Voice 3 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V4VOLL($40)    // Voice 4 Left  Volume                                      1B/RW
constant DSP_V4VOLR($41)    // Voice 4 Right Volume                                      1B/RW
constant DSP_V4PITCHL($42)  // Voice 4 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V4PITCHH($43)  // Voice 4 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V4SRCN($44)    // Voice 4 Source Number (0-255)                             1B/RW
constant DSP_V4ADSR1($45)   // Voice 4 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V4ADSR2($46)   // Voice 4 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V4GAIN($47)    // Voice 4 Gain Settings                                     1B/RW
constant DSP_V4ENVX($48)    // Voice 4 Current Envelope Value                            1B/R
constant DSP_V4OUTX($49)    // Voice 4 Current Sample   Value                            1B/R
constant DSP_V4UNUSEDA($4A) // Voice 4 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V4UNUSEDB($4B) // Voice 4 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V4UNUSEDC($4E) // Voice 4 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V5VOLL($50)    // Voice 5 Left  Volume                                      1B/RW
constant DSP_V5VOLR($51)    // Voice 5 Right Volume                                      1B/RW
constant DSP_V5PITCHL($52)  // Voice 5 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V5PITCHH($53)  // Voice 5 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V5SRCN($54)    // Voice 5 Source Number (0-255)                             1B/RW
constant DSP_V5ADSR1($55)   // Voice 5 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V5ADSR2($56)   // Voice 5 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V5GAIN($57)    // Voice 5 Gain Settings                                     1B/RW
constant DSP_V5ENVX($58)    // Voice 5 Current Envelope Value                            1B/R
constant DSP_V5OUTX($59)    // Voice 5 Current Sample   Value                            1B/R
constant DSP_V5UNUSEDA($5A) // Voice 5 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V5UNUSEDB($5B) // Voice 5 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V5UNUSEDC($5E) // Voice 5 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V6VOLL($60)    // Voice 6 Left  Volume                                      1B/RW
constant DSP_V6VOLR($61)    // Voice 6 Right Volume                                      1B/RW
constant DSP_V6PITCHL($62)  // Voice 6 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V6PITCHH($63)  // Voice 6 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V6SRCN($64)    // Voice 6 Source Number (0-255)                             1B/RW
constant DSP_V6ADSR1($65)   // Voice 6 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V6ADSR2($66)   // Voice 6 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V6GAIN($67)    // Voice 6 Gain Settings                                     1B/RW
constant DSP_V6ENVX($68)    // Voice 6 Current Envelope Value                            1B/R
constant DSP_V6OUTX($69)    // Voice 6 Current Sample   Value                            1B/R
constant DSP_V6UNUSEDA($6A) // Voice 6 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V6UNUSEDB($6B) // Voice 6 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V6UNUSEDC($6E) // Voice 6 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW

constant DSP_V7VOLL($70)    // Voice 7 Left  Volume                                      1B/RW
constant DSP_V7VOLR($71)    // Voice 7 Right Volume                                      1B/RW
constant DSP_V7PITCHL($72)  // Voice 7 Pitch Scaler  (Lower 8bit)                        2B/RW
constant DSP_V7PITCHH($73)  // Voice 7 Pitch Scaler  (Upper 6bit)                        1B/RW
constant DSP_V7SRCN($74)    // Voice 7 Source Number (0-255)                             1B/RW
constant DSP_V7ADSR1($75)   // Voice 7 ADSR Settings (Lower 8bit)                        2B/RW
constant DSP_V7ADSR2($76)   // Voice 7 ADSR Settings (Upper 8bit)                        1B/RW
constant DSP_V7GAIN($77)    // Voice 7 Gain Settings                                     1B/RW
constant DSP_V7ENVX($78)    // Voice 7 Current Envelope Value                            1B/R
constant DSP_V7OUTX($79)    // Voice 7 Current Sample   Value                            1B/R
constant DSP_V7UNUSEDA($7A) // Voice 7 Unused Byte A (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V7UNUSEDB($7B) // Voice 7 Unused Byte B (1 Byte Of General-Purpose RAM)     1B/RW
constant DSP_V7UNUSEDC($7E) // Voice 7 Unused Byte C (1 Byte Of General-Purpose RAM)     1B/RW
// $80..$FF - Read-Only Mirror Of $00..$7F

// SPC700 Macros
macro WDSP(REG, variable DATA) {
  str REG_DSPADDR=#{REG}
  str REG_DSPDATA=#DATA
}

macro WDSP_REG(REG) {
  str REG_DSPADDR=#{REG}
}

macro WDSP_DATA(variable DATA) {
  str REG_DSPDATA=#DATA
}

macro SPC_INIT() { // SPC700 Initialisation
  WDSP(DSP_FLG,$20)  // Disable Echo Buffer Writes
  WDSP(DSP_KON,$00)  // Reset Key On Flags
  WDSP(DSP_KOFF,$FF) // Set Key Off Flags
  WDSP(DSP_PMON,$00) // Reset Pitch Modulation Enable Flags
  WDSP(DSP_NON,$00)  // Reset Noise Enable Flags
  WDSP(DSP_EON,$00)  // Reset Echo On Flags
  WDSP(DSP_EVOLL,0)  // Reset Echo Volume Left
  WDSP(DSP_EVOLR,0)  // Reset Echo Volume Right
}

macro SPCWaitMS(AMOUNT) { // Wait For MilliSecond Amount (8kHz Timer)
  ldy #{AMOUNT} // Granularity = 1ms, Max Wait = 256ms
  str REG_T0DIV=#8 // 8kHz Clock Divider 8 = 1024 Clock Ticks (1ms)
  str REG_CONTROL=#$01
-
  bbc REG_T0OUT:0=- // IF (REG_T0OUT.BIT0 == 0) Wait For Timer
  bne --y=- // Y--, IF (Y != 0) Loop Timer Wait
}

macro SPCWaitSHIFTMS(AMOUNT, SHIFT) { // Wait For Shifted MilliSecond Amount (8kHz Timer)
  ldy #{AMOUNT} // Granularity = 1..16ms, Max Wait = 256 * 1..16ms
  str REG_T0DIV=#(8 << {SHIFT}) & $FF // Shift MilliSecond (0 = 1ms, 1 = 2ms, 2 = 4ms, 3 = 8ms, 4 = 16ms)
  str REG_CONTROL=#$01
-
  bbc REG_T0OUT:0=- // IF (REG_T0OUT.BIT0 == 0) Wait For Timer
  bne --y=- // Y--, IF (Y != 0) Loop Timer Wait
}

macro SPCWaitSHIFTMS64(AMOUNT, SHIFT) { // Wait For Shifted MilliSecond Amount (64kHz Timer)
  ldy #{AMOUNT} // Granularity = 1..4ms, Max Wait = 256 * 1..4ms
  str REG_T2DIV=#($40 << {SHIFT}) & $FF // Shift MilliSecond (0 = 1ms, 1 = 2ms, 2 = 4ms)
  str REG_CONTROL=#$04
-
  bbc REG_T2OUT:0=- // IF (REG_T2OUT.BIT0 == 0) Wait For Timer
  bne --y=- // Y--, IF (Y != 0) Loop Timer Wait
}

macro SPCRAMClear(ADDR, AMOUNT) { // Clear SPC RAM in 256 Byte Chunks * Amount
  lda #$00 // Clear Byte
  ldx #{AMOUNT} // Clear Amount High Byte
  ldy #$00 // Echo Buffer Index
-
  sta {ADDR},y // Store Clear Byte Into RAM Using 16-Bit Offset
  bne --y=- // Y--, IF (Y != 0) Loop Clear Byte

  variable modifyoffset(-)
  inc modifyoffset + 2 // Self Modify (Increment) 16-Bit ADDR (Hi Byte) Offset Above
  dex // Decrement X Clear Amount High Byte
  bne - // Loop Another 256 Byte Chunk
}

macro SPCBoot() { // Run SPC Bootloader
  str REG_CONTROL=#$80 // REG_CONTROL = $80 (Boot ROM ON)
  jmp SPCIPL // Jump To $FFC0 (Start of Boot ROM)
}

// 65C816 Macros
macro WaitAPUIO(PORT) {
-
  cmp.w REG_APUIO{PORT}
  bne -
}

macro SPCWaitBoot() { // Wait For SPC To Boot (Call At first Use Of SPC & After Re-Run of BootROM)
  lda.b #$AA
  WaitAPUIO(0)
  sta.w REG_APUIO0 // Clear In Case It Contains $CC
  lda.b #$BB
  WaitAPUIO(1)
}

macro SPCExecute(ADDR) { // Starts Executing At SPC ADDR X
  ldx.w #{ADDR}
  stx.w REG_APUIO2
  stz.w REG_APUIO1
  lda.w REG_APUIO0
  clc
  adc.b #$22
  sta.w REG_APUIO0
  WaitAPUIO(0) // Wait For Acknowledgement
}

macro SPCLoadByte() { // Loads Byte A To SPC & Increments X
  sta.w REG_APUIO1
  txa // Ready Signal
  sta.w REG_APUIO0
  inx // Increment X
  WaitAPUIO(0) // Wait For Acknowledgement
}

macro SPCBeginUpload() { // Starts Upload To SPC ADDR X & Sets X To 0 For Use As Index With SPCLoadByte
  stx.w REG_APUIO2
  lda.w REG_APUIO0 // Send Command
  clc
  adc.b #$22
  bne + // Special Case Fully Verified
  inc
+
  sta.w REG_APUIO1
  sta.w REG_APUIO0
  WaitAPUIO(0) // Wait For Acknowledgement
  ldx.w #0 // Initialize X Index To 0
}

macro TransferBlockSPC(SRC_ADDR, SPC_ADDR, SIZE) { // Transfer A Block Of Data To SPC RAM
  ldx.w #{SPC_ADDR}
  SPCBeginUpload()
-
  lda.l {SRC_ADDR},x
  SPCLoadByte()
  cpx.w #{SIZE}
  bne --
}

macro WriteDSP(REG, BYTE) { // Write Byte To SPC-700 DSP Register
  ldx.w #REG_DSPADDR // Do A Two Byte Upload To $00F2..$00F3, Setting DSP Register & Data Byte
  SPCBeginUpload()
  lda.b #{REG}
  SPCLoadByte() // DSP REG To $F2
  lda.b #{BYTE}
  SPCLoadByte() // DSP DATA To $F3
}

macro WriteCTRL(BYTE) { // Write Byte To SPC-700 Control Register
  ldx.w #REG_CONTROL // Do A Byte Upload To $00F1, Writing Control Register
  SPCBeginUpload()
  lda.b #{BYTE}
  SPCLoadByte() // Control DATA To $F1
}

constant Cs(11)
constant Db(11)
constant D(10)
constant Ds(9)
constant Eb(9)
constant E(8)
constant F(7)
constant Fs(6)
constant Gb(6)
constant G(5)
constant Gs(4)
constant Ab(4)
constant A(3)
constant As(2)
constant Bb(2)
constant B(1)
constant C(0)

macro SetPitch(voice, note, octave, C9Pitch) {
  variable pitch({C9Pitch})

  if {note} >= 1 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 2 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 3 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 4 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 5 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 6 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 7 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 8 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 9 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} >= 10 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }
  if {note} == 11 {
    pitch = ((pitch * 1000000000) / 1059463094)
  }

  if {note} {
    pitch = (pitch >> (8-{octave}))
  }
  if ! {note} {
    pitch = (pitch >> (9-{octave}))
  }

  WDSP(DSP_V{voice}PITCHL,pitch & $FF) // Voice X: Pitch (Lower Byte)
  WDSP(DSP_V{voice}PITCHH,pitch >> 8)  // Voice X: Pitch (Upper Byte)
}

// Frequency WORD Offsets For Sample Pitch Table
constant HIT($00)

constant C1($00)
constant C1s($02)
constant D1b($02)
constant D1($04)
constant D1s($06)
constant E1b($06)
constant E1($08)
constant F1($0A)
constant F1s($0C)
constant G1b($0C)
constant G1($0E)
constant G1s($10)
constant A1b($10)
constant A1($12)
constant A1s($14)
constant B1b($14)
constant B1($16)

constant C2($18)
constant C2s($1A)
constant D2b($1A)
constant D2($1C)
constant D2s($1E)
constant E2b($1E)
constant E2($20)
constant F2($22)
constant F2s($24)
constant G2b($24)
constant G2($26)
constant G2s($28)
constant A2b($28)
constant A2($2A)
constant A2s($2C)
constant B2b($2C)
constant B2($2E)

constant C3($30)
constant C3s($32)
constant D3b($32)
constant D3($34)
constant D3s($36)
constant E3b($36)
constant E3($38)
constant F3($3A)
constant F3s($3C)
constant G3b($3C)
constant G3($3E)
constant G3s($40)
constant A3b($40)
constant A3($42)
constant A3s($44)
constant B3b($44)
constant B3($46)

constant C4($48)
constant C4s($4A)
constant D4b($4A)
constant D4($4C)
constant D4s($4E)
constant E4b($4E)
constant E4($50)
constant F4($52)
constant F4s($54)
constant G4b($54)
constant G4($56)
constant G4s($58)
constant A4b($58)
constant A4($5A)
constant A4s($5C)
constant B4b($5C)
constant B4($5E)

constant C5($60)
constant C5s($62)
constant D5b($62)
constant D5($64)
constant D5s($66)
constant E5b($66)
constant E5($68)
constant F5($6A)
constant F5s($6C)
constant G5b($6C)
constant G5($6E)
constant G5s($70)
constant A5b($70)
constant A5($72)
constant A5s($74)
constant B5b($74)
constant B5($76)

constant C6($78)
constant C6s($7A)
constant D6b($7A)
constant D6($7C)
constant D6s($7E)
constant E6b($7E)
constant E6($80)
constant F6($82)
constant F6s($84)
constant G6b($84)
constant G6($86)
constant G6s($88)
constant A6b($88)
constant A6($8A)
constant A6s($8C)
constant B6b($8C)
constant B6($8E)

constant C7($90)
constant C7s($92)
constant D7b($92)
constant D7($94)
constant D7s($96)
constant E7b($96)
constant E7($98)
constant F7($9A)
constant F7s($9C)
constant G7b($9C)
constant G7($9E)
constant G7s($A0)
constant A7b($A0)
constant A7($A2)
constant A7s($A4)
constant B7b($A4)
constant B7($A6)

constant C8($A8)
constant C8s($AA)
constant D8b($AA)
constant D8($AC)
constant D8s($AE)
constant E8b($AE)
constant E8($B0)
constant F8($B2)
constant F8s($B4)
constant G8b($B4)
constant G8($B6)
constant G8s($B8)
constant A8b($B8)
constant A8($BA)
constant A8s($BC)
constant B8b($BC)
constant B8($BE)

constant C9($C0)
constant C9s($C2)
constant D9b($C2)
constant D9($C4)
constant D9s($C6)
constant E9b($C6)
constant E9($C8)
constant F9($CA)
constant F9s($CC)
constant G9b($CC)
constant G9($CE)
constant G9s($D0)
constant A9b($D0)
constant A9($D2)
constant A9s($D4)
constant B9b($D4)
constant B9($D6)

constant SUST($FE)
constant REST($FF)

macro WritePitchTable(C9Pitch) { // Write Sample Pitch Table From C9 Pitch, 9 Octaves: C1..B9 (108 Words)
  variable note(0)
  variable octave(0)

  while octave < 10 {
    variable pitch({C9Pitch})

    if note >= 1 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 2 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 3 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 4 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 5 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 6 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 7 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 8 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 9 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note >= 10 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }
    if note == 11 {
      pitch = ((pitch * 1000000000) / 1059463094)
    }

    pitch = (pitch >> (8-octave))

    if ! note {
      note = 12
      octave = (octave+1)
    }

    note = (note-1)

    dw pitch
  }
}