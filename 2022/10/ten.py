cycle = 0
X = 1
signal_strength = 0

wanted_cycles = {20, 60, 100, 140, 180, 220}

for line in open('2022/10/input.txt.txt'):
    line = line.strip()
    if line == 'noop':
        cycle += 1
        if cycle in wanted_cycles:
            signal_strength += X * cycle
        continue
    line = line.split()
    cycle += 1
    if cycle in wanted_cycles:
        signal_strength += X * cycle
    
    
    cycle += 1
    if cycle in wanted_cycles:
        signal_strength += X * cycle

    X += int(line[1])

print("Part one:")
print(signal_strength)

drawing_pos = 0

sprite_pos = 1

image = ""

for line in open('2022/10/input.txt.txt'):
    line = line.strip()
    if line == 'noop':
        if sprite_pos - 1 <= drawing_pos <= sprite_pos + 1:
            image += "#"
        else:
            image += "."
        drawing_pos += 1
        if drawing_pos > 39:
            drawing_pos = 0
        continue
    line = line.split()
    if sprite_pos - 1 <= drawing_pos <= sprite_pos + 1:
        image += "#"
    else:
        image += "."

    drawing_pos += 1
    if drawing_pos > 39:
            drawing_pos = 0

    if sprite_pos - 1 <= drawing_pos <= sprite_pos + 1:
        image += "#"
    else:
        image += "."

    drawing_pos += 1
    if drawing_pos > 39:
            drawing_pos = 0

    sprite_pos += int(line[1])
print("Part two:")
print(f"{image[0:40]}\n{image[40:80]}\n{image[80:120]}\n{image[120:160]}\n{image[160:200]}\n{image[200:240]}")
