// SNES Monster Farm Jump Game by krom (Peter Lemon):
arch snes.cpu
output "MonsterFarmJump.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $18000 // Fill Upto $FFFF (Bank 2) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

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

  // Title Screen
  LoadPAL(MonsterFarmJumpPal, $00, MonsterFarmJumpPal.size, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  LoadM7VRAM(MonsterFarmJumpMap, MonsterFarmJumpTiles, $0000, MonsterFarmJumpMap.size, MonsterFarmJumpTiles.size, 0) // Load Background Map & Tiles To VRAM

  LoadPAL(TecmoMiniPal, $80, TecmoMiniPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(TecmoMiniTiles, $8000, TecmoMiniTiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(TecmoCopyrightPal, $90, TecmoCopyrightPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(TecmoCopyrightTiles, $8400, TecmoCopyrightTiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(PressStartButtonPal, $A0, PressStartButtonPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(PressStartButtonTiles, $8800, PressStartButtonTiles.size, 0) // Load Sprite Tiles To VRAM

  // Setup Sprites
  lda.b #%00000010 // SSSNNBBB: S = Object Size, N = Name, B = Base
  sta.w REG_OBSEL  // $2101: Object Size = 8x8/16x16, Name = 0, Base = $8000

  stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte

  // OAM Info (Tecmo Mini 64x16)
  lda.b #96         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #176        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  // Starting Character (Tile) Number
  stz.w REG_OAMDATA // Store Zero To 3rd Byte Of Sprite Attribute
  lda.b #%00000000  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #112        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #176        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #2          // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000000  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #128        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #176        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #4          // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000000  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #144        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #176        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #6          // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000000  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  // OAM Info (Tecmo Copyright 136x8)
  lda.b #60         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #32         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #68         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #33         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #76         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #34         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #84         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #35         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #92         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #36         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #100        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #37         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #108        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #38         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #116        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #39         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #124        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #40         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #132        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #41         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #140        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #42         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #148        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #43         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #156        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #44         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #164        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #45         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #172        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #46         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #180        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #47         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #188        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #200        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #48         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000010  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  // OAM Info (Press Start Button 112x16)
  lda.b #72         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #64         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #88         // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #66         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #104        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #68         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #120        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #70         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #136        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #72         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #152        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #74         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  lda.b #168        // Load Sprite X Postion To A
  sta.w REG_OAMDATA // Store 1st Byte Of Sprite Attribute
  lda.b #144        // Load Sprite Y Postion To A
  sta.w REG_OAMDATA // Store 2nd Byte Of Sprite Attribute
  lda.b #76         // Starting Character (Tile) Number
  sta.w REG_OAMDATA // Store 3rd Byte Of Sprite Attribute
  lda.b #%00000100  // VHOOPPPC: C = Tile 9th Bit, P: Palette, O: Priority, H: Horizontal Flip, V = Vertical Flip
  sta.w REG_OAMDATA // Store 4th Byte Of Sprite Attribute

  // OAM Extra Info
  stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
  lda.b #$01 // A = $01
  sta.w REG_OAMADDH // Store OAM Access Address High Byte

  lda.b #%10101010  // Sprite 0..3 Size Big
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  stz.w REG_OAMDATA // Store Zero To Byte Of Sprite Attribute
  stz.w REG_OAMDATA // Store Zero To Byte Of Sprite Attribute
  stz.w REG_OAMDATA // Store Zero To Byte Of Sprite Attribute
  stz.w REG_OAMDATA // Store Zero To Byte Of Sprite Attribute
  lda.b #%10101000  // Sprite 21..23 Size Big
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  lda.b #%10101010  // Sprite 24..27 Size Big
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute

  // Setup Video
  lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

  lda.b #%00010001 // Enable BG1 & Sprites 
  sta.w REG_TM     // $212C: BG1 & Sprites To Main Screen Designation

  stz.w REG_M7SEL // $211A: Mode7 Settings

  lda.b #$80
  sta.w REG_BG1HOFS // $210D: BG1 Position X Lo Byte
  lda.b #$01
  sta.w REG_BG1HOFS // $210D: BG1 Position X Hi Byte

  lda.b #$B8
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
  lda.b #$01
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

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

  ldx.w #$0000
  TitleZoomOut:
    WaitNMI() // Wait VBlank
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

Loop:
  jmp Loop

// Character Data
// BANK 1
seek($18000)
insert TecmoPal,   "GFX/Tecmo2BPP.pal" // Include BG Palette Data (8 Bytes)
insert TecmoMap,   "GFX/Tecmo2BPP.map" // Include BG Map Data (3584 Bytes)
insert TecmoTiles, "GFX/Tecmo2BPP.pic" // Include BG Tile Data (3936 Bytes)

insert TecmoHiLightPal,   "GFX/TecmoHiLight4BPP.pal" // Include BG Palette Data (32 Bytes)
insert TecmoHiLightMap,   "GFX/TecmoHiLight4BPP.map" // Include BG Map Data (3584 Bytes)
insert TecmoHiLightTiles, "GFX/TecmoHiLight4BPP.pic" // Include BG Tile Data (6400 Bytes)

insert TecmoMiniPal,   "GFX/TecmoMini4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert TecmoMiniTiles, "GFX/TecmoMini4BPP.pic" // Include Sprite Tile Data (768 Bytes)

insert TecmoCopyrightPal,   "GFX/TecmoCopyright4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert TecmoCopyrightTiles, "GFX/TecmoCopyright4BPP.pic" // Include Sprite Tile Data (544 Bytes)

insert PressStartButtonPal,   "GFX/PressStartButton4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert PressStartButtonTiles, "GFX/PressStartButton4BPP.pic" // Include Sprite Tile Data (960 Bytes)

// BANK 2
seek($28000)
insert MonsterFarmJumpPal,   "GFX/MonsterFarmJump8BPP.pal" // Include BG Palette Data (256 Bytes)
insert MonsterFarmJumpMap,   "GFX/MonsterFarmJump8BPP.map" // Include BG Map Data (16384 Bytes)
insert MonsterFarmJumpTiles, "GFX/MonsterFarmJump8BPP.pic" // Include BG Tile Data (15360 Bytes)