// SNES Input X-Band Keyboard Text Printing demo by krom (Peter Lemon):
// 1. DMA Loads Palette Data To CGRAM
// 2. DMA Loads 1BPP Character Tile Data To VRAM (Converts to 2BPP Tiles)
// 3. DMA Clears VRAM Map To A Space " " Character
// 4. Load X-Band Keyboard Buffer With Scancodes
// 5. DMA Prints Text Characters To Lo Bytes Of Map
arch snes.cpu
output "XBandKeyboard.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table
include "LIB/SNES_GFX.INC"    // Include Graphics Macros
include "LIB/SNES_INPUT.INC"  // Include Input Macros

constant TEXTCURSOR($7F) // Text Cursor Character Tile #

// Variable Data
seek(WRAM) // 8Kb WRAM Mirror ($0000..$1FFF)
KeyboardBuffer:
  fill 16 // X-Band Keyboard Buffer (16 Bytes)
CURSORPOS:
  dw 0 // Cursor VRAM Map Position Word
CURSORCOUNT:
  db 0 // Cursor Refresh Count
TEXTCOUNT:
  db 0 // Text Refresh Count (Used For Delay & Repeat Rate)
KEYSCANCODE:
  db 0 // Key Scancode (0 = Key Released)
KEYFLAGS:
  db 0 // Bit 0 = Shift State (0 = Shift Released, 1 = Shift On), Bit 1 = CAPSLOCK State (0 = CAPSLOCK Off, 1 = CAPSLOCK On)

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Init Variable Data
  ldx.w #$F8C4 >> 1 // Reset Cursor VRAM Map Position
  lda.b #$F0 // A = $F0
  sta.b $01 // Initialize Keys To Released State
  stx.b CURSORPOS // Store CURSORPOS
  stz.b CURSORCOUNT // Rest CURSORCOUNT
  stz.b TEXTCOUNT // Reset TEXTCOUNT
  stz.b KEYSCANCODE // Reset KEYSCANCODE
  stz.b KEYFLAGS // Reset KEYFLAGS

  // Init VRAM Data
  LoadPAL(BGPAL, $00, 4, 0) // Load BG Palette Data
  LoadLOVRAM(BGCHR, $0000, $400, 0) // Load 1BPP Tiles To VRAM Lo Bytes (Converts To 2BPP Tiles)
  ClearVRAM(BGCLEAR, $F800, $400, 0) // Clear VRAM Map To Fixed Tile Word

  // Print Text
  LoadLOVRAM(TITLETEXT, $F884, 27, 0) // Load Text To VRAM Lo Bytes

  // Setup Video
  lda.b #%00001000 // DCBAPMMM: M = Mode, P = Priority, ABCD = BG1,2,3,4 Tile Size
  sta.w REG_BGMODE // $2105: BG Mode 0, Priority 1, BG1 8x8 Tiles

  // Setup BG1 4 Color Background
  lda.b #%11111100  // AAAAAASS: S = BG Map Size, A = BG Map Address
  sta.w REG_BG1SC   // $2108: BG1 32x32, BG1 Map Address = $3F (VRAM Address / $400)
  lda.b #%00000000  // BBBBAAAA: A = BG1 Tile Address, B = BG2 Tile Address
  sta.w REG_BG12NBA // $210B: BG1 Tile Address = $0 (VRAM Address / $1000)

  lda.b #%00000001 // Enable BG1
  sta.w REG_TM // $212C: BG1 To Main Screen Designation

  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos Low Byte
  stz.w REG_BG1HOFS // Store Zero To BG1 Horizontal Scroll Pos High Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Scroll Pos Low Byte
  stz.w REG_BG1VOFS // Store Zero To BG1 Vertical Pos High Byte

  FadeIN() // Screen Fade In

