// SNES GSU Test OR (Logical OR) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // OR register
  ////////////////////////////

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$00FF // R0 = $00FF
  with r1 ; or r0 // R1 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FF00 // R1 = $FF00
  iwt r0, #$FF00 // R0 = $FF00
  with r1 ; or r0 // R1 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r1, #$0000 // R1 = $0000
  or r1 // R0 |= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r1, #$FF00 // R1 = $FF00
  or r1 // R0 |= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r2, #$0000 // R2 = $0000
  or r2 // R0 |= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r2, #$FF00 // R2 = $FF00
  or r2 // R0 |= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r3, #$0000 // R3 = $0000
  or r3 // R0 |= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r3, #$FF00 // R3 = $FF00
  or r3 // R0 |= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r4, #$0000 // R4 = $0000
  or r4 // R0 |= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r4, #$FF00 // R4 = $FF00
  or r4 // R0 |= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r5, #$0000 // R5 = $0000
  or r5 // R0 |= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r5, #$FF00 // R5 = $FF00
  or r5 // R0 |= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r6, #$0000 // R6 = $0000
  or r6 // R0 |= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r6, #$FF00 // R6 = $FF00
  or r6 // R0 |= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r7, #$0000 // R7 = $0000
  or r7 // R0 |= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r7, #$FF00 // R7 = $FF00
  or r7 // R0 |= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r8, #$0000 // R8 = $0000
  or r8 // R0 |= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r8, #$FF00 // R8 = $FF00
  or r8 // R0 |= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r9, #$0000 // R9 = $0000
  or r9 // R0 |= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r9, #$FF00 // R9 = $FF00
  or r9 // R0 |= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r10, #$0000 // R10 = $0000
  or r10 // R0 |= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r10, #$FF00 // R10 = $FF00
  or r10 // R0 |= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r11, #$0000 // R11 = $0000
  or r11 // R0 |= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r11, #$FF00 // R11 = $FF00
  or r11 // R0 |= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r12, #$0000 // R12 = $0000
  or r12 // R0 |= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r12, #$FF00 // R12 = $FF00
  or r12 // R0 |= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r13, #$0000 // R13 = $0000
  or r13 // R0 |= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r13, #$FF00 // R13 = $FF00
  or r13 // R0 |= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  iwt r14, #$0000 // R14 = $0000
  or r14 // R0 |= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$00FF // R0 = $00FF
  iwt r14, #$FF00 // R14 = $FF00
  or r14 // R0 |= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or r15 // R0 |= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  or r15 // R0 |= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // OR #const
  ////////////////////////////

  iwt r0, #$00FF // R0 = $00FF
  or #0 // R0 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FF00 // R0 = $FF00
  or #0 // R0 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #1 // R0 |= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  or #1 // R0 |= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #2 // R0 |= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFD // R0 = $FFFD
  or #2 // R0 |= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #3 // R0 |= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFC // R0 = $FFFC
  or #3 // R0 |= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #4 // R0 |= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFB // R0 = $FFFB
  or #4 // R0 |= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #5 // R0 |= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFA // R0 = $FFFA
  or #5 // R0 |= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #6 // R0 |= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF9 // R0 = $FFF9
  or #6 // R0 |= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #7 // R0 |= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF8 // R0 = $FFF8
  or #7 // R0 |= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #8 // R0 |= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF7 // R0 = $FFF7
  or #8 // R0 |= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #9 // R0 |= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF6 // R0 = $FFF6
  or #9 // R0 |= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #10 // R0 |= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF5 // R0 = $FFF5
  or #10 // R0 |= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #11 // R0 |= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF4 // R0 = $FFF4
  or #11 // R0 |= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #12 // R0 |= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF3 // R0 = $FFF3
  or #12 // R0 |= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #13 // R0 |= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF2 // R0 = $FFF2
  or #13 // R0 |= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #14 // R0 |= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF1 // R0 = $FFF1
  or #14 // R0 |= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0000 // R0 = $0000
  or #15 // R0 |= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF0 // R0 = $FFF0
  or #15 // R0 |= 15

  stop // Stop GSU
  nop // Delay Slot