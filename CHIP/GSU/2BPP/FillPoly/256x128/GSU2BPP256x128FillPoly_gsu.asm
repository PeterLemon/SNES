// SNES GSU 2BPP 256x128 Fill Poly Demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  sub r0 // R0 = 0
  cmode // Set Color Mode

  // Fill Screen With Clear Color
  sub r0 // R0 = 0 (Fill Value)
  iwt r3, #$0000 // R3 = Screen Base (SRAM Destination)
  iwt r12, #(256*128)/8 // R12 = Loop Count
  move r13, r15 // R13 = Loop Address
  // Loop:
    stw (r3) // Store Fill Value Word To Screen Base
    inc r3 // Screen Base++
    loop // IF (Loop Count != 0) Loop
    inc r3 // Screen Base++ (Delay Slot)

  // Copy Scan Left/Right Data To RAM
  iwt r14, #ScanLeft // R14 = ROM Address
  iwt r3, #(256*128)/4 // R3 = SRAM Destination
  iwt r12, #(128*2)*2 // R12 = Loop Count
  move r13, r15 // R13 = Loop Address
  // Loop:
    getbl // R0 = ROM Byte Lo
    inc r14 // R14++
    getbh // R0 = ROM Byte Lo/Hi (ROM Word)
    inc r14 // R14++
    stw (r3) // Store R0 To RAM
    inc r3 // R3++
    loop // IF (Loop Count != 0) Loop
    inc r3 // R3++ (Delay Slot)

  // Fill Poly
  ibt r0, #1 // R0 = Color #1
  color // Set Value In COLOR
  iwt r3, #((256*128)/4)+64 // R3 = Scan Left RAM Address + Poly Top Scanline
  iwt r4, #((256*128)/4)+256+64 // R4 = Scan Right RAM Address + Poly Top Scanline
  ibt r2, #32 // R2 = Plot Y Position
  ibt r5, #63 // R5 = Fill Y Count (Poly Bottom Scanline - Poly Top Scanline)

  LoopFill:
    ldw (r3) // R0 = Scan Left Word
    move r1, r0 // R1 = Plot X Position
    ldw (r4) // R0 = Scan Right Word
    sub r1 // R0 = Fill Length
    move r12, r0 // R12 = Loop Count
    inc r12 // R12++
    move r13, r15 // R13 = Loop Address
    // Loop: 
      plot // Plot Color
      loop // IF (Loop Count != 0) Loop
      nop // Delay Slot

    inc r3 // R3++
    inc r3 // R3++
    inc r4 // R4++
    inc r4 // R4++
    inc r2 // Plot Y Position++
    dec r5 // Fill Y Count--
    bne LoopFill // IF (Fill Y Count != 0) Loop Fill
    nop // Delay Slot

  rpix // Flush Pixel Cache

  stop // Stop GSU
  nop // Delay Slot

ScanLeft: // Left Hand Scanline X Buffer (Size Of Screen Y)
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 127
  dw 126
  dw 125
  dw 124
  dw 123
  dw 122
  dw 121
  dw 120
  dw 119
  dw 118
  dw 117
  dw 116
  dw 115
  dw 114
  dw 113
  dw 112
  dw 111
  dw 110
  dw 109
  dw 108
  dw 107
  dw 106
  dw 105
  dw 104
  dw 103
  dw 102
  dw 101
  dw 100
  dw 99
  dw 98
  dw 97
  dw 96
  dw 97
  dw 98
  dw 99
  dw 100
  dw 101
  dw 102
  dw 103
  dw 104
  dw 105
  dw 106
  dw 107
  dw 108
  dw 109
  dw 110
  dw 111
  dw 112
  dw 113
  dw 114
  dw 115
  dw 116
  dw 117
  dw 118
  dw 119
  dw 120
  dw 121
  dw 122
  dw 123
  dw 124
  dw 125
  dw 126
  dw 127
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0

ScanRight: // Right Hand Scanline X Buffer (Size Of Screen Y)
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 127
  dw 128
  dw 129
  dw 130
  dw 131
  dw 132
  dw 133
  dw 134
  dw 135
  dw 136
  dw 137
  dw 138
  dw 139
  dw 140
  dw 141
  dw 142
  dw 143
  dw 144
  dw 145
  dw 146
  dw 147
  dw 148
  dw 149
  dw 150
  dw 151
  dw 152
  dw 153
  dw 154
  dw 155
  dw 156
  dw 157
  dw 158
  dw 157
  dw 156
  dw 155
  dw 154
  dw 153
  dw 152
  dw 151
  dw 150
  dw 149
  dw 148
  dw 147
  dw 146
  dw 145
  dw 144
  dw 143
  dw 142
  dw 141
  dw 140
  dw 139
  dw 138
  dw 137
  dw 136
  dw 135
  dw 134
  dw 133
  dw 132
  dw 131
  dw 130
  dw 129
  dw 128
  dw 127
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0
  dw 0