Loop:
  WaitNMI() // Wait For Vertical Blank

  ReadXBAND() // Read X-Band Keyboard ScanCodes To WRAM ($01..$0F)

  // Key Release
  lda.b $01 // A = MEM[$01] (Keyboard Buffer Scancode)
  cmp.b #$F0 // Compare MEM[$01] To Normal/Special Key Released Code
  bne KeyPressed // IF (ScanCode != $F0) Key Pressed
  stz.b TEXTCOUNT // Store Zero To TEXTCOUNT
  stz.b KEYSCANCODE // Store Zero To KEYSCANCODE
  lda.b $02 // A = MEM[$02] (Keyboard Buffer Scancode)
  LeftShiftRelease:
    cmp.b #$12 // Compare MEM[$02] To Left-SHIFT Key Code
    bne RightShiftRelease
    lda.b #$01 // A = Shift Bit
    trb.b KEYFLAGS // KEYFLAGS: Reset Shift Bit 0 (Shift Released)
    jmp SkipChar
  RightShiftRelease:
    cmp.b #$59 // Compare MEM[$02] To Right-SHIFT Key Code
    bne NormalKeyReleased
    lda.b #$01 // A = Shift Bit
    trb.b KEYFLAGS // KEYFLAGS: Reset Shift Bit 0 (Shift Released)
    jmp SkipChar
  NormalKeyReleased:
    jmp SkipChar

  KeyPressed: // A Key Has Been Pressed
    cmp.b KEYSCANCODE // Compare A With Key Scancode
    bne KeyDelay // IF (A != Key Scancode) Key Delay

    lda.b TEXTCOUNT // IF (TEXTCOUNT == 0)
    beq KeyRepeat   // Key Repeat Press
    dec.b TEXTCOUNT // ELSE TEXTCOUNT--
    jmp SkipChar    // Skip Character
  KeyDelay:
    sta.b KEYSCANCODE // Key Scancode = A
    lda.b #32 // TEXTCOUNT = 32 (Delay Rate)
    jmp KeyEnd
  KeyRepeat:
    lda.b #4 // TEXTCOUNT = 4 (Repeat Rate)
  KeyEnd:
    sta.b TEXTCOUNT // Store TEXTCOUNT Delay/Repeat Rate

  lda.b KEYSCANCODE // A = Keyboard Scancode

  cmp.b #$E0 // Compare A To Special Key Code
  bne CancelKey
  jmp SkipChar

  CancelKey:
    cmp.b #$76 // Compare A To Cancel Key Pressed Code
    bne SwitchKey
    jmp SkipChar

  SwitchKey:
    cmp.b #$0D // Compare A To Switch Key Pressed Code
    bne LeftCtrlKey
    jmp SkipChar

  LeftCtrlKey:
    cmp.b #$11 // Compare A To Left Ctrl Key Pressed Code
    bne RightCtrlKey
    jmp SkipChar

  RightCtrlKey:
    cmp.b #$14 // Compare A To Right Ctrl Key Pressed Code
    bne BackSpace
    jmp SkipChar

  BackSpace:
    cmp.b #$66 // Compare A To BackSpace Key Pressed Code
    bne ReturnKey
    ldx.b CURSORPOS  // Set VRAM Destination
    stx.w REG_VMADDL // $2116: VRAM
    lda.b #$20 // A = Space " " Ascii Character
    sta.w REG_VMDATAL // $2118: VRAM Write Lo Byte
    dex // CURSORPOS--
    stx.b CURSORPOS // Store Cursor Position
    jmp SkipChar

  ReturnKey:
    cmp.b #$5A // Compare A To Return Key Pressed Code
    bne LeftShiftKey
    ldx.b CURSORPOS  // Set VRAM Destination
    stx.w REG_VMADDL // $2116: VRAM
    lda.b #$20 // A = Space " " Ascii Character
    sta.w REG_VMDATAL // $2118: VRAM Write Lo Byte
    lda.b CURSORPOS // Set Cursor Position To Start of Current Row
    and.b #$E0
    sta.b CURSORPOS
    lda.b #34 // Increment Cursor Position 34 Times (+= 34)
    ldx.b CURSORPOS // X = Cursor Position
    LoopReturn:
       inx // X++
       dec // A--
       bne LoopReturn
    cpx.w #$7F42  // Compare Cursor Position To Bottom Of Page
    bne ReturnEnd // IF (Cursor Position != Bottom Of Page) Return End
    ldx.w #$7F22  // ELSE Cursor Position = $7F22
    ReturnEnd:
      stx.b CURSORPOS // Store Cursor Position
      jmp SkipChar

  LeftShiftKey:
    cmp.b #$12 // Compare A To Left-SHIFT Key Code
    bne RightShiftKey
    lda.b #$01 // A = Shift Bit
    tsb.b KEYFLAGS // KEYFLAGS: Set Shift Bit 0 (Shift On)
    jmp SkipChar
 
  RightShiftKey:
    cmp.b #$59 // Compare A To Right-SHIFT Key Code
    bne CAPSLOCK
    lda.b #$01 // A = KEYFLAGS: Shift Bit
    tsb.b KEYFLAGS // KEYFLAGS: Set Shift Bit 0 (Shift On)
    jmp SkipChar

  CAPSLOCK:
    cmp.b #$58 // Compare A To CAPSLOCK Key Code
    bne NormalKey
    lda.b #$02 // A = KEYFLAGS: CAPSLOCK Bit
    tsb.b KEYFLAGS // KEYFLAGS: Test & Set CAPSLOCK Bit 1 (CAPSLOCK On)
    beq CAPSLOCKEnd // IF (Test == 0) CAPSLOCK End
    trb.b KEYFLAGS  // ELSE KEYFLAGS: Reset CAPSLOCK Bit 1 (CAPSLOCK Off)
    CAPSLOCKEnd:
    jmp SkipChar

  NormalKey:
    lda.b KEYSCANCODE // A = X-Band Shift Ascii Map Offset
    tax // X = A
    lda.b KEYFLAGS // A = KEYFLAGS
    bit.b #$01  // Test Bit 0 (Shift State)
    bne ShiftOn // IF (KEYFLAGS.BIT0 != 0) Shift On
    bit.b #$02 // Test Bit 1 (CAPSLOCK State)
    bne CAPSOn // IF (KEYFLAGS.BIT1 != 0) CAPSLOCK On
    lda.w XBANDASCIIMAP,x // Load Ascii Character From Map
    sta.b $00 // Store Ascii Character to MEM[$00]
    jmp PrintChar

  ShiftOn:
    bit.b #$02 // Test Bit 1 (CAPSLOCK State)
    bne ShiftCAPSOn // IF (KEYFLAGS.BIT1 != 0) Shift & CAPSLOCK On
    lda.w XBANDSHIFTASCIIMAP,x // Load Ascii Character From Map
    sta.b $00 // Store Ascii Character to MEM[$00]
    jmp PrintChar

  CAPSOn:
    lda.w XBANDCAPSASCIIMAP,x // Load Ascii Character From Map
    sta.b $00 // Store Ascii Character to MEM[$00]
    jmp PrintChar

  ShiftCAPSOn:
    lda.w XBANDSHIFTCAPSASCIIMAP,x // Load Ascii Character From Map
    sta.b $00 // Store Ascii Character to MEM[$00]

  PrintChar: // Print Character To VRAM Lo Byte
    ldx.b CURSORPOS  // Set VRAM Destination
    stx.w REG_VMADDL // $2116: VRAM
    lda.b $00 // A = Ascii Character
    sta.w REG_VMDATAL // $2118: VRAM Write Lo Byte
    inx // CURSORPOS++
    stx.b CURSORPOS // Store Cursor Position
  SkipChar:


  // Cursor
  ldx.b CURSORPOS  // Set VRAM Destination

  CursorTop:
    cpx.w #$7C41
    bne CursorBottom
    inx
    stx.b CURSORPOS // Store Cursor Position
    jmp CURSORON
  CursorBottom:
    cpx.w #$7F3E
    bne CursorLeftRight
    dex
    stx.b CURSORPOS // Store Cursor Position
    jmp CURSORON

  CursorLeftRight:
    txa // A = X (Lo Byte)
    and.b #$1F
  CursorLeftDetect:
    cmp.b #$01
    beq CursorLeft
    jmp CursorRightDetect
  CursorLeft:
    dex
    dex
    dex
    dex
    stx.b CURSORPOS // Store Cursor Position
  CursorRightDetect:
    cmp.b #$1E
    beq CursorRight
    jmp CURSORON
  CursorRight:
    inx
    inx
    inx
    inx
    stx.b CURSORPOS // Store Cursor Position

  CURSORON:
    stx.w REG_VMADDL // $2116: VRAM
    lda.b #$0F
    cmp.b CURSORCOUNT
    bpl CURSOROFF
    lda.b #TEXTCURSOR // A = Text Cursor Character
    jmp CURSOREND
  CURSOROFF:
    lda.b #$20 // A = Space " " Character (Clear Cursor)
  CURSOREND:
    sta.w REG_VMDATAL // $2118: VRAM Write Lo Byte
    inc.b CURSORCOUNT // Cursor Refresh Count++  
    lda.b #$1F        // A = $1F
    and.b CURSORCOUNT // Cursor Refresh Count &= $1F
    sta.b CURSORCOUNT // Store Cursor Refresh Count

  jmp Loop

