from string import ascii_lowercase
from heapq import heappop, heappush

data = open("2022/12/input.txt.txt", 'r')
lines = data.read().strip().split()

grid = [list(map(str, list(line))) for line in lines]

n = len(grid)
m = len(grid[0])

def height(s):
    if s in ascii_lowercase:
        return ascii_lowercase.index(s)
    if s == "S":
        return 0
    if s == "E":
        return 25

print("Part one:")
# find neighbors for part one
def neighbors(y, x):
    new_pos = []
    for plus_y, plus_x in [[1, 0], [-1, 0], [0, 1], [0, -1]]:
        new_y = y + plus_y
        new_x = x + plus_x

        if new_y < 0 or new_y >= n:
            continue
        if new_x < 0 or new_x >= m:
            continue

        if height(grid[new_y][new_x]) <= height(grid[y][x]) + 1:
            new_pos.append((new_y, new_x))
    return new_pos



start = 0,0

end = 0,0

for y in range(n):
    for x in range(m):
        char = grid[y][x]
        if char == "S":
            start = y, x
        if char == "E":
            end = y, x


visited = []

for y in range(n):
    visited.append([])
    for x in range(m):
        visited[y].append(False)

heap = [(0, start[0], start[1])]

while True:
    steps, y, x = heappop(heap)

    if visited[y][x]:
        continue

    visited[y][x] = True

    if visited[end[0]][end[1]] == True:
        print(steps)
        break

    for positions in neighbors(y,x):
        heappush(heap, (steps+1, positions[0],positions[1]))

print("Part two:")

#find neighbors for part two
def neighbors(y, x):
    new_pos = []
    for plus_y, plus_x in [[1, 0], [-1, 0], [0, 1], [0, -1]]:
        new_y = y + plus_y
        new_x = x + plus_x

        if new_y < 0 or new_y >= n:
            continue
        if new_x < 0 or new_x >= m:
            continue

        if height(grid[new_y][new_x]) >= height(grid[y][x]) - 1:
            new_pos.append((new_y, new_x))
    return new_pos

start = 0,0

for y in range(n):
    for x in range(m):
        char = grid[y][x]
        if char == "E":
            start = y, x


visited = []

for y in range(n):
    visited.append([])
    for x in range(m):
        visited[y].append(False)



heap = [(0, start[0], start[1])]


while True:
    steps, y, x = heappop(heap)

    if visited[y][x]:
        continue

    visited[y][x] = True

    if grid[y][x] == ("a" or "S"):
        #no need of checking the other a positions because the first a position that is found takes the smallest amount of steps
        print(steps)
        break


    for positions in neighbors(y,x):
        heappush(heap, (steps+1, positions[0],positions[1]))