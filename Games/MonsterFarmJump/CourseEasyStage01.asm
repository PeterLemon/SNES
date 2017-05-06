//---------------------
// Course Easy Stage 01
//---------------------
// Clear Mode7 VRAM
lda.b #$80       // Set Increment VRAM Address After Accessing Hi Byte
sta.w REG_VMAIN  // $2115: Video Port Control
ldx.w #$0000     // Set VRAM Destination
stx.w REG_VMADDL // $2116: VRAM
ldy.w #$0000
LoopClearMode7VRAM:
  sty.w REG_VMDATAL // $2118: VRAM Data Write
  inx // X++
  cpx.w #$4000
  bne LoopClearMode7VRAM

LoadPAL(CourseEasyStage01Pal, $00, CourseEasyStage01Pal.size, 0) // Load Background Palette (BG Palette Uses 128 Colors)
LoadHIVRAM(CourseEasyStage01Tiles, $0000, CourseEasyStage01Tiles.size, 0) // Load Background Tiles To VRAM

LoadPAL(HiScoreLifeHeartPal, $80, HiScoreLifeHeartPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(HiScoreTiles, $8000, HiScoreTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(DistanceGoalLifeScoreTimePal, $90, DistanceGoalLifeScoreTimePal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(DistanceGoalLifeScoreTimeTiles, $8200, DistanceGoalLifeScoreTimeTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(ScoreNumberPal, $A0, ScoreNumberPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadPAL(TimeNumberPal, $B0, TimeNumberPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ScoreTimeNumberTiles, $8A00, ScoreTimeNumberTiles.size, 0) // Load Sprite Tiles To VRAM

LoadVRAM(LifeHeartTiles, $9440, 64, 0) // Load Sprite Tiles To VRAM
LoadVRAM(LifeHeartTiles + 64, $9640, 64, 0) // Load Sprite Tiles To VRAM

LoadPAL(ShadowPal, $E0, ShadowPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ShadowTiles, $9500, 128, 0) // Load Sprite Tiles To VRAM
LoadVRAM(ShadowTiles + 128, $9700, 128, 0) // Load Sprite Tiles To VRAM
LoadVRAM(ShadowTiles + 256, $9580, 128, 0) // Load Sprite Tiles To VRAM
LoadVRAM(ShadowTiles + 384, $9780, 128, 0) // Load Sprite Tiles To VRAM

LoadPAL(CloudDayPal, $F0, CloudDayPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CloudDayTiles, $A800, CloudDayTiles.size, 0) // Load Sprite Tiles To VRAM

// Set Character Selection Sprite
CharacterSelectionRoochoSprite:
  lda.b CourseCharacterSelect
  bit.b #%00010000 // Test Roocho Bit
  bne CharacterSelectionRoochooSpriteCopy
  jmp CharacterSelectionBeochiSprite
  CharacterSelectionRoochooSpriteCopy:
    LoadPAL(DistanceMarkerRoochoPal, $C0, DistanceMarkerRoochoPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(DistanceMarkerRoochoTiles, $9480, 128, 0) // Load Sprite Tiles To VRAM
    LoadVRAM(DistanceMarkerRoochoTiles + 128, $9680, 128, 0) // Load Sprite Tiles To VRAM
    LoadPAL(RoochoJumpUpPal, $D0, RoochoJumpUpPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(RoochoJumpUpTiles, $9800, RoochoJumpUpTiles.size, 0) // Load Sprite Tiles To VRAM
    jmp CharacterSelectionSpriteEnd
CharacterSelectionBeochiSprite:
  bit.b #%00100000 // Test Beochi Bit
  bne CharacterSelectionBeochiSpriteCopy
  jmp CharacterSelectionChitoSprite
  CharacterSelectionBeochiSpriteCopy:
    LoadPAL(DistanceMarkerBeochiPal, $C0, DistanceMarkerBeochiPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(DistanceMarkerBeochiTiles, $9480, 128, 0) // Load Sprite Tiles To VRAM
    LoadVRAM(DistanceMarkerBeochiTiles + 128, $9680, 128, 0) // Load Sprite Tiles To VRAM
    LoadPAL(BeochiJumpUpPal, $D0, BeochiJumpUpPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(BeochiJumpUpTiles, $9800, BeochiJumpUpTiles.size, 0) // Load Sprite Tiles To VRAM
    jmp CharacterSelectionSpriteEnd
CharacterSelectionChitoSprite:
  bit.b #%01000000 // Test Chito Bit
  bne CharacterSelectionChitoSpriteCopy
  jmp CharacterSelectionGolemSprite
  CharacterSelectionChitoSpriteCopy:
    LoadPAL(DistanceMarkerChitoPal, $C0, DistanceMarkerChitoPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(DistanceMarkerChitoTiles, $9480, 128, 0) // Load Sprite Tiles To VRAM
    LoadVRAM(DistanceMarkerChitoTiles + 128, $9680, 128, 0) // Load Sprite Tiles To VRAM
    LoadPAL(ChitoJumpUpPal, $D0, ChitoJumpUpPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(ChitoJumpUpTiles, $9800, ChitoJumpUpTiles.size, 0) // Load Sprite Tiles To VRAM
    jmp CharacterSelectionSpriteEnd
CharacterSelectionGolemSprite:
  bit.b #%10000000 // Test Golem Bit
  bne CharacterSelectionGolemSpriteCopy
  jmp CharacterSelectionSpriteEnd
  CharacterSelectionGolemSpriteCopy:
    LoadPAL(DistanceMarkerGolemPal, $C0, DistanceMarkerGolemPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(DistanceMarkerGolemTiles, $9480, 128, 0) // Load Sprite Tiles To VRAM
    LoadVRAM(DistanceMarkerGolemTiles + 128, $9680, 128, 0) // Load Sprite Tiles To VRAM
    LoadPAL(GolemJumpUpPal, $D0, GolemJumpUpPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    LoadVRAM(GolemJumpUpTiles, $9800, GolemJumpUpTiles.size, 0) // Load Sprite Tiles To VRAM
CharacterSelectionSpriteEnd:

// Clear OAM
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
ldx.w #$0080
lda.b #$E0
-
  sta.w REG_OAMDATA // OAM Data Write 1st Write = $E0 (Lower 8-Bit) ($2104)
  sta.w REG_OAMDATA // OAM Data Write 2nd Write = $E0 (Upper 8-Bit) ($2104)
  stz.w REG_OAMDATA // OAM Data Write 1st Write = 0 (Lower 8-Bit) ($2104)
  stz.w REG_OAMDATA // OAM Data Write 2nd Write = 0 (Upper 8-Bit) ($2104)
  dex
  bne -

ldx.w #$0020
-
  stz.w REG_OAMDATA // OAM Data Write 1st/2nd Write = 0 (Lower/Upper 8-Bit) ($2104)
  dex
  bne -

// Course Stage OAM Info
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCourseStageOAM:
  lda.w CourseStageOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$01D8
  bne LoopCourseStageOAM

// Course Stage OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCourseStageOAMSize:
  lda.w CourseStageOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$01F6
  bne LoopCourseStageOAMSize

// Setup Video
lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

lda.b #%00010001 // Enable BG1 & Sprites
sta.w REG_TM     // $212C: BG1 & Sprites To Main Screen Designation

lda.b #%00010000 // Enable Sprites
sta.w REG_TS     // $212D: Sprites To Sub Screen Designation

lda.b #$80 // No Repeat on Mode7 Screen
sta.w REG_M7SEL // $211A: Mode7 Settings

stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7D // $211E: MODE7 COSINE B
stz.w REG_M7D // $211E: MODE7 COSINE B

ldx.w #-174 // BG1HOFS = -174
stx.b BG1ScrPosX

ldx.w #248 // BG1VOFS = 248
stx.b BG1ScrPosY

ldx.w #-46 // M7X = -46
stx.b Mode7PosX

ldx.w #512 // M7Y = 512
stx.b Mode7PosY

lda.b BG1ScrPosX
sta.w REG_BG1HOFS // $210D: BG1 Position X Lo Byte
lda.b BG1ScrPosX + 1
sta.w REG_BG1HOFS // $210D: BG1 Position X Hi Byte

lda.b BG1ScrPosY
sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
lda.b BG1ScrPosY + 1
sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

lda.b Mode7PosX
sta.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
lda.b Mode7PosX + 1
sta.w REG_M7X // $211F: Mode7 Center Position X Hi Byte

lda.b Mode7PosY
sta.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
lda.b Mode7PosY + 1
sta.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

// HDMA Mode7 -SIN (A) Scanline
lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
sta.w REG_DMAP0   // $4300: DMA0 DMA/HDMA Parameters
lda.b #REG_M7B    // $1C: Start At MODE7 SINE A ($211C)
sta.w REG_BBAD0   // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7NSINHDMATable // HMDA Table Address
stx.w REG_A1T0L   // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #M7NSINHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B0    // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

// HDMA Mode7 +SIN (D) Scanline
lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
sta.w REG_DMAP1   // $4310: DMA1 DMA/HDMA Parameters
lda.b #REG_M7C    // $1D: Start At MODE7 SINE B ($211D)
sta.w REG_BBAD1   // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7SINHDMATable // HMDA Table Address
stx.w REG_A1T1L   // $4312: DMA1 DMA/HDMA Table Start Address
lda.b #M7SINHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B1    // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

// HDMA Mode7 Intensity
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP2  // $4320: DMA2 DMA/HDMA Parameters
lda.b #REG_COLDATA // $32: Start At Color Math Sub Screen Backdrop Color ($2132)
sta.w REG_BBAD2  // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7IntensityHDMATable // HMDA Table Address
stx.w REG_A1T2L  // $4322: DMA2 DMA/HDMA Table Start Address
lda.b #M7IntensityHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B2   // $4324: DMA2 DMA/HDMA Table Start Address (Bank)

// HDMA Backdrop/Object Blend
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP3  // $4330: DMA3 DMA/HDMA Parameters
lda.b #REG_CGWSEL // $32: Start At Color Math Control Register A ($2130)
sta.w REG_BBAD3  // $4331: DMA3 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #BDOBJBlendHDMATable // HMDA Table Address
stx.w REG_A1T3L  // $4332: DMA3 DMA/HDMA Table Start Address
lda.b #BDOBJBlendHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B3   // $4334: DMA3 DMA/HDMA Table Start Address (Bank)

// HDMA Backdrop/Object Blend DIV
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP4  // $4340: DMA4 DMA/HDMA Parameters
lda.b #REG_CGADSUB // $41: Start At Color Math Control Register B ($2131)
sta.w REG_BBAD4  // $4341: DMA4 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #BDOBJBlendDIVHDMATable // HMDA Table Address
stx.w REG_A1T4L  // $4342: DMA4 DMA/HDMA Table Start Address
lda.b #BDOBJBlendDIVHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B4   // $4344: DMA4 DMA/HDMA Table Start Address (Bank)

// HDMA OAM Size & Object Base
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP5  // $4350: DMA5 DMA/HDMA Parameters
lda.b #REG_OBSEL // $01: Start At Object Size & Object Base ($2101)
sta.w REG_BBAD5  // $4351: DMA5 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #StageHDMATableOAM // HMDA Table Address
stx.w REG_A1T5L  // $4352: DMA5 DMA/HDMA Table Start Address
lda.b #StageHDMATableOAM >> 16 // HDMA Table Bank
sta.w REG_A1B5   // $4354: DMA5 DMA/HDMA Table Start Address (Bank)

lda.b #%00111111 // HDMA Channel Select (Channel 0..5)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

// DMA Load Mode7 Background Map To VRAM
stz.w REG_DMAP6 // Set DMA Mode (Write Byte, Increment Source) ($4360: DMA Control)
lda.b #$18      // Set Destination Register ($2118: VRAM Write)
sta.w REG_BBAD6 // $4361: DMA6 Destination
lda.b #CourseEasyStage01Map >> 16 // Set Source Bank
sta.w REG_A1B6  // $4364: Source Bank
stz.w REG_DAS6H // $4366: DMA6 Transfer Size/HDMA (Hi Byte)

stz.w REG_VMAIN  // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
ldx.w #$1700     // Set VRAM Destination
stx.w REG_VMADDL // $2116: VRAM

ldx.w #CourseEasyStage01Map // Set Source Offset
stx.b StageMapOffset // Store Stage Map Offset
ldy.w #36 // Mode7 Play Area Tile Rows

LoopInitMode7Rows:
  stx.w REG_A1T6L // $4362: DMA6 Source
  lda.b #128      // Set Size In Bytes To DMA Transfer
  sta.w REG_DAS6L // $4365: DMA6 Transfer Size/HDMA (Lo Byte)

  lda.b #%01000000 // Start DMA Transfer On Channel 6
  sta.w REG_MDMAEN // $420B: DMA6 Enable

  rep #$20 // Set 16-Bit Accumulator
  txa // A = X
  clc // Clear Carry Flag
  adc.w #588 // A += Mode7 Play Area Tile Tile columns
  tax // X = A
  sep #$20 // Set 8-Bit Accumulator

  dey // Y--
  bne LoopInitMode7Rows

FadeIN() // Screen Fade In

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  // Dynamic Mode7 Background Map
  Mode7MapInc:
    ldx.b Mode7PosX // X = Mode7 Center Position X
    cpx.w #-6
    bne Mode7MapDec // IF (Mode7 Center Position X != -6) Mode7 Map Dec

    ldx.b StageMapOffset // X = Stage Map Offset
    cpx.w #$8000 + 460
    beq Mode7MapDec // IF (Stage Map Offset = Last Map Column) Mode7 Map Dec

    ldx.w #-14        // ELSE Mode7 Center Position X = -14, BG1 Position X = -142
    stx.b Mode7PosX
    ldx.w #-142
    stx.b BG1ScrPosX

    ldx.b StageMapOffset // Set Source Offset
    inx // X++
    stx.b StageMapOffset // Store Stage Map Offset
    jmp Mode7Rows

  Mode7MapDec:
    ldx.b Mode7PosX // X = Mode7 Center Position X
    cpx.w #-15
    bne SkipMode7Rows // IF (Mode7 Center Position X != -15) Skip Mode7 Rows

    ldx.b StageMapOffset // X = Stage Map Offset
    cpx.w #$8000 + 0
    beq SkipMode7Rows // IF (Stage Map Offset = First Map Column) Skip Mode7 Rows

    ldx.w #-6         // ELSE Mode7 Center Position X = -6, BG1 Position X = -134
    stx.b Mode7PosX
    ldx.w #-134
    stx.b BG1ScrPosX

    ldx.b StageMapOffset // Set Source Offset
    dex // X--
    stx.b StageMapOffset // Store Stage Map Offset

  Mode7Rows:
    stz.w REG_VMAIN  // Set Increment VRAM Address After Accessing Lo Byte ($2115: Video Port Control)
    ldy.w #$1700     // Set VRAM Destination
    sty.w REG_VMADDL // $2116: VRAM

    ldy.w #36 // Mode7 Play Area Tile Rows

    LoopMode7Rows:
      stx.w REG_A1T6L // $4362: DMA6 Source
      lda.b #128      // Set Size In Bytes To DMA Transfer
      sta.w REG_DAS6L // $4365: DMA6 Transfer Size/HDMA (Lo Byte)

      lda.b #%01000000 // Start DMA Transfer On Channel 6
      sta.w REG_MDMAEN // $420B: DMA6 Enable

      rep #$20 // Set 16-Bit Accumulator
      txa // A = X
      clc // Clear Carry Flag
      adc.w #588 // A += Mode7 Play Area Tile Tile columns
      tax // X = A
      sep #$20 // Set 8-Bit Accumulator

      dey // Y--
      bne LoopMode7Rows
  SkipMode7Rows:

  lda.b BG1ScrPosX
  sta.w REG_BG1HOFS // $210D: BG1 Position X Lo Byte
  lda.b BG1ScrPosX + 1
  sta.w REG_BG1HOFS // $210D: BG1 Position X Hi Byte

  lda.b BG1ScrPosY
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
  lda.b BG1ScrPosY + 1
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

  lda.b Mode7PosX
  sta.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
  lda.b Mode7PosX + 1
  sta.w REG_M7X // $211F: Mode7 Center Position X Hi Byte

  lda.b Mode7PosY
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  lda.b Mode7PosY + 1
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  JoyUp:
    ReadJOY({JOY_UP}) // Test Joypad UP Button
    beq JoyDown // IF (UP ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Increment BG1 X Pos
    inx
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Increment Mode7 X Pos
    inx
    stx.b Mode7PosX

  JoyDown:
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq JoyLeft // IF (DOWN ! Pressed) Branch Down
    ldx.b BG1ScrPosX // Decrement BG1 X Pos
    dex
    stx.b BG1ScrPosX

    ldx.b Mode7PosX // Decrement Mode7 X Pos
    dex
    stx.b Mode7PosX

  JoyLeft:
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq JoyRight // IF (LEFT ! Pressed) Branch Down
    ldx.b BG1ScrPosY // Decrement BG1 Y Pos
    dex
    stx.b BG1ScrPosY

    ldx.b Mode7PosY // Decrement Mode7 Y Pos
    dex
    stx.b Mode7PosY

  JoyRight:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish // IF (RIGHT ! Pressed) Branch Down
    ldx.b BG1ScrPosY // Increment BG1 Y Pos
    inx
    stx.b BG1ScrPosY

    ldx.b Mode7PosY // Increment Mode7 Y Pos
    inx
    stx.b Mode7PosY

Finish:
  jmp InputLoop

CourseStageOAM:
  // 8x8 / 32x32 Sprites
  // OAM Info (Course Hi Score 32x8)
  db   8,   8,  10, %00110000
  db  16,   8,  11, %00110000
  db  24,   8,  12, %00110000
  db  32,   8,  13, %00110000

  // OAM Info (Course Hi Score Number 8x8)
  db  44,   8,   0, %00110000
  db  50,   8,   0, %00110000
  db  56,   8,   0, %00110000
  db  62,   8,   4, %00110000
  db  68,   8,   2, %00110000
  db  74,   8,   0, %00110000
  db  80,   8,   0, %00110000
  db  86,   8,   0, %00110000
  db  92,   8,   0, %00110000

  // OAM Info (Course Score 32x16)
  db  12,  16,  21, %00110010
  db  20,  16,  22, %00110010
  db  28,  16,  23, %00110010
  db  36,  16,  24, %00110010

  db  12,  24,  37, %00110010
  db  20,  24,  38, %00110010
  db  28,  24,  39, %00110010
  db  36,  24,  40, %00110010

  // OAM Info (Course Score Number 8x16)
  db  44,  16,  80, %00110100
  db  44,  24,  96, %00110100

  db  50,  16,  80, %00110100
  db  50,  24,  96, %00110100

  db  56,  16,  80, %00110100
  db  56,  24,  96, %00110100

  db  62,  16,  80, %00110100
  db  62,  24,  96, %00110100

  db  68,  16,  80, %00110100
  db  68,  24,  96, %00110100

  db  74,  16,  80, %00110100
  db  74,  24,  96, %00110100

  db  80,  16,  80, %00110100
  db  80,  24,  96, %00110100

  db  86,  16,  80, %00110100
  db  86,  24,  96, %00110100

  db  92,  16,  80, %00110100
  db  92,  24,  96, %00110100

  // 16x16 / 32x32 Sprites
  // OAM Info (Distance Marker 16x16)
  db   9, 161, 164, %00111000

  // OAM Info (Goal 24x16)
  db   6,  40,  29, %00110010
  db  14,  40,  30, %00110010

  // OAM Info (Distance Fill 16x112)
  db  15,  58, 166, %00111000
  db  15,  74, 166, %00111000
  db  15,  90, 166, %00111000
  db  15, 106, 166, %00111000
  db  15, 122, 166, %00111000
  db  15, 138, 166, %00111000
  db  15, 154, 166, %00111000

  // OAM Info (Distance Block 16x120)
  db  15,  51,  58, %00110010
  db  15,  67,  60, %00110010
  db  15,  83,  60, %00110010
  db  15,  99,  60, %00110010
  db  15, 115,  60, %00110010
  db  15, 131,  60, %00110010
  db  15, 147,  60, %00110010
  db  15, 155,  62, %00110010

  // OAM Info (Time Number Large 16x24)
  db  18, 186, 124, %00110110
  db  18, 194, 140, %00110110

  db  26, 186, 126, %00110110
  db  26, 194, 142, %00110110

  // OAM Info (Time Number Small 16x16)
  db  35, 202, 160, %00110110
  db  41, 193,  94, %00110110

  // OAM Info (Time 40x40)
  db  13, 174,  16, %00110010
  db  37, 174,  19, %00110010
  db  37, 190,  51, %00110010

  db  13, 206,  53, %00110010
  db  29, 206,  55, %00110010
  db  37, 206,  56, %00110010

  // OAM Info (Life 32x16)
  db 202, 174,  25, %00110010
  db 218, 174,  27, %00110010

  // OAM Info (Life Heart X5 16x16)
  db 171, 194, 162, %00110000
  db 186, 194, 162, %00110000
  db 201, 194, 162, %00110000
  db 216, 194, 162, %00110000
  db 231, 194, 162, %00110000

  // OAM Info (Character 96x96)
  db  80,  52, 192, %00111010
  db 112,  52, 196, %00111010
  db 144,  52, 200, %00111010

  db  80,  84, 204, %00111010
  db 112,  84,   0, %00111011
  db 144,  84,   4, %00111011

  db  80, 116,   8, %00111011
  db 112, 116,  12, %00111011

  // OAM Info (Shadow 32x32)
  db 112, 132, 168, %00001100
  db 128, 132, 170, %00001100

  db 112, 148, 172, %00001100
  db 128, 148, 174, %00001100

  // OAM Info (Cloud A 80x48)
  db  44,   2, 166, %00001111
  db  76,   2, 170, %00001111
  db  92,   2, 172, %00001111

  db  44,  34, 230, %00001111
  db  52,  34, 231, %00001111
  db  60,  34, 232, %00001111
  db  68,  34, 233, %00001111
  db  76,  34, 234, %00001111
  db  84,  34, 235, %00001111
  db  92,  34, 236, %00001111
  db 100,  34, 237, %00001111
  db 108,  34, 238, %00001111

  // OAM Info (Cloud B 80x48)
  db  84, 174,  76, %00001111
  db 116, 174, 160, %00001111
  db 148, 174, 164, %00001111

  db 148, 190, 196, %00001111

  db  84, 206, 140, %00001111
  db 100, 206, 142, %00001111
  db 116, 206, 224, %00001111
  db 132, 206, 226, %00001111
  db 148, 206, 228, %00001111

  // OAM Info (Cloud C 96x48)
  db 174,  76,  64, %00001111
  db 206,  76,  68, %00001111
  db 238,  76,  72, %00001111

  db 174, 108, 128, %00001111
  db 190, 108, 130, %00001111
  db 206, 108, 132, %00001111
  db 222, 108, 134, %00001111
  db 238, 108, 136, %00001111
  db 254, 108, 138, %00001111

  // OAM Extra Info
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %10000000
  db %00000000
  db %00000000
  db %00000000
  db %10101010
  db %10101010
  db %00000000
  db %00101010
  db %00000000
  db %00000000
  db %00001010
  db %00000000
  db %10101000
  db %00000000
  db %10100000

M7IntensityHDMATable:
  db 1, %11111111 // Repeat 1 Scanlines, RGB Intensity 31
  db 1, %11111110 // Repeat 1 Scanlines, RGB Intensity 30
  db 1, %11111101 // Repeat 1 Scanlines, RGB Intensity 29
  db 1, %11111100 // Repeat 1 Scanlines, RGB Intensity 28
  db 1, %11111011 // Repeat 1 Scanlines, RGB Intensity 27
  db 1, %11111010 // Repeat 1 Scanlines, RGB Intensity 26
  db 1, %11111001 // Repeat 1 Scanlines, RGB Intensity 25
  db 1, %11111000 // Repeat 1 Scanlines, RGB Intensity 24
  db 1, %11110111 // Repeat 1 Scanlines, RGB Intensity 23
  db 1, %11110110 // Repeat 1 Scanlines, RGB Intensity 22
  db 1, %11110101 // Repeat 1 Scanlines, RGB Intensity 21
  db 1, %11110100 // Repeat 1 Scanlines, RGB Intensity 20
  db 1, %11110011 // Repeat 1 Scanlines, RGB Intensity 19
  db 1, %11110010 // Repeat 1 Scanlines, RGB Intensity 18
  db 1, %11110001 // Repeat 1 Scanlines, RGB Intensity 17
  db 2, %11110000 // Repeat 2 Scanlines, RGB Intensity 16
  db 2, %11101111 // Repeat 2 Scanlines, RGB Intensity 15
  db 2, %11101110 // Repeat 2 Scanlines, RGB Intensity 14
  db 2, %11101101 // Repeat 2 Scanlines, RGB Intensity 13
  db 2, %11101100 // Repeat 2 Scanlines, RGB Intensity 12
  db 2, %11101011 // Repeat 2 Scanlines, RGB Intensity 11
  db 2, %11101010 // Repeat 2 Scanlines, RGB Intensity 10
  db 2, %11101001 // Repeat 2 Scanlines, RGB Intensity 9
  db 2, %11101000 // Repeat 2 Scanlines, RGB Intensity 8
  db 2, %11100111 // Repeat 2 Scanlines, RGB Intensity 7
  db 2, %11100110 // Repeat 2 Scanlines, RGB Intensity 6
  db 2, %11100101 // Repeat 2 Scanlines, RGB Intensity 5
  db 2, %11100100 // Repeat 2 Scanlines, RGB Intensity 4
  db 2, %11100011 // Repeat 2 Scanlines, RGB Intensity 3
  db 2, %11100010 // Repeat 2 Scanlines, RGB Intensity 2
  db 2, %11100001 // Repeat 2 Scanlines, RGB Intensity 1
  db 1, %00000000 // Repeat 1 Scanlines, RGB Intensity 0
  db 0 // End Of HDMA

BDOBJBlendHDMATable:
  db 128, %00000000 // Repeat 128 Scanlines, Enable Sub Screen Backdrop Color ADD/SUB
  db   4, %00000000 // Repeat   4 Scanlines, Enable Sub Screen Backdrop Color ADD/SUB
  db  32, %00000010 // Repeat  32 Scanlines, Enable Sub Screen BG/OBJ/Backdrop Color ADD/SUB
  db   1, %00000000 // Repeat   1 Scanlines, Enable Sub Screen Backdrop Color ADD/SUB
  db 0 // End Of HDMA

BDOBJBlendDIVHDMATable:
  db 128, %00000001 // Repeat 128 Scanlines, Enable Colour Addition On BG1
  db   4, %00000001 // Repeat   4 Scanlines, Enable Colour Addition On BG1
  db  32, %01000001 // Repeat  32 Scanlines, Enable Colour Addition On BG1, Half Result
  db   1, %00000000 // Repeat   1 Scanlines, Enable Colour Addition On BG1
  db 0 // End Of HDMA

StageHDMATableOAM:
  db 40, %00100010 // Repeat 40 Scanlines, Object Size =   8x8/32x32, Name = 0, Base = $8000
  db  1, %01100010 // Repeat  1 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $8000
  db 0 // End Of HDMA

M7NSINHDMATable: // Mode7 -SIN (C) Table 224 * Rotation / Scaling Ratios (Last 8-Bits Fractional)
db $01; dw -20480 // Repeat 1 Scanline, Mode7 -SIN Scanline 1
db $01; dw -10240 // Repeat 1 Scanline, Mode7 -SIN Scanline 2
db $01; dw -6827 // Repeat 1 Scanline, Mode7 -SIN Scanline 3
db $01; dw -5120 // Repeat 1 Scanline, Mode7 -SIN Scanline 4
db $01; dw -4096 // Repeat 1 Scanline, Mode7 -SIN Scanline 5
db $01; dw -3413 // Repeat 1 Scanline, Mode7 -SIN Scanline 6
db $01; dw -2926 // Repeat 1 Scanline, Mode7 -SIN Scanline 7
db $01; dw -2560 // Repeat 1 Scanline, Mode7 -SIN Scanline 8
db $01; dw -2276 // Repeat 1 Scanline, Mode7 -SIN Scanline 9
db $01; dw -2048 // Repeat 1 Scanline, Mode7 -SIN Scanline 10
db $01; dw -1862 // Repeat 1 Scanline, Mode7 -SIN Scanline 11
db $01; dw -1707 // Repeat 1 Scanline, Mode7 -SIN Scanline 12
db $01; dw -1575 // Repeat 1 Scanline, Mode7 -SIN Scanline 13
db $01; dw -1463 // Repeat 1 Scanline, Mode7 -SIN Scanline 14
db $01; dw -1365 // Repeat 1 Scanline, Mode7 -SIN Scanline 15
db $01; dw -1280 // Repeat 1 Scanline, Mode7 -SIN Scanline 16
db $01; dw -1205 // Repeat 1 Scanline, Mode7 -SIN Scanline 17
db $01; dw -1138 // Repeat 1 Scanline, Mode7 -SIN Scanline 18
db $01; dw -1078 // Repeat 1 Scanline, Mode7 -SIN Scanline 19
db $01; dw -1024 // Repeat 1 Scanline, Mode7 -SIN Scanline 20
db $01; dw -975 // Repeat 1 Scanline, Mode7 -SIN Scanline 21
db $01; dw -931 // Repeat 1 Scanline, Mode7 -SIN Scanline 22
db $01; dw -890 // Repeat 1 Scanline, Mode7 -SIN Scanline 23
db $01; dw -853 // Repeat 1 Scanline, Mode7 -SIN Scanline 24
db $01; dw -819 // Repeat 1 Scanline, Mode7 -SIN Scanline 25
db $01; dw -788 // Repeat 1 Scanline, Mode7 -SIN Scanline 26
db $01; dw -759 // Repeat 1 Scanline, Mode7 -SIN Scanline 27
db $01; dw -731 // Repeat 1 Scanline, Mode7 -SIN Scanline 28
db $01; dw -706 // Repeat 1 Scanline, Mode7 -SIN Scanline 29
db $01; dw -683 // Repeat 1 Scanline, Mode7 -SIN Scanline 30
db $01; dw -661 // Repeat 1 Scanline, Mode7 -SIN Scanline 31
db $01; dw -640 // Repeat 1 Scanline, Mode7 -SIN Scanline 32
db $01; dw -621 // Repeat 1 Scanline, Mode7 -SIN Scanline 33
db $01; dw -602 // Repeat 1 Scanline, Mode7 -SIN Scanline 34
db $01; dw -585 // Repeat 1 Scanline, Mode7 -SIN Scanline 35
db $01; dw -569 // Repeat 1 Scanline, Mode7 -SIN Scanline 36
db $01; dw -554 // Repeat 1 Scanline, Mode7 -SIN Scanline 37
db $01; dw -539 // Repeat 1 Scanline, Mode7 -SIN Scanline 38
db $01; dw -525 // Repeat 1 Scanline, Mode7 -SIN Scanline 39
db $01; dw -512 // Repeat 1 Scanline, Mode7 -SIN Scanline 40
db $01; dw -500 // Repeat 1 Scanline, Mode7 -SIN Scanline 41
db $01; dw -488 // Repeat 1 Scanline, Mode7 -SIN Scanline 42
db $01; dw -476 // Repeat 1 Scanline, Mode7 -SIN Scanline 43
db $01; dw -465 // Repeat 1 Scanline, Mode7 -SIN Scanline 44
db $01; dw -455 // Repeat 1 Scanline, Mode7 -SIN Scanline 45
db $01; dw -445 // Repeat 1 Scanline, Mode7 -SIN Scanline 46
db $01; dw -436 // Repeat 1 Scanline, Mode7 -SIN Scanline 47
db $01; dw -427 // Repeat 1 Scanline, Mode7 -SIN Scanline 48
db $01; dw -418 // Repeat 1 Scanline, Mode7 -SIN Scanline 49
db $01; dw -410 // Repeat 1 Scanline, Mode7 -SIN Scanline 50
db $01; dw -402 // Repeat 1 Scanline, Mode7 -SIN Scanline 51
db $01; dw -394 // Repeat 1 Scanline, Mode7 -SIN Scanline 52
db $01; dw -386 // Repeat 1 Scanline, Mode7 -SIN Scanline 53
db $01; dw -379 // Repeat 1 Scanline, Mode7 -SIN Scanline 54
db $01; dw -372 // Repeat 1 Scanline, Mode7 -SIN Scanline 55
db $01; dw -366 // Repeat 1 Scanline, Mode7 -SIN Scanline 56
db $01; dw -359 // Repeat 1 Scanline, Mode7 -SIN Scanline 57
db $01; dw -353 // Repeat 1 Scanline, Mode7 -SIN Scanline 58
db $01; dw -347 // Repeat 1 Scanline, Mode7 -SIN Scanline 59
db $01; dw -341 // Repeat 1 Scanline, Mode7 -SIN Scanline 60
db $01; dw -336 // Repeat 1 Scanline, Mode7 -SIN Scanline 61
db $01; dw -330 // Repeat 1 Scanline, Mode7 -SIN Scanline 62
db $01; dw -325 // Repeat 1 Scanline, Mode7 -SIN Scanline 63
db $01; dw -320 // Repeat 1 Scanline, Mode7 -SIN Scanline 64
db $01; dw -315 // Repeat 1 Scanline, Mode7 -SIN Scanline 65
db $01; dw -310 // Repeat 1 Scanline, Mode7 -SIN Scanline 66
db $01; dw -306 // Repeat 1 Scanline, Mode7 -SIN Scanline 67
db $01; dw -301 // Repeat 1 Scanline, Mode7 -SIN Scanline 68
db $01; dw -297 // Repeat 1 Scanline, Mode7 -SIN Scanline 69
db $01; dw -293 // Repeat 1 Scanline, Mode7 -SIN Scanline 70
db $01; dw -288 // Repeat 1 Scanline, Mode7 -SIN Scanline 71
db $01; dw -284 // Repeat 1 Scanline, Mode7 -SIN Scanline 72
db $01; dw -281 // Repeat 1 Scanline, Mode7 -SIN Scanline 73
db $01; dw -277 // Repeat 1 Scanline, Mode7 -SIN Scanline 74
db $01; dw -273 // Repeat 1 Scanline, Mode7 -SIN Scanline 75
db $01; dw -269 // Repeat 1 Scanline, Mode7 -SIN Scanline 76
db $01; dw -266 // Repeat 1 Scanline, Mode7 -SIN Scanline 77
db $01; dw -263 // Repeat 1 Scanline, Mode7 -SIN Scanline 78
db $01; dw -259 // Repeat 1 Scanline, Mode7 -SIN Scanline 79
db $01; dw -256 // Repeat 1 Scanline, Mode7 -SIN Scanline 80
db $01; dw -253 // Repeat 1 Scanline, Mode7 -SIN Scanline 81
db $01; dw -250 // Repeat 1 Scanline, Mode7 -SIN Scanline 82
db $01; dw -247 // Repeat 1 Scanline, Mode7 -SIN Scanline 83
db $01; dw -244 // Repeat 1 Scanline, Mode7 -SIN Scanline 84
db $01; dw -241 // Repeat 1 Scanline, Mode7 -SIN Scanline 85
db $01; dw -238 // Repeat 1 Scanline, Mode7 -SIN Scanline 86
db $01; dw -235 // Repeat 1 Scanline, Mode7 -SIN Scanline 87
db $01; dw -233 // Repeat 1 Scanline, Mode7 -SIN Scanline 88
db $01; dw -230 // Repeat 1 Scanline, Mode7 -SIN Scanline 89
db $01; dw -228 // Repeat 1 Scanline, Mode7 -SIN Scanline 90
db $01; dw -225 // Repeat 1 Scanline, Mode7 -SIN Scanline 91
db $01; dw -223 // Repeat 1 Scanline, Mode7 -SIN Scanline 92
db $01; dw -220 // Repeat 1 Scanline, Mode7 -SIN Scanline 93
db $01; dw -218 // Repeat 1 Scanline, Mode7 -SIN Scanline 94
db $01; dw -216 // Repeat 1 Scanline, Mode7 -SIN Scanline 95
db $01; dw -213 // Repeat 1 Scanline, Mode7 -SIN Scanline 96
db $01; dw -211 // Repeat 1 Scanline, Mode7 -SIN Scanline 97
db $01; dw -209 // Repeat 1 Scanline, Mode7 -SIN Scanline 98
db $01; dw -207 // Repeat 1 Scanline, Mode7 -SIN Scanline 99
db $01; dw -205 // Repeat 1 Scanline, Mode7 -SIN Scanline 100
db $01; dw -203 // Repeat 1 Scanline, Mode7 -SIN Scanline 101
db $01; dw -201 // Repeat 1 Scanline, Mode7 -SIN Scanline 102
db $01; dw -199 // Repeat 1 Scanline, Mode7 -SIN Scanline 103
db $01; dw -197 // Repeat 1 Scanline, Mode7 -SIN Scanline 104
db $01; dw -195 // Repeat 1 Scanline, Mode7 -SIN Scanline 105
db $01; dw -193 // Repeat 1 Scanline, Mode7 -SIN Scanline 106
db $01; dw -191 // Repeat 1 Scanline, Mode7 -SIN Scanline 107
db $01; dw -190 // Repeat 1 Scanline, Mode7 -SIN Scanline 108
db $01; dw -188 // Repeat 1 Scanline, Mode7 -SIN Scanline 109
db $01; dw -186 // Repeat 1 Scanline, Mode7 -SIN Scanline 110
db $01; dw -185 // Repeat 1 Scanline, Mode7 -SIN Scanline 111
db $01; dw -183 // Repeat 1 Scanline, Mode7 -SIN Scanline 112
db $01; dw -181 // Repeat 1 Scanline, Mode7 -SIN Scanline 113
db $01; dw -180 // Repeat 1 Scanline, Mode7 -SIN Scanline 114
db $01; dw -178 // Repeat 1 Scanline, Mode7 -SIN Scanline 115
db $01; dw -177 // Repeat 1 Scanline, Mode7 -SIN Scanline 116
db $01; dw -175 // Repeat 1 Scanline, Mode7 -SIN Scanline 117
db $01; dw -174 // Repeat 1 Scanline, Mode7 -SIN Scanline 118
db $01; dw -172 // Repeat 1 Scanline, Mode7 -SIN Scanline 119
db $01; dw -171 // Repeat 1 Scanline, Mode7 -SIN Scanline 120
db $01; dw -169 // Repeat 1 Scanline, Mode7 -SIN Scanline 121
db $01; dw -168 // Repeat 1 Scanline, Mode7 -SIN Scanline 122
db $01; dw -167 // Repeat 1 Scanline, Mode7 -SIN Scanline 123
db $01; dw -165 // Repeat 1 Scanline, Mode7 -SIN Scanline 124
db $01; dw -164 // Repeat 1 Scanline, Mode7 -SIN Scanline 125
db $01; dw -163 // Repeat 1 Scanline, Mode7 -SIN Scanline 126
db $01; dw -161 // Repeat 1 Scanline, Mode7 -SIN Scanline 127
db $01; dw -160 // Repeat 1 Scanline, Mode7 -SIN Scanline 128
db $01; dw -159 // Repeat 1 Scanline, Mode7 -SIN Scanline 129
db $01; dw -158 // Repeat 1 Scanline, Mode7 -SIN Scanline 130
db $01; dw -156 // Repeat 1 Scanline, Mode7 -SIN Scanline 131
db $01; dw -155 // Repeat 1 Scanline, Mode7 -SIN Scanline 132
db $01; dw -154 // Repeat 1 Scanline, Mode7 -SIN Scanline 133
db $01; dw -153 // Repeat 1 Scanline, Mode7 -SIN Scanline 134
db $01; dw -152 // Repeat 1 Scanline, Mode7 -SIN Scanline 135
db $01; dw -151 // Repeat 1 Scanline, Mode7 -SIN Scanline 136
db $01; dw -149 // Repeat 1 Scanline, Mode7 -SIN Scanline 137
db $01; dw -148 // Repeat 1 Scanline, Mode7 -SIN Scanline 138
db $01; dw -147 // Repeat 1 Scanline, Mode7 -SIN Scanline 139
db $01; dw -146 // Repeat 1 Scanline, Mode7 -SIN Scanline 140
db $01; dw -145 // Repeat 1 Scanline, Mode7 -SIN Scanline 141
db $01; dw -144 // Repeat 1 Scanline, Mode7 -SIN Scanline 142
db $01; dw -143 // Repeat 1 Scanline, Mode7 -SIN Scanline 143
db $01; dw -142 // Repeat 1 Scanline, Mode7 -SIN Scanline 144
db $01; dw -141 // Repeat 1 Scanline, Mode7 -SIN Scanline 145
db $01; dw -140 // Repeat 1 Scanline, Mode7 -SIN Scanline 146
db $01; dw -139 // Repeat 1 Scanline, Mode7 -SIN Scanline 147
db $01; dw -138 // Repeat 1 Scanline, Mode7 -SIN Scanline 148
db $01; dw -137 // Repeat 1 Scanline, Mode7 -SIN Scanline 149
db $01; dw -137 // Repeat 1 Scanline, Mode7 -SIN Scanline 150
db $01; dw -136 // Repeat 1 Scanline, Mode7 -SIN Scanline 151
db $01; dw -135 // Repeat 1 Scanline, Mode7 -SIN Scanline 152
db $01; dw -134 // Repeat 1 Scanline, Mode7 -SIN Scanline 153
db $01; dw -133 // Repeat 1 Scanline, Mode7 -SIN Scanline 154
db $01; dw -132 // Repeat 1 Scanline, Mode7 -SIN Scanline 155
db $01; dw -131 // Repeat 1 Scanline, Mode7 -SIN Scanline 156
db $01; dw -130 // Repeat 1 Scanline, Mode7 -SIN Scanline 157
db $01; dw -130 // Repeat 1 Scanline, Mode7 -SIN Scanline 158
db $01; dw -129 // Repeat 1 Scanline, Mode7 -SIN Scanline 159
db $01; dw -128 // Repeat 1 Scanline, Mode7 -SIN Scanline 160
db $01; dw -127 // Repeat 1 Scanline, Mode7 -SIN Scanline 161
db $01; dw -126 // Repeat 1 Scanline, Mode7 -SIN Scanline 162
db $01; dw -126 // Repeat 1 Scanline, Mode7 -SIN Scanline 163
db $01; dw -125 // Repeat 1 Scanline, Mode7 -SIN Scanline 164
db $01; dw -124 // Repeat 1 Scanline, Mode7 -SIN Scanline 165
db $01; dw -123 // Repeat 1 Scanline, Mode7 -SIN Scanline 166
db $01; dw -123 // Repeat 1 Scanline, Mode7 -SIN Scanline 167
db $01; dw -122 // Repeat 1 Scanline, Mode7 -SIN Scanline 168
db $01; dw -121 // Repeat 1 Scanline, Mode7 -SIN Scanline 169
db $01; dw -120 // Repeat 1 Scanline, Mode7 -SIN Scanline 170
db $01; dw -120 // Repeat 1 Scanline, Mode7 -SIN Scanline 171
db $01; dw -119 // Repeat 1 Scanline, Mode7 -SIN Scanline 172
db $01; dw -118 // Repeat 1 Scanline, Mode7 -SIN Scanline 173
db $01; dw -118 // Repeat 1 Scanline, Mode7 -SIN Scanline 174
db $01; dw -117 // Repeat 1 Scanline, Mode7 -SIN Scanline 175
db $01; dw -116 // Repeat 1 Scanline, Mode7 -SIN Scanline 176
db $01; dw -116 // Repeat 1 Scanline, Mode7 -SIN Scanline 177
db $01; dw -115 // Repeat 1 Scanline, Mode7 -SIN Scanline 178
db $01; dw -114 // Repeat 1 Scanline, Mode7 -SIN Scanline 179
db $01; dw -114 // Repeat 1 Scanline, Mode7 -SIN Scanline 180
db $01; dw -113 // Repeat 1 Scanline, Mode7 -SIN Scanline 181
db $01; dw -113 // Repeat 1 Scanline, Mode7 -SIN Scanline 182
db $01; dw -112 // Repeat 1 Scanline, Mode7 -SIN Scanline 183
db $01; dw -111 // Repeat 1 Scanline, Mode7 -SIN Scanline 184
db $01; dw -111 // Repeat 1 Scanline, Mode7 -SIN Scanline 185
db $01; dw -110 // Repeat 1 Scanline, Mode7 -SIN Scanline 186
db $01; dw -110 // Repeat 1 Scanline, Mode7 -SIN Scanline 187
db $01; dw -109 // Repeat 1 Scanline, Mode7 -SIN Scanline 188
db $01; dw -108 // Repeat 1 Scanline, Mode7 -SIN Scanline 189
db $01; dw -108 // Repeat 1 Scanline, Mode7 -SIN Scanline 190
db $01; dw -107 // Repeat 1 Scanline, Mode7 -SIN Scanline 191
db $01; dw -107 // Repeat 1 Scanline, Mode7 -SIN Scanline 192
db $01; dw -106 // Repeat 1 Scanline, Mode7 -SIN Scanline 193
db $01; dw -106 // Repeat 1 Scanline, Mode7 -SIN Scanline 194
db $01; dw -105 // Repeat 1 Scanline, Mode7 -SIN Scanline 195
db $01; dw -104 // Repeat 1 Scanline, Mode7 -SIN Scanline 196
db $01; dw -104 // Repeat 1 Scanline, Mode7 -SIN Scanline 197
db $01; dw -103 // Repeat 1 Scanline, Mode7 -SIN Scanline 198
db $01; dw -103 // Repeat 1 Scanline, Mode7 -SIN Scanline 199
db $01; dw -102 // Repeat 1 Scanline, Mode7 -SIN Scanline 200
db $01; dw -102 // Repeat 1 Scanline, Mode7 -SIN Scanline 201
db $01; dw -101 // Repeat 1 Scanline, Mode7 -SIN Scanline 202
db $01; dw -101 // Repeat 1 Scanline, Mode7 -SIN Scanline 203
db $01; dw -100 // Repeat 1 Scanline, Mode7 -SIN Scanline 204
db $01; dw -100 // Repeat 1 Scanline, Mode7 -SIN Scanline 205
db $01; dw -99 // Repeat 1 Scanline, Mode7 -SIN Scanline 206
db $01; dw -99 // Repeat 1 Scanline, Mode7 -SIN Scanline 207
db $01; dw -98 // Repeat 1 Scanline, Mode7 -SIN Scanline 208
db $01; dw -98 // Repeat 1 Scanline, Mode7 -SIN Scanline 209
db $01; dw -98 // Repeat 1 Scanline, Mode7 -SIN Scanline 210
db $01; dw -97 // Repeat 1 Scanline, Mode7 -SIN Scanline 211
db $01; dw -97 // Repeat 1 Scanline, Mode7 -SIN Scanline 212
db $01; dw -96 // Repeat 1 Scanline, Mode7 -SIN Scanline 213
db $01; dw -96 // Repeat 1 Scanline, Mode7 -SIN Scanline 214
db $01; dw -95 // Repeat 1 Scanline, Mode7 -SIN Scanline 215
db $01; dw -95 // Repeat 1 Scanline, Mode7 -SIN Scanline 216
db $01; dw -94 // Repeat 1 Scanline, Mode7 -SIN Scanline 217
db $01; dw -94 // Repeat 1 Scanline, Mode7 -SIN Scanline 218
db $01; dw -94 // Repeat 1 Scanline, Mode7 -SIN Scanline 219
db $01; dw -93 // Repeat 1 Scanline, Mode7 -SIN Scanline 220
db $01; dw -93 // Repeat 1 Scanline, Mode7 -SIN Scanline 221
db $01; dw -92 // Repeat 1 Scanline, Mode7 -SIN Scanline 222
db $01; dw -92 // Repeat 1 Scanline, Mode7 -SIN Scanline 223
db $01; dw -91 // Repeat 1 Scanline, Mode7 -SIN Scanline 224
db $00 // End Of HDMA

M7SINHDMATable: // Mode7 +SIN (B) Table 224 * Rotation / Scaling Ratios (Last 8-Bits Fractional)
db $01; dw 20480 // Repeat 1 Scanline, Mode7 +SIN Scanline 1
db $01; dw 10240 // Repeat 1 Scanline, Mode7 +SIN Scanline 2
db $01; dw 6827 // Repeat 1 Scanline, Mode7 +SIN Scanline 3
db $01; dw 5120 // Repeat 1 Scanline, Mode7 +SIN Scanline 4
db $01; dw 4096 // Repeat 1 Scanline, Mode7 +SIN Scanline 5
db $01; dw 3413 // Repeat 1 Scanline, Mode7 +SIN Scanline 6
db $01; dw 2926 // Repeat 1 Scanline, Mode7 +SIN Scanline 7
db $01; dw 2560 // Repeat 1 Scanline, Mode7 +SIN Scanline 8
db $01; dw 2276 // Repeat 1 Scanline, Mode7 +SIN Scanline 9
db $01; dw 2048 // Repeat 1 Scanline, Mode7 +SIN Scanline 10
db $01; dw 1862 // Repeat 1 Scanline, Mode7 +SIN Scanline 11
db $01; dw 1707 // Repeat 1 Scanline, Mode7 +SIN Scanline 12
db $01; dw 1575 // Repeat 1 Scanline, Mode7 +SIN Scanline 13
db $01; dw 1463 // Repeat 1 Scanline, Mode7 +SIN Scanline 14
db $01; dw 1365 // Repeat 1 Scanline, Mode7 +SIN Scanline 15
db $01; dw 1280 // Repeat 1 Scanline, Mode7 +SIN Scanline 16
db $01; dw 1205 // Repeat 1 Scanline, Mode7 +SIN Scanline 17
db $01; dw 1138 // Repeat 1 Scanline, Mode7 +SIN Scanline 18
db $01; dw 1078 // Repeat 1 Scanline, Mode7 +SIN Scanline 19
db $01; dw 1024 // Repeat 1 Scanline, Mode7 +SIN Scanline 20
db $01; dw 975 // Repeat 1 Scanline, Mode7 +SIN Scanline 21
db $01; dw 931 // Repeat 1 Scanline, Mode7 +SIN Scanline 22
db $01; dw 890 // Repeat 1 Scanline, Mode7 +SIN Scanline 23
db $01; dw 853 // Repeat 1 Scanline, Mode7 +SIN Scanline 24
db $01; dw 819 // Repeat 1 Scanline, Mode7 +SIN Scanline 25
db $01; dw 788 // Repeat 1 Scanline, Mode7 +SIN Scanline 26
db $01; dw 759 // Repeat 1 Scanline, Mode7 +SIN Scanline 27
db $01; dw 731 // Repeat 1 Scanline, Mode7 +SIN Scanline 28
db $01; dw 706 // Repeat 1 Scanline, Mode7 +SIN Scanline 29
db $01; dw 683 // Repeat 1 Scanline, Mode7 +SIN Scanline 30
db $01; dw 661 // Repeat 1 Scanline, Mode7 +SIN Scanline 31
db $01; dw 640 // Repeat 1 Scanline, Mode7 +SIN Scanline 32
db $01; dw 621 // Repeat 1 Scanline, Mode7 +SIN Scanline 33
db $01; dw 602 // Repeat 1 Scanline, Mode7 +SIN Scanline 34
db $01; dw 585 // Repeat 1 Scanline, Mode7 +SIN Scanline 35
db $01; dw 569 // Repeat 1 Scanline, Mode7 +SIN Scanline 36
db $01; dw 554 // Repeat 1 Scanline, Mode7 +SIN Scanline 37
db $01; dw 539 // Repeat 1 Scanline, Mode7 +SIN Scanline 38
db $01; dw 525 // Repeat 1 Scanline, Mode7 +SIN Scanline 39
db $01; dw 512 // Repeat 1 Scanline, Mode7 +SIN Scanline 40
db $01; dw 500 // Repeat 1 Scanline, Mode7 +SIN Scanline 41
db $01; dw 488 // Repeat 1 Scanline, Mode7 +SIN Scanline 42
db $01; dw 476 // Repeat 1 Scanline, Mode7 +SIN Scanline 43
db $01; dw 465 // Repeat 1 Scanline, Mode7 +SIN Scanline 44
db $01; dw 455 // Repeat 1 Scanline, Mode7 +SIN Scanline 45
db $01; dw 445 // Repeat 1 Scanline, Mode7 +SIN Scanline 46
db $01; dw 436 // Repeat 1 Scanline, Mode7 +SIN Scanline 47
db $01; dw 427 // Repeat 1 Scanline, Mode7 +SIN Scanline 48
db $01; dw 418 // Repeat 1 Scanline, Mode7 +SIN Scanline 49
db $01; dw 410 // Repeat 1 Scanline, Mode7 +SIN Scanline 50
db $01; dw 402 // Repeat 1 Scanline, Mode7 +SIN Scanline 51
db $01; dw 394 // Repeat 1 Scanline, Mode7 +SIN Scanline 52
db $01; dw 386 // Repeat 1 Scanline, Mode7 +SIN Scanline 53
db $01; dw 379 // Repeat 1 Scanline, Mode7 +SIN Scanline 54
db $01; dw 372 // Repeat 1 Scanline, Mode7 +SIN Scanline 55
db $01; dw 366 // Repeat 1 Scanline, Mode7 +SIN Scanline 56
db $01; dw 359 // Repeat 1 Scanline, Mode7 +SIN Scanline 57
db $01; dw 353 // Repeat 1 Scanline, Mode7 +SIN Scanline 58
db $01; dw 347 // Repeat 1 Scanline, Mode7 +SIN Scanline 59
db $01; dw 341 // Repeat 1 Scanline, Mode7 +SIN Scanline 60
db $01; dw 336 // Repeat 1 Scanline, Mode7 +SIN Scanline 61
db $01; dw 330 // Repeat 1 Scanline, Mode7 +SIN Scanline 62
db $01; dw 325 // Repeat 1 Scanline, Mode7 +SIN Scanline 63
db $01; dw 320 // Repeat 1 Scanline, Mode7 +SIN Scanline 64
db $01; dw 315 // Repeat 1 Scanline, Mode7 +SIN Scanline 65
db $01; dw 310 // Repeat 1 Scanline, Mode7 +SIN Scanline 66
db $01; dw 306 // Repeat 1 Scanline, Mode7 +SIN Scanline 67
db $01; dw 301 // Repeat 1 Scanline, Mode7 +SIN Scanline 68
db $01; dw 297 // Repeat 1 Scanline, Mode7 +SIN Scanline 69
db $01; dw 293 // Repeat 1 Scanline, Mode7 +SIN Scanline 70
db $01; dw 288 // Repeat 1 Scanline, Mode7 +SIN Scanline 71
db $01; dw 284 // Repeat 1 Scanline, Mode7 +SIN Scanline 72
db $01; dw 281 // Repeat 1 Scanline, Mode7 +SIN Scanline 73
db $01; dw 277 // Repeat 1 Scanline, Mode7 +SIN Scanline 74
db $01; dw 273 // Repeat 1 Scanline, Mode7 +SIN Scanline 75
db $01; dw 269 // Repeat 1 Scanline, Mode7 +SIN Scanline 76
db $01; dw 266 // Repeat 1 Scanline, Mode7 +SIN Scanline 77
db $01; dw 263 // Repeat 1 Scanline, Mode7 +SIN Scanline 78
db $01; dw 259 // Repeat 1 Scanline, Mode7 +SIN Scanline 79
db $01; dw 256 // Repeat 1 Scanline, Mode7 +SIN Scanline 80
db $01; dw 253 // Repeat 1 Scanline, Mode7 +SIN Scanline 81
db $01; dw 250 // Repeat 1 Scanline, Mode7 +SIN Scanline 82
db $01; dw 247 // Repeat 1 Scanline, Mode7 +SIN Scanline 83
db $01; dw 244 // Repeat 1 Scanline, Mode7 +SIN Scanline 84
db $01; dw 241 // Repeat 1 Scanline, Mode7 +SIN Scanline 85
db $01; dw 238 // Repeat 1 Scanline, Mode7 +SIN Scanline 86
db $01; dw 235 // Repeat 1 Scanline, Mode7 +SIN Scanline 87
db $01; dw 233 // Repeat 1 Scanline, Mode7 +SIN Scanline 88
db $01; dw 230 // Repeat 1 Scanline, Mode7 +SIN Scanline 89
db $01; dw 228 // Repeat 1 Scanline, Mode7 +SIN Scanline 90
db $01; dw 225 // Repeat 1 Scanline, Mode7 +SIN Scanline 91
db $01; dw 223 // Repeat 1 Scanline, Mode7 +SIN Scanline 92
db $01; dw 220 // Repeat 1 Scanline, Mode7 +SIN Scanline 93
db $01; dw 218 // Repeat 1 Scanline, Mode7 +SIN Scanline 94
db $01; dw 216 // Repeat 1 Scanline, Mode7 +SIN Scanline 95
db $01; dw 213 // Repeat 1 Scanline, Mode7 +SIN Scanline 96
db $01; dw 211 // Repeat 1 Scanline, Mode7 +SIN Scanline 97
db $01; dw 209 // Repeat 1 Scanline, Mode7 +SIN Scanline 98
db $01; dw 207 // Repeat 1 Scanline, Mode7 +SIN Scanline 99
db $01; dw 205 // Repeat 1 Scanline, Mode7 +SIN Scanline 100
db $01; dw 203 // Repeat 1 Scanline, Mode7 +SIN Scanline 101
db $01; dw 201 // Repeat 1 Scanline, Mode7 +SIN Scanline 102
db $01; dw 199 // Repeat 1 Scanline, Mode7 +SIN Scanline 103
db $01; dw 197 // Repeat 1 Scanline, Mode7 +SIN Scanline 104
db $01; dw 195 // Repeat 1 Scanline, Mode7 +SIN Scanline 105
db $01; dw 193 // Repeat 1 Scanline, Mode7 +SIN Scanline 106
db $01; dw 191 // Repeat 1 Scanline, Mode7 +SIN Scanline 107
db $01; dw 190 // Repeat 1 Scanline, Mode7 +SIN Scanline 108
db $01; dw 188 // Repeat 1 Scanline, Mode7 +SIN Scanline 109
db $01; dw 186 // Repeat 1 Scanline, Mode7 +SIN Scanline 110
db $01; dw 185 // Repeat 1 Scanline, Mode7 +SIN Scanline 111
db $01; dw 183 // Repeat 1 Scanline, Mode7 +SIN Scanline 112
db $01; dw 181 // Repeat 1 Scanline, Mode7 +SIN Scanline 113
db $01; dw 180 // Repeat 1 Scanline, Mode7 +SIN Scanline 114
db $01; dw 178 // Repeat 1 Scanline, Mode7 +SIN Scanline 115
db $01; dw 177 // Repeat 1 Scanline, Mode7 +SIN Scanline 116
db $01; dw 175 // Repeat 1 Scanline, Mode7 +SIN Scanline 117
db $01; dw 174 // Repeat 1 Scanline, Mode7 +SIN Scanline 118
db $01; dw 172 // Repeat 1 Scanline, Mode7 +SIN Scanline 119
db $01; dw 171 // Repeat 1 Scanline, Mode7 +SIN Scanline 120
db $01; dw 169 // Repeat 1 Scanline, Mode7 +SIN Scanline 121
db $01; dw 168 // Repeat 1 Scanline, Mode7 +SIN Scanline 122
db $01; dw 167 // Repeat 1 Scanline, Mode7 +SIN Scanline 123
db $01; dw 165 // Repeat 1 Scanline, Mode7 +SIN Scanline 124
db $01; dw 164 // Repeat 1 Scanline, Mode7 +SIN Scanline 125
db $01; dw 163 // Repeat 1 Scanline, Mode7 +SIN Scanline 126
db $01; dw 161 // Repeat 1 Scanline, Mode7 +SIN Scanline 127
db $01; dw 160 // Repeat 1 Scanline, Mode7 +SIN Scanline 128
db $01; dw 159 // Repeat 1 Scanline, Mode7 +SIN Scanline 129
db $01; dw 158 // Repeat 1 Scanline, Mode7 +SIN Scanline 130
db $01; dw 156 // Repeat 1 Scanline, Mode7 +SIN Scanline 131
db $01; dw 155 // Repeat 1 Scanline, Mode7 +SIN Scanline 132
db $01; dw 154 // Repeat 1 Scanline, Mode7 +SIN Scanline 133
db $01; dw 153 // Repeat 1 Scanline, Mode7 +SIN Scanline 134
db $01; dw 152 // Repeat 1 Scanline, Mode7 +SIN Scanline 135
db $01; dw 151 // Repeat 1 Scanline, Mode7 +SIN Scanline 136
db $01; dw 149 // Repeat 1 Scanline, Mode7 +SIN Scanline 137
db $01; dw 148 // Repeat 1 Scanline, Mode7 +SIN Scanline 138
db $01; dw 147 // Repeat 1 Scanline, Mode7 +SIN Scanline 139
db $01; dw 146 // Repeat 1 Scanline, Mode7 +SIN Scanline 140
db $01; dw 145 // Repeat 1 Scanline, Mode7 +SIN Scanline 141
db $01; dw 144 // Repeat 1 Scanline, Mode7 +SIN Scanline 142
db $01; dw 143 // Repeat 1 Scanline, Mode7 +SIN Scanline 143
db $01; dw 142 // Repeat 1 Scanline, Mode7 +SIN Scanline 144
db $01; dw 141 // Repeat 1 Scanline, Mode7 +SIN Scanline 145
db $01; dw 140 // Repeat 1 Scanline, Mode7 +SIN Scanline 146
db $01; dw 139 // Repeat 1 Scanline, Mode7 +SIN Scanline 147
db $01; dw 138 // Repeat 1 Scanline, Mode7 +SIN Scanline 148
db $01; dw 137 // Repeat 1 Scanline, Mode7 +SIN Scanline 149
db $01; dw 137 // Repeat 1 Scanline, Mode7 +SIN Scanline 150
db $01; dw 136 // Repeat 1 Scanline, Mode7 +SIN Scanline 151
db $01; dw 135 // Repeat 1 Scanline, Mode7 +SIN Scanline 152
db $01; dw 134 // Repeat 1 Scanline, Mode7 +SIN Scanline 153
db $01; dw 133 // Repeat 1 Scanline, Mode7 +SIN Scanline 154
db $01; dw 132 // Repeat 1 Scanline, Mode7 +SIN Scanline 155
db $01; dw 131 // Repeat 1 Scanline, Mode7 +SIN Scanline 156
db $01; dw 130 // Repeat 1 Scanline, Mode7 +SIN Scanline 157
db $01; dw 130 // Repeat 1 Scanline, Mode7 +SIN Scanline 158
db $01; dw 129 // Repeat 1 Scanline, Mode7 +SIN Scanline 159
db $01; dw 128 // Repeat 1 Scanline, Mode7 +SIN Scanline 160
db $01; dw 127 // Repeat 1 Scanline, Mode7 +SIN Scanline 161
db $01; dw 126 // Repeat 1 Scanline, Mode7 +SIN Scanline 162
db $01; dw 126 // Repeat 1 Scanline, Mode7 +SIN Scanline 163
db $01; dw 125 // Repeat 1 Scanline, Mode7 +SIN Scanline 164
db $01; dw 124 // Repeat 1 Scanline, Mode7 +SIN Scanline 165
db $01; dw 123 // Repeat 1 Scanline, Mode7 +SIN Scanline 166
db $01; dw 123 // Repeat 1 Scanline, Mode7 +SIN Scanline 167
db $01; dw 122 // Repeat 1 Scanline, Mode7 +SIN Scanline 168
db $01; dw 121 // Repeat 1 Scanline, Mode7 +SIN Scanline 169
db $01; dw 120 // Repeat 1 Scanline, Mode7 +SIN Scanline 170
db $01; dw 120 // Repeat 1 Scanline, Mode7 +SIN Scanline 171
db $01; dw 119 // Repeat 1 Scanline, Mode7 +SIN Scanline 172
db $01; dw 118 // Repeat 1 Scanline, Mode7 +SIN Scanline 173
db $01; dw 118 // Repeat 1 Scanline, Mode7 +SIN Scanline 174
db $01; dw 117 // Repeat 1 Scanline, Mode7 +SIN Scanline 175
db $01; dw 116 // Repeat 1 Scanline, Mode7 +SIN Scanline 176
db $01; dw 116 // Repeat 1 Scanline, Mode7 +SIN Scanline 177
db $01; dw 115 // Repeat 1 Scanline, Mode7 +SIN Scanline 178
db $01; dw 114 // Repeat 1 Scanline, Mode7 +SIN Scanline 179
db $01; dw 114 // Repeat 1 Scanline, Mode7 +SIN Scanline 180
db $01; dw 113 // Repeat 1 Scanline, Mode7 +SIN Scanline 181
db $01; dw 113 // Repeat 1 Scanline, Mode7 +SIN Scanline 182
db $01; dw 112 // Repeat 1 Scanline, Mode7 +SIN Scanline 183
db $01; dw 111 // Repeat 1 Scanline, Mode7 +SIN Scanline 184
db $01; dw 111 // Repeat 1 Scanline, Mode7 +SIN Scanline 185
db $01; dw 110 // Repeat 1 Scanline, Mode7 +SIN Scanline 186
db $01; dw 110 // Repeat 1 Scanline, Mode7 +SIN Scanline 187
db $01; dw 109 // Repeat 1 Scanline, Mode7 +SIN Scanline 188
db $01; dw 108 // Repeat 1 Scanline, Mode7 +SIN Scanline 189
db $01; dw 108 // Repeat 1 Scanline, Mode7 +SIN Scanline 190
db $01; dw 107 // Repeat 1 Scanline, Mode7 +SIN Scanline 191
db $01; dw 107 // Repeat 1 Scanline, Mode7 +SIN Scanline 192
db $01; dw 106 // Repeat 1 Scanline, Mode7 +SIN Scanline 193
db $01; dw 106 // Repeat 1 Scanline, Mode7 +SIN Scanline 194
db $01; dw 105 // Repeat 1 Scanline, Mode7 +SIN Scanline 195
db $01; dw 104 // Repeat 1 Scanline, Mode7 +SIN Scanline 196
db $01; dw 104 // Repeat 1 Scanline, Mode7 +SIN Scanline 197
db $01; dw 103 // Repeat 1 Scanline, Mode7 +SIN Scanline 198
db $01; dw 103 // Repeat 1 Scanline, Mode7 +SIN Scanline 199
db $01; dw 102 // Repeat 1 Scanline, Mode7 +SIN Scanline 200
db $01; dw 102 // Repeat 1 Scanline, Mode7 +SIN Scanline 201
db $01; dw 101 // Repeat 1 Scanline, Mode7 +SIN Scanline 202
db $01; dw 101 // Repeat 1 Scanline, Mode7 +SIN Scanline 203
db $01; dw 100 // Repeat 1 Scanline, Mode7 +SIN Scanline 204
db $01; dw 100 // Repeat 1 Scanline, Mode7 +SIN Scanline 205
db $01; dw 99 // Repeat 1 Scanline, Mode7 +SIN Scanline 206
db $01; dw 99 // Repeat 1 Scanline, Mode7 +SIN Scanline 207
db $01; dw 98 // Repeat 1 Scanline, Mode7 +SIN Scanline 208
db $01; dw 98 // Repeat 1 Scanline, Mode7 +SIN Scanline 209
db $01; dw 98 // Repeat 1 Scanline, Mode7 +SIN Scanline 210
db $01; dw 97 // Repeat 1 Scanline, Mode7 +SIN Scanline 211
db $01; dw 97 // Repeat 1 Scanline, Mode7 +SIN Scanline 212
db $01; dw 96 // Repeat 1 Scanline, Mode7 +SIN Scanline 213
db $01; dw 96 // Repeat 1 Scanline, Mode7 +SIN Scanline 214
db $01; dw 95 // Repeat 1 Scanline, Mode7 +SIN Scanline 215
db $01; dw 95 // Repeat 1 Scanline, Mode7 +SIN Scanline 216
db $01; dw 94 // Repeat 1 Scanline, Mode7 +SIN Scanline 217
db $01; dw 94 // Repeat 1 Scanline, Mode7 +SIN Scanline 218
db $01; dw 94 // Repeat 1 Scanline, Mode7 +SIN Scanline 219
db $01; dw 93 // Repeat 1 Scanline, Mode7 +SIN Scanline 220
db $01; dw 93 // Repeat 1 Scanline, Mode7 +SIN Scanline 221
db $01; dw 92 // Repeat 1 Scanline, Mode7 +SIN Scanline 222
db $01; dw 92 // Repeat 1 Scanline, Mode7 +SIN Scanline 223
db $01; dw 91 // Repeat 1 Scanline, Mode7 +SIN Scanline 224
db $00 // End Of HDMA