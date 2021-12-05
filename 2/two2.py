horizontal = 0
depth = 0
aim = 0
for line in open('2/two.txt'):
    line = line.split(' ')
    if line[0] == 'down':
        aim += int(line[1].strip())

    elif line[0] == 'up':
        aim -= int(line[1].strip())

    else:
        if aim != 0:
            depth += int(line[1].strip()) * aim
        horizontal += int(line[1].strip())


print(horizontal, depth, horizontal*depth)

            