XBANDASCIIMAP:
  db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, "`", $00
  db $00, $00, $00, $00, $00, "q", "1", $00, $00, $00, "z", "s", "a", "w", "2", $00
  db $00, "c", "x", "d", "e", "4", "3", $00, $00, " ", "v", "f", "t", "r", "5", $00
  db $00, "n", "b", "h", "g", "y", "6", $00, $00, $00, "m", "j", "u", "7", "8", $00
  db $00, ",", "k", "i", "o", "0", "9", $00, $00, ".", "/", "l", ";", "p", "-", $00
  db $00, $00, $27, $00, "[", "=", $00, $00, $00, $00, $00, "]", $00, "\", $00, $00
  db $00, $00, $00, $00, $00, $00, " ", $00, $00, $00, $00, $00, $00, $00, $00, $00

XBANDCAPSASCIIMAP:
  db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, "`", $00
  db $00, $00, $00, $00, $00, "Q", "1", $00, $00, $00, "Z", "S", "A", "W", "2", $00
  db $00, "C", "X", "D", "E", "4", "3", $00, $00, " ", "V", "F", "T", "R", "5", $00
  db $00, "N", "B", "H", "G", "Y", "6", $00, $00, $00, "M", "J", "U", "7", "8", $00
  db $00, ",", "K", "I", "O", "0", "9", $00, $00, ".", "/", "L", ";", "P", "-", $00
  db $00, $00, $27, $00, "[", "=", $00, $00, $00, $00, $00, "]", $00, "\", $00, $00
  db $00, $00, $00, $00, $00, $00, " ", $00, $00, $00, $00, $00, $00, $00, $00, $00

