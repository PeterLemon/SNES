// SNES GSU Test LOB (Lo Byte) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // LOB register
  ////////////////////////////

  iwt r0, #$FF00 // R0 = $FF00
  lob // R0 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r0, #$FFFF // R0 = $FFFF
  lob // R0 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FF00 // R1 = $FF00
  with r1 ; lob // R1 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r1, #$FFFF // R1 = $FFFF
  with r1 ; lob // R1 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FF00 // R2 = $FF00
  with r2 ; lob // R2 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r2, #$FFFF // R2 = $FFFF
  with r2 ; lob // R2 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FF00 // R3 = $FF00
  with r3 ; lob // R3 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r3, #$FFFF // R3 = $FFFF
  with r3 ; lob // R3 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FF00 // R4 = $FF00
  with r4 ; lob // R4 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r4, #$FFFF // R4 = $FFFF
  with r4 ; lob // R4 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FF00 // R5 = $FF00
  with r5 ; lob // R5 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r5, #$FFFF // R5 = $FFFF
  with r5 ; lob // R5 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FF00 // R6 = $FF00
  with r6 ; lob // R6 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r6, #$FFFF // R6 = $FFFF
  with r6 ; lob // R6 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FF00 // R7 = $FF00
  with r7 ; lob // R7 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$FFFF // R7 = $FFFF
  with r7 ; lob // R7 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FF00 // R8 = $FF00
  with r8 ; lob // R8 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r8, #$FFFF // R8 = $FFFF
  with r8 ; lob // R8 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FF00 // R9 = $FF00
  with r9 ; lob // R9 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r9, #$FFFF // R9 = $FFFF
  with r9 ; lob // R9 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FF00 // R10 = $FF00
  with r10 ; lob // R10 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r10, #$FFFF // R10 = $FFFF
  with r10 ; lob // R10 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FF00 // R11 = $FF00
  with r11 ; lob // R11 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r11, #$FFFF // R11 = $FFFF
  with r11 ; lob // R11 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FF00 // R12 = $FF00
  with r12 ; lob // R12 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r12, #$FFFF // R12 = $FFFF
  with r12 ; lob // R12 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FF00 // R13 = $FF00
  with r13 ; lob // R13 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r13, #$FFFF // R13 = $FFFF
  with r13 ; lob // R13 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FF00 // R14 = $FF00
  with r14 ; lob // R14 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  iwt r14, #$FFFF // R14 = $FFFF
  with r14 ; lob // R14 &= $FF

  stop // Stop GSU
  nop // Delay Slot

  to r0 ; from r15 ; lob // R0 = R15 & $FF

  stop // Stop GSU
  nop // Delay Slot