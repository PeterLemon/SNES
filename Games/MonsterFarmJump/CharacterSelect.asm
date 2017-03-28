//-----------------
// Character Select
//-----------------
LoadVRAM(CharacterSelectDarkBlendTiles, $8000, CharacterSelectDarkBlendTiles.size, 0) // Load Background Tiles To VRAM
LoadVRAM(CharacterSelectDarkBlendMap, $8900, CharacterSelectDarkBlendMap.size, 0) // Load Background Tile Map To VRAM

LoadPAL(CharacterSelectPal, $80, CharacterSelectPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterSelectTiles, $C000, CharacterSelectTiles.size, 0) // Load Sprite Tiles To VRAM

//LoadPAL(CharacterRoochoDarkPal, $90, CharacterRoochoDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadPAL(CharacterRoochoPal, $90, CharacterRoochoPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterRoochoTiles, $E000, CharacterRoochoTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CharacterBeochiDarkPal, $A0, CharacterBeochiDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
//LoadPAL(CharacterBeochiPal, $A0, CharacterBeochiPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterBeochiTiles, $E800, CharacterBeochiTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CharacterChitoDarkPal, $B0, CharacterChitoDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
//LoadPAL(CharacterChitoPal, $B0, CharacterChitoPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterChitoTiles, $F000, CharacterChitoTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CharacterGolemDarkPal, $C0, CharacterGolemDarkPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
//LoadPAL(CharacterGolemPal, $C0, CharacterGolemPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterGolemTiles, $F800, CharacterGolemTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(CharacterArrowPal, $D0, CharacterArrowPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(CharacterArrowTiles, $D800, CourseBorderTiles.size, 0) // Load Sprite Tiles To VRAM

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

// Character Select OAM Info
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCharacterSelectOAM:
  lda.w CharacterSelectOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0140
  bne LoopCharacterSelectOAM

// Character Select OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopCharacterSelectOAMSize:
  lda.w CharacterSelectOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0154
  bne LoopCharacterSelectOAMSize

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
ldx.w #CharacterSelectHDMATable // HMDA Table Address
stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #CharacterSelectHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
lda.b #%00000001 // HDMA Channel Select (Channel 0)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

FadeIN() // Screen Fade In

