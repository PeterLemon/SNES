//----------
// Scroller
//----------
LoadPAL(FontYellowPal, $00, FontYellowPal.size, 0) // Load Background Palette

WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles, $0000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$0800, $1000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$1000, $2000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$1800, $3000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$2000, $4000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$2800, $5000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$3000, $6000, $0800, 0) // Load Background Tiles To VRAM
WaitNMI() // Wait For Vertical Blank
LoadHIVRAM(FontTiles+$3800, $7000, $0800, 0) // Load Background Tiles To VRAM

WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap, $0000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$0800, $1000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$1000, $2000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$1800, $3000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$2000, $4000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$2800, $5000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$3000, $6000, $0800, 0) // Load Background Tile Map To VRAM
WaitNMI() // Wait For Vertical Blank
LoadLOVRAM(ScrollerFontMap+$3800, $7000, $0800, 0) // Load Background Tile Map To VRAM

// Setup Video
stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7A // $211B: MODE7 COSINE A
stz.w REG_M7D // $211E: MODE7 COSINE B
stz.w REG_M7D // $211E: MODE7 COSINE B

ldx.w #384 // BG1HOFS = 384
stx.b BG1ScrPosX

ldx.w #-256 // BG1VOFS = -256
stx.b BG1ScrPosY

ldx.w #512 // M7X = 512
stx.b Mode7PosX

ldx.w #0 // M7Y = 0
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

// HDMA Mode7 +COS (A) Scanline
lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
sta.w REG_DMAP0   // $4300: DMA0 DMA/HDMA Parameters
lda.b #REG_M7A    // $1B: Start At MODE7 COSINE A ($211B)
sta.w REG_BBAD0   // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7COSHDMATable // HMDA Table Address
stx.w REG_A1T0L   // $4302: DMA0 DMA/HDMA Table Start Address
lda.b #M7COSHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B0    // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

// HDMA Mode7 +COS (D) Scanline
lda.b #%00000010  // HMDA: Write 2 Bytes Each Scanline, Repeat A/B-bus Address Twice
sta.w REG_DMAP1   // $4310: DMA1 DMA/HDMA Parameters
lda.b #REG_M7D    // $1E: Start At MODE7 COSINE B ($211E)
sta.w REG_BBAD1   // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7COSHDMATable // HMDA Table Address
stx.w REG_A1T1L   // $4312: DMA1 DMA/HDMA Table Start Address
lda.b #M7COSHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B1    // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

// HDMA Mode7 Intensity
lda.b #%00000000 // HMDA: Write 1 Bytes Each Scanline
sta.w REG_DMAP2  // $4320: DMA2 DMA/HDMA Parameters
lda.b #REG_COLDATA // $32: Start At Color Math Sub Screen Backdrop Color ($2132)
sta.w REG_BBAD2  // $4321: DMA2 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
ldx.w #M7IntensityHDMATable // HMDA Table Address
stx.w REG_A1T2L  // $4322: DMA2 DMA/HDMA Table Start Address
lda.b #M7IntensityHDMATable >> 16 // HDMA Table Bank
sta.w REG_A1B2   // $4324: DMA2 DMA/HDMA Table Start Address (Bank)

lda.b #%00001111 // HDMA Channel Select (Channel 0..3)
sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels

ScrollerLoop: 
  WaitNMI() // Wait For Vertical Blank

  lda.b BG1ScrPosY
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Lo Byte
  lda.b BG1ScrPosY + 1
  sta.w REG_BG1VOFS // $210E: BG1 Position Y Hi Byte

  lda.b Mode7PosY
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Lo Byte
  lda.b Mode7PosY + 1
  sta.w REG_M7Y // $2120: Mode7 Center Position Y Hi Byte

  ldx.b BG1ScrPosY // Increment BG1 Y Pos
  inx
  stx.b BG1ScrPosY

  ldx.b Mode7PosY // Increment Mode7 Y Pos
  inx
  stx.b Mode7PosY

  cpx.w #$600 // IF (Mode7Pos != $600) Loop Scroller
  bne ScrollerLoop

