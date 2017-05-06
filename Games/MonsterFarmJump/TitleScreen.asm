//-------------
// Title Screen
//-------------
LoadPAL(MonsterFarmJumpPal, $00, MonsterFarmJumpPal.size, 0) // Load Background Palette (BG Palette Uses 96 Colors)
LoadM7VRAM(MonsterFarmJumpMap, MonsterFarmJumpTiles, $0000, MonsterFarmJumpMap.size, MonsterFarmJumpTiles.size, 0) // Load Background Map & Tiles To VRAM

LoadPAL(TecmoMiniPal, $80, TecmoMiniPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(TecmoMiniTiles, $8000, TecmoMiniTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(TecmoCopyrightPal, $90, TecmoCopyrightPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(TecmoCopyrightTiles, $8400, TecmoCopyrightTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(PressStartButtonPal, $A0, PressStartButtonPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(PressStartButtonTiles, $8C00, PressStartButtonTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(ComicAPal, $B0, ComicAPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ComicATiles, $C000, ComicATiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(ComicBPal, $C0, ComicBPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ComicBTiles, $E000, ComicBTiles.size, 0) // Load Sprite Tiles To VRAM

LoadPAL(ComicCPal, $D0, ComicCPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ComicCTiles, $9000, ComicCTiles.size, 0) // Load BG/Sprite Tiles To VRAM

LoadPAL(ComicDPal, $E0, ComicDPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(ComicDTiles, $A800, ComicDTiles.size, 0) // Load BG/Sprite Tiles To VRAM

LoadPAL(ComicCPal, $60, ComicCPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
LoadPAL(ComicDPal, $70, ComicDPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
LoadVRAM(ComicCDMap, $8800, 768, 0) // Load Background Tile Map To VRAM

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

// Title Screen OAM Info
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopTitleScreenOAM:
  lda.w TitleScreenOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0050
  bne LoopTitleScreenOAM

// Title Screen OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopTitleScreenOAMSize:
  lda.w TitleScreenOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0055
  bne LoopTitleScreenOAMSize
  
// Setup Video
                 // Interlace Mode Off
stz.w REG_SETINI // $2133: Screen Mode Select

lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

// Setup BG2 16 Color Background
lda.b #%01000100  // AAAAAASS: S = BG Map Size, A = BG Map Address
sta.w REG_BG2SC   // $2108: BG2 32x32, BG2 Map Address = $8800 (VRAM Address / $400)
lda.b #%01000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
sta.w REG_BG12NBA // $210B: BG2 Tile Address = $8000 (VRAM Address / $1000)

lda.b #%00010011 // Enable BG1 & Sprites
sta.w REG_TM     // $212C: BG1 & Sprites To Main Screen Designation

stz.w REG_M7SEL // $211A: Mode7 Settings

lda.b #$80
sta.w REG_BG1HOFS // $210D: BG1 Position X Lo Byte
lda.b #$01
sta.w REG_BG1HOFS // $210D: BG1 Position X Hi Byte

stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Lo Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Hi Byte

lda.b #$B8
sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
lda.b #$01
sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

lda.b #127 // Scroll BG2 127 Pixels Up
sta.w REG_BG2VOFS // Store A To BG Scroll Position Low Byte
stz.w REG_BG2VOFS // Store Zero To BG Scroll Position High Byte

stz.w REG_M7X // $211F: Mode7 Center Position X Lo Byte
lda.b #$02
sta.w REG_M7X // $211F: Mode7 Center Position X Hi Byte

stz.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
lda.b #$02
sta.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

stz.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
stz.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
stz.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
stz.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)

// HDMA OAM Size & Object Base
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
lda.b #REG_OBSEL // $01: Start At Object Size & Object Base ($2101)
sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #TitleScreenHDMATableOAM1 // HMDA Table Address
stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #TitleScreenHDMATableOAM1 >> 16 // HDMA Table Bank
sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
lda.b #%00000001 // HDMA Channel Select (Channel 0)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

FadeIN() // Screen Fade In

// Zoom Title Logo
lda.b #$00
TitleZoomOutInit:
  WaitNMI() // Wait VBlank
  sta.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
  stz.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
  sta.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
  stz.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
  inc // A++
  inc // A++
  bne TitleZoomOutInit

// HDMA OAM Size & Object Base
ldx.w #TitleScreenHDMATableOAM2 // HMDA Table Address
stx.w REG_A1T0L // $4302: DMA0 DMA/HDMA Table Start Address

// HDMA BG Mode & BG Character Size
lda.b #%00000000  // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP1   // $4310: DMA1 DMA/HDMA Parameters
lda.b #REG_BGMODE // $05: Start At BG Mode & BG Character Size ($2105)
sta.w REG_BBAD1   // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #TitleScreenHDMATableBG // HMDA Table Address
stx.w REG_A1T1L   // $4312: DMA1 DMA/HDMA Table Start Address
lda.b #TitleScreenHDMATableBG >> 16 // HDMA Table Bank
sta.w REG_A1B1    // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

// HDMA Main Screen Designation
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP2  // $4320: DMA2 DMA/HDMA Parameters
lda.b #REG_TM    // $2C: Start At Main Screen Designation ($212C)
sta.w REG_BBAD2  // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #TitleScreenHDMATableTM // HMDA Table Address
stx.w REG_A1T2L  // $4322: DMA2 DMA/HDMA Table Start Address
lda.b #TitleScreenHDMATableBG >> 16 // HDMA Table Bank
sta.w REG_A1B2   // $4324: DMA2 DMA/HDMA Table Start Address (Bank)

lda.b #%00000111 // HDMA Channel Select (Channel 0..2)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

// Title Screen OAM Info
ldx.w #$0010 // X = $0010
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
ldx.w #$0000 // X = 0
LoopTitleScreenForeGroundOAM:
  lda.w TitleScreenForeGroundOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0070
  bne LoopTitleScreenForeGroundOAM

// Title Screen OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopTitleScreenForeGroundOAMSize:
  lda.w TitleScreenForeGroundOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #$0079
  bne LoopTitleScreenForeGroundOAMSize

ldx.w #$0000 // X = Zoom In / Out Scale
TitleZoomOut:
  WaitNMI() // Wait VBlank
  ReadJOY({JOY_START}) // Test START Button
  beq TitleZoomOutAnim // IF (! START Pressed) Title Zoom Out Anim
  jmp TitleScreenEnd   // ELSE Title Screen End

  TitleZoomOutAnim: // Zoom Logo Out
    txa // A = X
    sta.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
    lda.b #$01
    sta.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
    txa // A = X
    sta.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
    lda.b #$01
    sta.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
    inx // X++
    inx // X++
    cpx #$00C0
    bne TitleZoomOut

TitleZoomIn:
  WaitNMI() // Wait VBlank
  ReadJOY({JOY_START}) // Test START Button
  beq TitleZoomInAnim  // IF (! START Pressed) Branch Down
  jmp TitleScreenEnd   // ELSE Title Screen End

  TitleZoomInAnim: // Zoom Logo In
    txa // A = X
    sta.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
    lda.b #$01
    sta.w REG_M7A // $211B: Mode7 Rot/Scale A (COSINE A) & Maths 16-Bit Operand
    txa // A = X
    sta.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
    lda.b #$01
    sta.w REG_M7D // $211E: Mode7 Rot/Scale D (COSINE B)
    dex // X--
    dex // X--
    bne TitleZoomIn
    bra TitleZoomOut

TitleScreenHDMATableOAM1:
  db 128, %10100011 // Repeat 128 Scanlines, Object Size = 32x32/64x64, Name = 0, Base = $C000
  db   1, %10100010 // Repeat   1 Scanlines, Object Size = 32x32/64x64, Name = 0, Base = $8000
  db 0 // End Of HDMA

TitleScreenHDMATableOAM2:
  db 128, %10100011 // Repeat 128 Scanlines, Object Size = 32x32/64x64, Name = 0, Base = $C000
  db   1, %00000010 // Repeat   1 Scanlines, Object Size =   8x8/16x16, Name = 0, Base = $8000
  db 0 // End Of HDMA

TitleScreenHDMATableBG:
  db 128, %00000111 // Repeat 128 Scanlines, BG Mode 7, Priority 0, BG1 8x8 Tiles
  db   1, %00000011 // Repeat   1 Scanlines, BG Mode 3, Priority 0, BG2 8x8 Tiles
  db 0 // End Of HDMA

TitleScreenHDMATableTM:
  db 128, %00010011 // Repeat 128 Scanlines, BG1 & Sprites To Main Screen Designation
  db   1, %00010010 // Repeat   1 Scanlines, BG2 & Sprites To Main Screen Designation
  db 0 // End Of HDMA

TitleScreenOAM:
  // 32x32 / 64x64 Sprites
  // OAM Info (Comic A 128x128, Comic B 128x128)
  db   0,   0,   0, %00000110
  db  64,   0,   8, %00000110
  db 128,   0,   0, %00001001
  db 192,   0,   8, %00001001

  db   0,  64, 128, %00000110
  db  64,  64, 136, %00000110
  db 128,  64, 128, %00001001
  db 192,  64, 136, %00001001

  // OAM Info (Comic C 128x96, Comic D 128x96)
  db   0, 128, 128, %00001010
  db  64, 128, 136, %00001010
  db 128, 128,  64, %00001101
  db 192, 128,  72, %00001101

  db   0, 192,   0, %00001011
  db  32, 192,   4, %00001011
  db  64, 192,   8, %00001011
  db  96, 192,  12, %00001011
  db 128, 192, 192, %00001101
  db 160, 192, 196, %00001101
  db 192, 192, 200, %00001101
  db 224, 192, 204, %00001101

  // OAM Extra Info
  db %10101010
  db %10101010
  db %10101010
  db %00000000
  db %00000000

TitleScreenForeGroundOAM:
  // 8x8 / 16x16 Sprites
  // OAM Info (Tecmo Mini 64x16)
  db  96, 180,   0, %00000000
  db 112, 180,   2, %00000000
  db 128, 180,   4, %00000000
  db 144, 180,   6, %00000000

  // OAM Info (Tecmo Copyright 136x16)
  db  60, 200,  32, %00000010
  db  68, 200,  33, %00000010
  db  76, 200,  34, %00000010
  db  84, 200,  35, %00000010
  db  92, 200,  36, %00000010
  db 100, 200,  37, %00000010
  db 108, 200,  38, %00000010
  db 116, 200,  39, %00000010
  db 124, 200,  40, %00000010
  db 132, 200,  41, %00000010
  db 140, 200,  42, %00000010
  db 148, 200,  43, %00000010
  db 156, 200,  44, %00000010
  db 164, 200,  45, %00000010
  db 172, 200,  46, %00000010
  db 180, 200,  47, %00000010
  db 188, 200,  48, %00000010

  // OAM Info (Press Start Button 112x16)
  db  72, 144,  96, %00000100
  db  88, 144,  98, %00000100
  db 104, 144, 100, %00000100
  db 120, 144, 102, %00000100
  db 136, 144, 104, %00000100
  db 152, 144, 106, %00000100
  db 168, 144, 108, %00000100

  // OAM Extra Info (Title Screen Fore Ground OAM Size)
  db %10101010
  db %10101010
  db %10101010
  db %00000000
  db %00000000

  db %00000000
  db %00000000
  db %10101000
  db %10101010

TitleScreenEnd:
  FadeOUT() // Screen Fade Out

  lda.b #$80
  sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)

  stz.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels