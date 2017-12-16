// SNES GSU Test MOVE (Move Register) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // MOVE destination, source
  ////////////////////////////

  iwt r1, #$0000 // R1 = $0000
  move r0, r1 // R0 = R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  move r0, r1 // R0 = R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$0000 // R2 = $0000
  move r1, r2 // R1 = R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R1 = $FFFF
  move r1, r2 // R1 = R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$0000 // R3 = $0000
  move r2, r3 // R2 = R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  move r2, r3 // R2 = R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$0000 // R4 = $0000
  move r3, r4 // R3 = R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  move r3, r4 // R3 = R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$0000 // R5 = $0000
  move r4, r5 // R4 = R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  move r4, r5 // R4 = R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  move r5, r6 // R5 = R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFF // R6 = $FFFF
  move r5, r6 // R5 = R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$0000 // R7 = $0000
  move r6, r7 // R6 = R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  move r6, r7 // R6 = R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$0000 // R8 = $0000
  move r7, r8 // R7 = R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  move r7, r8 // R7 = R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$0000 // R9 = $0000
  move r8, r9 // R8 = R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  move r8, r9 // R8 = R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$0000 // R10 = $0000
  move r9, r10 // R9 = R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  move r9, r10 // R9 = R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$0000 // R11 = $0000
  move r10, r11 // R10 = R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  move r10, r11 // R10 = R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$0000 // R12 = $0000
  move r11, r12 // R11 = R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  move r11, r12 // R11 = R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$0000 // R13 = $0000
  move r12, r13 // R12 = R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  move r12, r13 // R12 = R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$0000 // R14 = $0000
  move r13, r14 // R13 = R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  move r13, r14 // R13 = R14

  stop // Stop GSU
  nop // Delay Slot

  move r14, r15 // R14 = R15

  stop // Stop GSU
  nop // Delay Slot

  move r14, r15 // R14 = R15

  stop // Stop GSU
  nop // Delay Slot