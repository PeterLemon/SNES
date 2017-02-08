// SNES GSU 2BPP 256x128 Plot Line Demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  sub r0 // R0 = 0
  cmode // Set Color Mode

  // Fill Screen With Clear Color
  sub r0 // R0 = 0 (Fill Value)
  iwt r3, #$0000 // R3 = Screen Base (SRAM Destination)
  iwt r12, #(256*128)/8 // R12 = Loop Count
  move r13, r15 // R13 = Loop Address
  // Loop:
    stw (r3) // Store Fill Value Word To Screen Base
    inc r3 // Screen Base++
    loop // IF (Loop Count != 0) Loop
    inc r3 // Screen Base++ (Delay Slot)

  // Plot Line Color From X0/Y0 To X1/Y1 Location
  ibt r0, #1 // R0 = Color #1
  color // Set Value In COLOR

  iwt r1, #0 // R1 = X0
  iwt r2, #0 // R2 = Y0
  iwt r3, #255 // R3 = X1
  iwt r4, #127 // R4 = Y1

  with r5 ; sub r5 // R5 = 0
  from r3 ; to r7 ; sub r1 // R7 = DX (X1 - X0)
  bpl SXPos
  inc r5 // IF (X1 > X0), R5 (SX) = 1 (Delay Slot)
  dec r5 // IF (X1 < X0), R5 (SX) = -1
  dec r5 // R5 = -1
  with r7 ; not // R7 ~= R7
  inc r7 // R7 = ABS(DX)
  SXPos:

  with r6 ; sub r6 // R6 = 0
  from r4 ; to r8 ; sub r2 // R8 = DY (Y1 - Y0)
  bpl SYPos
  inc r6 // IF (Y1 > Y0), R6 (SY) = 1 (Delay Slot)
  dec r6 // IF (Y1 < Y0), R6 (SY) = -1
  dec r6 // R6 = -1
  with r8 ; not // R8 ~= R8
  inc r8 // R8 = ABS(DY)
  SYPos:

  from r7 ; cmp r8 // Compare DX To DY
  blt RunY

  from r7 ; to r4 ; lsr // IF (DX >= DY), R4 (X Error) = R7 (DX) / 2 (X Error = DX / 2)
  move r12, r7 // R12 = Loop Count (DX)
  inc r12 // R12++
  move r13, r15 // R13 = Loop Address
  // LoopX:
    plot // Plot Color (R1++)
    with r4 ; sub r8 // Subtract R8 (DY) From R4 (X Error) & Compare R4 (X Error) To Zero (X Error -= DY)
    bge XEnd
    with r2 ; add r6 // IF (X Error < 0), Add R6 (SY) To R2 (Y0) (Y0 += SY)
    with r4 ; add r7 // IF (X Error < 0), Add R7 (DX) To R4 (X Error) (X Error += DX)
    XEnd:
      with r1 ; add r5 // Add R5 (SX) To R1 (X0) (X0 += SX)
      loop // LoopX, IF (X0 == X1), Line End
      dec r1 // R1-- (Delay Slot)
      bra LineEnd

  RunY:
  from r8 ; to r3 ; lsr // IF (DX < DY), R3 (Y Error) = R8 (DY) / 2 (Y Error = DY / 2)
  move r12, r8 // R12 = Loop Count (DY)
  inc r12 // R12++
  move r13, r15 // R13 = Loop Address
  // LoopY:
    plot // Plot Color (R1++)
    with r3 ; sub r7 // Subtract R7 (DX) From R3 (Y Error) & Compare R1 (Y Error) To Zero
    bge YEnd
    with r1 ; add r5 // IF (Y Error < 0), Add R5 (SX) To R1 (X0) (X0 += SX)
    with r3 ; add r8 // IF (Y Error < 0), Add R8 (DY) To R3 (Y Error) (Y Error += DY)
    YEnd:
      with r2 ; add r6 // Add R6 (SY) To R2 (Y0) (Y0 += SY)
      loop // LoopY, IF (Y0 == Y1), Line End
      dec r1 // R1-- (Delay Slot)

  LineEnd:
    rpix // Flush Pixel Cache

  stop // Stop GSU
  nop // Delay Slot