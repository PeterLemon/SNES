// SNES GSU Test NOT (Compliment Bits) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // NOT register
  ////////////////////////////

  iwt r0, #$FFFF // R0 = $FFFF
  not // R0 ~= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  not // R0 ~= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  with r1 ; not // R1 ~= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$0000 // R1 = $0000
  with r1 ; not // R1 ~= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  with r2 ; not // R2 ~= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$0000 // R2 = $0000
  with r2 ; not // R2 ~= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  with r3 ; not // R3 ~= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$0000 // R3 = $0000
  with r3 ; not // R3 ~= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  with r4 ; not // R4 ~= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$0000 // R4 = $0000
  with r4 ; not // R4 ~= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  with r5 ; not // R5 ~= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$0000 // R5 = $0000
  with r5 ; not // R5 ~= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFF // R6 = $FFFF
  with r6 ; not // R6 ~= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$0000 // R6 = $0000
  with r6 ; not // R6 ~= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  with r7 ; not // R7 ~= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$0000 // R7 = $0000
  with r7 ; not // R7 ~= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  with r8 ; not // R8 ~= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$0000 // R8 = $0000
  with r8 ; not // R8 ~= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  with r9 ; not // R9 ~= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$0000 // R9 = $0000
  with r9 ; not // R9 ~= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  with r10 ; not // R10 ~= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$0000 // R10 = $0000
  with r10 ; not // R10 ~= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  with r11 ; not // R11 ~= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$0000 // R11 = $0000
  with r11 ; not // R11 ~= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  with r12 ; not // R12 ~= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$0000 // R12 = $0000
  with r12 ; not // R12 ~= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  with r13 ; not // R13 ~= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$0000 // R13 = $0000
  with r13 ; not // R13 ~= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  with r14 ; not // R14 ~= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$0000 // R14 = $0000
  with r14 ; not // R14 ~= R14

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; not // R0 = ~R15

  stop // Stop GSU
  nop // Delay Slot