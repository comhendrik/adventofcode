from collections import defaultdict

with open("2022/23/input.txt.txt") as fin:
    grid = fin.read().strip().split("\n")


checks = [
    [[1, 2, 3], 2],
    [[7, 6, 5], 6],
    [[5, 4, 3], 4],
    [[1, 0, 7], 0]
]


n = len(grid)
m = len(grid[0])

elves = set()

for i in range(n):
    for j in range(m):
        if grid[i][j] == "#":
            elves.add((i, j))


dirs = [
    [0, 1],
    [-1, 1],
    [-1, 0],
    [-1, -1],
    [0, -1],
    [1, -1],
    [1, 0],
    [1, 1]
]


def get_bounds(elves):
    min_row = 1 << 60
    max_row = -(1 << 60)
    min_col = 1 << 60
    max_col = -(1 << 60)

    for row, col in elves:
        min_row = min(min_row, row)
        max_row = max(max_row, row)

        min_col = min(min_col, col)
        max_col = max(max_col, col)

    return min_row, max_row, min_col, max_col



for round in range(10):
    # Stage 1: make proposals
    propose = {}
    proposed = defaultdict(int)
    for elf in elves:
        row, col = elf

        # If elf has no neighbors, continue
        good = False
        for drow, dcol in dirs:
            if (row + drow, col + dcol) in elves:
                good = True
                break
        if not good:
            continue

        for check_dirs, propose_dir in checks:
            good = True
            for d in check_dirs:
                drow, dcol = dirs[d]
                if (row + drow, col + dcol) in elves:
                    good = False
                    break

            if not good:
                continue

            drow, dcol = dirs[propose_dir]
            propose[elf] = (row + drow, col + dcol)
            proposed[propose[elf]] += 1
            break


    # Stage 2: do the proposals
    new_elves = set()
    for elf in elves:
        if elf in propose:
            new_loc = propose[elf]
            if proposed[new_loc] > 1 or proposed[new_loc] == 0:
                new_elves.add(elf)
            else:
                new_elves.add(new_loc)
        else:
            new_elves.add(elf)

    # Rotate stuff
    checks = checks[1:] + [checks[0]]
    elves = new_elves


# Find bounding box
min_row, max_row, min_col, max_col = get_bounds(elves)

print("Part one:")
print((max_row - min_row + 1) * (max_col - min_col + 1) - len(elves))


checks = [
    [[1, 2, 3], 2],
    [[7, 6, 5], 6],
    [[5, 4, 3], 4],
    [[1, 0, 7], 0]
]


n = len(grid)
m = len(grid[0])

elves = set()

for i in range(n):
    for j in range(m):
        if grid[i][j] == "#":
            elves.add((i, j))


print("Part two")
current_round = 1
while True:
    # Stage 1: make proposals
    propose = {}
    proposed = defaultdict(int)
    for elf in elves:
        row, col = elf

        # If elf has no neighbors, continue
        good = False
        for drow, dcol in dirs:
            if (row + drow, col + dcol) in elves:
                good = True
                break
        if not good:
            continue

        for check_dirs, propose_dir in checks:
            good = True
            for d in check_dirs:
                drow, dcol = dirs[d]
                if (row + drow, col + dcol) in elves:
                    good = False
                    break

            if not good:
                continue

            drow, dcol = dirs[propose_dir]
            propose[elf] = (row + drow, col + dcol)
            proposed[propose[elf]] += 1
            break

    if len(propose) == 0:
        print(current_round)
        break

    # Stage 2: do the proposals
    new_elves = set()
    for elf in elves:
        if elf in propose:
            new_loc = propose[elf]
            if proposed[new_loc] > 1 or proposed[new_loc] == 0:
                new_elves.add(elf)
            else:
                new_elves.add(new_loc)
        else:
            new_elves.add(elf)

    # Rotate stuff
    checks = checks[1:] + [checks[0]]
    elves = new_elves
    current_round += 1