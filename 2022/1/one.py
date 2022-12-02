elves = []
elv = 0
for line in open('2022/1/input.txt'):
    if line.strip():
        elv += int(line)
    else: 
        elves.append(elv)
        elv = 0
elves = sorted(elves)

print("Part one:")
print(elves[-1])

print("Part two:")
print(elves[-1]+elves[-2]+elves[-3])