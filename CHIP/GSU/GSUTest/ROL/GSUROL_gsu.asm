// SNES GSU Test ROL (Rotate Left) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // ROL register
  ////////////////////////////

  iwt r0, #$8000 // R0 = $8000
  rol // R0 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  rol // R0 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$8000 // R1 = $8000
  with r1 ; rol // R1 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  with r1 ; rol // R1 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$8000 // R2 = $8000
  with r2 ; rol // R2 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$7FFF // R2 = $7FFF
  with r2 ; rol // R2 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$8000 // R3 = $8000
  with r3 ; rol // R3 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$7FFF // R3 = $7FFF
  with r3 ; rol // R3 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$8000 // R4 = $8000
  with r4 ; rol // R4 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$7FFF // R4 = $7FFF
  with r4 ; rol // R4 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$8000 // R5 = $8000
  with r5 ; rol // R5 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$7FFF // R5 = $7FFF
  with r5 ; rol // R5 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$8000 // R6 = $8000
  with r6 ; rol // R6 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$7FFF // R6 = $7FFF
  with r6 ; rol // R6 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$8000 // R7 = $8000
  with r7 ; rol // R7 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$7FFF // R7 = $7FFF
  with r7 ; rol // R7 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$8000 // R8 = $8000
  with r8 ; rol // R8 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$7FFF // R8 = $7FFF
  with r8 ; rol // R8 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$8000 // R9 = $8000
  with r9 ; rol // R9 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$7FFF // R9 = $7FFF
  with r9 ; rol // R9 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$8000 // R10 = $8000
  with r10 ; rol // R10 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$7FFF // R10 = $7FFF
  with r10 ; rol // R10 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$8000 // R11 = $8000
  with r11 ; rol // R11 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$7FFF // R11 = $7FFF
  with r11 ; rol // R11 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$8000 // R12 = $8000
  with r12 ; rol // R12 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$7FFF // R12 = $7FFF
  with r12 ; rol // R12 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$8000 // R13 = $8000
  with r13 ; rol // R13 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$7FFF // R13 = $7FFF
  with r13 ; rol // R13 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$8000 // R14 = $8000
  with r14 ; rol // R14 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$7FFF // R14 = $7FFF
  with r14 ; rol // R14 <<=  1

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; rol // R0 = R15 << 1

  stop // Stop GSU
  nop // Delay Slot