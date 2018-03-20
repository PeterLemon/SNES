colbri = []
for col in range(32):
    for bri in range(16):
        colbri.append(((col+1)/16)*(bri+1))
        #print('Color = 0x%02X, Brightness = 0x%01X, Calculation = %f' %(col, bri, ((col+1)/16)*(bri+1)))

print('COLHDMATable:')
currentcol = 0x1F
currentbri = 0xF
currentcolbri = 32.0
for scanline in range(224):
    #print('Color = 0x%02X, Brightness = 0x%01X, Calculation = %f' %(currentcol, currentbri, currentcolbri))
    print('  db $01; dw $0000, $00%02X // Repeat 1 Scanline, Palette Address 0, Gradient Color %d' %(currentcol, scanline))
    tempcol = 0
    tempbri = 0
    tempcolbri = 0.0
    for col in range(32):
        for bri in range(16):
            if colbri[(col*16)+bri] < currentcolbri and colbri[(col*16)+bri] > tempcolbri and col != currentcol and bri != currentbri:
                tempcolbri = colbri[(col*16)+bri]
                tempcol = col
                tempbri = bri
    currentcolbri = tempcolbri
    currentcol = tempcol
    currentbri = tempbri
print('  db $00 // End Of HDMA\n')

print('BRIHDMATable:')
currentcol = 0x1F
currentbri = 0xF
currentcolbri = 32.0
for scanline in range(224):
    #print('Color = 0x%02X, Brightness = 0x%01X, Calculation = %f' %(currentcol, currentbri, currentcolbri))
    print('  db $01, $%01X // Repeat 1 Scanline, Screen Brightness %d' %(currentbri, scanline))
    tempcol = 0
    tempbri = 0
    tempcolbri = 0.0
    for col in range(32):
        for bri in range(16):
            if colbri[(col*16)+bri] < currentcolbri and colbri[(col*16)+bri] > tempcolbri and col != currentcol and bri != currentbri:
                tempcolbri = colbri[(col*16)+bri]
                tempcol = col
                tempbri = bri
    currentcolbri = tempcolbri
    currentcol = tempcol
    currentbri = tempbri
print('  db $00 // End Of HDMA')
                
