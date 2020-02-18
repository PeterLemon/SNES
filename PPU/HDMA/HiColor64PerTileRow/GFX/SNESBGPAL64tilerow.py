# Syntax: SNESBGPAL64tilerow.py image.in file.out
# Notes: image.in needs to be 256x224 pixel resolution image
# Written for Python 3.6.2 with the Pillow 4.2.1 library
import sys
import struct
import PIL.Image

# Quantize Options:
colors = 15 # The desired number of colors, <= 256
method = 0  # 0 = median cut 1 = maximum coverage 2 = fast octree 3 = libimagequant
kmeans = 3  # Integer

def convert_pal(image, filedata): # Convert To SNES 16 Color Palette Data
    palette = image.getpalette()[:(15*3)] # Get 15 * R,G,B Palette Entries
    filedata.write(struct.pack('H', 0)) # Store Black To Palette Color Index 0
    for i in range(15):
        R = palette[i*3]
        G = palette[(i*3)+1]
        B = palette[(i*3)+2]
        SNEScol = ((B & 0xF8) << 7) | ((G & 0xF8) << 2) | ((R & 0xF8) >> 3)
        filedata.write(struct.pack('H', SNEScol))

def convert_tile(image, tilenum, filedata): # Convert To SNES 8x8 4BPP Tile Data
    pixels = image.getdata()

    tile = []
    i = tilenum * 8
    for y in range(8):
        for x in range(8):
            tile.append(pixels[i] + 1)
            i += 1
        i += 56 # Tile Row Segment Stride

    SNEStile = [0] * 32 # Set SNES Tile Array (32 Bytes)
    for y in range(8): # Rows
        byte1 = byte2 = byte3 = byte4 = 0
        for x in range(8): # Columns
            byte1 += (tile[(y<<3)+x] & 1)<<(7-x)
            byte2 += ((tile[(y<<3)+x]>>1) & 1)<<(7-x)
            byte3 += ((tile[(y<<3)+x]>>2) & 1)<<(7-x)
            byte4 += ((tile[(y<<3)+x]>>3) & 1)<<(7-x)
        SNEStile[(y*2)] = byte1
        SNEStile[(y*2)+1] = byte2
        SNEStile[(y*2)+16] = byte3
        SNEStile[(y*2)+17] = byte4

    for i in range(32): filedata.write(struct.pack('B', SNEStile[i])) # Write 4BPP 8x8 Tile (32 Bytes)

def convert_segment(image, filedata): # Convert Tile Data From 64x8 Picture Segment
    convert_tile(image, 0, filedata)
    convert_tile(image, 1, filedata)
    convert_tile(image, 2, filedata)
    convert_tile(image, 3, filedata)
    convert_tile(image, 4, filedata)
    convert_tile(image, 5, filedata)
    convert_tile(image, 6, filedata)
    convert_tile(image, 7, filedata)
        
def main(argv=None):
    if argv is None:
        argv = sys.argv[1:]
    infilename, outfilename = argv
    outpal = open(outfilename+'.pal', 'wb')
    outtile = open(outfilename+'.pic', 'wb')
    in_img = PIL.Image.open(infilename)
    width, height = in_img.size

    # Convert Tile Row Data & Palette From Full Picture
    for i in range(int(height/8)):
        segment = in_img.crop((0, i*8, 64, (i*8)+8)) # Convert Tile Data & Palette From 64x8 Picture Segment (Left)
        segment = segment.quantize(colors=colors, method=method, kmeans=kmeans)
        convert_pal(segment, outpal)
        convert_segment(segment, outtile)

        segment = in_img.crop((64, i*8, 128, (i*8)+8)) # Convert Tile Data & Palette From 64x8 Picture Segment (Middle Left)
        segment = segment.quantize(colors=colors, method=method, kmeans=kmeans)
        convert_pal(segment, outpal)
        convert_segment(segment, outtile)

        segment = in_img.crop((128, i*8, 192, (i*8)+8)) # Convert Tile Data & Palette From 64x8 Picture Segment (Middle Right)
        segment = segment.quantize(colors=colors, method=method, kmeans=kmeans)
        convert_pal(segment, outpal)
        convert_segment(segment, outtile)

        segment = in_img.crop((192, i*8, 256, (i*8)+8)) # Convert Tile Data & Palette From 64x8 Picture Segment (Right)
        segment = segment.quantize(colors=colors, method=method, kmeans=kmeans)
        convert_pal(segment, outpal)
        convert_segment(segment, outtile)

if __name__ == '__main__':
    main()
