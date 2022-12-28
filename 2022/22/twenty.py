grid = []
for line in open('2022/22/t.txt'):
    line = line.strip()
    grid.append([])
    for char in line:
        grid[-1].append(char)


dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

position = (0,0, dirs[0])
instructions = '10 R 5 L 5 R 2 L 4 R 5 L 5'
instructions = instructions.split(' ')

for i in range(len(grid[0])):
    if grid[0][i] != '/':
        position = (0,i, dirs[0])
        break


for instruction in instructions:


    #numeric movement
    if instruction.isnumeric():
        for i in range(int(instruction)):
            #new position
            new_y = position[0] + position[2][0]
            new_x = position[1] + position[2][1]

            if grid[new_y][new_x] == '#':
                break
            elif grid[new_y][new_x] == '/':
                #checking dir
                index = dirs.index(position[2])
                if index == 0 or index == 2:
                    x = 0
                    while grid[new_y][x] == '/':
                        x += position[2][1]
                    position = (new_y,x,position[2])
                else:
                    y = 0
                    while grid[y][new_x] == '/':
                        y += position[2][0]
                    position = (y,new_x,position[2])
            else:
                position = (new_y,new_x, position[2])
    else:
        if instruction == 'R':
            if dirs.index(position[2]) == len(dirs) - 1:
                
                position = (position[0],position[1],dirs[0])
            else:
                position = (position[0],position[1],dirs[dirs.index(position[2])+1])
        else:
            if dirs.index(position[2]) == 0:
                position = (position[0],position[1],dirs[-1])
            else:
                position = (position[0],position[1],dirs[dirs.index(position[2])-1])



final_row = position[0] + 1
final_col = position[1] + 1
facing = dirs.index(position[2])

print((1000*final_row)+(4*final_col)+facing)