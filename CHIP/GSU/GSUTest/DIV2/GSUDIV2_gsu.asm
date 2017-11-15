// SNES GSU Test DIV2 (Divide by 2) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // DIV2 register
  ////////////////////////////

  iwt r0, #$FFFF // R0 = $FFFF
  div2 // R0 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  div2 // R0 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  with r1 ; div2 // R1 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFE // R1 = $FFFE
  with r1 ; div2 // R1 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  with r2 ; div2 // R2 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFE // R2 = $FFFE
  with r2 ; div2 // R2 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  with r3 ; div2 // R3 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFE // R3 = $FFFE
  with r3 ; div2 // R3 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  with r4 ; div2 // R4 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFE // R4 = $FFFE
  with r4 ; div2 // R4 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  with r5 ; div2 // R5 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFE // R5 = $FFFE
  with r5 ; div2 // R5 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFF // R6 = $FFFF
  with r6 ; div2 // R6 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFE // R6 = $FFFE
  with r6 ; div2 // R6 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  with r7 ; div2 // R7 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFE // R7 = $FFFE
  with r7 ; div2 // R7 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  with r8 ; div2 // R8 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFE // R8 = $FFFE
  with r8 ; div2 // R8 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  with r9 ; div2 // R9 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFE // R9 = $FFFE
  with r9 ; div2 // R9 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  with r10 ; div2 // R10 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFE // R10 = $FFFE
  with r10 ; div2 // R10 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  with r11 ; div2 // R11 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFE // R11 = $FFFE
  with r11 ; div2 // R11 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  with r12 ; div2 // R12 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFE // R12 = $FFFE
  with r12 ; div2 // R12 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  with r13 ; div2 // R13 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFE // R13 = $FFFE
  with r13 ; div2 // R13 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  with r14 ; div2 // R14 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFE // R14 = $FFFE
  with r14 ; div2 // R14 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; div2 // R0 = R15 >> 1

  stop // Stop GSU
  nop // Delay Slot