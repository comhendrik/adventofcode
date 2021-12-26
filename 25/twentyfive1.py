import copy
east_positions = set()
south_positions = set()
max_y = -1
max_x = 0
for line in open('25/twentyfive.txt'):
    line = line.strip()
    line = list(map(str,line))
    max_y += 1
    for i in range(len(line)):
        max_x = i
        if line[i] == '>':
            east_positions.add((i,max_y))
        elif line[i] == 'v':
            south_positions.add((i,max_y))


def check_if_east_is_movable(x,y):
    if x == max_x:
        if (0,y) in east_positions or (0,y) in south_positions:
            return None,None
        else:
            return 0,y
    elif (x+1,y) in east_positions or (x+1,y) in south_positions:
        return None,None
    else:
        return (x+1),y
def check_if_south_is_movable(x,y,east):
    if y == max_y:
        if (x,0) in east or (x,0) in south_positions:
            return None,None
        else:
            return x,0
    elif (x,y+1) in east or (x,y+1) in south_positions:
        return None,None
    else:
        return x,(y+1)

def do_step(east,south):
    done = True
    new_east = copy.copy(east)
    new_south = copy.copy(south)
    for x,y in east_positions:
        new_x,new_y = check_if_east_is_movable(x,y)
        if new_x != None and new_y != None:
            done = False
            new_east.discard((x,y))
            new_east.add((new_x,new_y))
    for x,y in south_positions:
        new_x,new_y = check_if_south_is_movable(x,y,new_east)
        if new_x != None and new_y != None:
            done = False
            new_south.discard((x,y))
            new_south.add((new_x,new_y))
    return new_east, new_south, done
def print_field():
    arr = []
    for _ in range(max_y+1):
        new_arr = []
        for _ in range(max_x+1):
            new_arr.append('.')
        arr.append(new_arr)
    for x,y in east_positions:
        arr[y][x] = '>'
    for x,y in south_positions:
        arr[y][x] = 'v'
    for y in arr:
        print(y)
index = 0
while True:
    index += 1
    new_east, new_south, done = do_step(east_positions,south_positions)
    east_positions = new_east
    south_positions = new_south
    if done == True:
        break
print_field()
print(index)