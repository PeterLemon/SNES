// SNES GSU Test XOR (Exclusive-OR) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // XOR register
  ////////////////////////////

  iwt r1, #$00FF // R1 = $00FF
  iwt r0, #$00FF // R0 = $00FF
  with r1 ; xor r0 // R1 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FF00 // R1 = $FF00
  iwt r0, #$FF00 // R0 = $FF00
  with r1 ; xor r0 // R1 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$FFFF // R1 = $FFFF
  xor r1 // R0 ^= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r1, #$0000 // R1 = $0000
  xor r1 // R0 ^= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$FFFF // R2 = $FFFF
  xor r2 // R0 ^= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r2, #$0000 // R2 = $0000
  xor r2 // R0 ^= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$FFFF // R3 = $FFFF
  xor r3 // R0 ^= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r3, #$0000 // R3 = $0000
  xor r3 // R0 ^= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$FFFF // R4 = $FFFF
  xor r4 // R0 ^= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r4, #$0000 // R4 = $0000
  xor r4 // R0 ^= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$FFFF // R5 = $FFFF
  xor r5 // R0 ^= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r5, #$0000 // R5 = $0000
  xor r5 // R0 ^= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$FFFF // R6 = $FFFF
  xor r6 // R0 ^= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r6, #$0000 // R6 = $0000
  xor r6 // R0 ^= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$FFFF // R7 = $FFFF
  xor r7 // R0 ^= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r7, #$0000 // R7 = $0000
  xor r7 // R0 ^= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$FFFF // R8 = $FFFF
  xor r8 // R0 ^= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r8, #$0000 // R8 = $0000
  xor r8 // R0 ^= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$FFFF // R9 = $FFFF
  xor r9 // R0 ^= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r9, #$0000 // R9 = $0000
  xor r9 // R0 ^= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$FFFF // R10 = $FFFF
  xor r10 // R0 ^= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r10, #$0000 // R10 = $0000
  xor r10 // R0 ^= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$FFFF // R11 = $FFFF
  xor r11 // R0 ^= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r11, #$0000 // R11 = $0000
  xor r11 // R0 ^= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$FFFF // R12 = $FFFF
  xor r12 // R0 ^= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r12, #$0000 // R12 = $0000
  xor r12 // R0 ^= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$FFFF // R13 = $FFFF
  xor r13 // R0 ^= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r13, #$0000 // R13 = $0000
  xor r13 // R0 ^= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$FFFF // R14 = $FFFF
  xor r14 // R0 ^= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  iwt r14, #$0000 // R14 = $0000
  xor r14 // R0 ^= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$BDEE // R0 = $BDEE
  xor r15 // R0 ^= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$420A // R0 = $420A
  xor r15 // R0 ^= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // XOR #const
  ////////////////////////////

  iwt r0, #$00FF // R0 = $00FF
  xor #0 // R0 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FF00 // R0 = $FF00
  xor #0 // R0 >>= 8 (HIB)

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0001 // R0 = $0001
  xor #1 // R0 ^= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  xor #1 // R0 ^= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0002 // R0 = $0002
  xor #2 // R0 ^= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFD // R0 = $FFFD
  xor #2 // R0 ^= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0003 // R0 = $0003
  xor #3 // R0 ^= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFC // R0 = $FFFC
  xor #3 // R0 ^= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0004 // R0 = $0004
  xor #4 // R0 ^= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFB // R0 = $FFFB
  xor #4 // R0 ^= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0005 // R0 = $0005
  xor #5 // R0 ^= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFA // R0 = $FFFA
  xor #5 // R0 ^= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0006 // R0 = $0006
  xor #6 // R0 ^= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF9 // R0 = $FFF9
  xor #6 // R0 ^= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0007 // R0 = $0007
  xor #7 // R0 ^= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF8 // R0 = $FFF8
  xor #7 // R0 ^= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0008 // R0 = $0008
  xor #8 // R0 ^= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF7 // R0 = $FFF7
  xor #8 // R0 ^= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0009 // R0 = $0009
  xor #9 // R0 ^= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF6 // R0 = $FFF6
  xor #9 // R0 ^= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000A // R0 = $000A
  xor #10 // R0 ^= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF5 // R0 = $FFF5
  xor #10 // R0 ^= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000B // R0 = $000B
  xor #11 // R0 ^= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF4 // R0 = $FFF4
  xor #11 // R0 ^= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000C // R0 = $000C
  xor #12 // R0 ^= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF3 // R0 = $FFF3
  xor #12 // R0 ^= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000D // R0 = $000D
  xor #13 // R0 ^= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF2 // R0 = $FFF2
  xor #13 // R0 ^= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000E // R0 = $000E
  xor #14 // R0 ^= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF1 // R0 = $FFF1
  xor #14 // R0 ^= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000F // R0 = $000F
  xor #15 // R0 ^= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF0 // R0 = $FFF0
  xor #15 // R0 ^= 15

  stop // Stop GSU
  nop // Delay Slot