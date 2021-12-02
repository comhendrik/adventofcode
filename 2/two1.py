x = 0
y = 0
for line in open('2/two1.txt'):
    line = line.split(' ')
    if line[0] == 'down':
        y += int(line[1].strip())

    elif line[0] == 'up':
        y -= int(line[1].strip())

    else:
        x += int(line[1].strip())

print(x,y,x*y)