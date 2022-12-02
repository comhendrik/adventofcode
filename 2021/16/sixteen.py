bs = bin(int('1'+open("16/sixteen.txt").read(),16))[3:]

def ps1(startbit):
    i = startbit # index into bs
    tv = int(bs[i:i+3],2) # total version
    ID = int(bs[i+3:i+6],2) # packet type ID
    i += 6
    if ID == 4: #literal value
        while True:
            i += 5
            if bs[i-5] == '0': #last value packet
                break
    else:
        if bs[i] == '0':
            endi = i + 16 + int(bs[i+1:i+16],2)
            i += 16
            while i < endi:
                i,v = ps1(i)
                tv += v
        else:
            np = int(bs[i+1:i+12],2)
            i += 12
            for _ in range(np):
                i,v = ps1(i)
                tv += v

    return i,tv

print("Total of version numbers:",ps1(0)[1])