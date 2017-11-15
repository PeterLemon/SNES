// SNES GSU Test SBC (Subtract With Borrow) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // SBC register
  ////////////////////////////

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$7FFE // R0 = $7FFE
  with r1 ; sbc r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$8000 // R0 = $8000
  with r1 ; sbc r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$7FFE // R1 = $7FFE
  sbc r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$8000 // R1 = $8000
  sbc r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$7FFE // R2 = $7FFE
  sbc r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$8000 // R2 = $8000
  sbc r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$7FFE // R3 = $7FFE
  sbc r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$8000 // R3 = $8000
  sbc r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$7FFE // R4 = $7FFE
  sbc r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$8000 // R4 = $8000
  sbc r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$7FFE // R5 = $7FFE
  sbc r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$8000 // R5 = $8000
  sbc r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$7FFE // R6 = $7FFE
  sbc r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$8000 // R6 = $8000
  sbc r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$7FFE // R7 = $7FFE
  sbc r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$8000 // R7 = $8000
  sbc r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$7FFE // R8 = $7FFE
  sbc r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$8000 // R8 = $8000
  sbc r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$7FFE // R9 = $7FFE
  sbc r9 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$8000 // R9 = $8000
  sbc r9 // R0 -= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$7FFE // R10 = $7FFE
  sbc r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$8000 // R10 = $8000
  sbc r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$7FFE // R11 = $7FFE
  sbc r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$8000 // R11 = $8000
  sbc r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$7FFE // R12 = $7FFE
  sbc r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$8000 // R12 = $8000
  sbc r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$7FFE // R13 = $7FFE
  sbc r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$8000 // R13 = $8000
  sbc r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$7FFE // R14 = $7FFE
  sbc r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$8000 // R14 = $8000
  sbc r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$A0EE // R0 = $A0EE
  sbc r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$A0F3 // R0 = $A0F3
  sbc r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot