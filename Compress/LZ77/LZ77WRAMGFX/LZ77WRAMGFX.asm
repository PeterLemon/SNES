// SNES LZ77 WRAM GFX Demo by krom (Peter Lemon):
arch snes.cpu
output "LZ77WRAMGFX.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
LZFlagData:
  db 0 // LZ Flag Data Byte
LZBlockShift:
  db 0 // LZ Block Type Shifter Byte
LZNBDMSB:
  db 0 // LZ Number Of Bytes To Copy & Disp MSB's Byte
LZDLSB:
  db 0 // LZ Disp LSB's Byte
LZDMSB:
  db 0 // LZ Disp MSB's Byte
LZNB:
  db 0 // LZ Number Of Bytes To Copy Byte
LZDISP:
  dl 0 // LZ Disp Offset Long
LZDEST:
  dl 0 // LZ Destination Offset Long
LZOUT: // LZ Output WRAM Offset

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 16 Colors)

  ldx.w #LZOUT // WRAM Destination
  stx.b LZDEST // Store WRAM Long Destination Offset
  lda.b #$7E // A = WRAM Long Hi Byte
  sta.b LZDEST+2 // Store WRAM Long Hi Byte
  sta.b LZDISP+2 // Store WRAM Long Hi Byte

  ldx.w #$0004 // X = Source Address Index (Skip LZ Header)

  LZLoop:
    lda.l BGTiles,x // A = Flag Data For Next 8 Blocks (0 = Uncompressed Byte, 1 = Compressed Bytes)
    inx // Add 1 To LZ Offset
    sta.b LZFlagData // Store Flag Data
    lda.b #%10000000 // A = Flag Data Block Type Shifter
    sta.b LZBlockShift // Store Block Type Shifter
    LZBlockLoop:
      cpx.w #BGTiles.size // IF (Destination Address == Destination End Offset) LZEnd
      beq LZEnd
      lda.b LZBlockShift // A = Flag Data Block Type Shifter
      lsr LZBlockShift // Shift To Next Flag Data Block Type
      cmp.b #0 // IF (Flag Data Block Type Shifter == 0) LZLoop
      beq LZLoop
      bit.b LZFlagData // Test Block Type
      bne LZDecode // IF (BlockType != 0) LZDecode Bytes
      lda.l BGTiles,x // ELSE Copy Uncompressed Byte
      inx // Add 1 To LZ Offset
      sta [LZDEST] // Store Uncompressed Byte To Destination
      ldy.b LZDEST // Y = LZ Destination Offset
      iny // Add 1 To LZ Destination Offset
      sty.b LZDEST // LZ Destination Offset = Y
      jmp LZBlockLoop

      LZDecode:
        lda.l BGTiles,x // A = Number Of Bytes To Copy & Disp MSB's
        inx // Add 1 To LZ Offset
        sta.b LZNBDMSB // Store Number Of Bytes To Copy & Disp MSB's
        and.b #$F // A = Disp MSB's
        sta.b LZDMSB // Store Disp MSB's
        lda.l BGTiles,x // A = Disp LSB's
        inx // Add 1 To LZ Offset
        sta.b LZDLSB // Store Disp LSB's
        lda.b LZNBDMSB // A = Number Of Bytes To Copy & Disp MSB's
        lsr // A >>= 4
        lsr
        lsr
        lsr // A = Number Of Bytes To Copy (Minus 3)
        clc // Clear Carry Flag
        adc.b #3 // A = Number Of Bytes To Copy
        sta.b LZNB // Store Number Of Bytes To Copy
        ldy.b LZDLSB // Y = Disp
        iny // Y = Disp + 1
        sty.b LZDISP // Store Disp
        rep #$20 // Set 16-Bit Accumulator
        lda.b LZDEST // A = LZ Destination Offset
        sec // Set Carry Flag
        sbc.b LZDISP // A = Destination - Disp - 1 (LZ Disp Offset)
        sta.b LZDISP // Store LZ Disp Offset
        sep #$20 // Set 8-Bit Accumulator
        LZCopy:
          lda [LZDISP] // A = Byte To Copy
          ldy.b LZDISP // Y = LZ Disp Offset
          iny // Add 1 To LZ Disp Offset
          sty.b LZDISP // LZ Disp Offset = Y
          sta [LZDEST] // Store Uncompressed Byte To Destination
          ldy.b LZDEST // Y = LZ Destination Offset
          iny // Add 1 To LZ Destination Offset
          sty.b LZDEST // LZ Destination Offset = Y
          dec LZNB // Decrement Number Of Bytes To Copy
          bne LZCopy
          jmp LZBlockLoop
    LZEnd:

  LoadVRAM($7E0000+LZOUT, $0000, $40C0, 0) // Load Background Tiles To VRAM
  LoadVRAM(BGMap, $F200, BGMap.size, 0) // Load Background Tile Map To VRAM

  // Setup Video
  lda.b #%00001101 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 5, Priority 1, BG1 16x8 Tiles

  lda.b #%00000001 // Interlace Mode On
  sta.w REG_SETINI // $2133: Screen Mode Select

  // Setup BG1 16 Color Background
  lda.b #%01111010  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x32, BG1 Map Address = $F200 (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0000 (VRAM Address / $1000)

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation
  sta.w REG_TS // $212D: BG1 To Sub Screen Designation (Needed To Show Interlace GFX)

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte

  lda.b #62 // Scroll BG 62 Pixels Up
  sta.w REG_BG1VOFS // Store A To BG Scroll Vertical Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG Scroll Vertical Position Hi Byte

  FadeIN() // Screen Fade In

Loop:
  jmp Loop

// Character Data
// BANK 0
insert BGPal,   "GFX/BG.pal"   // Include BG Palette Data (32 Bytes)
insert BGMap,   "GFX/BG.map"   // Include BG Map Data (3584 Bytes)
insert BGTiles, "GFX/BGPIC.lz" // Include LZ Compressed BG Tile Data (6871 Bytes)