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

LoadPAL(FontPal, $D0, CourseSelectPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(FontTiles, $A000, CourseSelectTiles.size, 0) // Load Sprite Tiles To VRAM

// Setup Sprites
lda.b #%01100011 // Object Size = 16x16/32x32, Name = 0, Base = $C000
sta.w REG_OBSEL  // $2101: Object Size & Object Base

// Clear OAM
stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
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
stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
                  // Object Priority Rotation / OAM Data Address High Bit
stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
ldx.w #$0000 // X = 0
LoopCourseSelectOAM:
  lda.w CourseSelectOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$01CC
  bne LoopCourseSelectOAM

// Course Select OAM Extra Info
stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
lda.b #%00000001  // Object Priority Rotation / OAM Data Address High Bit
sta.w REG_OAMADDH // Store OAM Access Address High Byte
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

lda.b #$02
sta.w REG_CGWSEL // $2130: Enable Subscreen Color ADD/SUB
    
lda.b #%01100010
sta.w REG_CGADSUB // $2131: Colour Addition On BG1 And Backdrop Colour

stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Lo Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Hi Byte

lda.b #31 // Scroll BG2 31 Pixels Up
sta.w REG_BG1VOFS // Store A To BG1 Vertical Scroll Position Lo Byte
stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte
sta.w REG_BG2VOFS // Store A To BG Scroll Position Low Byte
stz.w REG_BG2VOFS // Store Zero To BG Scroll Position High Byte

// HDMA OAM Size & Object Base   
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
lda.b #REG_OBSEL // $0B: Start At Object Size & Object Base ($2101)
sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #CourseSelectHDMATable // HMDA Table Address
stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #CourseSelectHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
lda.b #%00000001 // HDMA Channel Select (Channel 0)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

FadeIN() // Screen Fade In

CourseEasy:
  WaitNMI() // Wait VBlank
  LoadPAL(CourseEasyPal, $90, CourseEasyPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Course Easy Text OAM Info
  lda.b #$AE // A = $AE
  sta.w REG_OAMADDL // Store OAM Access Address Low Byte
                    // Object Priority Rotation / OAM Data Address High Bit
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
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
    jmp CourseHard     // ELSE GOTO Course Hard
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
    beq CourseEasyEnd    // IF (! DOWN Pressed) GOTO Course Course Easy End
    LoadPAL(CourseEasyDarkPal, $90, CourseEasyDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseNormal     // ELSE GOTO Course Normal
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
  lda.b #$AE // A = $AE
  sta.w REG_OAMADDL // Store OAM Access Address Low Byte
                    // Object Priority Rotation / OAM Data Address High Bit
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
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
    jmp CourseVeryHard   // GOTO Course Very Hard
  CourseHardDown:
    ReadJOY({JOY_DOWN})  // Test DOWN Button
    beq CourseHardEnd    // IF (! DOWN Pressed) GOTO Course Hard End
    LoadPAL(CourseHardDarkPal, $A0, CourseHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseVeryHard   // GOTO Course Very Hard
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
  lda.b #$AE // A = $AE
  sta.w REG_OAMADDL // Store OAM Access Address Low Byte
                    // Object Priority Rotation / OAM Data Address High Bit
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
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
    beq CourseNormalEnd   // IF (! DOWN Pressed) GOTO Course Normal End
    LoadPAL(CourseNormalDarkPal, $B0, CourseNormalDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseEasy        // ELSE GOTO Course Easy
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
  lda.b #$AE // A = $AE
  sta.w REG_OAMADDL // Store OAM Access Address Low Byte
                    // Object Priority Rotation / OAM Data Address High Bit
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
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
    beq CourseVeryHardEnd   // IF (! DOWN Pressed) GOTO Course Very Hard End
    LoadPAL(CourseVeryHardDarkPal, $C0, CourseVeryHardDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CourseHard          // ELSE GOTO Course Hard
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