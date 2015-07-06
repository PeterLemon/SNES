// SNES Red Space Indirect HDMA Demo by krom (Peter Lemon):
arch snes.cpu
output "RedSpaceIndirectHDMA.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB\SNES.INC"        // Include SNES Definitions
include "LIB\SNES_HEADER.ASM" // Include Header & Vector Table

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
HDMAIndirectData:
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color
  dw 0, 0 // Palette Address, Gradient Color

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Fill HDMAIndirectData
  lda.b #$1F // Gradient Color0
  sta.b HDMAIndirectData+2

  lda.b #$1E // Gradient Color1
  sta.b HDMAIndirectData+6

  lda.b #$1D // Gradient Color2
  sta.b HDMAIndirectData+10

  lda.b #$1C // Gradient Color3
  sta.b HDMAIndirectData+14

  lda.b #$1B // Gradient Color4
  sta.b HDMAIndirectData+18

  lda.b #$1A // Gradient Color5
  sta.b HDMAIndirectData+22

  lda.b #$19 // Gradient Color6
  sta.b HDMAIndirectData+26

  lda.b #$18 // Gradient Color7
  sta.b HDMAIndirectData+30

  lda.b #$17 // Gradient Color8
  sta.b HDMAIndirectData+34

  lda.b #$16 // Gradient Color9
  sta.b HDMAIndirectData+38

  lda.b #$15 // Gradient Color10
  sta.b HDMAIndirectData+42

  lda.b #$14 // Gradient Color11
  sta.b HDMAIndirectData+46

  lda.b #$13 // Gradient Color12
  sta.b HDMAIndirectData+50

  lda.b #$12 // Gradient Color13
  sta.b HDMAIndirectData+54

  lda.b #$11 // Gradient Color14
  sta.b HDMAIndirectData+58

  lda.b #$10 // Gradient Color15
  sta.b HDMAIndirectData+62

  lda.b #$0F // Gradient Color16
  sta.b HDMAIndirectData+66

  lda.b #$0E // Gradient Color17
  sta.b HDMAIndirectData+70

  lda.b #$0D // Gradient Color18
  sta.b HDMAIndirectData+74

  lda.b #$0C // Gradient Color19
  sta.b HDMAIndirectData+78

  lda.b #$0B // Gradient Color20
  sta.b HDMAIndirectData+82

  lda.b #$0A // Gradient Color21
  sta.b HDMAIndirectData+86

  lda.b #$09 // Gradient Color22
  sta.b HDMAIndirectData+90

  lda.b #$08 // Gradient Color23
  sta.b HDMAIndirectData+94

  lda.b #$07 // Gradient Color24
  sta.b HDMAIndirectData+98

  lda.b #$06 // Gradient Color25
  sta.b HDMAIndirectData+102

  lda.b #$05 // Gradient Color26
  sta.b HDMAIndirectData+106

  lda.b #$04 // Gradient Color27
  sta.b HDMAIndirectData+110

  lda.b #$03 // Gradient Color28
  sta.b HDMAIndirectData+114

  lda.b #$02 // Gradient Color29
  sta.b HDMAIndirectData+118

  lda.b #$01 // Gradient Color30
  sta.b HDMAIndirectData+122

  lda.b #$00 // Gradient Color31
  sta.b HDMAIndirectData+126

  // Load Red HDMA Gradient Backround Palette Color
  lda.b #%01000011 // HMDA: Write 4 Bytes Each Scanline, Repeat A/B-bus Address Twice, Indirect HDMA
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_CGADD // $21: Start At Palette CGRAM Address ($2121)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
  sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
  sta.w REG_DASB0  // $4307: DMA0 Indirect HDMA Address (Bank)
  lda.b #%00000001 // HDMA Channel Select (Channel 0)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels 

  stz.w REG_TM // $212C: Main Screen Designation

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop

HDMATable:
  db $07; dw HDMAIndirectData     // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+4   // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+8   // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+12  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+16  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+20  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+24  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+28  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+32  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+36  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+40  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+44  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+48  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+52  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+56  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+60  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+64  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+68  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+72  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+76  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+80  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+84  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+88  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+92  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+96  // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+100 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+104 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+108 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+112 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+116 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+120 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $07; dw HDMAIndirectData+124 // Repeat 7 Scanlines, HDMA Indirect Data Address
  db $00 // End Of HDMA