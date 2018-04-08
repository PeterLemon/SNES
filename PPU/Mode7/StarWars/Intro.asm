//-------
// Intro
//-------
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

LoadPAL(FontBluePal, $00, FontYellowPal.size, 0) // Load Background Palette
LoadHIVRAM(FontTiles, $0000, FontTiles.size, 0) // Load Background Tiles To VRAM
LoadLOVRAM(IntroFontMap, $0000, 1280, 0) // Load Background Tile Map To VRAM

// Setup Video
lda.b #%00000111 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
sta.w REG_BGMODE // $2105: BG Mode 7, Priority 0, BG1 8x8 Tiles

lda.b #%00000001 // Enable BG1
sta.w REG_TM     // $212C: BG1 To Main Screen Designation

lda.b #$80 // No Repeat on Mode7 Screen
sta.w REG_M7SEL // $211A: Mode7 Settings

lda.b #$9A // Reset Scale
sta.w REG_M7A // $211B: MODE7 COSINE A
lda.b #$01
sta.w REG_M7A // $211B: MODE7 COSINE A
lda.b #$00
sta.w REG_M7D // $211E: MODE7 COSINE B
lda.b #$01
sta.w REG_M7D // $211E: MODE7 COSINE B

ldx.w #382 // BG1HOFS = 384
stx.b BG1ScrPosX

ldx.w #-90 // BG1VOFS = 0
stx.b BG1ScrPosY

ldx.w #512 // M7X = 512
stx.b Mode7PosX

ldx.w #-90 // M7Y = 0
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

FadeIN() // Screen Fade In

ldx.w #120
IntroLoop:
  WaitNMI() // Wait For Vertical Blank
  dex
  bne IntroLoop

FadeOUT() // Screen Fade Out

lda.b #$80
sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)