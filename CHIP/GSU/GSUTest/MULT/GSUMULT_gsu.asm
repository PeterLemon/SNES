// SNES GSU Test MULT (Signed Multiply Byte) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // MULT register
  ////////////////////////////

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$0000 // R0 = $0000
  with r1 ; mult r0 // R1 *= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$007F // R0 = $007F
  with r1 ; mult r0 // R1 *= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r1, #$0000 // R1 = $0000
  mult r1 // R0 *= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r1, #$007F // R1 = $007F
  mult r1 // R0 *= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r2, #$0000 // R2 = $0000
  mult r2 // R0 *= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r2, #$007F // R2 = $007F
  mult r2 // R0 *= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r3, #$0000 // R3 = $0000
  mult r3 // R0 *= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r3, #$007F // R3 = $007F
  mult r3 // R0 *= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r4, #$0000 // R4 = $0000
  mult r4 // R0 *= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r4, #$007F // R4 = $007F
  mult r4 // R0 *= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r5, #$0000 // R5 = $0000
  mult r5 // R0 *= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r5, #$007F // R5 = $007F
  mult r5 // R0 *= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r6, #$0000 // R6 = $0000
  mult r6 // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r6, #$007F // R6 = $007F
  mult r6 // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r7, #$0000 // R7 = $0000
  mult r7 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r7, #$007F // R7 = $007F
  mult r7 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r8, #$0000 // R8 = $0000
  mult r8 // R0 *= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r8, #$007F // R8 = $007F
  mult r8 // R0 *= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r9, #$0000 // R9 = $0000
  mult r9 // R0 *= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r9, #$007F // R9 = $007F
  mult r9 // R0 *= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r10, #$0000 // R10 = $0000
  mult r10 // R0 *= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r10, #$007F // R10 = $007F
  mult r10 // R0 *= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r11, #$0000 // R11 = $0000
  mult r11 // R0 *= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r11, #$007F // R11 = $007F
  mult r11 // R0 *= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r12, #$0000 // R12 = $0000
  mult r12 // R0 *= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r12, #$007F // R12 = $007F
  mult r12 // R0 *= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r13, #$0000 // R13 = $0000
  mult r13 // R0 *= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r13, #$007F // R13 = $007F
  mult r13 // R0 *= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r14, #$0000 // R14 = $0000
  mult r14 // R0 *= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r14, #$007F // R14 = $007F
  mult r14 // R0 *= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult r15 // R0 *= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$007F // R0 = $007F
  mult r15 // R0 *= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // MULT #const
  ////////////////////////////

  iwt r0, #$00FF // R0 = $00FF
  mult #0 // R0 *= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$007F // R0 = $007F
  mult #0 // R0 *= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #1 // R0 *= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #1 // R0 *= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #2 // R0 *= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #2 // R0 *= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #3 // R0 *= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #3 // R0 *= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #4 // R0 *= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #4 // R0 *= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #5 // R0 *= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #5 // R0 *= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #6 // R0 *= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #6 // R0 *= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #7 // R0 *= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #7 // R0 *= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #8 // R0 *= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #8 // R0 *= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #9 // R0 *= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #9 // R0 *= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #10 // R0 *= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #10 // R0 *= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #11 // R0 *= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #11 // R0 *= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #12 // R0 *= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #12 // R0 *= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #13 // R0 *= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #13 // R0 *= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #14 // R0 *= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #14 // R0 *= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  mult #15 // R0 *= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  mult #15 // R0 *= 15

  stop // Stop GSU
  nop // Delay Slot