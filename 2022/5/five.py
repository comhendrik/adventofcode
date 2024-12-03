stacks = [
    ['W','D','G','B','H','R','V'],
    ['J','N','G','C','R','F'],
    ['L','S','F','H','D','N','J'],
    ['J','D','S','V'],
    ['S','H','D','R','Q','W','N','V'],
    ['P','G','H','C','M'],
    ['F','J','B','G','L','Z','H','C'],
    ['S','J','R'],
    ['L','G','S','R','B','N','V','M']
]
rearrangement_step = [0,0,0]

for line in open('2022/5/input.txt.txt'):
    stripped_line = line.strip()
    parts_of_line = stripped_line.split(' ')
    rearrangement_step[0] = int(parts_of_line[1])
    rearrangement_step[1] = int(parts_of_line[3])
    rearrangement_step[2] = int(parts_of_line[5])
    for _ in range(0, rearrangement_step[0]):
        popped_item = stacks[rearrangement_step[1]-1].pop()
        stacks[rearrangement_step[2]-1].append(popped_item)

print("Part one:")
for stack in stacks:
    print(stack[-1])


stacks = [
    ['W','D','G','B','H','R','V'],
    ['J','N','G','C','R','F'],
    ['L','S','F','H','D','N','J'],
    ['J','D','S','V'],
    ['S','H','D','R','Q','W','N','V'],
    ['P','G','H','C','M'],
    ['F','J','B','G','L','Z','H','C'],
    ['S','J','R'],
    ['L','G','S','R','B','N','V','M']
]

for line in open('2022/5/input.txt.txt'):
    stripped_line = line.strip()
    parts_of_line = stripped_line.split(' ')
    rearrangement_step[0] = int(parts_of_line[1])
    rearrangement_step[1] = int(parts_of_line[3])
    rearrangement_step[2] = int(parts_of_line[5])
    crates_to_move = []
    for _ in range(0, rearrangement_step[0]):
        crates_to_move.append(stacks[rearrangement_step[1]-1].pop())
    print(crates_to_move)
    print(stacks)
    for item in reversed(crates_to_move):
        stacks[rearrangement_step[2]-1].append(item)
    print(stacks)

print("Part two")
for stack in stacks:
    print(stack[-1])