XBANDSHIFTASCIIMAP:
  db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, "~", $00
  db $00, $00, $00, $00, $00, "Q", "!", $00, $00, $00, "Z", "S", "A", "W", "@", $00
  db $00, "C", "X", "D", "E", "$", "#", $00, $00, " ", "V", "F", "T", "R", "%", $00
  db $00, "N", "B", "H", "G", "Y", "^", $00, $00, $00, "M", "J", "U", "&", "*", $00
  db $00, "<", "K", "I", "O", ")", "(", $00, $00, ">", "?", "L", ":", "P", "_", $00
  db $00, $00, $22, $00, "{", "+", $00, $00, $00, $00, $00, "}", $00, "|", $00, $00
  db $00, $00, $00, $00, $00, $00, " ", $00, $00, $00, $00, $00, $00, $00, $00, $00

XBANDSHIFTCAPSASCIIMAP:
  db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, "~", $00
  db $00, $00, $00, $00, $00, "q", "!", $00, $00, $00, "z", "s", "a", "w", "@", $00
  db $00, "c", "x", "d", "e", "$", "#", $00, $00, " ", "v", "f", "t", "r", "%", $00
  db $00, "n", "b", "h", "g", "y", "^", $00, $00, $00, "m", "j", "u", "&", "*", $00
  db $00, "<", "k", "i", "o", ")", "(", $00, $00, ">", "?", "l", ":", "p", "_", $00
  db $00, $00, $22, $00, "{", "+", $00, $00, $00, $00, $00, "}", $00, "|", $00, $00
  db $00, $00, $00, $00, $00, $00, " ", $00, $00, $00, $00, $00, $00, $00, $00, $00

TITLETEXT:
  db "X-Band Keyboard Input Test:" // Title Text

BGCHR:
  include "Font8x8.asm" // Include BG 1BPP 8x8 Tile Font Character Data (1024 Bytes)
BGPAL:
  dw $7FFF, $0000 // White / Black Palette (4 Bytes)
BGCLEAR:
  dw $0020 // BG Clear Character Space " " Fixed Word