# Syntax: SNESBGOBJPAL128tilerow.py image.in file.out
# Notes: in.png needs to be 256x224 pixel resolution image
# Written for Python 3.6.2 with the Pillow 4.2.1 library
import sys
import struct
import PIL.Image

def convert_pal(image, filedata): # Convert To SNES 16 Color Palette Data
    palette = image.getpalette()[:(15*3)] # Get 15 * R,G,B Palette Entries
    i = 0
    SNEScol = 0
    filedata.write(struct.pack('H', SNEScol)) # Store Black To Palette Color #0
    while i < 45:
        R = palette[i]
        G = palette[i+1]
        B = palette[i+2]
        SNEScol = ((B & 0xF8) << 7) | ((G & 0xF8) << 2) | ((R & 0xF8) >> 3)
        i += 3
        filedata.write(struct.pack('H', SNEScol))

def convert_tile(image, tilenum, filedata): # Convert To SNES 8x8 4BPP Tile Data
    pixels = image.getdata()

    tile = []
    i = tilenum * 8
    y = 0
    while y < 8:
        x = 0
        while x < 8:
            tile.append(pixels[i] + 1)
            i += 1
            x += 1
        i += 24
        y += 1

    SNEStile = []
    SNEStile.append(((tile[0] & 0x01) << 7) | ((tile[1] & 0x01) << 6) | ((tile[2] & 0x01) << 5) | ((tile[3] & 0x01) << 4) | ((tile[4] & 0x01) << 3) | ((tile[5] & 0x01) << 2) | ((tile[6] & 0x01) << 1) | ((tile[7] & 0x01) << 0)) # ROW 0, BITPlane 0
    SNEStile.append(((tile[0] & 0x02) << 6) | ((tile[1] & 0x02) << 5) | ((tile[2] & 0x02) << 4) | ((tile[3] & 0x02) << 3) | ((tile[4] & 0x02) << 2) | ((tile[5] & 0x02) << 1) | ((tile[6] & 0x02) << 0) | ((tile[7] & 0x02) >> 1)) # ROW 0, BITPlane 1
    SNEStile.append(((tile[8] & 0x01) << 7) | ((tile[9] & 0x01) << 6) | ((tile[10]& 0x01) << 5) | ((tile[11]& 0x01) << 4) | ((tile[12]& 0x01) << 3) | ((tile[13]& 0x01) << 2) | ((tile[14]& 0x01) << 1) | ((tile[15]& 0x01) << 0)) # ROW 1, BITPlane 0
    SNEStile.append(((tile[8] & 0x02) << 6) | ((tile[9] & 0x02) << 5) | ((tile[10]& 0x02) << 4) | ((tile[11]& 0x02) << 3) | ((tile[12]& 0x02) << 2) | ((tile[13]& 0x02) << 1) | ((tile[14]& 0x02) << 0) | ((tile[15]& 0x02) >> 1)) # ROW 1, BITPlane 1
    SNEStile.append(((tile[16]& 0x01) << 7) | ((tile[17]& 0x01) << 6) | ((tile[18]& 0x01) << 5) | ((tile[19]& 0x01) << 4) | ((tile[20]& 0x01) << 3) | ((tile[21]& 0x01) << 2) | ((tile[22]& 0x01) << 1) | ((tile[23]& 0x01) << 0)) # ROW 2, BITPlane 0
    SNEStile.append(((tile[16]& 0x02) << 6) | ((tile[17]& 0x02) << 5) | ((tile[18]& 0x02) << 4) | ((tile[19]& 0x02) << 3) | ((tile[20]& 0x02) << 2) | ((tile[21]& 0x02) << 1) | ((tile[22]& 0x02) << 0) | ((tile[23]& 0x02) >> 1)) # ROW 2, BITPlane 1
    SNEStile.append(((tile[24]& 0x01) << 7) | ((tile[25]& 0x01) << 6) | ((tile[26]& 0x01) << 5) | ((tile[27]& 0x01) << 4) | ((tile[28]& 0x01) << 3) | ((tile[29]& 0x01) << 2) | ((tile[30]& 0x01) << 1) | ((tile[31]& 0x01) << 0)) # ROW 3, BITPlane 0
    SNEStile.append(((tile[24]& 0x02) << 6) | ((tile[25]& 0x02) << 5) | ((tile[26]& 0x02) << 4) | ((tile[27]& 0x02) << 3) | ((tile[28]& 0x02) << 2) | ((tile[29]& 0x02) << 1) | ((tile[30]& 0x02) << 0) | ((tile[31]& 0x02) >> 1)) # ROW 3, BITPlane 1
    SNEStile.append(((tile[32]& 0x01) << 7) | ((tile[33]& 0x01) << 6) | ((tile[34]& 0x01) << 5) | ((tile[35]& 0x01) << 4) | ((tile[36]& 0x01) << 3) | ((tile[37]& 0x01) << 2) | ((tile[38]& 0x01) << 1) | ((tile[39]& 0x01) << 0)) # ROW 4, BITPlane 0
    SNEStile.append(((tile[32]& 0x02) << 6) | ((tile[33]& 0x02) << 5) | ((tile[34]& 0x02) << 4) | ((tile[35]& 0x02) << 3) | ((tile[36]& 0x02) << 2) | ((tile[37]& 0x02) << 1) | ((tile[38]& 0x02) << 0) | ((tile[39]& 0x02) >> 1)) # ROW 4, BITPlane 1
    SNEStile.append(((tile[40]& 0x01) << 7) | ((tile[41]& 0x01) << 6) | ((tile[42]& 0x01) << 5) | ((tile[43]& 0x01) << 4) | ((tile[44]& 0x01) << 3) | ((tile[45]& 0x01) << 2) | ((tile[46]& 0x01) << 1) | ((tile[47]& 0x01) << 0)) # ROW 5, BITPlane 0
    SNEStile.append(((tile[40]& 0x02) << 6) | ((tile[41]& 0x02) << 5) | ((tile[42]& 0x02) << 4) | ((tile[43]& 0x02) << 3) | ((tile[44]& 0x02) << 2) | ((tile[45]& 0x02) << 1) | ((tile[46]& 0x02) << 0) | ((tile[47]& 0x02) >> 1)) # ROW 5, BITPlane 1
    SNEStile.append(((tile[48]& 0x01) << 7) | ((tile[49]& 0x01) << 6) | ((tile[50]& 0x01) << 5) | ((tile[51]& 0x01) << 4) | ((tile[52]& 0x01) << 3) | ((tile[53]& 0x01) << 2) | ((tile[54]& 0x01) << 1) | ((tile[55]& 0x01) << 0)) # ROW 6, BITPlane 0
    SNEStile.append(((tile[48]& 0x02) << 6) | ((tile[49]& 0x02) << 5) | ((tile[50]& 0x02) << 4) | ((tile[51]& 0x02) << 3) | ((tile[52]& 0x02) << 2) | ((tile[53]& 0x02) << 1) | ((tile[54]& 0x02) << 0) | ((tile[55]& 0x02) >> 1)) # ROW 6, BITPlane 1
    SNEStile.append(((tile[56]& 0x01) << 7) | ((tile[57]& 0x01) << 6) | ((tile[58]& 0x01) << 5) | ((tile[59]& 0x01) << 4) | ((tile[60]& 0x01) << 3) | ((tile[61]& 0x01) << 2) | ((tile[62]& 0x01) << 1) | ((tile[63]& 0x01) << 0)) # ROW 7, BITPlane 0
    SNEStile.append(((tile[56]& 0x02) << 6) | ((tile[57]& 0x02) << 5) | ((tile[58]& 0x02) << 4) | ((tile[59]& 0x02) << 3) | ((tile[60]& 0x02) << 2) | ((tile[61]& 0x02) << 1) | ((tile[62]& 0x02) << 0) | ((tile[63]& 0x02) >> 1)) # ROW 7, BITPlane 1

    SNEStile.append(((tile[0] & 0x04) << 5) | ((tile[1] & 0x04) << 4) | ((tile[2] & 0x04) << 3) | ((tile[3] & 0x04) << 2) | ((tile[4] & 0x04) << 1) | ((tile[5] & 0x04) << 0) | ((tile[6] & 0x04) >> 1) | ((tile[7] & 0x04) >> 2)) # ROW 0, BITPlane 2
    SNEStile.append(((tile[0] & 0x08) << 4) | ((tile[1] & 0x08) << 3) | ((tile[2] & 0x08) << 2) | ((tile[3] & 0x08) << 1) | ((tile[4] & 0x08) << 0) | ((tile[5] & 0x08) >> 1) | ((tile[6] & 0x08) >> 2) | ((tile[7] & 0x08) >> 3)) # ROW 0, BITPlane 3
    SNEStile.append(((tile[8] & 0x04) << 5) | ((tile[9] & 0x04) << 4) | ((tile[10]& 0x04) << 3) | ((tile[11]& 0x04) << 2) | ((tile[12]& 0x04) << 1) | ((tile[13]& 0x04) << 0) | ((tile[14]& 0x04) >> 1) | ((tile[15]& 0x04) >> 2)) # ROW 1, BITPlane 2
    SNEStile.append(((tile[8] & 0x08) << 4) | ((tile[9] & 0x08) << 3) | ((tile[10]& 0x08) << 2) | ((tile[11]& 0x08) << 1) | ((tile[12]& 0x08) << 0) | ((tile[13]& 0x08) >> 1) | ((tile[14]& 0x08) >> 2) | ((tile[15]& 0x08) >> 3)) # ROW 1, BITPlane 3
    SNEStile.append(((tile[16]& 0x04) << 5) | ((tile[17]& 0x04) << 4) | ((tile[18]& 0x04) << 3) | ((tile[19]& 0x04) << 2) | ((tile[20]& 0x04) << 1) | ((tile[21]& 0x04) << 0) | ((tile[22]& 0x04) >> 1) | ((tile[23]& 0x04) >> 2)) # ROW 2, BITPlane 2
    SNEStile.append(((tile[16]& 0x08) << 4) | ((tile[17]& 0x08) << 3) | ((tile[18]& 0x08) << 2) | ((tile[19]& 0x08) << 1) | ((tile[20]& 0x08) << 0) | ((tile[21]& 0x08) >> 1) | ((tile[22]& 0x08) >> 2) | ((tile[23]& 0x08) >> 3)) # ROW 2, BITPlane 3
    SNEStile.append(((tile[24]& 0x04) << 5) | ((tile[25]& 0x04) << 4) | ((tile[26]& 0x04) << 3) | ((tile[27]& 0x04) << 2) | ((tile[28]& 0x04) << 1) | ((tile[29]& 0x04) << 0) | ((tile[30]& 0x04) >> 1) | ((tile[31]& 0x04) >> 2)) # ROW 3, BITPlane 2
    SNEStile.append(((tile[24]& 0x08) << 4) | ((tile[25]& 0x08) << 3) | ((tile[26]& 0x08) << 2) | ((tile[27]& 0x08) << 1) | ((tile[28]& 0x08) << 0) | ((tile[29]& 0x08) >> 1) | ((tile[30]& 0x08) >> 2) | ((tile[31]& 0x08) >> 3)) # ROW 3, BITPlane 3
    SNEStile.append(((tile[32]& 0x04) << 5) | ((tile[33]& 0x04) << 4) | ((tile[34]& 0x04) << 3) | ((tile[35]& 0x04) << 2) | ((tile[36]& 0x04) << 1) | ((tile[37]& 0x04) << 0) | ((tile[38]& 0x04) >> 1) | ((tile[39]& 0x04) >> 2)) # ROW 4, BITPlane 2
    SNEStile.append(((tile[32]& 0x08) << 4) | ((tile[33]& 0x08) << 3) | ((tile[34]& 0x08) << 2) | ((tile[35]& 0x08) << 1) | ((tile[36]& 0x08) << 0) | ((tile[37]& 0x08) >> 1) | ((tile[38]& 0x08) >> 2) | ((tile[39]& 0x08) >> 3)) # ROW 4, BITPlane 3
    SNEStile.append(((tile[40]& 0x04) << 5) | ((tile[41]& 0x04) << 4) | ((tile[42]& 0x04) << 3) | ((tile[43]& 0x04) << 2) | ((tile[44]& 0x04) << 1) | ((tile[45]& 0x04) << 0) | ((tile[46]& 0x04) >> 1) | ((tile[47]& 0x04) >> 2)) # ROW 5, BITPlane 2
    SNEStile.append(((tile[40]& 0x08) << 4) | ((tile[41]& 0x08) << 3) | ((tile[42]& 0x08) << 2) | ((tile[43]& 0x08) << 1) | ((tile[44]& 0x08) << 0) | ((tile[45]& 0x08) >> 1) | ((tile[46]& 0x08) >> 2) | ((tile[47]& 0x08) >> 3)) # ROW 5, BITPlane 3
    SNEStile.append(((tile[48]& 0x04) << 5) | ((tile[49]& 0x04) << 4) | ((tile[50]& 0x04) << 3) | ((tile[51]& 0x04) << 2) | ((tile[52]& 0x04) << 1) | ((tile[53]& 0x04) << 0) | ((tile[54]& 0x04) >> 1) | ((tile[55]& 0x04) >> 2)) # ROW 6, BITPlane 2
    SNEStile.append(((tile[48]& 0x08) << 4) | ((tile[49]& 0x08) << 3) | ((tile[50]& 0x08) << 2) | ((tile[51]& 0x08) << 1) | ((tile[52]& 0x08) << 0) | ((tile[53]& 0x08) >> 1) | ((tile[54]& 0x08) >> 2) | ((tile[55]& 0x08) >> 3)) # ROW 6, BITPlane 3
    SNEStile.append(((tile[56]& 0x04) << 5) | ((tile[57]& 0x04) << 4) | ((tile[58]& 0x04) << 3) | ((tile[59]& 0x04) << 2) | ((tile[60]& 0x04) << 1) | ((tile[61]& 0x04) << 0) | ((tile[62]& 0x04) >> 1) | ((tile[63]& 0x04) >> 2)) # ROW 7, BITPlane 2
    SNEStile.append(((tile[56]& 0x08) << 4) | ((tile[57]& 0x08) << 3) | ((tile[58]& 0x08) << 2) | ((tile[59]& 0x08) << 1) | ((tile[60]& 0x08) << 0) | ((tile[61]& 0x08) >> 1) | ((tile[62]& 0x08) >> 2) | ((tile[63]& 0x08) >> 3)) # ROW 7, BITPlane 3

    i = 0
    while i < 32:
        filedata.write(struct.pack('B', SNEStile[i]))
        i += 1

