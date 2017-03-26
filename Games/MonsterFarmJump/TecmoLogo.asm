//-----------
// Tecmo Logo
//-----------
LoadPAL(TecmoPal, $00, TecmoPal.size, 0) // Load Background Palette (BG Palette Uses 4 Colors)
LoadVRAM(TecmoTiles, $0000, TecmoTiles.size, 0) // Load Background Tiles To VRAM
LoadVRAM(TecmoMap, $F200, TecmoMap.size, 0) // Load Background Tile Map To VRAM

LoadPAL(TecmoHiLightPal, $10, TecmoHiLightPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
LoadVRAM(TecmoHiLightTiles, $2000, TecmoHiLightTiles.size, 0) // Load Background Tiles To VRAM
LoadVRAM(TecmoHiLightMap, $E200, TecmoHiLightMap.size, 0) // Load Background Tile Map To VRAM

// Setup Video
lda.b #%00001101 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 5, Priority 1, BG1 & BG2 16x8 Tiles

lda.b #%00000001 // Interlace Mode On
sta.w REG_SETINI // $2133: Screen Mode Select

// Setup BG1 16 Color Background & BG2 4 Color Background
lda.b #%01110010  // AAAAAASS: S = BG Map Size, A = BG Map Address
sta.w REG_BG1SC   // $2107: BG1 64x32, BG1 Map Address = $E200 (VRAM Address / $400)
lda.b #%01111010  // AAAAAASS: S = BG Map Size, A = BG Map Address
sta.w REG_BG2SC   // $2108: BG2 64x32, BG2 Map Address = $F200 (VRAM Address / $400)
lda.b #%00000001  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
sta.w REG_BG12NBA // $210B: BG1 Tile Address = $2000, BG2 Tile Address = $0000 (VRAM Address / $1000)

lda.b #$03   // Enable BG1 & BG2
sta.w REG_TM // $212C: BG1 & BG2 To Main Screen Designation
sta.w REG_TS // $212D: BG1 & BG2 To Sub Screen Designation (Needed To Show Interlace GFX)

lda.b #$30
sta.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Lo Byte
stz.w REG_BG2HOFS // Store Zero To BG2 Horizontal Scroll Position Hi Byte

lda.b #62 // Scroll BG 62 Pixels Up
sta.w REG_BG1VOFS // Store A To BG Scroll Vertical Position Lo Byte
stz.w REG_BG1VOFS // Store Zero To BG Scroll Vertical Position Hi Byte
sta.w REG_BG2VOFS // Store A To BG2 Vertical Scroll Position Lo Byte
stz.w REG_BG2VOFS // Store Zero To BG2 Vertical Scroll Position Hi Byte

// Show Tecmo Logo Animation
FadeIN() // Screen Fade In

lda.b #180 // A = 180
LoopHiLightStart:
  WaitNMI() // Wait VBlank
  dec // A--
  bne LoopHiLightStart // IF (A != 0) Loop HiLight Start

lda.b #$30 // A = $30
LoopHiLight:
  WaitNMI() // Wait VBlank
  sta.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  sec // Set Carry
  sbc.b #4 // A -= 4
  cmp.b #$30 // Compare A To $30
  bne LoopHiLight // IF (A != $30) Loop HiLight

lda.b #240 // A = 240
LoopHiLightEnd:
  WaitNMI() // Wait VBlank
  dec // A--
  bne LoopHiLightEnd // IF (A != 0) Loop HiLight End

FadeOUT() // Screen Fade Out

lda.b #$80
sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)