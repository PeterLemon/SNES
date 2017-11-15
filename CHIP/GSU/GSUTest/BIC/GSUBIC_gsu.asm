// SNES GSU Test BIC (BIT Clear) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // BIC register
  ////////////////////////////

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r1 ; bic r0 // R1 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  iwt r8, #$FF00 // R8 = $FF00
  with r1 ; bic r0 // R1 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$FFFF // R1 = $FFFF
  bic r1 // R0 &= !R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$0000 // R1 = $0000
  bic r1 // R0 &= !R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$FFFF // R2 = $FFFF
  bic r2 // R0 &= !R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$0000 // R2 = $0000
  bic r2 // R0 &= !R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$FFFF // R3 = $FFFF
  bic r3 // R0 &= !R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$0000 // R3 = $0000
  bic r3 // R0 &= !R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$FFFF // R4 = $FFFF
  bic r4 // R0 &= !R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$0000 // R4 = $0000
  bic r4 // R0 &= !R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$FFFF // R5 = $FFFF
  bic r5 // R0 &= !R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$0000 // R5 = $0000
  bic r5 // R0 &= !R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$FFFF // R6 = $FFFF
  bic r6 // R0 &= !R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  bic r6 // R0 &= !R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$FFFF // R7 = $FFFF
  bic r7 // R0 &= !R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$0000 // R7 = $0000
  bic r7 // R0 &= !R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$FFFF // R8 = $FFFF
  bic r8 // R0 &= !R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$0000 // R8 = $0000
  bic r8 // R0 &= !R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$FFFF // R9 = $FFFF
  bic r9 // R0 &= !R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$0000 // R9 = $0000
  bic r9 // R0 &= !R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$FFFF // R10 = $FFFF
  bic r10 // R0 &= !R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$0000 // R10 = $0000
  bic r10 // R0 &= !R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$FFFF // R11 = $FFFF
  bic r11 // R0 &= !R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$0000 // R11 = $0000
  bic r11 // R0 &= !R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$FFFF // R12 = $FFFF
  bic r12 // R0 &= !R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$0000 // R12 = $0000
  bic r12 // R0 &= !R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$FFFF // R13 = $FFFF
  bic r13 // R0 &= !R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$0000 // R13 = $0000
  bic r13 // R0 &= !R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$FFFF // R14 = $FFFF
  bic r14 // R0 &= !R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$0000 // R14 = $0000
  bic r14 // R0 &= !R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$BDF0 // R0 = $BDF0
  bic r15 // R0 &= !R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic r15 // R0 &= !R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // BIC #const
  ////////////////////////////

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  bic #0 // R0 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  iwt r8, #$FF00 // R8 = $FF00
  bic #0 // R0 = (R7 & $FF00) + (R8 / $100) (MERGE)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0001 // R0 = $0001
  bic #1 // R0 &= !1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #1 // R0 &= !1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0002 // R0 = $0002
  bic #2 // R0 &= !2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #2 // R0 &= !2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0003 // R0 = $0003
  bic #3 // R0 &= !3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #3 // R0 &= !3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0004 // R0 = $0004
  bic #4 // R0 &= !4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #4 // R0 &= !4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0005 // R0 = $0005
  bic #5 // R0 &= !5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #5 // R0 &= !5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0006 // R0 = $0006
  bic #6 // R0 &= !6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #6 // R0 &= !6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0007 // R0 = $0007
  bic #7 // R0 &= !7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #7 // R0 &= !7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0008 // R0 = $0008
  bic #8 // R0 &= !8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #8 // R0 &= !8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0009 // R0 = $0009
  bic #9 // R0 &= !9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #9 // R0 &= !9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000A // R0 = $000A
  bic #10 // R0 &= !10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #10 // R0 &= !10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000B // R0 = $000B
  bic #11 // R0 &= !11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #11 // R0 &= !11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000C // R0 = $000C
  bic #12 // R0 &= !12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #12 // R0 &= !12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000D // R0 = $000D
  bic #13 // R0 &= !13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #13 // R0 &= !13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000E // R0 = $000E
  bic #14 // R0 &= !14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #14 // R0 &= !14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000F // R0 = $000F
  bic #15 // R0 &= !15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  bic #15 // R0 &= !15

  stop // Stop GSU
  nop // Delay Slot