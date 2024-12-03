cave = set()

for line in open('2022/14/input.txt.txt'):
    coords = []

    for str_coord in line.split(" -> "):
        x, y = map(int, str_coord.split(","))
        coords.append((x, y))

    for i in range(1, len(coords)):
        cx, cy = coords[i]  # cur
        px, py = coords[i - 1]

        if cy != py:
            assert cx == px
            for y in range(min(cy, py), max(cy, py) + 1):
                cave.add((cx, y))

        if cx != px:
            assert cy == py
            for x in range(min(cx, px), max(cx, px) + 1):
                cave.add((x, cy))

max_y = max([coord[1] for coord in cave])
#Part above with help of W.Y.Feng the code for everything else was written by myself

sand_starting_point = (500,0)

simulate_sand = True
i = 0

while simulate_sand:
    x,y = sand_starting_point
    while True:
        while (x, y) not in cave:
            x,y = x, y+1
            if y > max_y:
                break
        if y > max_y:
            break
        if (x-1,y) not in cave:
            x,y = x-1,y
        elif (x+1,y) not in cave:
            x,y = x+1,y
        else:
            sand_to_add = (x,y-1)
            cave.add(sand_to_add)
            i += 1
            break
    if y > max_y:
        break

print("Part one:")
print(i)
