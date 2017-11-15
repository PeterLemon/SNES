// SNES GSU Test AND (Logical AND) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // AND register
  ////////////////////////////

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r1 ; and r0 // R1 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  iwt r8, #$FF00 // R8 = $FF00
  with r1 ; and r0 // R1 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$0000 // R1 = $0000
  and r1 // R0 &= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$FFFF // R1 = $FFFF
  and r1 // R0 &= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$0000 // R2 = $0000
  and r2 // R0 &= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$FFFF // R2 = $FFFF
  and r2 // R0 &= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$0000 // R3 = $0000
  and r3 // R0 &= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$FFFF // R3 = $FFFF
  and r3 // R0 &= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$0000 // R4 = $0000
  and r4 // R0 &= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$FFFF // R4 = $FFFF
  and r4 // R0 &= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$0000 // R5 = $0000
  and r5 // R0 &= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$FFFF // R5 = $FFFF
  and r5 // R0 &= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  and r6 // R0 &= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$FFFF // R6 = $FFFF
  and r6 // R0 &= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$0000 // R7 = $0000
  and r7 // R0 &= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$FFFF // R7 = $FFFF
  and r7 // R0 &= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$0000 // R8 = $0000
  and r8 // R0 &= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$FFFF // R8 = $FFFF
  and r8 // R0 &= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$0000 // R9 = $0000
  and r9 // R0 &= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$FFFF // R9 = $FFFF
  and r9 // R0 &= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$0000 // R10 = $0000
  and r10 // R0 &= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$FFFF // R10 = $FFFF
  and r10 // R0 &= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$0000 // R11 = $0000
  and r11 // R0 &= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$FFFF // R11 = $FFFF
  and r11 // R0 &= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$0000 // R12 = $0000
  and r12 // R0 &= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$FFFF // R12 = $FFFF
  and r12 // R0 &= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$0000 // R13 = $0000
  and r13 // R0 &= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$FFFF // R13 = $FFFF
  and r13 // R0 &= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$0000 // R14 = $0000
  and r14 // R0 &= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$FFFF // R14 = $FFFF
  and r14 // R0 &= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and r15 // R0 &= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and r15 // R0 &= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // AND #const
  ////////////////////////////

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  and #0 // R0 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  iwt r8, #$FF00 // R8 = $FF00
  and #0 // R0 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #1 // R0 &= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #1 // R0 &= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #2 // R0 &= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #2 // R0 &= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #3 // R0 &= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #3 // R0 &= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #4 // R0 &= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #4 // R0 &= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #5 // R0 &= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #5 // R0 &= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #6 // R0 &= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #6 // R0 &= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #7 // R0 &= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #7 // R0 &= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #8 // R0 &= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #8 // R0 &= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #9 // R0 &= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #9 // R0 &= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #10 // R0 &= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #10 // R0 &= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #11 // R0 &= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #11 // R0 &= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #12 // R0 &= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #12 // R0 &= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #13 // R0 &= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #13 // R0 &= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #14 // R0 &= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #14 // R0 &= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  and #15 // R0 &= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  and #15 // R0 &= 15

  stop // Stop GSU
  nop // Delay Slot