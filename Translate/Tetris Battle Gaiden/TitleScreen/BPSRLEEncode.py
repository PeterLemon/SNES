from itertools import *

# BPS SNES RLE Encode
BLOCKRAW = 0x00   # BLOCK: RAW Copy 7-Bit "0x00 + LENGTH (1..127), RAW BYTES"
BLOCKRLE = 0x80   # BLOCK: RLE Copy 7-Bit "0x80 + LENGTH (1..127), RLE BYTE"
# BLOCK: END "0x00, 0xFF"

fileeven = [] # Clear EVEN Byte Array
fileodd = [] # Clear ODD Byte Array
filein = open('TitleScreenENGVRAM$C000.bin', 'rb')
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
    rawlength = 0 # RAW Length
    rawbytes = [] # RAW Bytes
    for (length, byte) in group:
        if length >= 3: # IF RLE Length >= 3
            if rawlength > 0: # IF RAW Length > 0
                out.append(BLOCKRAW+rawlength) # Output RAW Length Byte
                for rawbyte in rawbytes: # Output RAW Bytes
                    out.append(rawbyte)
                rawlength = 0 # Reset RAW Length
                rawbytes = [] # Reset RAW Bytes
            if length > 127: # IF RLE Length > 127
                while length > 127: # WHILE RLE Length > 127
                    out.append(BLOCKRLE+127) # Output RLE Length 127
                    out.append(byte) # Output RLE Byte
                    length -= 127 # RLE Length -= 127
                out.append(BLOCKRLE+length) # Output RLE Length Remaining
                out.append(byte) # Output RLE Byte
            else:
                out.append(BLOCKRLE+length) # Output RLE Length
                out.append(byte) # Output RLE Byte
        else: # ELSE RLE Length < 3
            rawlength += length # RAW Length += Length
            for i in range(length): # Store Next RAW Bytes
                rawbytes.append(byte)
    out.append(0x00) # Output RLE END EVEN Bytes
    out.append(0xFF)

compress(groupeven)
compress(groupodd)

fileout = open('TitleScreen.rle', 'wb')
for byte in out: fileout.write(b"%c" %byte)
fileout.close()
