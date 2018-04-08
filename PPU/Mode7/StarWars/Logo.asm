//------
// Logo
//------
// Clear Mode7 VRAM
lda.b #$80       // Set Increment VRAM Address After Accessing Hi Byte
sta.w REG_VMAIN  // $2115: Video Port Control
ldx.w #$0000     // Set VRAM Destination
stx.w REG_VMADDL // $2116: VRAM
ldy.w #$0000
-
  sty.w REG_VMDATAL // $2118: VRAM Data Write
  inx // X++
  cpx.w #$4000
  bne -

LoadPAL(LogoPal, $00, LogoPal.size, 0) // Load Background Palette
LoadHIVRAM(LogoTiles, $0000, FontTiles.size, 0) // Load Background Tiles To VRAM
LoadLOVRAM(LogoMap, $0000, LogoMap.size, 0) // Load Background Tile Map To VRAM

LoadPAL(StarsPal, $80, StarsPal.size, 0) // Load Sprite Palette (Sprite Palette Uses 16 Colors)
LoadVRAM(StarsTiles, $8000, StarsTiles.size, 0) // Load Sprite Tiles To VRAM

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

// Scroller OAM Info
ldx.w #$0000 // X = $0000
stx.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopStarsOAM:
  lda.w StarsOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #80
  bne LoopStarsOAM

// Scroller OAM Extra Info
ldy.w #$0100 // Y = $0100
sty.w REG_OAMADDL // $2102: OAM Address & Priority Rotation
LoopStarsOAMSize:
  lda.w StarsOAM,x
  sta.w REG_OAMDATA // Store Byte Of Sprite Attribute
  inx // X++
  cpx.w #85
  bne LoopStarsOAMSize

// Setup Video
lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

lda.b #%00010001 // Enable BG1 & Sprites
sta.w REG_TM     // $212C: BG1 & Sprites To Main Screen Designation

lda.b #%00010000 // Enable Sprites
sta.w REG_TS     // $212D: Sprites To Sub Screen Designation

lda.b #$80 // No Repeat on Mode7 Screen
sta.w REG_M7SEL // $211A: Mode7 Settings

// Reset Scale
stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7D // $211E: MODE7 COSINE B
stz.w REG_M7D // $211E: MODE7 COSINE B

ldx.w #384 // BG1HOFS = 384
stx.b BG1ScrPosX

ldx.w #400 // BG1VOFS = 400
stx.b BG1ScrPosY

ldx.w #512 // M7X = 512
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

// Setup Blend
stz.w REG_CGWSEL // $2130: Color Math Control Register A
lda.b #%10000001 // Enable Sub Screen Backdrop Color SUB
sta.w REG_CGADSUB // $2131: Color Math Control Register B
stz.w REG_COLDATA // $2132: Color Math Sub Screen Backdrop Color (RGB Intensity)

// Setup Sprites
lda.b #%10100010 // Object Size = 32x32/64x64, Name = 0, Base = $8000
sta.w REG_OBSEL // $2101: Object Size & Object Base

// HDMA OAM Size & Object Base
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP3  // $4330: DMA3 DMA/HDMA Parameters
lda.b #REG_OBSEL // $01: Start At Object Size & Object Base ($2101)
sta.w REG_BBAD3  // $4331: DMA3 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #StarsHDMATableOAM // HMDA Table Address
stx.w REG_A1T3L  // $4332: DMA3 DMA/HDMA Table Start Address
lda.b #StarsHDMATableOAM >> 16 // HDMA Table Bank
sta.w REG_A1B3   // $4334: DMA3 DMA/HDMA Table Start Address (Bank)

lda.b #%00001000 // HDMA Channel Select (Channel 3)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

FadeIN() // Screen Fade In

lda.b #$00 // Zoom Value
xba
lda.b #$00
LogoLoop:
  WaitNMI() // Wait For Vertical Blank

  // Scale Logo
  sta.w REG_M7A // $211B: MODE7 COSINE A
  xba
  sta.w REG_M7A // $211B: MODE7 COSINE A
  xba
  sta.w REG_M7D // $211E: MODE7 COSINE B
  xba
  sta.w REG_M7D // $211E: MODE7 COSINE B
  //sta.w REG_COLDATA // $2132: Color Math Sub Screen Backdrop Color (RGB Intensity)
  xba

  inc // Zoom Value Lo++
  inc // Zoom Value Lo++
  inc // Zoom Value Lo++
  inc // Zoom Value Lo++
  bne LogoLoop // IF (Zoom Value != 0) Logo Loop
  xba // ELSE INC B
  inc // Zoom Value Hi++
  tax // X = A
  asl
  ora.b #%11100000
  sta.w REG_COLDATA // $2132: Color Math Sub Screen Backdrop Color (RGB Intensity)
  cmp.b #$FE // IF (RGB Intensity == $FE) Logo Finish
  beq LogoFinish
  txa // A = X
  xba
  bra LogoLoop

StarsOAM:
  // Stars 64x64)
  db 0, 0, 0, %00000000
  db 64, 0, 8, %00000000
  db 128, 0, 128, %00000000
  db 192, 0, 136, %00000000

  db 0, 64, 0, %00000001
  db 64, 64, 8, %00000001
  db 128, 64, 128, %00000001
  db 192, 64, 136, %00000001

  db 0, 128, 0, %00000000
  db 64, 128, 8, %00000000
  db 128, 128, 128, %00000000
  db 192, 128, 136, %00000000

  db 0, 192, 0, %00000001
  db 32, 192, 4, %00000001
  db 64, 192, 8, %00000001
  db 96, 192, 12, %00000001
  db 128, 192, 16, %00000001
  db 160, 192, 20, %00000001
  db 192, 192, 24, %00000001
  db 224, 192, 28, %00000001

  // OAM Extra Info
  db %10101010
  db %10101010
  db %10101010
  db %00000000
  db %00000000

StarsHDMATableOAM:
  db 128, %10100010 // Repeat 40 Scanlines, Object Size = 32x32/64x64, Name = 0, Base = $8000
  db   1, %10100011 // Repeat  1 Scanlines, Object Size = 32x32/64x64, Name = 0, Base = $C000
  db 0 // End Of HDMA

LogoFinish: