// SNES GSU Test UMULT (Unsigned Multiply Byte) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // UMULT register
  ////////////////////////////

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$0000 // R0 = $0000
  with r1 ; umult r0 // R1 *= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$00FF // R0 = $00FF
  with r1 ; umult r0 // R1 *= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r1, #$0000 // R1 = $0000
  umult r1 // R0 *= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r1, #$00FF // R1 = $00FF
  umult r1 // R0 *= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r2, #$0000 // R2 = $0000
  umult r2 // R0 *= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r2, #$00FF // R2 = $00FF
  umult r2 // R0 *= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r3, #$0000 // R3 = $0000
  umult r3 // R0 *= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r3, #$00FF // R3 = $00FF
  umult r3 // R0 *= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r4, #$0000 // R4 = $0000
  umult r4 // R0 *= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r4, #$00FF // R4 = $00FF
  umult r4 // R0 *= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r5, #$0000 // R5 = $0000
  umult r5 // R0 *= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r5, #$00FF // R5 = $00FF
  umult r5 // R0 *= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r6, #$0000 // R6 = $0000
  umult r6 // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r6, #$00FF // R6 = $00FF
  umult r6 // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r7, #$0000 // R7 = $0000
  umult r7 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r7, #$00FF // R7 = $00FF
  umult r7 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r8, #$0000 // R8 = $0000
  umult r8 // R0 *= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  umult r8 // R0 *= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r9, #$0000 // R9 = $0000
  umult r9 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r9, #$00FF // R9 = $00FF
  umult r9 // R0 *= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r10, #$0000 // R10 = $0000
  umult r10 // R0 *= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r10, #$00FF // R10 = $00FF
  umult r10 // R0 *= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r11, #$0000 // R11 = $0000
  umult r11 // R0 *= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r11, #$00FF // R11 = $00FF
  umult r11 // R0 *= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r12, #$0000 // R12 = $0000
  umult r12 // R0 *= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r12, #$00FF // R12 = $00FF
  umult r12 // R0 *= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r13, #$0000 // R13 = $0000
  umult r13 // R0 *= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r13, #$00FF // R13 = $00FF
  umult r13 // R0 *= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r14, #$0000 // R14 = $0000
  umult r14 // R0 *= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r14, #$00FF // R14 = $00FF
  umult r14 // R0 *= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult r15 // R0 *= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult r15 // R0 *= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // UMULT #const
  ////////////////////////////

  iwt r0, #$00FF // R0 = $00FF
  umult #0 // R0 *= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$007F // R0 = $007F
  umult #0 // R0 *= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #1 // R0 *= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #1 // R0 *= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #2 // R0 *= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #2 // R0 *= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #3 // R0 *= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #3 // R0 *= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #4 // R0 *= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #4 // R0 *= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #5 // R0 *= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #5 // R0 *= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #6 // R0 *= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #6 // R0 *= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #7 // R0 *= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #7 // R0 *= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #8 // R0 *= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #8 // R0 *= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #9 // R0 *= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #9 // R0 *= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #10 // R0 *= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #10 // R0 *= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #11 // R0 *= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #11 // R0 *= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #12 // R0 *= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #12 // R0 *= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #13 // R0 *= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #13 // R0 *= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #14 // R0 *= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #14 // R0 *= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  umult #15 // R0 *= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  umult #15 // R0 *= 15

  stop // Stop GSU
  nop // Delay Slot