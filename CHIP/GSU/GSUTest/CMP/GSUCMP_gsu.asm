// SNES GSU Test CMP (Compare) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // CMP register
  ////////////////////////////

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$7FFF // R0 = $7FFF
  with r1 ; cmp r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$8000 // R0 = $8000
  with r1 ; cmp r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$7FFF // R1 = $7FFF
  cmp r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$8000 // R1 = $8000
  cmp r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$7FFF // R2 = $7FFF
  cmp r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$8000 // R2 = $8000
  cmp r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$7FFF // R3 = $7FFF
  cmp r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$8000 // R3 = $8000
  cmp r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$7FFF // R4 = $7FFF
  cmp r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$8000 // R4 = $8000
  cmp r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$7FFF // R5 = $7FFF
  cmp r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$8000 // R5 = $8000
  cmp r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$7FFF // R6 = $7FFF
  cmp r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$8000 // R6 = $8000
  cmp r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$7FFF // R7 = $7FFF
  cmp r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$8000 // R7 = $8000
  cmp r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$7FFF // R8 = $7FFF
  cmp r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$8000 // R8 = $8000
  cmp r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$7FFF // R9 = $7FFF
  cmp r9 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$8000 // R9 = $8000
  cmp r9 // R0 -= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$7FFF // R10 = $7FFF
  cmp r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$8000 // R10 = $8000
  cmp r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$7FFF // R11 = $7FFF
  cmp r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$8000 // R11 = $8000
  cmp r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$7FFF // R12 = $7FFF
  cmp r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$8000 // R12 = $8000
  cmp r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$7FFF // R13 = $7FFF
  cmp r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$8000 // R13 = $8000
  cmp r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$7FFF // R14 = $7FFF
  cmp r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$8000 // R14 = $8000
  cmp r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$A0E8 // R0 = $A0E8
  cmp r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$A0ED // R0 = $A0ED
  cmp r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot