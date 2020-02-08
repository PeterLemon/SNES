// SNES Window HDMA Demo by krom (Peter Lemon):
arch snes.cpu
output "WindowHDMA.sfc", create

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

  LoadPAL(BGPal, $00, BGPal.size, 0) // Load Background Palette (BG Palette Uses 256 Colors)
  LoadVRAM(BGMap, $0000, BGMap.size, 0) // Load Background Tile Map To VRAM
  LoadVRAM(BGTiles, $4000, BGTiles.size, 0) // Load Background Tiles To VRAM

  lda.b #$01
  sta.w REG_NMITIMEN // Enable Joypad NMI Reading Interrupt

  // Setup Video
  lda.b #%00001011 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 3, Priority 1, BG1 8x8 Tiles

  // Setup BG1 256 Color Background
  lda.b #%00000011  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2107: BG1 64x64, BG1 Map Address = $0000 (VRAM Address / $400)
  lda.b #%00000010  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $4000 (VRAM Address / $1000)

  lda.b #$01   // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  // Green Background / Window
  lda.b #%11100000 // Load Green Colour Lo Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Lo Byte
  lda.b #%00000011 // Load Green Colour Hi Byte
  sta.w REG_CGDATA // $2122: CGRAM Data Write Hi Byte

  // Window
  lda.b #3         // Load Window BG1 Inside
  sta.w REG_W12SEL // $2123: Window BG1/BG2  Mask Settings Write Byte
  lda.b #1         // Load Window BG1 Disable
  sta.w REG_TMW    // $212E: Window Area Main Screen Disable Write Byte

  // HDMA Window     
  lda.b #%00000001 // HMDA: Write 2 Bytes Each Scanline
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_WH0   // $26: Start At Window 1 Left Position (X1)($2126)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #HDMATable // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
  sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)
  lda.b #%00000001 // HDMA Channel Select (Channel 0)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels 

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Lo Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Position Hi Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Lo Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Position Hi Byte

  FadeIN() // Screen Fade In

ldx.w #$0000 // Reset BG X Position
ldy.w #$0000 // Reset BG Y Position

InputLoop: 
  WaitNMI() // Wait For Vertical Blank

  Up:
    cpy.w #$0000 // Check If At Top Of Screen
    beq Down     // Skip BG Scrolling If Top
    ReadJOY({JOY_UP}) // Test UP Button
    beq Down          // IF (UP ! Pressed) Branch Down
    BGScroll8I(y, REG_BG1VOFS, de) // Decrement BG1 Vertical Position

  Down:
    cpy.w #$00FF // Check If At Bottom Of Screen
    beq Left     // Skip BG Scrolling If Bottom
    ReadJOY({JOY_DOWN}) // Test DOWN Button
    beq Left            // IF (DOWN ! Pressed) Branch Down
    BGScroll8I(y, REG_BG1VOFS, in) // Increment BG1 Vertical Position

  Left:
    cpx.w #$0000 // Check If At Left Of Screen
    beq Right    // Skip BG Scrolling If Left
    ReadJOY({JOY_LEFT}) // Test LEFT Button
    beq Right           // IF (LEFT ! Pressed) Branch Down
    BGScroll8I(x, REG_BG1HOFS, de) // Decrement BG1 Horizontal Position

  Right:
    cpx.w #$00FF // Check If At Right Of Screen
    beq Finish   // Skip BG Scrolling If Right
    ReadJOY({JOY_RIGHT}) // Test RIGHT Button
    beq Finish           // IF (RIGHT ! Pressed) Branch Down
    BGScroll8I(x, REG_BG1HOFS, in) // Increment BG1 Horizontal Position

  Finish:
    jmp InputLoop

HDMATable:
  db 16,   1,   0 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  15, 240 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  14, 241 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  13, 242 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  12, 243 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  11, 244 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  10, 245 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  10, 245 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  11, 244 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  12, 243 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  13, 242 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  14, 241 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,  15, 240 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 16,   1,   0 // Repeat 16 Scanlines, Window 1 X1, Window 1 X2
  db 0 // End Of HDMA

// Character Data
// BANK 0
insert BGPal, "GFX/BG.pal" // Include BG Palette Data (512 Bytes)
insert BGMap, "GFX/BG.map" // Include BG Map Data (8192 Bytes)
// BANK 1
seek($18000)
insert BGTiles, "GFX/BG.pic" // Include BG Tile Data (32384 Bytes)