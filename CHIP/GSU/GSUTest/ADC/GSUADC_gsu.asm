// SNES GSU Test ADC (Add With Carry) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // ADC register
  ////////////////////////////

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$8001 // R0 = $8001
  with r1 ; adc r0 // R1 += R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$7FFF // R1 = $7FFF
  iwt r0, #$7FFF // R0 = $7FFF
  with r1 ; adc r0 // R1 += R0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$8001 // R1 = $8001
  adc r1 // R0 += R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r1, #$7FFF // R1 = $7FFF
  adc r1 // R0 += R1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$8001 // R2 = $8001
  adc r2 // R0 += R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r2, #$7FFF // R2 = $7FFF
  adc r2 // R0 += R2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$8001 // R3 = $8001
  adc r3 // R0 += R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r3, #$7FFF // R3 = $7FFF
  adc r3 // R0 += R3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$8001 // R4 = $8001
  adc r4 // R0 += R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r4, #$7FFF // R4 = $7FFF
  adc r4 // R0 += R4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$8001 // R5 = $8001
  adc r5 // R0 += R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r5, #$7FFF // R5 = $7FFF
  adc r5 // R0 += R5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$8001 // R6 = $8001
  adc r6 // R0 += R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r6, #$7FFF // R6 = $7FFF
  adc r6 // R0 += R6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$8001 // R7 = $8001
  adc r7 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r7, #$7FFF // R7 = $7FFF
  adc r7 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$8001 // R8 = $8001
  adc r8 // R0 += R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r8, #$7FFF // R8 = $7FFF
  adc r8 // R0 += R8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$8001 // R9 = $8001
  adc r9 // R0 += R7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r9, #$7FFF // R9 = $7FFF
  adc r9 // R0 += R9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$8001 // R10 = $8001
  adc r10 // R0 += R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r10, #$7FFF // R10 = $7FFF
  adc r10 // R0 += R10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$8001 // R11 = $8001
  adc r11 // R0 += R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r11, #$7FFF // R11 = $7FFF
  adc r11 // R0 += R11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$8001 // R12 = $8001
  adc r12 // R0 += R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r12, #$7FFF // R12 = $7FFF
  adc r12 // R0 += R12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$8001 // R13 = $8001
  adc r13 // R0 += R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r13, #$7FFF // R13 = $7FFF
  adc r13 // R0 += R13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$8001 // R14 = $8001
  adc r14 // R0 += R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFF // R0 = $7FFF
  iwt r14, #$7FFF // R14 = $7FFF
  adc r14 // R0 += R14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$420E // R0 = $420E
  adc r15 // R0 += R15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$4205 // R0 = $4205
  adc r15 // R0 += R15

  stop // Stop GSU
  nop // Delay Slot

  ////////////////////////////
  // ADC #const
  ////////////////////////////

  iwt r0, #$0000 // R0 = $0000
  adc #0 // R0 += 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$8000 // R0 = $8000
  adc #0 // R0 += 0

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  adc #1 // R0 += 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFE // R0 = $7FFE
  adc #1 // R0 += 1

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFE // R0 = $FFFE
  adc #2 // R0 += 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFD // R0 = $7FFD
  adc #2 // R0 += 2

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFD // R0 = $FFFD
  adc #3 // R0 += 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFC // R0 = $7FFC
  adc #3 // R0 += 3

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFC // R0 = $FFFC
  adc #4 // R0 += 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFB // R0 = $7FFB
  adc #4 // R0 += 4

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFB // R0 = $FFFB
  adc #5 // R0 += 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FFA // R0 = $7FFA
  adc #5 // R0 += 5

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFA // R0 = $FFFA
  adc #6 // R0 += 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF9 // R0 = $7FF9
  adc #6 // R0 += 6

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF9 // R0 = $FFF9
  adc #7 // R0 += 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF8 // R0 = $7FF8
  adc #7 // R0 += 7

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF8 // R0 = $FFF8
  adc #8 // R0 += 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF7 // R0 = $7FF7
  adc #8 // R0 += 8

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF7 // R0 = $FFF7
  adc #9 // R0 += 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF6 // R0 = $7FF6
  adc #9 // R0 += 9

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF6 // R0 = $FFF6
  adc #10 // R0 += 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF5 // R0 = $7FF5
  adc #10 // R0 += 10

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF5 // R0 = $FFF5
  adc #11 // R0 += 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF4 // R0 = $7FF4
  adc #11 // R0 += 11

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF4 // R0 = $FFF4
  adc #12 // R0 += 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF3 // R0 = $7FF3
  adc #12 // R0 += 12

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF3 // R0 = $FFF3
  adc #13 // R0 += 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF2 // R0 = $7FF2
  adc #13 // R0 += 13

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF2 // R0 = $FFF2
  adc #14 // R0 += 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF1 // R0 = $7FF1
  adc #14 // R0 += 14

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFF1 // R0 = $FFF1
  adc #15 // R0 += 15

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$7FF0 // R0 = $7FF0
  adc #15 // R0 += 15

  stop // Stop GSU
  nop // Delay Slot