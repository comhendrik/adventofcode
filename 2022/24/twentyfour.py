#used problem to understand code from others

from heapq import heappop, heappush

with open("2022/24/t.txt") as fin:
    lines = fin.read().strip().split("\n")

n = len(lines)
m = len(lines[0])

start = (0, 1)
end = (n - 1, m - 2)

period = (n * m) * 2 #enough options for time

# Calculate blizzard positions after every point
arrows = ">v<^"

dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

storms = set()
for i in range(n):
    for j in range(m):
        c = lines[i][j]
        if c in arrows:
            storms.add((i, j, arrows.index(c)))


states = [None] * period
states[0] = storms


for t in range(1, period):
    new_storms = set()

    for storm in storms:
        row, col, d = storm
        drow, dcol = dirs[d]
        new_row, new_col = row + drow, col + dcol

        if new_row == 0:
            assert d == 3
            new_row = n - 2
        elif new_row == n - 1:
            assert d == 1
            new_row = 1

        if new_col == 0:
            assert d == 2
            new_col = m - 2
        elif new_col == m - 1:
            assert d == 0
            new_col = 1

        new_storms.add((new_row, new_col, d))

    states[t] = new_storms
    storms = new_storms  # Update


def occupied(loc, st):
    for d in range(4):
        if (loc[0], loc[1], d) in st:
            return True
    return False

print("Part one:")


# Go go go
pq = [(0, start)]
visited = set()

while len(pq) > 0:
    top = heappop(pq)
    if top in visited:
        continue
    visited.add(top)

    t, loc = top
    row, col = loc

    

    assert not occupied(loc, states[t])

    if loc == end:

        print(t)
        break

    # Go through neighbors
    for drow, dcol in (dirs + [[0, 0]]):
        new_row, new_col = row + drow, col + dcol
        new_loc = (new_row, new_col)

        # Within bounds?
        if (not new_loc in [start, end]) \
            and not (1 <= new_row <= n - 2
                     and 1 <= new_col <= m - 2):
            continue

        # Check if hitting a blizzard
        if occupied(new_loc, states[(t + 1)]):
            continue

        new_state = (t + 1, new_loc)
        heappush(pq, new_state)

print("Part two:")
pq = [(0, start, False, False)]
visited = set()

while len(pq) > 0:
    top = heappop(pq)
    if top in visited:
        continue
    visited.add(top)

    t, loc, hit_start, hit_end = top

    row, col = loc


    assert not (hit_start and not hit_end)

    assert not occupied(loc, states[t])

    if loc == end:
        if hit_start and hit_end:
            print(t)
            break
        hit_end = True

    if loc == start:
        if hit_end:
            hit_start = True

    # Go through neighbors
    for drow, dcol in (dirs + [[0, 0]]): #0,0 symbolizes not moving
        new_row, new_col = row + drow, col + dcol
        new_loc = (new_row, new_col)

        # Within bounds?
        if (not new_loc in [start, end]) \
            and not (1 <= new_row <= n - 2
                     and 1 <= new_col <= m - 2):
            continue

        # Check if hitting a blizzard
        if occupied(new_loc, states[(t + 1)]):
            continue

        new_state = (t + 1, new_loc, hit_start, hit_end)
        heappush(pq, new_state)