// SNES GSU Test SUB (Subtraction) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // SUB register
  ////////////////////////////

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$7FFF // R0 = $7FFF
  with r1 ; sub r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$8000 // R0 = $8000
  with r1 ; sub r0 // R1 -= R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$7FFF // R1 = $7FFF
  sub r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$8000 // R1 = $8000
  sub r1 // R0 -= R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$7FFF // R2 = $7FFF
  sub r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$8000 // R2 = $8000
  sub r2 // R0 -= R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$7FFF // R3 = $7FFF
  sub r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$8000 // R3 = $8000
  sub r3 // R0 -= R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$7FFF // R4 = $7FFF
  sub r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$8000 // R4 = $8000
  sub r4 // R0 -= R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$7FFF // R5 = $7FFF
  sub r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$8000 // R5 = $8000
  sub r5 // R0 -= R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$7FFF // R6 = $7FFF
  sub r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$8000 // R6 = $8000
  sub r6 // R0 -= R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$7FFF // R7 = $7FFF
  sub r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$8000 // R7 = $8000
  sub r7 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$7FFF // R8 = $7FFF
  sub r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$8000 // R8 = $8000
  sub r8 // R0 -= R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$7FFF // R9 = $7FFF
  sub r9 // R0 -= R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$8000 // R9 = $8000
  sub r9 // R0 -= R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$7FFF // R10 = $7FFF
  sub r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$8000 // R10 = $8000
  sub r10 // R0 -= R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$7FFF // R11 = $7FFF
  sub r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$8000 // R11 = $8000
  sub r11 // R0 -= R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$7FFF // R12 = $7FFF
  sub r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$8000 // R12 = $8000
  sub r12 // R0 -= R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$7FFF // R13 = $7FFF
  sub r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$8000 // R13 = $8000
  sub r13 // R0 -= R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$7FFF // R14 = $7FFF
  sub r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$8000 // R14 = $8000
  sub r14 // R0 -= R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$BDD0 // R0 = $BDD0
  sub r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$BDD5 // R0 = $BDD5
  sub r15 // R0 -= R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // SUB #const
  ////////////////////////////

  iwt r0, #$0000 // R0 = $0000
  sub #0 // R0 -= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8000 // R0 = $8000
  sub #0 // R0 -= 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0001 // R0 = $0001
  sub #1 // R0 -= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8001 // R0 = $8001
  sub #1 // R0 -= 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0002 // R0 = $0002
  sub #2 // R0 -= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8002 // R0 = $8002
  sub #2 // R0 -= 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0003 // R0 = $0003
  sub #3 // R0 -= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8003 // R0 = $8003
  sub #3 // R0 -= 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0004 // R0 = $0004
  sub #4 // R0 -= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8004 // R0 = $8004
  sub #4 // R0 -= 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0005 // R0 = $0005
  sub #5 // R0 -= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8005 // R0 = $8005
  sub #5 // R0 -= 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0006 // R0 = $0006
  sub #6 // R0 -= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8006 // R0 = $8006
  sub #6 // R0 -= 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0007 // R0 = $0007
  sub #7 // R0 -= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8007 // R0 = $8007
  sub #7 // R0 -= 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0008 // R0 = $0008
  sub #8 // R0 -= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8008 // R0 = $8008
  sub #8 // R0 -= 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$0009 // R0 = $0009
  sub #9 // R0 -= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8009 // R0 = $8009
  sub #9 // R0 -= 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000A // R0 = $000A
  sub #10 // R0 -= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800A // R0 = $800A
  sub #10 // R0 -= 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000B // R0 = $000B
  sub #11 // R0 -= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800B // R0 = $800B
  sub #11 // R0 -= 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000C // R0 = $000C
  sub #12 // R0 -= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800C // R0 = $800C
  sub #12 // R0 -= 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000D // R0 = $000D
  sub #13 // R0 -= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800D // R0 = $800D
  sub #13 // R0 -= 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000E // R0 = $000E
  sub #14 // R0 -= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800E // R0 = $800E
  sub #14 // R0 -= 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$000F // R0 = $000F
  sub #15 // R0 -= 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$800F // R0 = $800F
  sub #15 // R0 -= 15

  stop // Stop GSU
  nop // Delay Slot