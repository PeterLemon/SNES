from math import sin

i = 0.0
while i < 224:
    sinval = round(sin(i) * 10)
    i += 0.25
    print("db 1; dw", sinval)
