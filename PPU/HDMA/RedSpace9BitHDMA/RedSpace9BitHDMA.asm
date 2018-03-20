// SNES Red Space 9-Bit HDMA Demo by krom (Peter Lemon):
// Uses Brightness Register For Extra Color Space (9-Bit)
arch snes.cpu
output "RedSpace9BitHDMA.sfc", create

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

seek($8000); fill $8000 // Fill Upto $7FFF (Bank 0) With Zero Bytes
include "LIB/SNES.INC"        // Include SNES Definitions
include "LIB/SNES_HEADER.ASM" // Include Header & Vector Table

seek($8000); Start:
  SNES_INIT(SLOWROM) // Run SNES Initialisation Routine

  // Load Red HDMA Gradient Backround Palette Color With DMA Channel 0
  lda.b #%00000011 // HMDA: Write 4 Bytes Each Scanline, Repeat A/B-bus Address Twice
  sta.w REG_DMAP0  // $4300: DMA0 DMA/HDMA Parameters
  lda.b #REG_CGADD // $21: Start At Palette CGRAM Address ($2121)
  sta.w REG_BBAD0  // $4301: DMA0 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #COLHDMATable // HMDA Table Address
  stx.w REG_A1T0L  // $4302: DMA0 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
  sta.w REG_A1B0   // $4304: DMA0 DMA/HDMA Table Start Address (Bank)

  // Load HDMA Screen Display Brightness With DMA Channel 1
  lda.b #%00000000 // HMDA: Write 1 Byte Each Scanline
  sta.w REG_DMAP1  // $4310: DMA1 DMA/HDMA Parameters
  lda.b #REG_INIDISP // $00: Start At Display Control 1 ($2100)
  sta.w REG_BBAD1  // $4311: DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)
  ldx.w #BRIHDMATable // HMDA Table Address
  stx.w REG_A1T1L  // $4312: DMA1 DMA/HDMA Table Start Address
  lda.b #0         // HDMA Table Bank
  sta.w REG_A1B1   // $4314: DMA1 DMA/HDMA Table Start Address (Bank)

  lda.b #%00000011 // HDMA Channel Select (Channel 0 & 1)
  sta.w REG_HDMAEN // $420C: Select H-Blank DMA (H-DMA) Channels 

  stz.w REG_TM // $212C: Main Screen Designation

Loop:
  jmp Loop

