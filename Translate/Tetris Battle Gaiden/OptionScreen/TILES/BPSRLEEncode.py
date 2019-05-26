from itertools import *

# BPS SNES RLE Encode
BLOCKRAW = 0x00   # BLOCK: RAW Copy 7-Bit "0x00 + LENGTH (1..127), RAW BYTES"
BLOCKRLE = 0x80   # BLOCK: RLE Copy 7-Bit "0x80 + LENGTH (1..127), RLE BYTE"
# BLOCK: END "0x00, 0xFF"

fileeven = [] # Clear EVEN Byte Array
fileodd = [] # Clear ODD Byte Array
filein = open('OptionScreenENGVRAM$0000..$2000.bin', 'rb')
byteevenin = filein.read(1)
byteoddin = filein.read(1)
while byteevenin: # Load EVEN/ODD Byte Array
    fileeven.append(ord(byteevenin)) # Convert Byte To Int
    fileodd.append(ord(byteoddin)) # Convert Byte To Int
    byteevenin = filein.read(1)
    byteoddin = filein.read(1)
filein.close()

groupeven = [(len(list(group)),name) for name, group in groupby(fileeven)] # Group EVEN Bytes
groupodd = [(len(list(group)),name) for name, group in groupby(fileodd)] # Group ODD Bytes

out = [] # RLE EVEN/ODD Byte Output

def compress(group):
    rawbytes = [] # RAW Bytes
    groupcount = 0 # Group Count
    for (length, byte) in group:
        if length >= 3: # IF RLE Length >= 3
            if len(rawbytes) > 0: # IF RAW Length > 0
                if len(rawbytes) > 127:
                    while len(rawbytes) > 127: # WHILE RAW Length > 127
                        out.append(BLOCKRAW+127) # Output RAW Length 127
                        for rawbyte in range(127): out.append(rawbytes[rawbyte]) # Output 127 RAW Bytes
                        del rawbytes[0:127] # RAW Length -= 127
                out.append(BLOCKRAW+len(rawbytes)) # Output RAW Length Byte
                for rawbyte in rawbytes: out.append(rawbyte) # Output RAW Bytes
                rawbytes = [] # Reset RAW Bytes
            if length > 127: # IF RLE Length > 127
                while length > 127: # WHILE RLE Length > 127
                    out.append(BLOCKRLE+127) # Output RLE Length 127
                    out.append(byte) # Output RLE Byte
                    length -= 127 # RLE Length -= 127
            out.append(BLOCKRLE+length) # Output RLE Length
            out.append(byte) # Output RLE Byte
        else: # ELSE RLE Length < 3
            if length == 2 and group[groupcount+1][0] > 2: # IF RLELength == 2 && Next RLELength > 2
                if len(rawbytes) > 0: # IF RAW Length > 0
                    if len(rawbytes) > 127:
                        while len(rawbytes) > 127: # WHILE RAW Length > 127
                            out.append(BLOCKRAW+127) # Output RAW Length 127
                            for rawbyte in range(127): out.append(rawbytes[rawbyte]) # Output 127 RAW Bytes
                            del rawbytes[0:127] # RAW Length -= 127
                    out.append(BLOCKRAW+len(rawbytes)) # Output RAW Length Byte
                    for rawbyte in rawbytes: out.append(rawbyte) # Output RAW Bytes
                    rawbytes = [] # Reset RAW Bytes
                out.append(BLOCKRLE+length) # Output RLE Length
                out.append(byte) # Output RLE Byte
            else:
                for i in range(length): rawbytes.append(byte) # Store Next RAW Bytes
        groupcount += 1 # Group Count++
    out.append(0x00) # Output RLE BLOCK END Bytes (0x00, 0xFF)
    out.append(0xFF)

compress(groupeven)
compress(groupodd)

fileout = open('OptionScreen.rle', 'wb')
for byte in out: fileout.write(b"%c" %byte)
fileout.close()
