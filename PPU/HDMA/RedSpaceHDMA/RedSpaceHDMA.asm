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
  db $07; dw $0000, $001F // Repeat 7 Scanlines, Palette Address 0, Gradient Color0
  db $07; dw $0000, $001E // Repeat 7 Scanlines, Palette Address 0, Gradient Color1
  db $07; dw $0000, $001D // Repeat 7 Scanlines, Palette Address 0, Gradient Color2
  db $07; dw $0000, $001C // Repeat 7 Scanlines, Palette Address 0, Gradient Color3
  db $07; dw $0000, $001B // Repeat 7 Scanlines, Palette Address 0, Gradient Color4
  db $07; dw $0000, $001A // Repeat 7 Scanlines, Palette Address 0, Gradient Color5
  db $07; dw $0000, $0019 // Repeat 7 Scanlines, Palette Address 0, Gradient Color6
  db $07; dw $0000, $0018 // Repeat 7 Scanlines, Palette Address 0, Gradient Color7
  db $07; dw $0000, $0017 // Repeat 7 Scanlines, Palette Address 0, Gradient Color8
  db $07; dw $0000, $0016 // Repeat 7 Scanlines, Palette Address 0, Gradient Color9
  db $07; dw $0000, $0015 // Repeat 7 Scanlines, Palette Address 0, Gradient Color10
  db $07; dw $0000, $0014 // Repeat 7 Scanlines, Palette Address 0, Gradient Color11
  db $07; dw $0000, $0013 // Repeat 7 Scanlines, Palette Address 0, Gradient Color12
  db $07; dw $0000, $0012 // Repeat 7 Scanlines, Palette Address 0, Gradient Color13
  db $07; dw $0000, $0011 // Repeat 7 Scanlines, Palette Address 0, Gradient Color14
  db $07; dw $0000, $0010 // Repeat 7 Scanlines, Palette Address 0, Gradient Color15
  db $07; dw $0000, $000F // Repeat 7 Scanlines, Palette Address 0, Gradient Color16
  db $07; dw $0000, $000E // Repeat 7 Scanlines, Palette Address 0, Gradient Color17
  db $07; dw $0000, $000D // Repeat 7 Scanlines, Palette Address 0, Gradient Color18
  db $07; dw $0000, $000C // Repeat 7 Scanlines, Palette Address 0, Gradient Color19
  db $07; dw $0000, $000B // Repeat 7 Scanlines, Palette Address 0, Gradient Color20
  db $07; dw $0000, $000A // Repeat 7 Scanlines, Palette Address 0, Gradient Color21
  db $07; dw $0000, $0009 // Repeat 7 Scanlines, Palette Address 0, Gradient Color22
  db $07; dw $0000, $0008 // Repeat 7 Scanlines, Palette Address 0, Gradient Color23
  db $07; dw $0000, $0007 // Repeat 7 Scanlines, Palette Address 0, Gradient Color24
  db $07; dw $0000, $0006 // Repeat 7 Scanlines, Palette Address 0, Gradient Color25
  db $07; dw $0000, $0005 // Repeat 7 Scanlines, Palette Address 0, Gradient Color26
  db $07; dw $0000, $0004 // Repeat 7 Scanlines, Palette Address 0, Gradient Color27
  db $07; dw $0000, $0003 // Repeat 7 Scanlines, Palette Address 0, Gradient Color28
  db $07; dw $0000, $0002 // Repeat 7 Scanlines, Palette Address 0, Gradient Color29
  db $07; dw $0000, $0001 // Repeat 7 Scanlines, Palette Address 0, Gradient Color30
  db $07; dw $0000, $0000 // Repeat 7 Scanlines, Palette Address 0, Gradient Color31
  db $00 // End Of HDMA