// SNES GSU Plot Pixel Demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  nop

  sub r0 // R0 = 0
  cmode // Set Color Mode

  ibt r0, #2 // R0 = Color
  color // Set Value In COLOR
  ibt r1, #2 // R1 = Start X Position
  ibt r2, #6 // R2 = Start Y Position
  plot // Plot Color
  rpix // Flush Pixel Cache

  stop // Stop GSU
  nop // Delay Slot