def convert_segment(image, height, filedata):
    for i in range(int(height/8)): # Convert Tile Data From 128 Pixel Wide Picture Segment
        tilerowsegment = image.crop((0, i*8, 32, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_tile(tilerowsegment, 0, filedata)
        convert_tile(tilerowsegment, 1, filedata)
        convert_tile(tilerowsegment, 2, filedata)
        convert_tile(tilerowsegment, 3, filedata)

        tilerowsegment = image.crop((32, i*8, 64, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_tile(tilerowsegment, 0, filedata)
        convert_tile(tilerowsegment, 1, filedata)
        convert_tile(tilerowsegment, 2, filedata)
        convert_tile(tilerowsegment, 3, filedata)

        tilerowsegment = image.crop((64, i*8, 96, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_tile(tilerowsegment, 0, filedata)
        convert_tile(tilerowsegment, 1, filedata)
        convert_tile(tilerowsegment, 2, filedata)
        convert_tile(tilerowsegment, 3, filedata)

        tilerowsegment = image.crop((96, i*8, 128, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_tile(tilerowsegment, 0, filedata)
        convert_tile(tilerowsegment, 1, filedata)
        convert_tile(tilerowsegment, 2, filedata)
        convert_tile(tilerowsegment, 3, filedata)

def main(argv=None):
    if argv is None:
        argv = sys.argv[1:]
    infilename, outfilename = argv
    outpal = open(outfilename+'.pal', 'wb')
    outtile = open(outfilename+'.pic', 'wb')
    in_img = PIL.Image.open(infilename)
    width, height = in_img.size

    # PASS 1: Convert Tile Row Palettes From Full Picture
    for i in range(int(height/8)):
        tilerowsegment = in_img.crop((0, i*8, 32, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((32, i*8, 64, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((64, i*8, 96, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((96, i*8, 128, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((128, i*8, 160, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((160, i*8, 192, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((192, i*8, 224, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

        tilerowsegment = in_img.crop((224, i*8, 256, (i*8)+8))
        tilerowsegment = tilerowsegment.convert("P", dither=PIL.Image.NONE, palette=PIL.Image.ADAPTIVE, colors=15)
        convert_pal(tilerowsegment, outpal)

    # PASS 2: Convert Tile Data From Cropped Picture Segments
    segment = in_img.crop((0, 0, 128, 64)) # Convert Tile Data From 128x64 Picture Segment (Top Left)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((128, 0, 256, 64)) # Convert Tile Data From 128x64 Picture Segment (Top Right)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((0, 64, 128, 128)) # Convert Tile Data From 128x64 Picture Segment (Upper Middle Left)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((128, 64, 256, 128)) # Convert Tile Data From 128x64 Picture Segment (Upper Middle Right)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((0, 128, 128, 192)) # Convert Tile Data From 128x64 Picture Segment (Lower Middle Left)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((128, 128, 256, 192)) # Convert Tile Data From 128x64 Picture Segment (Lower Middle Right)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((0, 192, 128, 224)) # Convert Tile Data From 128x32 Picture Segment (Bottom Left)
    width, height = segment.size
    convert_segment(segment, height, outtile)

    segment = in_img.crop((128, 192, 256, 224)) # Convert Tile Data From 128x32 Picture Segment (Bottom Right)
    width, height = segment.size
    convert_segment(segment, height, outtile)

if __name__ == '__main__':
    main()
