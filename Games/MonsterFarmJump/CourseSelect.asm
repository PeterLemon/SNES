//--------------
// Course Select
//--------------
LoadPAL(ComicPal, $00, ComicPal.size, 0) // Load Background Palette (BG Palette Uses 128 Colors)
LoadVRAM(ComicTiles, $0000, ComicTiles.size, 0) // Load Background Tiles To VRAM
LoadVRAM(ComicMap, $7900, ComicMap.size, 0) // Load Background Tile Map To VRAM

LoadVRAM(CourseSelectDarkBlendTiles, $8000, CourseSelectDarkBlendTiles.size, 0) // Load Background Tiles To VRAM
LoadVRAM(CourseSelectDarkBlendMap, $8900, CourseSelectDarkBlendMap.size, 0) // Load Background Tile Map To VRAM

LoadPAL(CourseSelectPal, $80, CourseSelectPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CourseSelectTiles, $C000, CourseSelectTiles.size, 0) // Load Sprite Tiles To VRAM

LoadVRAM(CourseBorderTiles, $D800, CourseBorderTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CourseEasyPal, $90, CourseEasyPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CourseEasyTiles, $E000, CourseEasyTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CourseHardTiles, $E800, CourseHardTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CourseNormalTiles, $F000, CourseNormalTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CourseVeryHardTiles, $F800, CourseVeryHardTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(FontPal, $F0, CourseSelectPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(FontTiles, $A000, CourseSelectTiles.size, 0) // Load Sprite Tiles To VRAM

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

// Course Select OAM Info
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCourseSelectOAM:
  lda.w CourseSelectOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$01CC
  bne LoopCourseSelectOAM

// Course Select OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCourseSelectOAMSize:
  lda.w CourseSelectOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$01E9
  bne LoopCourseSelectOAMSize

// Setup Video
lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 & BG2 8x8 Tiles

// Setup BG1 256 Color Background
lda.b #%01000100 // AAAAAASS: S = BG Map Size, A = BG Map Address
sta.w REG_BG1SC  // $2107: BG1 32x32, BG1 Map Address = $8900 (VRAM Address / $400)

// Setup BG2 16 Color Background
lda.b #%00111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $7800 (VRAM Address / $400)

lda.b #%00000100  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
sta.w REG_BG12NBA // $210B: BG1 Tile Address = $8000, BG2 Tile Address = $0000 (VRAM Address / $1000)

lda.b #%00010010 // Enable BG2 & Sprites
sta.w REG_TM     // $212C: BG2 & Sprites To Main Screen Designation

lda.b #%00000001 // Enable BG1
sta.w REG_TS     // $212D: BG1 To Sub Screen Designation

lda.b #%00000010 // Enable Subscreen BG/OBJ Color ADD/SUB
sta.w REG_CGWSEL // $2130: Color Math Control Register A
    
lda.b #%01100010  // Colour Addition On BG2 And Backdrop Colour (Half Result)
sta.w REG_CGADSUB // $2131: Color Math Control Register B

stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Lo Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Hi Byte

lda.b #31 // Scroll BG1 & BG2 31 Pixels Up
sta.w REG_BG1VOFS // Store A To BG1 Vertical Scroll Position Lo Byte
stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte
sta.w REG_BG2VOFS // Store A To BG Scroll Position Low Byte
stz.w REG_BG2VOFS // Store Zero To BG Scroll Position High Byte

// HDMA OAM Size & Object Base
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
lda.b #REG_OBSEL // $01: Start At Object Size & Object Base ($2101)
sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #CourseSelectHDMATableOAM // HMDA Table Address
stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #CourseSelectHDMATableOAM >> 16 // HDMA Table Bank
sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
lda.b #%00000001 // HDMA Channel Select (Channel 0)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

FadeIN() // Screen Fade In

CourseEasy:
  WaitNMI() // Wait VBlank
  LoadPAL(CourseEasyPal, $90, CourseEasyPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Course Easy Text OAM Info
  ldx.w #$00AE // X = $00AE
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCourseEasyTextOAM:
    lda.w CourseEasyTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0070
    bne LoopCourseEasyTextOAM

  lda.b #15
  CourseEasyWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CourseEasyWait

  ldy.w #$4083 // Y = Border Color

  CourseEasyLeft:
    ReadJOY({JOY_LEFT})  // Test LEFT Button
    beq CourseEasyRight  // IF (! LEFT Pressed) GOTO Course Easy Right
    LoadPAL(CourseEasyDarkPal, $90, CourseEasyDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseHard       // ELSE GOTO Course Hard
  CourseEasyRight:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq CourseEasyUp     // IF (! RIGHT Pressed) GOTO Course Easy Up
    LoadPAL(CourseEasyDarkPal, $90, CourseEasyDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseHard       // ELSE GOTO Course Hard
  CourseEasyUp:
    ReadJOY({JOY_UP})    // Test UP Button
    beq CourseEasyDown   // IF (! UP Pressed) GOTO Course Easy Down
    LoadPAL(CourseEasyDarkPal, $90, CourseEasyDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseNormal     // ELSE GOTO Course Normal
  CourseEasyDown:
    ReadJOY({JOY_DOWN})  // Test DOWN Button
    beq CourseEasyStart  // IF (! DOWN Pressed) GOTO Course Easy Start
    LoadPAL(CourseEasyDarkPal, $90, CourseEasyDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseNormal     // ELSE GOTO Course Normal
  CourseEasyStart:
    ReadJOY({JOY_START}) // Test START Button
    beq CourseEasyEnd    // IF (! START Pressed) GOTO Course Easy End
    lda.b #%00000001     // A = Course Select Easy Flag
    sta.b CourseCharacterSelect // Store Course Selection
    jmp CourseSelectEnd  // ELSE GOTO Course Select End
  CourseEasyEnd:

    lda.b #$91 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0111110000000000
    cmp.w #%0111110000000000
    beq EasyBorderDecrementFlag
    cmp.w #%0011110000000000
    beq EasyBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq EasyBorderIncrement
    bne EasyBorderDecrement

    EasyBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra EasyBorderIncrement

    EasyBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra EasyBorderDecrement

    EasyBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra EasyBorderEnd

    EasyBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    EasyBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CourseEasyLeft // GOTO Course Easy Left

CourseHard:
  WaitNMI() // Wait VBlank
  LoadPAL(CourseHardPal, $A0, CourseHardPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Course Hard Text OAM Info
  ldx.w #$00AE // X = $00AE
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCourseHardTextOAM:
    lda.w CourseHardTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0070
    bne LoopCourseHardTextOAM

  lda.b #15
  CourseHardWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CourseHardWait

  ldy.w #$2610 // Y = Border Color

  CourseHardLeft:
    ReadJOY({JOY_LEFT})  // Test LEFT Button
    beq CourseHardRight  // IF (! LEFT Pressed) GOTO Course Hard Right
    LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseEasy       // ELSE GOTO Course Easy
  CourseHardRight:
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq CourseHardUp     // IF (! RIGHT Pressed) GOTO Course Hard Up
    LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseEasy       // ELSE GOTO Course Easy
  CourseHardUp:
    ReadJOY({JOY_UP})    // Test UP Button
    beq CourseHardDown   // IF (! UP Pressed) GOTO Course Hard Down
    LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseVeryHard   // ELSE GOTO Course Very Hard
  CourseHardDown:
    ReadJOY({JOY_DOWN})  // Test DOWN Button
    beq CourseHardStart  // IF (! DOWN Pressed) GOTO Course Hard Start
    LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseVeryHard   // ELSE GOTO Course Very Hard
  CourseHardStart:
    ReadJOY({JOY_START}) // Test START Button
    beq CourseHardEnd    // IF (! START Pressed) GOTO Course Hard End
    lda.b #%00000100     // A = Course Select Hard Flag
    sta.b CourseCharacterSelect // Store Course Selection
    jmp CourseSelectEnd  // ELSE GOTO Course Select End
  CourseHardEnd:

    lda.b #$A1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0000001111100000
    cmp.w #%0000001111100000
    beq HardBorderDecrementFlag
    cmp.w #%0000000111100000
    beq HardBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq HardBorderIncrement
    bne HardBorderDecrement

    HardBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra HardBorderIncrement

    HardBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra HardBorderDecrement

    HardBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra HardBorderEnd

    HardBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    HardBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CourseHardLeft // GOTO Course Hard Left

CourseNormal:
  WaitNMI() // Wait VBlank
  LoadPAL(CourseNormalPal, $B0, CourseNormalPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Course Normal Text OAM Info
  ldx.w #$00AE // X = $00AE
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCourseNormalTextOAM:
    lda.w CourseNormalTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0070
    bne LoopCourseNormalTextOAM

  lda.b #15
  CourseNormalWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CourseNormalWait

  ldy.w #$2A05 // Y = Border Color

  CourseNormalLeft:
    ReadJOY({JOY_LEFT})   // Test LEFT Button
    beq CourseNormalRight // IF (! LEFT Pressed) GOTO Course Normal Right
    LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseVeryHard    // ELSE GOTO Course Very Hard
  CourseNormalRight:
    ReadJOY({JOY_RIGHT})  // Test RIGHT Button
    beq CourseNormalUp    // IF (! RIGHT Pressed) GOTO Course Normal Up
    LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseVeryHard    // ELSE GOTO Course Very Hard
  CourseNormalUp:
    ReadJOY({JOY_UP})     // Test UP Button
    beq CourseNormalDown  // IF (! UP Pressed) GOTO Course Normal Down
    LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseEasy        // ELSE GOTO Course Easy
  CourseNormalDown:
    ReadJOY({JOY_DOWN})   // Test DOWN Button
    beq CourseNormalStart // IF (! DOWN Pressed) GOTO Course Normal Start
    LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseEasy        // ELSE GOTO Course Easy
  CourseNormalStart:
    ReadJOY({JOY_START})  // Test START Button
    beq CourseNormalEnd   // IF (! START Pressed) GOTO Course Normal End
    lda.b #%00000010      // A = Course Select Normal Flag
    sta.b CourseCharacterSelect // Store Course Selection
    jmp CourseSelectEnd   // ELSE GOTO Course Select End
  CourseNormalEnd:

    lda.b #$B1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0000001111100000
    cmp.w #%0000001111100000
    beq NormalBorderDecrementFlag
    cmp.w #%0000000111100000
    beq NormalBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq NormalBorderIncrement
    bne NormalBorderDecrement

    NormalBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra NormalBorderIncrement

    NormalBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra NormalBorderDecrement

    NormalBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra NormalBorderEnd

    NormalBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    NormalBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CourseNormalLeft // GOTO Course Normal Left

CourseVeryHard:
  WaitNMI() // Wait VBlank
  LoadPAL(CourseVeryHardPal, $C0, CourseVeryHardPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Course Very Hard Text OAM Info
  ldx.w #$00AE // X = $00AE
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCourseVeryHardTextOAM:
    lda.w CourseVeryHardTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0070
    bne LoopCourseVeryHardTextOAM

  lda.b #15
  CourseVeryHardWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CourseVeryHardWait

  ldy.w #$1890 // Y = Border Color

  CourseVeryHardLeft:
    ReadJOY({JOY_LEFT})     // Test LEFT Button
    beq CourseVeryHardRight // IF (! LEFT Pressed) GOTO Course Very Hard Right
    LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseNormal        // ELSE GOTO Course Normal
  CourseVeryHardRight:
    ReadJOY({JOY_RIGHT})    // Test RIGHT Button
    beq CourseVeryHardUp    // IF (! RIGHT Pressed) GOTO Course Very Hard Up
    LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseNormal        // ELSE GOTO Course Normal
  CourseVeryHardUp:
    ReadJOY({JOY_UP})       // Test UP Button
    beq CourseVeryHardDown  // IF (! UP Pressed) GOTO Course Very Hard Down
    LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseHard          // ELSE GOTO Course Hard
  CourseVeryHardDown:
    ReadJOY({JOY_DOWN})     // Test DOWN Button
    beq CourseVeryHardStart // IF (! DOWN Pressed) GOTO Course Very Hard Start
    LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseHard          // ELSE GOTO Course Hard
  CourseVeryHardStart:
    ReadJOY({JOY_START})    // Test START Button
    beq CourseVeryHardEnd   // IF (! START Pressed) GOTO Course Very Hard End
    lda.b #%00001000        // A = Course Select Very Hard Flag
    sta.b CourseCharacterSelect // Store Course Selection
    jmp CourseSelectEnd     // ELSE GOTO Course Select End
  CourseVeryHardEnd:

    lda.b #$C1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0000000000011111
    cmp.w #%0000000000011111
    beq VeryHardBorderDecrementFlag
    cmp.w #%0000000000001111
    beq VeryHardBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq VeryHardBorderIncrement
    bne VeryHardBorderDecrement

    VeryHardBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra VeryHardBorderIncrement

    VeryHardBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra VeryHardBorderDecrement

    VeryHardBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra VeryHardBorderEnd

    VeryHardBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    VeryHardBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CourseVeryHardLeft // GOTO Course Very Hard Left

CourseSelectHDMATableOAM:
  db 128, %01100011 // Repeat 128 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db  58, %01100011 // Repeat  58 Scanlines, Object Size = 16x16/32x32, Name = 0, Base = $C000
  db   1, %00000010 // Repeat   1 Scanlines, Object Size =   8x8/16x16, Name = 0, Base = $8000
  db 0 // End Of HDMA

CourseSelectOAM:
  // 16x16 / 32x32 Sprites
  // OAM Info (Course Select 160x48)
  db  48,  11,   0, %00000000
  db  80,  11,   4, %00000000
  db 112,  11,   8, %00000000
  db 144,  11,  12, %00000000
  db 176,  11,  96, %00000000

  db  48,  43,  64, %00000000
  db  64,  43,  66, %00000000
  db  80,  43,  68, %00000000
  db  96,  43,  70, %00000000
  db 112,  43,  72, %00000000
  db 128,  43,  74, %00000000
  db 144,  43,  76, %00000000
  db 160,  43,  78, %00000000
  db 176,  43, 160, %00000000
  db 192,  43, 162, %00000000

  // OAM Info (Course Easy 112x64)
  db   6,  62, 192, %00000010
  db  22,  62, 194, %00000010
  db  38,  62, 196, %00000010
  db  54,  62, 198, %00000010
  db  70,  62, 200, %00000010
  db  86,  62, 202, %00000010
  db 102,  62, 204, %00000010

  db   6,  78,   0, %00000011
  db  38,  78,   4, %00000011
  db  70,  78,   8, %00000011
  db 102,  78,  12, %00000011

  db   6, 110, 224, %00000010
  db  22, 110, 226, %00000010
  db  38, 110, 228, %00000010
  db  54, 110, 230, %00000010
  db  70, 110, 232, %00000010
  db  86, 110, 234, %00000010
  db 102, 110, 236, %00000010

  // OAM Info (Course Hard 112x64)
  db 114,  62, 192, %00000100
  db 130,  62, 194, %00000100
  db 146,  62, 196, %00000100
  db 162,  62, 198, %00000100
  db 178,  62, 200, %00000100
  db 194,  62, 202, %00000100
  db 210,  62, 204, %00000100

  db 114,  78,  64, %00000101
  db 146,  78,  68, %00000101
  db 178,  78,  72, %00000101
  db 210,  78,  76, %00000101

  db 114, 110, 224, %00000100
  db 130, 110, 226, %00000100
  db 146, 110, 228, %00000100
  db 162, 110, 230, %00000100
  db 178, 110, 232, %00000100
  db 194, 110, 234, %00000100
  db 210, 110, 236, %00000100

  // OAM Info (Course Normal 112x64)
  db  34, 122, 192, %00000110
  db  50, 122, 194, %00000110
  db  66, 122, 196, %00000110
  db  82, 122, 198, %00000110
  db  98, 122, 200, %00000110
  db 114, 122, 202, %00000110
  db 130, 122, 204, %00000110

  db  34, 138, 128, %00000111
  db  66, 138, 132, %00000111
  db  98, 138, 136, %00000111
  db 130, 138, 140, %00000111

  db  34, 170, 224, %00000110
  db  50, 170, 226, %00000110
  db  66, 170, 228, %00000110
  db  82, 170, 230, %00000110
  db  98, 170, 232, %00000110
  db 114, 170, 234, %00000110
  db 130, 170, 236, %00000110

  // OAM Info (Course Very Hard 112x64)
  db 142, 122, 192, %00001000
  db 158, 122, 194, %00001000
  db 174, 122, 196, %00001000
  db 190, 122, 198, %00001000
  db 206, 122, 200, %00001000
  db 222, 122, 202, %00001000
  db 238, 122, 204, %00001000

  db 142, 138, 192, %00001001
  db 174, 138, 196, %00001001
  db 206, 138, 200, %00001001
  db 238, 138, 204, %00001001

  db 142, 170, 224, %00001000
  db 158, 170, 226, %00001000
  db 174, 170, 228, %00001000
  db 190, 170, 230, %00001000
  db 206, 170, 232, %00001000
  db 222, 170, 234, %00001000
  db 238, 170, 236, %00001000

  map 'a', $00, 26
  map $22, $1A // Double Quote '"'
  map '#', $1B
  map '$', $1C
  map '%', $1D
  map '&', $1E
  map $27, $1F // Single Quote "'"
  map '*', $20
  map '@', $21
  map '/', $22
  map '_', $23
  map $3B, $24 // Semicolon ";"
  map ' ', $25

  map 'A', $80, 26
  map '-', $9A
  map '+', $9B
  map '0', $9C, 10
  map '!', $A6
  map '(', $A7
  map ')', $A8
  map $2C, $A9 // Comma ","
  map '.', $AA
  map ':', $AB
  map '=', $AC
  map '?', $AD
  map '`', $AE

  // 8x8 / 16x16 Sprites
  CourseEasyTextOAM: // OAM Info (Course Easy Text)
    db  35, 189, "T", %00001111
    db  43, 189, "o", %00001111
    db  49, 189, "t", %00001111
    db  56, 189, "a", %00001111
    db  64, 189, "l", %00001111

    db  71, 189, "1", %00001111
    db  78, 189, "0", %00001111

    db  91, 189, "s", %00001111
    db  97, 189, "t", %00001111
    db 104, 189, "a", %00001111
    db 112, 190, "g", %00001111
    db 119, 189, "e", %00001111
    db 126, 189, "s", %00001111

    db 136, 189, "f", %00001111
    db 142, 189, "o", %00001111
    db 148, 189, "r", %00001111

    db 158, 189, "b", %00001111
    db 165, 189, "e", %00001111
    db 172, 190, "g", %00001111
    db 179, 189, "i", %00001111
    db 183, 189, "n", %00001111
    db 190, 189, "n", %00001111
    db 197, 189, "e", %00001111
    db 204, 189, "r", %00001111
    db 210, 189, "s", %00001111
    db 216, 190, ".", %00001111

    db 255, 189, " ", %00001111
    db 255, 189, " ", %00001111

  // OAM Extra Info
  db %10101010
  db %00000010
  db %00000000
  db %00000000
  db %00000000
  db %10100000
  db %00001010
  db %00000000
  db %00000000
  db %00000000
  db %10101010
  db %00000000
  db %00000000
  db %00000000
  db %10100000
  db %00001010
  db %00000000
  db %00000000
  db %00000000
  db %10101010
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000
  db %00000000

  CourseHardTextOAM: // OAM Info (Course Hard Text)
    db  43, 189, "H", %00001111
    db  51, 189, "a", %00001111
    db  58, 189, "r", %00001111
    db  65, 189, "d", %00001111

    db  77, 189, "l", %00001111
    db  80, 189, "e", %00001111
    db  88, 189, "v", %00001111
    db  95, 189, "e", %00001111
    db 103, 189, "l", %00001111
    db 106, 190, ".", %00001111

    db 114, 189, "T", %00001111
    db 122, 189, "o", %00001111
    db 128, 189, "t", %00001111
    db 135, 189, "a", %00001111
    db 143, 189, "l", %00001111

    db 150, 189, "2", %00001111
    db 158, 189, "0", %00001111

    db 171, 189, "s", %00001111
    db 177, 189, "t", %00001111
    db 184, 189, "a", %00001111
    db 192, 190, "g", %00001111
    db 199, 189, "e", %00001111
    db 206, 189, "s", %00001111
    db 212, 190, ".", %00001111

    db 255, 189, " ", %00001111
    db 255, 189, " ", %00001111
    db 255, 189, " ", %00001111
    db 255, 189, " ", %00001111

  CourseNormalTextOAM: // OAM Info (Course Normal Text)
    db  35, 189, "N", %00001111
    db  43, 189, "o", %00001111
    db  50, 189, "r", %00001111
    db  56, 189, "m", %00001111
    db  64, 189, "a", %00001111
    db  72, 189, "l", %00001111

    db  81, 189, "l", %00001111
    db  84, 189, "e", %00001111
    db  92, 189, "v", %00001111
    db  99, 189, "e", %00001111
    db 107, 189, "l", %00001111
    db 110, 190, ".", %00001111

    db 118, 189, "T", %00001111
    db 126, 189, "o", %00001111
    db 132, 189, "t", %00001111
    db 139, 189, "a", %00001111
    db 147, 189, "l", %00001111

    db 154, 189, "2", %00001111
    db 162, 189, "0", %00001111

    db 175, 189, "s", %00001111
    db 181, 189, "t", %00001111
    db 188, 189, "a", %00001111
    db 196, 190, "g", %00001111
    db 203, 189, "e", %00001111
    db 210, 189, "s", %00001111
    db 216, 190, ".", %00001111

    db 255, 189, " ", %00001111
    db 255, 189, " ", %00001111

  CourseVeryHardTextOAM: // OAM Info (Course Very Hard Text)
    db  26, 189, "V", %00001111
    db  34, 189, "e", %00001111
    db  41, 189, "r", %00001111
    db  47, 190, "y", %00001111

    db  60, 189, "h", %00001111
    db  67, 189, "a", %00001111
    db  74, 189, "r", %00001111
    db  80, 189, "d", %00001111

    db  92, 189, "l", %00001111
    db  95, 189, "e", %00001111
    db 103, 189, "v", %00001111
    db 110, 189, "e", %00001111
    db 118, 189, "l", %00001111
    db 121, 190, ".", %00001111

    db 129, 189, "T", %00001111
    db 137, 189, "o", %00001111
    db 143, 189, "t", %00001111
    db 150, 189, "a", %00001111
    db 158, 189, "l", %00001111

    db 165, 189, "2", %00001111
    db 173, 189, "0", %00001111

    db 186, 189, "s", %00001111
    db 192, 189, "t", %00001111
    db 199, 189, "a", %00001111
    db 207, 190, "g", %00001111
    db 214, 189, "e", %00001111
    db 221, 189, "s", %00001111
    db 227, 190, ".", %00001111

CourseSelectEnd:
  FadeOUT() // Screen Fade Out

  lda.b #$80
  sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)

  stz.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels