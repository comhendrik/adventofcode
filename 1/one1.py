p1 = 0
prev = None
for line in open('one1.txt'):
    line = line.strip()
    x = int(line)
    if prev and x > prev:
        p1 += 1
    prev = x
print(p1)