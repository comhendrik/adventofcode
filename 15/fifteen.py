import heapq
from collections import defaultdict
cave = []
for line in open('15/fifteen.txt'):
    line = line.strip()
    path = []
    for char in line:
        path.append(int(char))
    cave.append(path)

min_y = len(cave)
min_x = len(cave[0])
visited = set()
path_cost = defaultdict(int)

priority_queue = [(0, 0, 0)]
heapq.heapify(priority_queue)


while len(priority_queue) > 0:
    cost, col, row = heapq.heappop(priority_queue)

    if (row, col) in visited:
        continue
    visited.add((row, col))

    path_cost[(row, col)] = cost

    if row == min_x - 1 and col == min_y - 1:
        break

    for yplus, xplus in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
        yplus = col + yplus
        xplus = row + xplus
        if not (0 <= yplus < min_y and 0 <= xplus < min_x):
            continue
        print(cost + cave[yplus][xplus], yplus, xplus)
        heapq.heappush(priority_queue, (cost + cave[yplus][xplus], yplus, xplus))


print(path_cost[(min_y - 1, min_x - 1)])