// SNES GSU Test LMULT (Multiply Long Word) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // LMULT register
  ////////////////////////////

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  lmult // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R1 = $FFFF
  iwt r6, #$0800 // R6 = $FFFF
  lmult // R0 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r1 ; lmult // R1 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r1 ; lmult // R1 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r2 ; lmult // R2 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r2 ; lmult // R2 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r3 ; lmult // R3 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r3 ; lmult // R3 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r4 ; lmult // R4 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r4 ; lmult // R4 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r5 ; lmult // R5 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r5 ; lmult // R5 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  to r6 ; from r0 ; lmult // R6 = R0 * R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  to r6 ; from r0 ; lmult // R6 = R0 * R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r7 ; lmult // R7 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r7 ; lmult // R7 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r8 ; lmult // R8 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r8 ; lmult // R8 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r9 ; lmult // R9 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r9 ; lmult // R9 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r10 ; lmult // R10 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r10 ; lmult // R10 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r11 ; lmult // R11 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r11 ; lmult // R11 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r12 ; lmult // R12 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r12 ; lmult // R12 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r13 ; lmult // R13 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r13 ; lmult // R13 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r14 ; lmult // R14 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r14 ; lmult // R14 *= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  to r0 ; from r15 ; lmult // R0 = r15 * R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0800 // R6 = $0800
  to r0 ; from r15 ; lmult // R0 = r15 * R6

  stop // Stop GSU
  nop // Delay Slot