COLHDMATable:
  db $01; dw $0000, $001F // Repeat 1 Scanline, Palette Address 0, Gradient Color 0
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 1
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 2
  db $01; dw $0000, $001D // Repeat 1 Scanline, Palette Address 0, Gradient Color 3
  db $01; dw $0000, $001B // Repeat 1 Scanline, Palette Address 0, Gradient Color 4
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 5
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 6
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 7
  db $01; dw $0000, $001B // Repeat 1 Scanline, Palette Address 0, Gradient Color 8
  db $01; dw $0000, $0019 // Repeat 1 Scanline, Palette Address 0, Gradient Color 9
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 10
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 11
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 12
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 13
  db $01; dw $0000, $001B // Repeat 1 Scanline, Palette Address 0, Gradient Color 14
  db $01; dw $0000, $0019 // Repeat 1 Scanline, Palette Address 0, Gradient Color 15
  db $01; dw $0000, $0017 // Repeat 1 Scanline, Palette Address 0, Gradient Color 16
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 17
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 18
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 19
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 20
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 21
  db $01; dw $0000, $0019 // Repeat 1 Scanline, Palette Address 0, Gradient Color 22
  db $01; dw $0000, $0017 // Repeat 1 Scanline, Palette Address 0, Gradient Color 23
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 24
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 25
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 26
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 27
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 28
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 29
  db $01; dw $0000, $0019 // Repeat 1 Scanline, Palette Address 0, Gradient Color 30
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 31
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 32
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 33
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 34
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 35
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 36
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 37
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 38
  db $01; dw $0000, $0017 // Repeat 1 Scanline, Palette Address 0, Gradient Color 39
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 40
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 41
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 42
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 43
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 44
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 45
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 46
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 47
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 48
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 49
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 50
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 51
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 52
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 53
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 54
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 55
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 56
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 57
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 58
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 59
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 60
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 61
  db $01; dw $0000, $000F // Repeat 1 Scanline, Palette Address 0, Gradient Color 62
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 63
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 64
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 65
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 66
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 67
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 68
  db $01; dw $0000, $001A // Repeat 1 Scanline, Palette Address 0, Gradient Color 69
  db $01; dw $0000, $0015 // Repeat 1 Scanline, Palette Address 0, Gradient Color 70
  db $01; dw $0000, $000E // Repeat 1 Scanline, Palette Address 0, Gradient Color 71
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 72
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 73
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 74
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 75
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 76
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 77
  db $01; dw $0000, $000E // Repeat 1 Scanline, Palette Address 0, Gradient Color 78
  db $01; dw $0000, $000D // Repeat 1 Scanline, Palette Address 0, Gradient Color 79
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 80
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 81
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 82
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 83
  db $01; dw $0000, $000D // Repeat 1 Scanline, Palette Address 0, Gradient Color 84
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 85
  db $01; dw $0000, $000C // Repeat 1 Scanline, Palette Address 0, Gradient Color 86
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 87
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 88
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 89
  db $01; dw $0000, $0013 // Repeat 1 Scanline, Palette Address 0, Gradient Color 90
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 91
  db $01; dw $0000, $000D // Repeat 1 Scanline, Palette Address 0, Gradient Color 92
  db $01; dw $0000, $000C // Repeat 1 Scanline, Palette Address 0, Gradient Color 93
  db $01; dw $0000, $000B // Repeat 1 Scanline, Palette Address 0, Gradient Color 94
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 95
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 96
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 97
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 98
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 99
  db $01; dw $0000, $000C // Repeat 1 Scanline, Palette Address 0, Gradient Color 100
  db $01; dw $0000, $000B // Repeat 1 Scanline, Palette Address 0, Gradient Color 101
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 102
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 103
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 104
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 105
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 106
  db $01; dw $0000, $000C // Repeat 1 Scanline, Palette Address 0, Gradient Color 107
  db $01; dw $0000, $000B // Repeat 1 Scanline, Palette Address 0, Gradient Color 108
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 109
  db $01; dw $0000, $0011 // Repeat 1 Scanline, Palette Address 0, Gradient Color 110
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 111
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 112
  db $01; dw $0000, $000B // Repeat 1 Scanline, Palette Address 0, Gradient Color 113
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 114
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 115
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 116
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 117
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 118
  db $01; dw $0000, $0014 // Repeat 1 Scanline, Palette Address 0, Gradient Color 119
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 120
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 121
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 122
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 123
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 124
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 125
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 126
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 127
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 128
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 129
  db $01; dw $0000, $0007 // Repeat 1 Scanline, Palette Address 0, Gradient Color 130
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 131
  db $01; dw $0000, $0018 // Repeat 1 Scanline, Palette Address 0, Gradient Color 132
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 133
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 134
  db $01; dw $0000, $0007 // Repeat 1 Scanline, Palette Address 0, Gradient Color 135
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 136
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 137
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 138
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 139
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 140
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 141
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 142
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 143
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 144
  db $01; dw $0000, $0007 // Repeat 1 Scanline, Palette Address 0, Gradient Color 145
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 146
  db $01; dw $0000, $0009 // Repeat 1 Scanline, Palette Address 0, Gradient Color 147
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 148
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 149
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 150
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 151
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 152
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 153
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 154
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 155
  db $01; dw $0000, $0007 // Repeat 1 Scanline, Palette Address 0, Gradient Color 156
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 157
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 158
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 159
  db $01; dw $0000, $0008 // Repeat 1 Scanline, Palette Address 0, Gradient Color 160
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 161
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 162
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 163
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 164
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 165
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 166
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 167
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 168
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 169
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 170
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 171
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 172
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 173
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 174
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 175
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 176
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 177
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 178
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 179
  db $01; dw $0000, $0005 // Repeat 1 Scanline, Palette Address 0, Gradient Color 180
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 181
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 182
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 183
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 184
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 185
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 186
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 187
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 188
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 189
  db $01; dw $0000, $0003 // Repeat 1 Scanline, Palette Address 0, Gradient Color 190
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 191
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 192
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 193
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 194
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 195
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 196
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 197
  db $01; dw $0000, $001E // Repeat 1 Scanline, Palette Address 0, Gradient Color 198
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 199
  db $01; dw $0000, $001C // Repeat 1 Scanline, Palette Address 0, Gradient Color 200
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 201
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 202
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 203
  db $01; dw $0000, $0004 // Repeat 1 Scanline, Palette Address 0, Gradient Color 204
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 205
  db $01; dw $0000, $0016 // Repeat 1 Scanline, Palette Address 0, Gradient Color 206
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 207
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 208
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 209
  db $01; dw $0000, $0012 // Repeat 1 Scanline, Palette Address 0, Gradient Color 210
  db $01; dw $0000, $0001 // Repeat 1 Scanline, Palette Address 0, Gradient Color 211
  db $01; dw $0000, $0010 // Repeat 1 Scanline, Palette Address 0, Gradient Color 212
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 213
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 214
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 215
  db $01; dw $0000, $000C // Repeat 1 Scanline, Palette Address 0, Gradient Color 216
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 217
  db $01; dw $0000, $000A // Repeat 1 Scanline, Palette Address 0, Gradient Color 218
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 219
  db $01; dw $0000, $0002 // Repeat 1 Scanline, Palette Address 0, Gradient Color 220
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 221
  db $01; dw $0000, $0006 // Repeat 1 Scanline, Palette Address 0, Gradient Color 222
  db $01; dw $0000, $0000 // Repeat 1 Scanline, Palette Address 0, Gradient Color 223
  db $00 // End Of HDMA

