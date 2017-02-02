// SNES GSU 4BPP 256x192 Plot Line Demo (GSU Code) by krom (Peter Lemon):
arch snes.gsu

GSUStart:
  sub r0 // R0 = 0
  cmode // Set Color Mode

  // Fill Screen With Clear Color
  sub r0 // R0 = 0 (Fill Value)
  iwt r3, #$0000 // R3 = Screen Base (SRAM Destination)
  iwt r12, #(256*192)/4 // R12 = Loop Count
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
  iwt r4, #191 // R4 = Y1

  move r0, r3 // R0 = X1
  sub r1 // R0 = DX (X1 - X0)
  blt SXNeg
  nop // Delay Slot
  ibt r5, #1 // IF (X1 > X0), R5 (SX) =	1
  bpl SXPos
  nop // Delay Slot
  SXNeg:
  ibt r5, #-1 // IF (X1 < X0), R5 (SX) = -1
  move r7, r0 // R7 = DX
  sub r0 // R0 = 0
  sub r7 // R0 = ABS(DX)
  SXPos:
  move r7, r0 // R7 = DX

  move r0, r4 // R0 = Y1
  sub r2 // R0 = DY (Y1 - Y0)
  blt SYNeg
  nop // Delay Slot
  ibt r6, #1 // IF (Y1 > Y0), R6 (SY) =	1
  bpl SYPos
  nop // Delay Slot
  SYNeg:
  ibt r6, #-1 // IF (Y1 < Y0), R6 (SY) = -1 (Delay Slot)
  move r8, r0 // R8 = DY
  sub r0 // R0 = 0
  sub r8 // R0 = ABS(DY)
  SYPos:
  move r8, r0 // R8 = DY

  move r0, r7 // R0 = DX
  cmp r8 // Compare DX To DY
  blt RunY
  nop // Delay Slot

  move r0, r7 // R0 = DX
  lsr // IF (DX >= DY), R4 (X Error) = R7 (DX) / 2 (X Error = DX / 2)
  move r4, r0 // R4 = X Error
  move r12, r7 // R12 = Loop Count (DX)
  inc r12 // R12++
  move r13, r15 // R13 = Loop Address
  // LoopX:
    plot // Plot Color (R1++)

    move r0, r4 // R0 = X Error
    sub r8 // Subtract R8 (DY) From R4 (X Error) & Compare R4 (X Error) To Zero (X Error -= DY)
    move r4, r0 // R4 = X Error
    bge XEnd
    nop // Delay Slot

    move r0, r2 // R0 = Y0
    add r6 // IF (X Error < 0), Add R6 (SY) To R2 (Y0) (Y0 += SY)
    move r2, r0 // R2 = Y0

    move r0, r4 // R0 = X Error
    add r7 // IF (X Error < 0), Add R7 (DX) To R4 (X Error) (X Error += DX)
    move r4, r0 // R4 = X Error

    XEnd:
    move r0, r1 // R0 = X0
    add r5 // Add R5 (SX) To R1 (X0) (X0 += SX)
    move r1, r0 // R1 = X0

    loop // LoopX, IF (X0 == X1), Line End
    dec r1 // R1-- (Delay Slot)
    bra LineEnd
    nop // Delay Slot

  RunY:
  move r0, r8 // R0 = DY
  lsr // IF (DX < DY), R3 (Y Error) = R8 (DY) / 2 (Y Error = DY / 2)
  move r3, r0 // R3 = Y Error
  move r12, r8 // R12 = Loop Count (DY)
  inc r12 // R12++
  move r13, r15 // R13 = Loop Address
  // LoopY:
    plot // Plot Color (R1++)

    move r0, r3 // R0 = Y Error
    sub r7 // Subtract R7 (DX) From R3 (Y Error) & Compare R1 (Y Error) To Zero
    move r3, r0 // R4 = Y Error
    bge YEnd
    nop // Delay Slot

    move r0, r1 // R0 = X0
    add r5 // IF (Y Error < 0), Add R5 (SX) To R1 (X0) (X0 += SX)
    move r1, r0 // R1 = X0

    move r0, r3 // R0 = Y Error
    add r8 // IF (Y Error < 0), Add R8 (DY) To R3 (Y Error) (Y Error += DY)
    move r3, r0 // R3 = Y Error

    YEnd:
    move r0, r2 // R0 = Y0
    add r6 // Add R6 (SY) To R2 (Y0) (Y0 += SY)
    move r2, r0 // R2 = Y0

    loop // LoopY, IF (Y0 == Y1), Line End
    dec r1 // R1-- (Delay Slot)

  LineEnd:
    rpix // Flush Pixel Cache

  stop // Stop GSU
  nop // Delay Slot