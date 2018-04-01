// SNES GSU Test Cache Injection demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  ////////////////////////////
  // Cache Injection Code
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

  fill 10 // PAD Cache Line (16 Bytes)