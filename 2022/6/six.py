data = open("2022/6/input.txt.txt", 'r')
data = data.read().strip()
i = 0
while True:
    packet = set(data[i:i+4])
    if len(packet) == 4:
        break
    i += 1

print("Part one")    
print(i+4)


while True:
    packet = set(data[i:i+14])
    if len(packet) == 14:
        break
    i += 1

print("Part two")    
print(i+14)