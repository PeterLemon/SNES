# Konami SNES RLE Compress
BLOCKRAW = 0x80      # BLOCK: RAW Copy 5-Bit "0x80 + LENGTH (0..31), DATA.."
BLOCKRLEZERO4 = 0xE0 # BLOCK: RLE Zero 4-Bit "0xE0 + LENGTH-2 (2..17)"
BLOCKRLEZERO8 = 0xFF # BLOCK: RLE Zero 8-Bit "0xFF,  LENGTH-2 (2..257)"

RAWRLELENGTH = []
# 1st PASS: Get RAW & Zero Run Data Lengths From File in Order
with open("FontENG.pic", "rb") as fin:
    bytein = fin.read(1)
    rawcount = 0
    zerocount = 0
    while bytein:
        if bytein != b'\x00': # RAW Copy Block
            if zerocount >= 3:
                if zerocount >= 258: # RLE Data > MAX LENGTH
                    while zerocount >= 258:
                        RAWRLELENGTH.append(BLOCKRLEZERO8)
                        RAWRLELENGTH.append(0xFF)
                        zerocount -= 257
                        
                RAWRLELENGTH.append(BLOCKRLEZERO8)
                RAWRLELENGTH.append(zerocount-2)
            else:
                rawcount += zerocount
            rawcount += 1
            zerocount = 0
        else: # RLE Zero Block (bytein == b'\x00')
            if zerocount == 3:
                if rawcount != 0:
                    RAWRLELENGTH.append(BLOCKRAW+rawcount)
                rawcount = 0
            zerocount += 1

        if rawcount >= 31: # MAX RAW Copy Length Check
            RAWRLELENGTH.append(BLOCKRAW+31)
            rawcount -= 31
            zerocount = 0
        bytein = fin.read(1)
fin.close()

# Get Last Remaing Block (IF Any) After File Has Been Read
# RLE Zero Block
if zerocount >= 3:
    if zerocount >= 258: # RLE Data > MAX LENGTH
        while zerocount >= 258:
            RAWRLELENGTH.append(BLOCKRLEZERO8)
            RAWRLELENGTH.append(0xFF)
            zerocount -= 257
    RAWRLELENGTH.append(BLOCKRLEZERO8)
    RAWRLELENGTH.append(zerocount-2)
else:
    rawcount += zerocount
# RAW Copy Block
if rawcount >= 31: # MAX RAW Copy Length Check
    RAWRLELENGTH.append(BLOCKRAW+31)
    rawcount -= 31
if rawcount != 0:
    RAWRLELENGTH.append(BLOCKRAW+rawcount)

# 2nd PASS: Save Lengths & RAW Data To File
fout = open("FontENG.rle", "wb")
i = 0
bytelength = 2
fout.write(b"%c" %0x00) # 2 Byte Pad For Byte Length
fout.write(b"%c" %0x00)
with open("FontENG.pic", "rb") as fin:
    while i < len(RAWRLELENGTH):
        if RAWRLELENGTH[i] != 255: # RAW Copy Bytes
            fout.write(b"%c" %RAWRLELENGTH[i])
            bytelength += 1
            rawcount = RAWRLELENGTH[i] - BLOCKRAW
            while rawcount != 0:
                bytein = fin.read(1)
                fout.write(bytein)
                bytelength += 1
                rawcount -= 1
            i += 1
        
        else: # RLE Zero Bytes
            if RAWRLELENGTH[i+1] >= 16:
                fout.write(b"%c" %RAWRLELENGTH[i])
                bytelength += 1
                i += 1
                fout.write(b"%c" %RAWRLELENGTH[i])
                bytelength += 1
            else:
                i += 1
                fout.write(b"%c" %(BLOCKRLEZERO4+RAWRLELENGTH[i]))
                bytelength += 1
            rlecount = RAWRLELENGTH[i] + 2
            while rlecount != 0:
                bytein = fin.read(1)
                rlecount -= 1
            i += 1
fout.seek(0) #get to the first position
fout.write(b"%c" %(bytelength & 0xFF))
fout.write(b"%c" %(bytelength >> 8))
fin.close()
fout.close()
print("Compressed Byte Length = %d" %bytelength)