FadeOUT() // Screen Fade Out

lda.b #$80
sta.w REG_INIDISP // $80: Turn Off Screen, Zero Brightness ($2100)

jmp Start // Loop Demo

M7IntensityHDMATable:
  db 32, %11111111 // Repeat 32 Scanlines, RGB Intensity 31
  db 1, %11111110 // Repeat 1 Scanlines, RGB Intensity 30
  db 1, %11111101 // Repeat 1 Scanlines, RGB Intensity 29
  db 1, %11111100 // Repeat 1 Scanlines, RGB Intensity 28
  db 1, %11111011 // Repeat 1 Scanlines, RGB Intensity 27
  db 1, %11111010 // Repeat 1 Scanlines, RGB Intensity 26
  db 1, %11111001 // Repeat 1 Scanlines, RGB Intensity 25
  db 1, %11111000 // Repeat 1 Scanlines, RGB Intensity 24
  db 1, %11110111 // Repeat 1 Scanlines, RGB Intensity 23
  db 1, %11110110 // Repeat 1 Scanlines, RGB Intensity 22
  db 1, %11110101 // Repeat 1 Scanlines, RGB Intensity 21
  db 1, %11110100 // Repeat 1 Scanlines, RGB Intensity 20
  db 1, %11110011 // Repeat 1 Scanlines, RGB Intensity 19
  db 1, %11110010 // Repeat 1 Scanlines, RGB Intensity 18
  db 1, %11110001 // Repeat 1 Scanlines, RGB Intensity 17
  db 2, %11110000 // Repeat 2 Scanlines, RGB Intensity 16
  db 2, %11101111 // Repeat 2 Scanlines, RGB Intensity 15
  db 2, %11101110 // Repeat 2 Scanlines, RGB Intensity 14
  db 2, %11101101 // Repeat 2 Scanlines, RGB Intensity 13
  db 2, %11101100 // Repeat 2 Scanlines, RGB Intensity 12
  db 2, %11101011 // Repeat 2 Scanlines, RGB Intensity 11
  db 2, %11101010 // Repeat 2 Scanlines, RGB Intensity 10
  db 2, %11101001 // Repeat 2 Scanlines, RGB Intensity 9
  db 2, %11101000 // Repeat 2 Scanlines, RGB Intensity 8
  db 2, %11100111 // Repeat 2 Scanlines, RGB Intensity 7
  db 2, %11100110 // Repeat 2 Scanlines, RGB Intensity 6
  db 2, %11100101 // Repeat 2 Scanlines, RGB Intensity 5
  db 2, %11100100 // Repeat 2 Scanlines, RGB Intensity 4
  db 2, %11100011 // Repeat 2 Scanlines, RGB Intensity 3
  db 2, %11100010 // Repeat 2 Scanlines, RGB Intensity 2
  db 2, %11100001 // Repeat 2 Scanlines, RGB Intensity 1
  db 1, %00000000 // Repeat 1 Scanlines, RGB Intensity 0
  db 0 // End Of HDMA

