from collections import defaultdict
import copy
instructions = defaultdict(str)
frequenz = defaultdict(int)
polymer = ''
for line in open('14/fourteen.txt'):
    if line.__contains__(' -> '):
        line = line.strip().split(' -> ')
        instructions[line[0]] = line[1]
        frequenz[line[0]] = 0
    else:
        polymer = line.strip()

for i in range(len(polymer)-1):
    frequenz[polymer[i]+polymer[i+1]] += 1


def new_polymer(count):
    new_count = copy.copy(count)
    for pair in count:
        for key, value in instructions.items():
            if pair == key:
                occs = count[pair]
                new_count[pair] -= occs
                new_count[pair[0] + value] += occs
                new_count[value + pair[1]] += occs
                break

    return new_count             

for i in range(10):
    frequenz = new_polymer(count=frequenz)
#Shoutout to https://www.youtube.com/channel/UCMhk437GeN8069t7y0lJQbw he helped me with the count function
count = defaultdict(int)
for pair in frequenz:
    count[pair[0]] += frequenz[pair]
    count[pair[1]] += frequenz[pair]

count[polymer[0]] += 1
count[polymer[-1]] += 1

count_vals = [c[1] // 2 for c in count.items()]

ans = max(count_vals) - min(count_vals)
print(ans)