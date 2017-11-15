// SNES GSU Test MERGE (Hi R7 + Hi R8) demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // MERGE register
  ////////////////////////////

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  merge // R0 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  merge // R0 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r1 ; merge // R1 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r1 ; merge // R1 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r2 ; merge // R2 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r2 ; merge // R2 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r3 ; merge // R3 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r3 ; merge // R3 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r4 ; merge // R4 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r4 ; merge // R4 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r5 ; merge // R5 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r5 ; merge // R5 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r6 ; merge // R6 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r6 ; merge // R6 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r7 ; merge // R7 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r7 ; merge // R7 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r8 ; merge // R8 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r8 ; merge // R8 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r9 ; merge // R9 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r9 ; merge // R9 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r10 ; merge // R10 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r10 ; merge // R10 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r11 ; merge // R11 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r11 ; merge // R11 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r12 ; merge // R12 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r12 ; merge // R12 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r13 ; merge // R13 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r13 ; merge // R13 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$00FF // R7 = $00FF
  iwt r8, #$00FF // R8 = $00FF
  with r14 ; merge // R14 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot

  iwt r7, #$C0FF // R7 = $C0FF
  iwt r8, #$30FF // R8 = $30FF
  with r14 ; merge // R14 = (R7 & $FF00) + (R8 / $100)

  stop // Stop GSU
  nop // Delay Slot