M7COSHDMATable: // Mode7 +COS (A & D) Table 224 * Rotation / Scaling Ratios (Last 8-Bits Fractional)
db $01; dw 40960 // Repeat 1 Scanline, Mode7 +COS Scanline 1
db $01; dw 20480 // Repeat 1 Scanline, Mode7 +COS Scanline 2
db $01; dw 13653 // Repeat 1 Scanline, Mode7 +COS Scanline 3
db $01; dw 10240 // Repeat 1 Scanline, Mode7 +COS Scanline 4
db $01; dw 8192 // Repeat 1 Scanline, Mode7 +COS Scanline 5
db $01; dw 6827 // Repeat 1 Scanline, Mode7 +COS Scanline 6
db $01; dw 5851 // Repeat 1 Scanline, Mode7 +COS Scanline 7
db $01; dw 5120 // Repeat 1 Scanline, Mode7 +COS Scanline 8
db $01; dw 4551 // Repeat 1 Scanline, Mode7 +COS Scanline 9
db $01; dw 4096 // Repeat 1 Scanline, Mode7 +COS Scanline 10
db $01; dw 3724 // Repeat 1 Scanline, Mode7 +COS Scanline 11
db $01; dw 3413 // Repeat 1 Scanline, Mode7 +COS Scanline 12
db $01; dw 3151 // Repeat 1 Scanline, Mode7 +COS Scanline 13
db $01; dw 2926 // Repeat 1 Scanline, Mode7 +COS Scanline 14
db $01; dw 2731 // Repeat 1 Scanline, Mode7 +COS Scanline 15
db $01; dw 2560 // Repeat 1 Scanline, Mode7 +COS Scanline 16
db $01; dw 2409 // Repeat 1 Scanline, Mode7 +COS Scanline 17
db $01; dw 2276 // Repeat 1 Scanline, Mode7 +COS Scanline 18
db $01; dw 2156 // Repeat 1 Scanline, Mode7 +COS Scanline 19
db $01; dw 2048 // Repeat 1 Scanline, Mode7 +COS Scanline 20
db $01; dw 1950 // Repeat 1 Scanline, Mode7 +COS Scanline 21
db $01; dw 1862 // Repeat 1 Scanline, Mode7 +COS Scanline 22
db $01; dw 1781 // Repeat 1 Scanline, Mode7 +COS Scanline 23
db $01; dw 1707 // Repeat 1 Scanline, Mode7 +COS Scanline 24
db $01; dw 1638 // Repeat 1 Scanline, Mode7 +COS Scanline 25
db $01; dw 1575 // Repeat 1 Scanline, Mode7 +COS Scanline 26
db $01; dw 1517 // Repeat 1 Scanline, Mode7 +COS Scanline 27
db $01; dw 1463 // Repeat 1 Scanline, Mode7 +COS Scanline 28
db $01; dw 1412 // Repeat 1 Scanline, Mode7 +COS Scanline 29
db $01; dw 1365 // Repeat 1 Scanline, Mode7 +COS Scanline 30
db $01; dw 1321 // Repeat 1 Scanline, Mode7 +COS Scanline 31
db $01; dw 1280 // Repeat 1 Scanline, Mode7 +COS Scanline 32
db $01; dw 1241 // Repeat 1 Scanline, Mode7 +COS Scanline 33
db $01; dw 1205 // Repeat 1 Scanline, Mode7 +COS Scanline 34
db $01; dw 1170 // Repeat 1 Scanline, Mode7 +COS Scanline 35
db $01; dw 1138 // Repeat 1 Scanline, Mode7 +COS Scanline 36
db $01; dw 1107 // Repeat 1 Scanline, Mode7 +COS Scanline 37
db $01; dw 1078 // Repeat 1 Scanline, Mode7 +COS Scanline 38
db $01; dw 1050 // Repeat 1 Scanline, Mode7 +COS Scanline 39
db $01; dw 1024 // Repeat 1 Scanline, Mode7 +COS Scanline 40
db $01; dw 999 // Repeat 1 Scanline, Mode7 +COS Scanline 41
db $01; dw 975 // Repeat 1 Scanline, Mode7 +COS Scanline 42
db $01; dw 953 // Repeat 1 Scanline, Mode7 +COS Scanline 43
db $01; dw 931 // Repeat 1 Scanline, Mode7 +COS Scanline 44
db $01; dw 910 // Repeat 1 Scanline, Mode7 +COS Scanline 45
db $01; dw 890 // Repeat 1 Scanline, Mode7 +COS Scanline 46
db $01; dw 871 // Repeat 1 Scanline, Mode7 +COS Scanline 47
db $01; dw 853 // Repeat 1 Scanline, Mode7 +COS Scanline 48
db $01; dw 836 // Repeat 1 Scanline, Mode7 +COS Scanline 49
db $01; dw 819 // Repeat 1 Scanline, Mode7 +COS Scanline 50
db $01; dw 803 // Repeat 1 Scanline, Mode7 +COS Scanline 51
db $01; dw 788 // Repeat 1 Scanline, Mode7 +COS Scanline 52
db $01; dw 773 // Repeat 1 Scanline, Mode7 +COS Scanline 53
db $01; dw 759 // Repeat 1 Scanline, Mode7 +COS Scanline 54
db $01; dw 745 // Repeat 1 Scanline, Mode7 +COS Scanline 55
db $01; dw 731 // Repeat 1 Scanline, Mode7 +COS Scanline 56
db $01; dw 719 // Repeat 1 Scanline, Mode7 +COS Scanline 57
db $01; dw 706 // Repeat 1 Scanline, Mode7 +COS Scanline 58
db $01; dw 694 // Repeat 1 Scanline, Mode7 +COS Scanline 59
db $01; dw 683 // Repeat 1 Scanline, Mode7 +COS Scanline 60
db $01; dw 671 // Repeat 1 Scanline, Mode7 +COS Scanline 61
db $01; dw 661 // Repeat 1 Scanline, Mode7 +COS Scanline 62
db $01; dw 650 // Repeat 1 Scanline, Mode7 +COS Scanline 63
db $01; dw 640 // Repeat 1 Scanline, Mode7 +COS Scanline 64
db $01; dw 630 // Repeat 1 Scanline, Mode7 +COS Scanline 65
db $01; dw 621 // Repeat 1 Scanline, Mode7 +COS Scanline 66
db $01; dw 611 // Repeat 1 Scanline, Mode7 +COS Scanline 67
db $01; dw 602 // Repeat 1 Scanline, Mode7 +COS Scanline 68
db $01; dw 594 // Repeat 1 Scanline, Mode7 +COS Scanline 69
db $01; dw 585 // Repeat 1 Scanline, Mode7 +COS Scanline 70
db $01; dw 577 // Repeat 1 Scanline, Mode7 +COS Scanline 71
db $01; dw 569 // Repeat 1 Scanline, Mode7 +COS Scanline 72
db $01; dw 561 // Repeat 1 Scanline, Mode7 +COS Scanline 73
db $01; dw 554 // Repeat 1 Scanline, Mode7 +COS Scanline 74
db $01; dw 546 // Repeat 1 Scanline, Mode7 +COS Scanline 75
db $01; dw 539 // Repeat 1 Scanline, Mode7 +COS Scanline 76
db $01; dw 532 // Repeat 1 Scanline, Mode7 +COS Scanline 77
db $01; dw 525 // Repeat 1 Scanline, Mode7 +COS Scanline 78
db $01; dw 518 // Repeat 1 Scanline, Mode7 +COS Scanline 79
db $01; dw 512 // Repeat 1 Scanline, Mode7 +COS Scanline 80
db $01; dw 506 // Repeat 1 Scanline, Mode7 +COS Scanline 81
db $01; dw 500 // Repeat 1 Scanline, Mode7 +COS Scanline 82
db $01; dw 493 // Repeat 1 Scanline, Mode7 +COS Scanline 83
db $01; dw 488 // Repeat 1 Scanline, Mode7 +COS Scanline 84
db $01; dw 482 // Repeat 1 Scanline, Mode7 +COS Scanline 85
db $01; dw 476 // Repeat 1 Scanline, Mode7 +COS Scanline 86
db $01; dw 471 // Repeat 1 Scanline, Mode7 +COS Scanline 87
db $01; dw 465 // Repeat 1 Scanline, Mode7 +COS Scanline 88
db $01; dw 460 // Repeat 1 Scanline, Mode7 +COS Scanline 89
db $01; dw 455 // Repeat 1 Scanline, Mode7 +COS Scanline 90
db $01; dw 450 // Repeat 1 Scanline, Mode7 +COS Scanline 91
db $01; dw 445 // Repeat 1 Scanline, Mode7 +COS Scanline 92
db $01; dw 440 // Repeat 1 Scanline, Mode7 +COS Scanline 93
db $01; dw 436 // Repeat 1 Scanline, Mode7 +COS Scanline 94
db $01; dw 431 // Repeat 1 Scanline, Mode7 +COS Scanline 95
db $01; dw 427 // Repeat 1 Scanline, Mode7 +COS Scanline 96
db $01; dw 422 // Repeat 1 Scanline, Mode7 +COS Scanline 97
db $01; dw 418 // Repeat 1 Scanline, Mode7 +COS Scanline 98
db $01; dw 414 // Repeat 1 Scanline, Mode7 +COS Scanline 99
db $01; dw 410 // Repeat 1 Scanline, Mode7 +COS Scanline 100
db $01; dw 406 // Repeat 1 Scanline, Mode7 +COS Scanline 101
db $01; dw 402 // Repeat 1 Scanline, Mode7 +COS Scanline 102
db $01; dw 398 // Repeat 1 Scanline, Mode7 +COS Scanline 103
db $01; dw 394 // Repeat 1 Scanline, Mode7 +COS Scanline 104
db $01; dw 390 // Repeat 1 Scanline, Mode7 +COS Scanline 105
db $01; dw 386 // Repeat 1 Scanline, Mode7 +COS Scanline 106
db $01; dw 383 // Repeat 1 Scanline, Mode7 +COS Scanline 107
db $01; dw 379 // Repeat 1 Scanline, Mode7 +COS Scanline 108
db $01; dw 376 // Repeat 1 Scanline, Mode7 +COS Scanline 109
db $01; dw 372 // Repeat 1 Scanline, Mode7 +COS Scanline 110
db $01; dw 369 // Repeat 1 Scanline, Mode7 +COS Scanline 111
db $01; dw 366 // Repeat 1 Scanline, Mode7 +COS Scanline 112
db $01; dw 362 // Repeat 1 Scanline, Mode7 +COS Scanline 113
db $01; dw 359 // Repeat 1 Scanline, Mode7 +COS Scanline 114
db $01; dw 356 // Repeat 1 Scanline, Mode7 +COS Scanline 115
db $01; dw 353 // Repeat 1 Scanline, Mode7 +COS Scanline 116
db $01; dw 350 // Repeat 1 Scanline, Mode7 +COS Scanline 117
db $01; dw 347 // Repeat 1 Scanline, Mode7 +COS Scanline 118
db $01; dw 344 // Repeat 1 Scanline, Mode7 +COS Scanline 119
db $01; dw 341 // Repeat 1 Scanline, Mode7 +COS Scanline 120
db $01; dw 339 // Repeat 1 Scanline, Mode7 +COS Scanline 121
db $01; dw 336 // Repeat 1 Scanline, Mode7 +COS Scanline 122
db $01; dw 333 // Repeat 1 Scanline, Mode7 +COS Scanline 123
db $01; dw 330 // Repeat 1 Scanline, Mode7 +COS Scanline 124
db $01; dw 328 // Repeat 1 Scanline, Mode7 +COS Scanline 125
db $01; dw 325 // Repeat 1 Scanline, Mode7 +COS Scanline 126
db $01; dw 323 // Repeat 1 Scanline, Mode7 +COS Scanline 127
db $01; dw 320 // Repeat 1 Scanline, Mode7 +COS Scanline 128
db $01; dw 318 // Repeat 1 Scanline, Mode7 +COS Scanline 129
db $01; dw 315 // Repeat 1 Scanline, Mode7 +COS Scanline 130
db $01; dw 313 // Repeat 1 Scanline, Mode7 +COS Scanline 131
db $01; dw 310 // Repeat 1 Scanline, Mode7 +COS Scanline 132
db $01; dw 308 // Repeat 1 Scanline, Mode7 +COS Scanline 133
db $01; dw 306 // Repeat 1 Scanline, Mode7 +COS Scanline 134
db $01; dw 303 // Repeat 1 Scanline, Mode7 +COS Scanline 135
db $01; dw 301 // Repeat 1 Scanline, Mode7 +COS Scanline 136
db $01; dw 299 // Repeat 1 Scanline, Mode7 +COS Scanline 137
db $01; dw 297 // Repeat 1 Scanline, Mode7 +COS Scanline 138
db $01; dw 295 // Repeat 1 Scanline, Mode7 +COS Scanline 139
db $01; dw 293 // Repeat 1 Scanline, Mode7 +COS Scanline 140
db $01; dw 290 // Repeat 1 Scanline, Mode7 +COS Scanline 141
db $01; dw 288 // Repeat 1 Scanline, Mode7 +COS Scanline 142
db $01; dw 286 // Repeat 1 Scanline, Mode7 +COS Scanline 143
db $01; dw 284 // Repeat 1 Scanline, Mode7 +COS Scanline 144
db $01; dw 282 // Repeat 1 Scanline, Mode7 +COS Scanline 145
db $01; dw 281 // Repeat 1 Scanline, Mode7 +COS Scanline 146
db $01; dw 279 // Repeat 1 Scanline, Mode7 +COS Scanline 147
db $01; dw 277 // Repeat 1 Scanline, Mode7 +COS Scanline 148
db $01; dw 275 // Repeat 1 Scanline, Mode7 +COS Scanline 149
db $01; dw 273 // Repeat 1 Scanline, Mode7 +COS Scanline 150
db $01; dw 271 // Repeat 1 Scanline, Mode7 +COS Scanline 151
db $01; dw 269 // Repeat 1 Scanline, Mode7 +COS Scanline 152
db $01; dw 268 // Repeat 1 Scanline, Mode7 +COS Scanline 153
db $01; dw 266 // Repeat 1 Scanline, Mode7 +COS Scanline 154
db $01; dw 264 // Repeat 1 Scanline, Mode7 +COS Scanline 155
db $01; dw 263 // Repeat 1 Scanline, Mode7 +COS Scanline 156
db $01; dw 261 // Repeat 1 Scanline, Mode7 +COS Scanline 157
db $01; dw 259 // Repeat 1 Scanline, Mode7 +COS Scanline 158
db $01; dw 258 // Repeat 1 Scanline, Mode7 +COS Scanline 159
db $01; dw 256 // Repeat 1 Scanline, Mode7 +COS Scanline 160
db $01; dw 254 // Repeat 1 Scanline, Mode7 +COS Scanline 161
db $01; dw 253 // Repeat 1 Scanline, Mode7 +COS Scanline 162
db $01; dw 251 // Repeat 1 Scanline, Mode7 +COS Scanline 163
db $01; dw 250 // Repeat 1 Scanline, Mode7 +COS Scanline 164
db $01; dw 248 // Repeat 1 Scanline, Mode7 +COS Scanline 165
db $01; dw 247 // Repeat 1 Scanline, Mode7 +COS Scanline 166
db $01; dw 245 // Repeat 1 Scanline, Mode7 +COS Scanline 167
db $01; dw 244 // Repeat 1 Scanline, Mode7 +COS Scanline 168
db $01; dw 242 // Repeat 1 Scanline, Mode7 +COS Scanline 169
db $01; dw 241 // Repeat 1 Scanline, Mode7 +COS Scanline 170
db $01; dw 240 // Repeat 1 Scanline, Mode7 +COS Scanline 171
db $01; dw 238 // Repeat 1 Scanline, Mode7 +COS Scanline 172
db $01; dw 237 // Repeat 1 Scanline, Mode7 +COS Scanline 173
db $01; dw 235 // Repeat 1 Scanline, Mode7 +COS Scanline 174
db $01; dw 234 // Repeat 1 Scanline, Mode7 +COS Scanline 175
db $01; dw 233 // Repeat 1 Scanline, Mode7 +COS Scanline 176
db $01; dw 231 // Repeat 1 Scanline, Mode7 +COS Scanline 177
db $01; dw 230 // Repeat 1 Scanline, Mode7 +COS Scanline 178
db $01; dw 229 // Repeat 1 Scanline, Mode7 +COS Scanline 179
db $01; dw 228 // Repeat 1 Scanline, Mode7 +COS Scanline 180
db $01; dw 226 // Repeat 1 Scanline, Mode7 +COS Scanline 181
db $01; dw 225 // Repeat 1 Scanline, Mode7 +COS Scanline 182
db $01; dw 224 // Repeat 1 Scanline, Mode7 +COS Scanline 183
db $01; dw 223 // Repeat 1 Scanline, Mode7 +COS Scanline 184
db $01; dw 221 // Repeat 1 Scanline, Mode7 +COS Scanline 185
db $01; dw 220 // Repeat 1 Scanline, Mode7 +COS Scanline 186
db $01; dw 219 // Repeat 1 Scanline, Mode7 +COS Scanline 187
db $01; dw 218 // Repeat 1 Scanline, Mode7 +COS Scanline 188
db $01; dw 217 // Repeat 1 Scanline, Mode7 +COS Scanline 189
db $01; dw 216 // Repeat 1 Scanline, Mode7 +COS Scanline 190
db $01; dw 214 // Repeat 1 Scanline, Mode7 +COS Scanline 191
db $01; dw 213 // Repeat 1 Scanline, Mode7 +COS Scanline 192
db $01; dw 212 // Repeat 1 Scanline, Mode7 +COS Scanline 193
db $01; dw 211 // Repeat 1 Scanline, Mode7 +COS Scanline 194
db $01; dw 210 // Repeat 1 Scanline, Mode7 +COS Scanline 195
db $01; dw 209 // Repeat 1 Scanline, Mode7 +COS Scanline 196
db $01; dw 208 // Repeat 1 Scanline, Mode7 +COS Scanline 197
db $01; dw 207 // Repeat 1 Scanline, Mode7 +COS Scanline 198
db $01; dw 206 // Repeat 1 Scanline, Mode7 +COS Scanline 199
db $01; dw 205 // Repeat 1 Scanline, Mode7 +COS Scanline 200
db $01; dw 204 // Repeat 1 Scanline, Mode7 +COS Scanline 201
db $01; dw 203 // Repeat 1 Scanline, Mode7 +COS Scanline 202
db $01; dw 202 // Repeat 1 Scanline, Mode7 +COS Scanline 203
db $01; dw 201 // Repeat 1 Scanline, Mode7 +COS Scanline 204
db $01; dw 200 // Repeat 1 Scanline, Mode7 +COS Scanline 205
db $01; dw 199 // Repeat 1 Scanline, Mode7 +COS Scanline 206
db $01; dw 198 // Repeat 1 Scanline, Mode7 +COS Scanline 207
db $01; dw 197 // Repeat 1 Scanline, Mode7 +COS Scanline 208
db $01; dw 196 // Repeat 1 Scanline, Mode7 +COS Scanline 209
db $01; dw 195 // Repeat 1 Scanline, Mode7 +COS Scanline 210
db $01; dw 194 // Repeat 1 Scanline, Mode7 +COS Scanline 211
db $01; dw 193 // Repeat 1 Scanline, Mode7 +COS Scanline 212
db $01; dw 192 // Repeat 1 Scanline, Mode7 +COS Scanline 213
db $01; dw 191 // Repeat 1 Scanline, Mode7 +COS Scanline 214
db $01; dw 191 // Repeat 1 Scanline, Mode7 +COS Scanline 215
db $01; dw 190 // Repeat 1 Scanline, Mode7 +COS Scanline 216
db $01; dw 189 // Repeat 1 Scanline, Mode7 +COS Scanline 217
db $01; dw 188 // Repeat 1 Scanline, Mode7 +COS Scanline 218
db $01; dw 187 // Repeat 1 Scanline, Mode7 +COS Scanline 219
db $01; dw 186 // Repeat 1 Scanline, Mode7 +COS Scanline 220
db $01; dw 185 // Repeat 1 Scanline, Mode7 +COS Scanline 221
db $01; dw 185 // Repeat 1 Scanline, Mode7 +COS Scanline 222
db $01; dw 184 // Repeat 1 Scanline, Mode7 +COS Scanline 223
db $01; dw 183 // Repeat 1 Scanline, Mode7 +COS Scanline 224
db $00 // End Of HDMA