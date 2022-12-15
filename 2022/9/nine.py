data = open("2022/9/input.txt")
data = data.read().strip().split("\n")


hx, hy = 0, 0
tx, ty = 0, 0


def touching(x1, y1, x2, y2):
    return abs(x1 - x2) <= 1 and abs(y1 - y2) <= 1


def move(dx, dy):
    global hx, hy, tx, ty

    hx += dx
    hy += dy

    if not touching(hx, hy, tx, ty):
        if hx == tx: #check if tail is on same x point
            tx += 0
        else:
            new_tail_position_x = hx - tx
            if new_tail_position_x == -2:
                tx  += new_tail_position_x + 1
            elif new_tail_position_x == 1 or new_tail_position_x == -1:
                tx += new_tail_position_x
            else:
                tx  += new_tail_position_x - 1
        if hy == ty: #check if tail is on same y point
            ty += 0
        else:
            new_tail_position_y = hy - ty
            if new_tail_position_y == -2:
                ty  += new_tail_position_y + 1
            elif new_tail_position_y == 1 or new_tail_position_y == -1:
                ty += new_tail_position_y
            else:
                ty  += new_tail_position_y - 1  


operations = {
    "R": [1, 0],
    "U": [0, 1],
    "L": [-1, 0],
    "D": [0, -1]
}

tail_visited = set()
tail_visited.add((tx, ty))

for line in data:
    operation, amount = line.split(" ")
    amount = int(amount)
    x_point, y_point = operations[operation]

    for _ in range(amount):
        move(x_point, y_point)
        tail_visited.add((tx, ty))

print("Part one")
print(len(tail_visited))


knots = []
for _ in range(10):
    knots.append([0,0])

def move(dx, dy):
    global knots

    knots[0][0] += dx
    knots[0][1] += dy

    for i in range(1, 10):
        hx , hy = knots[i-1]
        tx, ty = knots[i]
        if not touching(hx, hy, tx, ty):
            if hx == tx: #check if tail is on same x point
                tx += 0
            else:
                new_tail_position_x = hx - tx
                if new_tail_position_x == -2:
                    tx  += new_tail_position_x + 1
                elif new_tail_position_x == 1 or new_tail_position_x == -1:
                    tx += new_tail_position_x
                else:
                    tx  += new_tail_position_x - 1
            if hy == ty: #check if tail is on same y point
                ty += 0
            else:
                new_tail_position_y = hy - ty
                if new_tail_position_y == -2:
                    ty  += new_tail_position_y + 1
                elif new_tail_position_y == 1 or new_tail_position_y == -1:
                    ty += new_tail_position_y
                else:
                    ty  += new_tail_position_y - 1 
        knots[i] = [tx,ty]


tail_visited = set()
tail_visited.add(tuple(knots[-1]))

for line in data:
    operation, amount = line.split(" ")
    amount = int(amount)
    x_point, y_point = operations[operation]

    for _ in range(amount):
        move(x_point, y_point)
        tail_visited.add(tuple(knots[-1]))
        
print("Part one")
print(len(tail_visited))
