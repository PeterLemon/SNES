// SNES GSU Test SWAP (Hi/Lo Bytes) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // SWAP register
  ////////////////////////////

  iwt r0, #$0000 // R0 = $0000
  swap // R0 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$DCFE // R0 = $DCFE
  swap // R0 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$0000 // R1 = $0000
  with r1 ; swap // R1 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$DCFE // R1 = $DCFE
  with r1 ; swap // R1 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$0000 // R2 = $0000
  with r2 ; swap // R2 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$DCFE // R2 = $DCFE
  with r2 ; swap // R2 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$0000 // R3 = $0000
  with r3 ; swap // R3 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$DCFE // R3 = $DCFE
  with r3 ; swap // R3 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$0000 // R4 = $0000
  with r4 ; swap // R4 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$DCFE // R4 = $DCFE
  with r4 ; swap // R4 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$0000 // R5 = $0000
  with r5 ; swap // R5 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$DCFE // R5 = $DCFE
  with r5 ; swap // R5 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  with r6 ; swap // R6 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$DCFE // R6 = $DCFE
  with r6 ; swap // R6 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$0000 // R7 = $0000
  with r7 ; swap // R7 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$DCFE // R7 = $DCFE
  with r7 ; swap // R7 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$0000 // R8 = $0000
  with r8 ; swap // R8 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$DCFE // R8 = $DCFE
  with r8 ; swap // R8 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$0000 // R9 = $0000
  with r9 ; swap // R9 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$DCFE // R9 = $DCFE
  with r9 ; swap // R9 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$0000 // R10 = $0000
  with r10 ; swap // R10 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$DCFE // R10 = $DCFE
  with r10 ; swap // R10 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$0000 // R11 = $0000
  with r11 ; swap // R11 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$DCFE // R11 = $DCFE
  with r11 ; swap // R11 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$0000 // R12 = $0000
  with r12 ; swap // R12 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$DCFE // R12 = $DCFE
  with r12 ; swap // R12 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$0000 // R13 = $0000
  with r13 ; swap // R13 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$DCFE // R13 = $DCFE
  with r13 ; swap // R13 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$0000 // R14 = $0000
  with r14 ; swap // R14 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$DCFE // R14 = $DCFE
  with r14 ; swap // R14 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; swap // R0 = R15 >> 8

  stop // Stop GSU
  nop // Delay Slot