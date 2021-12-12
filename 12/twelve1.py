from collections import defaultdict
neighbours = defaultdict(list)

for line in open('12/twelve.txt'):
    a,b = line.strip().split('-')
    neighbours[a].append(b)
    neighbours[b].append(a)
print(neighbours)
def search(seen=set(),pos='start'):
    ans = 0
    print(pos)
    if pos == 'end':
        return 1
    if pos in seen:
        if pos == 'start': return 0
        if pos.islower(): return 0
    for i in range(len(neighbours[pos])):
        ans += search(seen|{pos},neighbours[pos][i])

    return ans

print(search())