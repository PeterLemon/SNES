// SNES GSU Test HIB (Hi Byte) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // HIB register
  ////////////////////////////

  iwt r0, #$00FF // R0 = $00FF
  hib // R0 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FF00 // R0 = $FF00
  hib // R0 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$00FF // R1 = $00FF
  with r1 ; hib // R1 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FF00 // R1 = $FF00
  with r1 ; hib // R1 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$00FF // R2 = $00FF
  with r2 ; hib // R2 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FF00 // R2 = $FF00
  with r2 ; hib // R2 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$00FF // R3 = $00FF
  with r3 ; hib // R3 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FF00 // R3 = $FF00
  with r3 ; hib // R3 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$00FF // R4 = $00FF
  with r4 ; hib // R4 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FF00 // R4 = $FF00
  with r4 ; hib // R4 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$00FF // R5 = $00FF
  with r5 ; hib // R5 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FF00 // R5 = $FF00
  with r5 ; hib // R5 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$00FF // R6 = $00FF
  with r6 ; hib // R6 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FF00 // R6 = $FF00
  with r6 ; hib // R6 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  with r7 ; hib // R7 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  with r7 ; hib // R7 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$00FF // R8 = $00FF
  with r8 ; hib // R8 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FF00 // R8 = $FF00
  with r8 ; hib // R8 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$00FF // R9 = $00FF
  with r9 ; hib // R9 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FF00 // R9 = $FF00
  with r9 ; hib // R9 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$00FF // R10 = $00FF
  with r10 ; hib // R10 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FF00 // R10 = $FF00
  with r10 ; hib // R10 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$00FF // R11 = $00FF
  with r11 ; hib // R11 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FF00 // R11 = $FF00
  with r11 ; hib // R11 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$00FF // R12 = $00FF
  with r12 ; hib // R12 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FF00 // R12 = $FF00
  with r12 ; hib // R12 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$00FF // R13 = $00FF
  with r13 ; hib // R13 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FF00 // R13 = $FF00
  with r13 ; hib // R13 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$00FF // R14 = $00FF
  with r14 ; hib // R14 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FF00 // R14 = $FF00
  with r14 ; hib // R14 >>= 8

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; hib // R0 = R15 >> 8

  stop // Stop GSU
  nop // Delay Slot