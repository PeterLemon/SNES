// SNES GSU Test ASR (Arithmetic Shift Right) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // ASR register
  ////////////////////////////

  iwt r0, #$0001 // R0 = $0001
  asr // R0 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  asr // R0 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$0001 // R1 = $0001
  with r1 ; asr // R1 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFE // R1 = $FFFE
  with r1 ; asr // R1 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$0001 // R2 = $0001
  with r2 ; asr // R2 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFE // R2 = $FFFE
  with r2 ; asr // R2 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$0001 // R3 = $0001
  with r3 ; asr // R3 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFE // R3 = $FFFE
  with r3 ; asr // R3 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$0001 // R4 = $0001
  with r4 ; asr // R4 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFE // R4 = $FFFE
  with r4 ; asr // R4 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$0001 // R5 = $0001
  with r5 ; asr // R5 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFE // R5 = $FFFE
  with r5 ; asr // R5 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0001 // R6 = $0001
  with r6 ; asr // R6 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFE // R6 = $FFFE
  with r6 ; asr // R6 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$0001 // R7 = $0001
  with r7 ; asr // R7 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFE // R7 = $FFFE
  with r7 ; asr // R7 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$0001 // R8 = $0001
  with r8 ; asr // R8 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFE // R8 = $FFFE
  with r8 ; asr // R8 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$0001 // R9 = $0001
  with r9 ; asr // R9 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFE // R9 = $FFFE
  with r9 ; asr // R9 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$0001 // R10 = $0001
  with r10 ; asr // R10 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFE // R10 = $FFFE
  with r10 ; asr // R10 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$0001 // R11 = $0001
  with r11 ; asr // R11 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFE // R11 = $FFFE
  with r11 ; asr // R11 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$0001 // R12 = $0001
  with r12 ; asr // R12 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFE // R12 = $FFFE
  with r12 ; asr // R12 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$0001 // R13 = $0001
  with r13 ; asr // R13 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFE // R13 = $FFFE
  with r13 ; asr // R13 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$0001 // R14 = $0001
  with r14 ; asr // R14 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFE // R14 = $FFFE
  with r14 ; asr // R14 >>= 1

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; asr // R0 = R15 >> 1

  stop // Stop GSU
  nop // Delay Slot