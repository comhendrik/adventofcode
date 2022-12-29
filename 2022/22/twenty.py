grid = []
for line in open('2022/22/input.txt'):
    line = line.strip()
    grid.append([])
    for char in line:
        grid[-1].append(char)


dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]

position = (0,0, dirs[0])
instructions = '10R5L5R10L4R5L5'
new_instruction = ''
splitted_instructions = []
for char in instructions:
    if char.isnumeric():
        new_instruction += char
    else:
        splitted_instructions.append(new_instruction)
        splitted_instructions.append(char)
        new_instruction = ''


for i in range(len(grid[0])):
    if grid[0][i] != '/':
        position = (0,i, dirs[0])
        break
print(position)
x_bounds = {-1, len(grid[0])}
y_bounds = {-1, len(grid)}
for instruction in splitted_instructions:

    #numeric movement
    if instruction.isnumeric():
        hit_wall = False
        for i in range(int(instruction)):
            #new position
            new_y = position[0] + position[2][0]
            new_x = position[1] + position[2][1]
            
            if new_y in y_bounds or new_x in x_bounds or grid[new_y][new_x] == '/':
                #checking dir
                index = dirs.index(position[2])
                #moving horizontally
                if index == 0:
                    x = 0
                    while grid[new_y][x] == '/':
                        x += 1
                    position = (new_y,x,position[2])

                elif index == 2:
                    x = len(grid[new_y]) - 1
                    while grid[new_y][x] == '/':
                        x -= 1
                    position = (new_y,x,position[2])
                #moving vertically
                elif index == 1:
                    #downwards
                    y = 0
                    while grid[y][new_x] == '/':
                        y += 1
                    position = (y,new_x,position[2])
                else:
                    #upwards
                    y = len(grid) - 1
                    while grid[y][new_x] == '/':
                        y -= 1
                    position = (y,new_x,position[2])
                    

            elif grid[new_y][new_x] == '#':
                break
            else:
                position = (new_y,new_x, position[2])
        
    #change direction
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
print(final_row,final_col,facing)
print((1000*final_row)+(4*final_col)+facing)