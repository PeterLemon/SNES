// SNES Interlace RPG Demo by krom (Peter Lemon):
arch snes.cpu
output "InterlaceRPG.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $10000 // Fill Upto $FFFF (Bank 1) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)
  LoadVRAM(BGTiles, $0000, BGTiles.size, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F200, BGMap.size, 0) // Load Background Tile Map To VRAM

  LoadPAL(SpritePal, $80, SpritePal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  //LoadVRAM(SpriteTiles, $8000, SpriteTiles.size, 0) // Load Sprite Tiles To VRAM
  LoadVRAMStride(SpriteTiles, $8400, 128, $200, 6, 0) // Load Sprite Tiles To VRAM

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

    // Sprite OAM Info
    ldx.w #$0000 // X = $0000
    stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
    LoopSpriteOAM:
      lda.w SpriteOAM,x
      sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
      inx // X++
      cpx.w #$04
      bne LoopSpriteOAM

  // Sprite OAM Extra Info
  ldy.w #$0100 // Y = $0100
  sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
  LoopSpriteOAMSize:
    lda.w SpriteOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$05
    bne LoopSpriteOAMSize

  // Setup Video
  lda.b #%00001101 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 5, Priority 1, BG1 16x8 Tiles

  lda.b #%00000011 // Object High-Resolution & Interlace Mode On
  sta.w REG_SETINI // $2133: Screen Mode Select

  // Setup BG1 16 Color Background
  lda.b #%01111010  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x32, BG1 Map Address = $F200 (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0000 (VRAM Address / $1000)

  lda.b #%00010001 // Enable BG1 & Sprites
  sta.w REG_TM     // $212C: BG1 & Sprites To Main Screen Designation
  sta.w REG_TS     // $212D: BG1 To Sub Screen Designation (Needed To Show Interlace GFX)

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte

  lda.b #62 // Scroll BG 62 Pixels Up
  sta.w REG_BG1VOFS // Store A To BG Scroll Vertical Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG Scroll Vertical Position Hi Byte

  // Setup Sprites
  lda.b #%11000010 // Object Size = 16x32/32x64, Name = 0, Base = $8000
  sta.w REG_OBSEL // $2101: Object Size & Object Base

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

// OAM Data
SpriteOAM:
  // 16x32 / 32x64 Sprites
  // OAM Info (Sprite 32x64)
  db 112, -4, 0, %00110000

  // OAM Extra Info
  db %00000010

// Character Data
// BANK 0
insert SpritePal,   "GFX/Sprite.pal" // Include Sprite Palette Data (32 Bytes)
insert SpriteTiles, "GFX/Sprite.pic" // Include Sprite Tile Data (768 Bytes)
insert BGPal,       "GFX/BG.pal" // Include BG Palette Data (32 Bytes)
insert BGMap,       "GFX/BG.map" // Include BG Map Data (3584 Bytes)
// BANK 1
seek($18000)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (32512 Bytes)