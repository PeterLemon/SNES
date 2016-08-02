import math

cam_pos_y = 80 # Camera Position Y

twoPI = math.pi * 2
points = 48 # Number Of Direction Points
angle = 0 # Direction Angle

while angle < points:
  print ("M7NSINTable%d: // Mode7 -SIN (C) Table 224 * Rotation / Scaling Ratios (Last 8-Bits Fractional)" % angle)

  g_cosf = math.cos((twoPI / points) * angle) # cos(phi)
  g_sinf = math.sin((twoPI / points) * angle) # sin(phi)

  REG_VCOUNT = 1 # Scanline

  while REG_VCOUNT <= 224:

    # Zoom * Rotation

    lam = cam_pos_y / REG_VCOUNT # lam = ScaleXY

    M7_NSIN = -g_sinf * lam # M7C = -SIN(angle) * ScaleXY

    print ("db $01; dw", round(M7_NSIN*256), "// Repeat 1 Scanline, Mode7 -SIN Scanline", REG_VCOUNT)
    REG_VCOUNT += 1

  print ("db $00 // End Of HDMA")
  angle += 1
