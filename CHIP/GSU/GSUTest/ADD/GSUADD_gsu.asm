// SNES GSU Test ADD (Addition) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // ADD register
  ////////////////////////////

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$8001 // R0 = $8001
  with r1 ; add r0 // R1 += R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$7FFF // R0 = $7FFF
  with r1 ; add r0 // R1 += R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$8001 // R1 = $8001
  add r1 // R0 += R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$7FFF // R1 = $7FFF
  add r1 // R0 += R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$8001 // R2 = $8001
  add r2 // R0 += R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$7FFF // R2 = $7FFF
  add r2 // R0 += R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$8001 // R3 = $8001
  add r3 // R0 += R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$7FFF // R3 = $7FFF
  add r3 // R0 += R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$8001 // R4 = $8001
  add r4 // R0 += R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$7FFF // R4 = $7FFF
  add r4 // R0 += R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$8001 // R5 = $8001
  add r5 // R0 += R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$7FFF // R5 = $7FFF
  add r5 // R0 += R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$8001 // R6 = $8001
  add r6 // R0 += R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$7FFF // R6 = $7FFF
  add r6 // R0 += R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$8001 // R7 = $8001
  add r7 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$7FFF // R7 = $7FFF
  add r7 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$8001 // R8 = $8001
  add r8 // R0 += R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$7FFF // R8 = $7FFF
  add r8 // R0 += R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$8001 // R9 = $8001
  add r9 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$7FFF // R9 = $7FFF
  add r9 // R0 += R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$8001 // R10 = $8001
  add r10 // R0 += R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$7FFF // R10 = $7FFF
  add r10 // R0 += R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$8001 // R11 = $8001
  add r11 // R0 += R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$7FFF // R11 = $7FFF
  add r11 // R0 += R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$8001 // R12 = $8001
  add r12 // R0 += R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$7FFF // R12 = $7FFF
  add r12 // R0 += R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$8001 // R13 = $8001
  add r13 // R0 += R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$7FFF // R13 = $7FFF
  add r13 // R0 += R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$8001 // R14 = $8001
  add r14 // R0 += R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$7FFF // R14 = $7FFF
  add r14 // R0 += R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$4233 // R0 = $4233
  add r15 // R0 += R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$422B // R0 = $422B
  add r15 // R0 += R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // ADD #const
  ////////////////////////////

  iwt r0, #$0000 // R0 = $0000
  add #0 // R0 += 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8000 // R0 = $8000
  add #0 // R0 += 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  add #1 // R0 += 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  add #1 // R0 += 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  add #2 // R0 += 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFE // R0 = $7FFE
  add #2 // R0 += 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFD // R0 = $FFFD
  add #3 // R0 += 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFD // R0 = $7FFD
  add #3 // R0 += 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFC // R0 = $FFFC
  add #4 // R0 += 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFC // R0 = $7FFC
  add #4 // R0 += 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFB // R0 = $FFFB
  add #5 // R0 += 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFB // R0 = $7FFB
  add #5 // R0 += 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFA // R0 = $FFFA
  add #6 // R0 += 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFA // R0 = $7FFA
  add #6 // R0 += 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF9 // R0 = $FFF9
  add #7 // R0 += 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF9 // R0 = $7FF9
  add #7 // R0 += 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF8 // R0 = $FFF8
  add #8 // R0 += 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF8 // R0 = $7FF8
  add #8 // R0 += 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF7 // R0 = $FFF7
  add #9 // R0 += 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF7 // R0 = $7FF7
  add #9 // R0 += 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF6 // R0 = $FFF6
  add #10 // R0 += 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF6 // R0 = $7FF6
  add #10 // R0 += 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF5 // R0 = $FFF5
  add #11 // R0 += 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF5 // R0 = $7FF5
  add #11 // R0 += 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF4 // R0 = $FFF4
  add #12 // R0 += 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF4 // R0 = $7FF4
  add #12 // R0 += 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF3 // R0 = $FFF3
  add #13 // R0 += 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF3 // R0 = $7FF3
  add #13 // R0 += 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF2 // R0 = $FFF2
  add #14 // R0 += 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF2 // R0 = $7FF2
  add #14 // R0 += 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF1 // R0 = $FFF1
  add #15 // R0 += 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF1 // R0 = $7FF1
  add #15 // R0 += 15

  stop // Stop GSU
  nop // Delay Slot