CharacterRoocho:
  WaitNMI() // Wait VBlank
  LoadPAL(CharacterRoochoPal, $90, CharacterRoochoPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Character Roocho Text OAM Info
  ldx.w #$0080 // X = $0080
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCharacterRoochoTextOAM:
    lda.w CharacterRoochoTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0040
    bne LoopCharacterRoochoTextOAM

  lda.b #15
  CharacterRoochoWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CharacterRoochoWait

  ldy.w #$2D4A // Y = Border Color

  CharacterRoochoLeft:
    ReadJOY({JOY_LEFT})      // Test LEFT Button
    beq CharacterRoochoRight // IF (! LEFT Pressed) GOTO Character Roocho Right
    LoadPAL(CharacterRoochoDarkPal, $90, CharacterRoochoDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterGolem       // ELSE GOTO Character Golem
  CharacterRoochoRight:
    ReadJOY({JOY_RIGHT})     // Test RIGHT Button
    beq CharacterRoochoStart // IF (! RIGHT Pressed) GOTO Character Roocho Up
    LoadPAL(CharacterRoochoDarkPal, $90, CharacterRoochoDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterBeochi      // ELSE GOTO Character Beochi
  CharacterRoochoStart:
    ReadJOY({JOY_START})     // Test START Button
    beq CharacterRoochoEnd   // IF (! START Pressed) GOTO Character Roocho End
    jmp CharacterSelectEnd   // ELSE GOTO Character Select End
  CharacterRoochoEnd:

    lda.b #$91 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0111110000000000
    cmp.w #%0111110000000000
    beq RoochoBorderDecrementFlag
    cmp.w #%0001000000000000
    beq RoochoBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq RoochoBorderIncrement
    bne RoochoBorderDecrement

    RoochoBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra RoochoBorderIncrement

    RoochoBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra RoochoBorderDecrement

    RoochoBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra RoochoBorderEnd

    RoochoBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    RoochoBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CharacterRoochoLeft  // GOTO Character Roocho Left

CharacterBeochi:
  WaitNMI() // Wait VBlank
  LoadPAL(CharacterBeochiPal, $A0, CharacterBeochiPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Character Beochi Text OAM Info
  ldx.w #$0080 // X = $0080
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCharacterBeochiTextOAM:
    lda.w CharacterBeochiTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0040
    bne LoopCharacterBeochiTextOAM

  lda.b #15
  CharacterBeochiWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CharacterBeochiWait

  ldy.w #$2D4A // Y = Border Color

  CharacterBeochiLeft:
    ReadJOY({JOY_LEFT})      // Test LEFT Button
    beq CharacterBeochiRight // IF (! LEFT Pressed) GOTO Character Beochi Right
    LoadPAL(CharacterBeochiDarkPal, $A0, CharacterBeochiDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterRoocho      // ELSE GOTO Character Roocho
  CharacterBeochiRight:
    ReadJOY({JOY_RIGHT})     // Test RIGHT Button
    beq CharacterBeochiStart // IF (! RIGHT Pressed) GOTO Character Beochi Up
    LoadPAL(CharacterBeochiDarkPal, $A0, CharacterBeochiDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterChito       // ELSE GOTO Character Chito
  CharacterBeochiStart:
    ReadJOY({JOY_START})     // Test START Button
    beq CharacterBeochiEnd   // IF (! START Pressed) GOTO Character Beochi End
    jmp CharacterSelectEnd   // ELSE GOTO Character Select End
  CharacterBeochiEnd:

    lda.b #$A1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0111110000000000
    cmp.w #%0111110000000000
    beq BeochiBorderDecrementFlag
    cmp.w #%0001000000000000
    beq BeochiBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq BeochiBorderIncrement
    bne BeochiBorderDecrement

    BeochiBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra BeochiBorderIncrement

    BeochiBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra BeochiBorderDecrement

    BeochiBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra BeochiBorderEnd

    BeochiBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    BeochiBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CharacterBeochiLeft  // GOTO Character Beochi Left

CharacterChito:
  WaitNMI() // Wait VBlank
  LoadPAL(CharacterChitoPal, $B0, CharacterChitoPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Character Chito Text OAM Info
  ldx.w #$0080 // X = $0080
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCharacterChitoTextOAM:
    lda.w CharacterChitoTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0040
    bne LoopCharacterChitoTextOAM

  lda.b #15
  CharacterChitoWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CharacterChitoWait

  ldy.w #$2D4A // Y = Border Color

  CharacterChitoLeft:
    ReadJOY({JOY_LEFT})     // Test LEFT Button
    beq CharacterChitoRight // IF (! LEFT Pressed) GOTO Character Chito Right
    LoadPAL(CharacterChitoDarkPal, $B0, CharacterChitoDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterBeochi     // ELSE GOTO Character Beochi
  CharacterChitoRight:
    ReadJOY({JOY_RIGHT})    // Test RIGHT Button
    beq CharacterChitoStart // IF (! RIGHT Pressed) GOTO Character Chito Up
    LoadPAL(CharacterChitoDarkPal, $B0, CharacterChitoDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterGolem      // ELSE GOTO Character Golem
  CharacterChitoStart:
    ReadJOY({JOY_START})    // Test START Button
    beq CharacterChitoEnd   // IF (! START Pressed) GOTO Character Chito End
    jmp CharacterSelectEnd  // ELSE GOTO Character Select End
  CharacterChitoEnd:

    lda.b #$B1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0111110000000000
    cmp.w #%0111110000000000
    beq ChitoBorderDecrementFlag
    cmp.w #%0001000000000000
    beq ChitoBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq ChitoBorderIncrement
    bne ChitoBorderDecrement

    ChitoBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra ChitoBorderIncrement

    ChitoBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra ChitoBorderDecrement

    ChitoBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra ChitoBorderEnd

    ChitoBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    ChitoBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CharacterChitoLeft  // GOTO Character Chito Left

CharacterGolem:
  WaitNMI() // Wait VBlank
  LoadPAL(CharacterGolemPal, $C0, CharacterGolemPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)

  // Character Golem Text OAM Info
  ldx.w #$0080 // X = $0080
  stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  ldx.w #$0000 // X = 0
  LoopCharacterGolemTextOAM:
    lda.w CharacterGolemTextOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$0040
    bne LoopCharacterGolemTextOAM

  lda.b #15
  CharacterGolemWait:
    WaitNMI() // Wait VBlank
    dec // A--
    bne CharacterGolemWait

  ldy.w #$2D4A // Y = Border Color

  CharacterGolemLeft:
    ReadJOY({JOY_LEFT})     // Test LEFT Button
    beq CharacterGolemRight // IF (! LEFT Pressed) GOTO Character Golem Right
    LoadPAL(CharacterGolemDarkPal, $C0, CharacterGolemDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterChito      // ELSE GOTO Character Chito
  CharacterGolemRight:
    ReadJOY({JOY_RIGHT})    // Test RIGHT Button
    beq CharacterGolemStart // IF (! RIGHT Pressed) GOTO Character Chito Up
    LoadPAL(CharacterGolemDarkPal, $C0, CharacterGolemDarkPal.size, 1) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
    jmp CharacterRoocho     // ELSE GOTO Character Roocho
  CharacterGolemStart:
    ReadJOY({JOY_START})    // Test START Button
    beq CharacterGolemEnd   // IF (! START Pressed) GOTO Character Golem End
    jmp CharacterSelectEnd  // ELSE GOTO Character Select End
  CharacterGolemEnd:

    lda.b #$C1 // A = Border Palette CGRAM Address
    sta.w REG_CGADD  // $2121: Palette CGRAM Address

    rep #$20 // Set 16-Bit Accumulator
    tya // A = Y
    
    and.w #%0111110000000000
    cmp.w #%0111110000000000
    beq GolemBorderDecrementFlag
    cmp.w #%0001000000000000
    beq GolemBorderIncrementFlag

    tya // A = Y
    bit.w #$8000 // Test Border Decrement Flag
    beq GolemBorderIncrement
    bne GolemBorderDecrement

    GolemBorderIncrementFlag:
      tya // A = Y
      and.w #$7FFF // Clear Border Decrement Flag
      bra GolemBorderIncrement

    GolemBorderDecrementFlag:
      tya // A = Y
      ora.w #$8000 // Set Border Decrement Flag
      bra GolemBorderDecrement

    GolemBorderIncrement:
      clc // Clear Carry Flag
      adc.w #%0000010000100001
      bra GolemBorderEnd

    GolemBorderDecrement:
      sec // Set Carry Flag
      sbc.w #%0000010000100001

    GolemBorderEnd:
      tay // Y = A
      sep #$20 // Set 8-Bit Accumulator

    WaitNMI() // Wait VBlank
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write
    xba // Exchange B & A Accumulators
    sta.w REG_CGDATA // $2122: Palette CGRAM Data Write

    jmp CharacterGolemLeft  // GOTO Character Golem Left

CharacterSelectEnd:
  FadeOUT() // Screen Fade Out

  lda.b #$80
  sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)

  stz.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels