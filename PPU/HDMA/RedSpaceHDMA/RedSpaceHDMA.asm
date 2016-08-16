// SNES Red Space HDMA Demo by krom (Peter Lemon):
arch snes.cpu
output "RedSpaceHDMA.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Load Red HDMA Gradient Backround Palette Color
  lda.b #%00000011 // HMDA: Write 4 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_CGADD // $21: Start At Palette CGRAM Address ($2121)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
  sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
  lda.b #%00000001 // HDMA Channel Select (Channel 0)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels 

  stz.w REG_TM // $212C: Main Screen Designation

  lda.b #$F // Turn On Screen, Maximum Brightness
  sta.w REG_INIDISP // $2100: Screen Display

Loop:
  jmp Loop

HDMATable:
  db $07, $00, $00, $1F, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color0
  db $07, $00, $00, $1E, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color1
  db $07, $00, $00, $1D, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color2
  db $07, $00, $00, $1C, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color3
  db $07, $00, $00, $1B, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color4
  db $07, $00, $00, $1A, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color5
  db $07, $00, $00, $19, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color6
  db $07, $00, $00, $18, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color7
  db $07, $00, $00, $17, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color8
  db $07, $00, $00, $16, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color9
  db $07, $00, $00, $15, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color10
  db $07, $00, $00, $14, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color11
  db $07, $00, $00, $13, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color12
  db $07, $00, $00, $12, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color13
  db $07, $00, $00, $11, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color14
  db $07, $00, $00, $10, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color15
  db $07, $00, $00, $0F, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color16
  db $07, $00, $00, $0E, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color17
  db $07, $00, $00, $0D, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color18
  db $07, $00, $00, $0C, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color19
  db $07, $00, $00, $0B, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color20
  db $07, $00, $00, $0A, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color21
  db $07, $00, $00, $09, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color22
  db $07, $00, $00, $08, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color23
  db $07, $00, $00, $07, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color24
  db $07, $00, $00, $06, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color25
  db $07, $00, $00, $05, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color26
  db $07, $00, $00, $04, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color27
  db $07, $00, $00, $03, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color28
  db $07, $00, $00, $02, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color29
  db $07, $00, $00, $01, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color30
  db $07, $00, $00, $00, $00 // Repeat 7 Scanlines, Palette Address 0, Gradient Color31
  db $00 // End Of HDMA