BRIHDMATable:
  db $01, $F // Repeat 1 Scanline, Screen Brightness 0
  db $01, $E // Repeat 1 Scanline, Screen Brightness 1
  db $01, $F // Repeat 1 Scanline, Screen Brightness 2
  db $01, $E // Repeat 1 Scanline, Screen Brightness 3
  db $01, $F // Repeat 1 Scanline, Screen Brightness 4
  db $01, $E // Repeat 1 Scanline, Screen Brightness 5
  db $01, $D // Repeat 1 Scanline, Screen Brightness 6
  db $01, $F // Repeat 1 Scanline, Screen Brightness 7
  db $01, $E // Repeat 1 Scanline, Screen Brightness 8
  db $01, $F // Repeat 1 Scanline, Screen Brightness 9
  db $01, $D // Repeat 1 Scanline, Screen Brightness 10
  db $01, $E // Repeat 1 Scanline, Screen Brightness 11
  db $01, $C // Repeat 1 Scanline, Screen Brightness 12
  db $01, $F // Repeat 1 Scanline, Screen Brightness 13
  db $01, $D // Repeat 1 Scanline, Screen Brightness 14
  db $01, $E // Repeat 1 Scanline, Screen Brightness 15
  db $01, $F // Repeat 1 Scanline, Screen Brightness 16
  db $01, $D // Repeat 1 Scanline, Screen Brightness 17
  db $01, $C // Repeat 1 Scanline, Screen Brightness 18
  db $01, $E // Repeat 1 Scanline, Screen Brightness 19
  db $01, $B // Repeat 1 Scanline, Screen Brightness 20
  db $01, $F // Repeat 1 Scanline, Screen Brightness 21
  db $01, $D // Repeat 1 Scanline, Screen Brightness 22
  db $01, $E // Repeat 1 Scanline, Screen Brightness 23
  db $01, $F // Repeat 1 Scanline, Screen Brightness 24
  db $01, $C // Repeat 1 Scanline, Screen Brightness 25
  db $01, $D // Repeat 1 Scanline, Screen Brightness 26
  db $01, $B // Repeat 1 Scanline, Screen Brightness 27
  db $01, $E // Repeat 1 Scanline, Screen Brightness 28
  db $01, $A // Repeat 1 Scanline, Screen Brightness 29
  db $01, $C // Repeat 1 Scanline, Screen Brightness 30
  db $01, $F // Repeat 1 Scanline, Screen Brightness 31
  db $01, $E // Repeat 1 Scanline, Screen Brightness 32
  db $01, $C // Repeat 1 Scanline, Screen Brightness 33
  db $01, $B // Repeat 1 Scanline, Screen Brightness 34
  db $01, $D // Repeat 1 Scanline, Screen Brightness 35
  db $01, $F // Repeat 1 Scanline, Screen Brightness 36
  db $01, $A // Repeat 1 Scanline, Screen Brightness 37
  db $01, $E // Repeat 1 Scanline, Screen Brightness 38
  db $01, $C // Repeat 1 Scanline, Screen Brightness 39
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 40
  db $01, $D // Repeat 1 Scanline, Screen Brightness 41
  db $01, $F // Repeat 1 Scanline, Screen Brightness 42
  db $01, $E // Repeat 1 Scanline, Screen Brightness 43
  db $01, $C // Repeat 1 Scanline, Screen Brightness 44
  db $01, $A // Repeat 1 Scanline, Screen Brightness 45
  db $01, $D // Repeat 1 Scanline, Screen Brightness 46
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 47
  db $01, $F // Repeat 1 Scanline, Screen Brightness 48
  db $01, $C // Repeat 1 Scanline, Screen Brightness 49
  db $01, $E // Repeat 1 Scanline, Screen Brightness 50
  db $01, $D // Repeat 1 Scanline, Screen Brightness 51
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 52
  db $01, $B // Repeat 1 Scanline, Screen Brightness 53
  db $01, $A // Repeat 1 Scanline, Screen Brightness 54
  db $01, $C // Repeat 1 Scanline, Screen Brightness 55
  db $01, $F // Repeat 1 Scanline, Screen Brightness 56
  db $01, $E // Repeat 1 Scanline, Screen Brightness 57
  db $01, $D // Repeat 1 Scanline, Screen Brightness 58
  db $01, $B // Repeat 1 Scanline, Screen Brightness 59
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 60
  db $01, $C // Repeat 1 Scanline, Screen Brightness 61
  db $01, $F // Repeat 1 Scanline, Screen Brightness 62
  db $01, $E // Repeat 1 Scanline, Screen Brightness 63
  db $01, $A // Repeat 1 Scanline, Screen Brightness 64
  db $01, $D // Repeat 1 Scanline, Screen Brightness 65
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 66
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 67
  db $01, $C // Repeat 1 Scanline, Screen Brightness 68
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 69
  db $01, $A // Repeat 1 Scanline, Screen Brightness 70
  db $01, $F // Repeat 1 Scanline, Screen Brightness 71
  db $01, $D // Repeat 1 Scanline, Screen Brightness 72
  db $01, $C // Repeat 1 Scanline, Screen Brightness 73
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 74
  db $01, $A // Repeat 1 Scanline, Screen Brightness 75
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 76
  db $01, $B // Repeat 1 Scanline, Screen Brightness 77
  db $01, $E // Repeat 1 Scanline, Screen Brightness 78
  db $01, $F // Repeat 1 Scanline, Screen Brightness 79
  db $01, $C // Repeat 1 Scanline, Screen Brightness 80
  db $01, $A // Repeat 1 Scanline, Screen Brightness 81
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 82
  db $01, $B // Repeat 1 Scanline, Screen Brightness 83
  db $01, $E // Repeat 1 Scanline, Screen Brightness 84
  db $01, $A // Repeat 1 Scanline, Screen Brightness 85
  db $01, $F // Repeat 1 Scanline, Screen Brightness 86
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 87
  db $01, $B // Repeat 1 Scanline, Screen Brightness 88
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 89
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 90
  db $01, $A // Repeat 1 Scanline, Screen Brightness 91
  db $01, $D // Repeat 1 Scanline, Screen Brightness 92
  db $01, $E // Repeat 1 Scanline, Screen Brightness 93
  db $01, $F // Repeat 1 Scanline, Screen Brightness 94
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 95
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 96
  db $01, $A // Repeat 1 Scanline, Screen Brightness 97
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 98
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 99
  db $01, $D // Repeat 1 Scanline, Screen Brightness 100
  db $01, $E // Repeat 1 Scanline, Screen Brightness 101
  db $01, $F // Repeat 1 Scanline, Screen Brightness 102
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 103
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 104
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 105
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 106
  db $01, $C // Repeat 1 Scanline, Screen Brightness 107
  db $01, $D // Repeat 1 Scanline, Screen Brightness 108
  db $01, $E // Repeat 1 Scanline, Screen Brightness 109
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 110
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 111
  db $01, $F // Repeat 1 Scanline, Screen Brightness 112
  db $01, $C // Repeat 1 Scanline, Screen Brightness 113
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 114
  db $01, $D // Repeat 1 Scanline, Screen Brightness 115
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 116
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 117
  db $01, $E // Repeat 1 Scanline, Screen Brightness 118
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 119
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 120
  db $01, $F // Repeat 1 Scanline, Screen Brightness 121
  db $01, $C // Repeat 1 Scanline, Screen Brightness 122
  db $01, $D // Repeat 1 Scanline, Screen Brightness 123
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 124
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 125
  db $01, $E // Repeat 1 Scanline, Screen Brightness 126
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 127
  db $01, $B // Repeat 1 Scanline, Screen Brightness 128
  db $01, $C // Repeat 1 Scanline, Screen Brightness 129
  db $01, $F // Repeat 1 Scanline, Screen Brightness 130
  db $01, $D // Repeat 1 Scanline, Screen Brightness 131
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 132
  db $01, $3 // Repeat 1 Scanline, Screen Brightness 133
  db $01, $A // Repeat 1 Scanline, Screen Brightness 134
  db $01, $E // Repeat 1 Scanline, Screen Brightness 135
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 136
  db $01, $C // Repeat 1 Scanline, Screen Brightness 137
  db $01, $3 // Repeat 1 Scanline, Screen Brightness 138
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 139
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 140
  db $01, $F // Repeat 1 Scanline, Screen Brightness 141
  db $01, $A // Repeat 1 Scanline, Screen Brightness 142
  db $01, $B // Repeat 1 Scanline, Screen Brightness 143
  db $01, $E // Repeat 1 Scanline, Screen Brightness 144
  db $01, $C // Repeat 1 Scanline, Screen Brightness 145
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 146
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 147
  db $01, $A // Repeat 1 Scanline, Screen Brightness 148
  db $01, $D // Repeat 1 Scanline, Screen Brightness 149
  db $01, $F // Repeat 1 Scanline, Screen Brightness 150
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 151
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 152
  db $01, $3 // Repeat 1 Scanline, Screen Brightness 153
  db $01, $C // Repeat 1 Scanline, Screen Brightness 154
  db $01, $E // Repeat 1 Scanline, Screen Brightness 155
  db $01, $A // Repeat 1 Scanline, Screen Brightness 156
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 157
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 158
  db $01, $D // Repeat 1 Scanline, Screen Brightness 159
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 160
  db $01, $F // Repeat 1 Scanline, Screen Brightness 161
  db $01, $C // Repeat 1 Scanline, Screen Brightness 162
  db $01, $A // Repeat 1 Scanline, Screen Brightness 163
  db $01, $3 // Repeat 1 Scanline, Screen Brightness 164
  db $01, $E // Repeat 1 Scanline, Screen Brightness 165
  db $01, $B // Repeat 1 Scanline, Screen Brightness 166
  db $01, $D // Repeat 1 Scanline, Screen Brightness 167
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 168
  db $01, $3 // Repeat 1 Scanline, Screen Brightness 169
  db $01, $A // Repeat 1 Scanline, Screen Brightness 170
  db $01, $C // Repeat 1 Scanline, Screen Brightness 171
  db $01, $F // Repeat 1 Scanline, Screen Brightness 172
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 173
  db $01, $1 // Repeat 1 Scanline, Screen Brightness 174
  db $01, $E // Repeat 1 Scanline, Screen Brightness 175
  db $01, $1 // Repeat 1 Scanline, Screen Brightness 176
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 177
  db $01, $D // Repeat 1 Scanline, Screen Brightness 178
  db $01, $A // Repeat 1 Scanline, Screen Brightness 179
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 180
  db $01, $C // Repeat 1 Scanline, Screen Brightness 181
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 182
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 183
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 184
  db $01, $F // Repeat 1 Scanline, Screen Brightness 185
  db $01, $1 // Repeat 1 Scanline, Screen Brightness 186
  db $01, $E // Repeat 1 Scanline, Screen Brightness 187
  db $01, $A // Repeat 1 Scanline, Screen Brightness 188
  db $01, $D // Repeat 1 Scanline, Screen Brightness 189
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 190
  db $01, $C // Repeat 1 Scanline, Screen Brightness 191
  db $01, $1 // Repeat 1 Scanline, Screen Brightness 192
  db $01, $B // Repeat 1 Scanline, Screen Brightness 193
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 194
  db $01, $1 // Repeat 1 Scanline, Screen Brightness 195
  db $01, $A // Repeat 1 Scanline, Screen Brightness 196
  db $01, $F // Repeat 1 Scanline, Screen Brightness 197
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 198
  db $01, $E // Repeat 1 Scanline, Screen Brightness 199
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 200
  db $01, $D // Repeat 1 Scanline, Screen Brightness 201
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 202
  db $01, $C // Repeat 1 Scanline, Screen Brightness 203
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 204
  db $01, $B // Repeat 1 Scanline, Screen Brightness 205
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 206
  db $01, $A // Repeat 1 Scanline, Screen Brightness 207
  db $01, $6 // Repeat 1 Scanline, Screen Brightness 208
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 209
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 210
  db $01, $8 // Repeat 1 Scanline, Screen Brightness 211
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 212
  db $01, $F // Repeat 1 Scanline, Screen Brightness 213
  db $01, $4 // Repeat 1 Scanline, Screen Brightness 214
  db $01, $D // Repeat 1 Scanline, Screen Brightness 215
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 216
  db $01, $B // Repeat 1 Scanline, Screen Brightness 217
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 218
  db $01, $9 // Repeat 1 Scanline, Screen Brightness 219
  db $01, $2 // Repeat 1 Scanline, Screen Brightness 220
  db $01, $7 // Repeat 1 Scanline, Screen Brightness 221
  db $01, $0 // Repeat 1 Scanline, Screen Brightness 222
  db $01, $5 // Repeat 1 Scanline, Screen Brightness 223
  db $00 // End Of HDMA