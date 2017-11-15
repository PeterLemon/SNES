// SNES GSU Test SEX (Sign Extend) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // SEX register
  ////////////////////////////

  iwt r0, #$0000 // R0 = $0000
  sex // R0 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  sex // R0 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$0000 // R1 = $0000
  with r1 ; sex // R1 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$00FF // R1 = $00FF
  with r1 ; sex // R1 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$0000 // R2 = $0000
  with r2 ; sex // R2 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$00FF // R2 = $00FF
  with r2 ; sex // R2 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$0000 // R3 = $0000
  with r3 ; sex // R3 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$00FF // R3 = $00FF
  with r3 ; sex // R3 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$0000 // R4 = $0000
  with r4 ; sex // R4 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$00FF // R4 = $00FF
  with r4 ; sex // R4 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$0000 // R5 = $0000
  with r5 ; sex // R5 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$00FF // R5 = $00FF
  with r5 ; sex // R5 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  with r6 ; sex // R6 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$00FF // R6 = $00FF
  with r6 ; sex // R6 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$0000 // R7 = $0000
  with r7 ; sex // R7 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  with r7 ; sex // R7 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$0000 // R8 = $0000
  with r8 ; sex // R8 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$00FF // R8 = $00FF
  with r8 ; sex // R8 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$0000 // R9 = $0000
  with r9 ; sex // R9 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$00FF // R9 = $00FF
  with r9 ; sex // R9 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$0000 // R10 = $0000
  with r10 ; sex // R10 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$00FF // R10 = $00FF
  with r10 ; sex // R10 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$0000 // R11 = $0000
  with r11 ; sex // R11 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$00FF // R11 = $00FF
  with r11 ; sex // R11 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$0000 // R12 = $0000
  with r12 ; sex // R12 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$00FF // R12 = $00FF
  with r12 ; sex // R12 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$0000 // R13 = $0000
  with r13 ; sex // R13 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$00FF // R13 = $00FF
  with r13 ; sex // R13 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$0000 // R14 = $0000
  with r14 ; sex // R14 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$00FF // R14 = $00FF
  with r14 ; sex // R14 = Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; sex // R0 = R15 Signed (16-Bit)

  stop // Stop GSU
  nop // Delay Slot