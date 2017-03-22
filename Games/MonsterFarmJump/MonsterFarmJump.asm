// SNES Monster Farm Jump Game by krom (Peter Lemon):
arch snes.cpu
output "MonsterFarmJump.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $20000 // Fill Upto $FFFF (Bank 3) With Zero Bytes
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
  LoadVRAM(PressStartButtonTiles, $8C00, PressStartButtonTiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(ComicCPal, $B0, ComicCPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(ComicCTiles, $9000, ComicCTiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(ComicDPal, $C0, ComicDPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(ComicDTiles, $A800, ComicDTiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(ComicAPal, $D0, ComicAPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(ComicATiles, $C000, ComicATiles.size, 0) // Load Sprite Tiles To VRAM

  LoadPAL(ComicBPal, $E0, ComicBPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
  LoadVRAM(ComicBTiles, $E000, ComicBTiles.size, 0) // Load Sprite Tiles To VRAM

  // Title Screen OAM Info
  stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
                    // Object Priority Rotation / OAM Data Address High Bit
  stz.w REG_OAMADDH // Store Zero To OAM Access Address High Byte
  ldx.w #$0000 // X = 0
  LoopTitleScreenOAM:
    lda.w TitleScreenOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$01A0
    bne LoopTitleScreenOAM

  // Title Screen OAM Extra Info
  stz.w REG_OAMADDL // Store Zero To OAM Access Address Low Byte
  lda.b #%00000001  // Object Priority Rotation / OAM Data Address High Bit
  sta.w REG_OAMADDH // Store OAM Access Address High Byte
  LoopTitleScreenOAMSize:
    lda.w TitleScreenOAM,x
    sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
    inx // X++
    cpx.w #$01BA
    bne LoopTitleScreenOAMSize
  
  // Setup Video
                   // Interlace Mode Off
  stz.w REG_SETINI // $2133: Screen Mode Select

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

  // HDMA OAM Size & Object Base   
  lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_OBSEL // $0B: Start At Object Size & Object Base ($2101)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
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

HDMATable:
  db 32, %01100011 // Repeat 32 Scanlines, Object Size = 8x8/16x16, Name = 0, Base = $C000
  db 32, %01100011 // Repeat 32 Scanlines, Object Size = 8x8/16x16, Name = 0, Base = $C000
  db 32, %01100011 // Repeat 32 Scanlines, Object Size = 8x8/16x16, Name = 0, Base = $C000
  db 32, %01100011 // Repeat 32 Scanlines, Object Size = 8x8/16x16, Name = 0, Base = $C000
  db  1, %01100010 // Repeat  1 Scanlines, Object Size = 8x8/16x16, Name = 0, Base = $8000
  db 0 // End Of HDMA

TitleScreenOAM:
  include "TitleScreenOAM.asm" // Include Title Screen OAM Table

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
insert TecmoCopyrightTiles, "GFX/TecmoCopyright4BPP.pic" // Include Sprite Tile Data (1056 Bytes)

insert PressStartButtonPal,   "GFX/PressStartButton4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert PressStartButtonTiles, "GFX/PressStartButton4BPP.pic" // Include Sprite Tile Data (960 Bytes)

// BANK 2
seek($28000)
insert MonsterFarmJumpPal,   "GFX/MonsterFarmJump8BPP.pal" // Include BG Palette Data (256 Bytes)
insert MonsterFarmJumpMap,   "GFX/MonsterFarmJump8BPP.map" // Include BG Map Data (16384 Bytes)
insert MonsterFarmJumpTiles, "GFX/MonsterFarmJump8BPP.pic" // Include BG Tile Data (15360 Bytes)

// BANK 3
seek($38000)
insert ComicAPal,   "GFX/ComicA4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicATiles, "GFX/ComicA4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicBPal,   "GFX/ComicB4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicBTiles, "GFX/ComicB4BPP.pic" // Include Sprite Tile Data (8192 Bytes)

insert ComicCPal,   "GFX/ComicC4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicCTiles, "GFX/ComicC4BPP.pic" // Include Sprite Tile Data (6144 Bytes)

insert ComicDPal,   "GFX/ComicD4BPP.pal" // Include Sprite Palette Data (32 Bytes)
insert ComicDTiles, "GFX/ComicD4BPP.pic" // Include Sprite Tile Data (6144 Bytes)