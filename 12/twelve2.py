from collections import defaultdict
neighbours = defaultdict(list)

for line in open('12/twelve.txt'):
    a,b = line.strip().split('-')
    neighbours[a].append(b)
    neighbours[b].append(a)
print(neighbours)
def search(seen=set(),pos='start',part=2):
    ans = 0
    if pos == 'end':
        return 1
    if pos in seen:
        if pos == 'start': return 0
        if pos.islower():
            if part == 1: 
                return 0
            else:
                part = 1
    for i in range(len(neighbours[pos])):
        ans += search(seen|{pos},neighbours[pos][i],part)

    return ans

print(search())