// SNES GSU Test FMULT (Multiply Fraction Word) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // FMULT register
  ////////////////////////////

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  fmult // R0 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R1 = $FFFF
  iwt r6, #$0800 // R6 = $FFFF
  fmult // R0 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r1 ; fmult // R1 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r1 ; fmult // R1 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r2 ; fmult // R2 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r2 ; fmult // R2 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r3 ; fmult // R3 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r3 ; fmult // R3 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r4 ; fmult // R4 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r4 ; fmult // R4 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r5 ; fmult // R5 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r5 ; fmult // R5 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  to r6 ; from r0 ; fmult // R6 = R0 * (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  to r6 ; from r0 ; fmult // R6 = R0 * (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r7 ; fmult // R7 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r7 ; fmult // R7 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r8 ; fmult // R8 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r8 ; fmult // R8 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r9 ; fmult // R9 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r9 ; fmult // R9 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r10 ; fmult // R10 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r10 ; fmult // R10 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r11 ; fmult // R11 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r11 ; fmult // R11 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r12 ; fmult // R12 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r12 ; fmult // R12 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r13 ; fmult // R13 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r13 ; fmult // R13 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  with r14 ; fmult // R14 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  iwt r6, #$0800 // R6 = $0800
  with r14 ; fmult // R14 *= (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  to r0 ; from r15 ; fmult // R0 = r15 * (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0800 // R6 = $0800
  to r0 ; from r15 ; fmult // R0 = r15 * (R6 / $10000)

  stop // Stop GSU
  nop // Delay Slot