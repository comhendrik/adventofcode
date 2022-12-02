def get_minimum(value, compare_values):
    index = 0
    for value_to_compare in compare_values:
        if value == value_to_compare:
            index += 1
    if index > 1:
        return None
    if value == min(compare_values):
        return value
    else:
        return None
basin_counter = []
def create_basin_search(cave, x, y):
    basin_counter.append(0)
    i = len(basin_counter) - 1
    visited = set()
    find_basin(cave,x,y, i,visited)
def find_basin(cave, x, y, i, visited):
    if x > -1 and y > -1 and y < len(cave) and x < len(cave[y]):
        if (y,x) not in visited and cave[y][x] != 9:
            cave[y][x] = 9
            visited.add((y,x))
            basin_counter[i] += 1
            find_basin(cave, x - 1, y,i,visited)
            find_basin(cave, x + 1, y,i,visited)
            find_basin(cave, x, y + 1,i,visited)
            find_basin(cave, x, y - 1,i,visited)



cave = []
min_values = []
for line in open('9/nine.txt'):
    line = line.strip()
    cave.append(list(map(int, line)))
for i in range(len(cave)):
    for x in range(len(cave[i])):
        found_low_point = False
        #edges
        if i == 0 and x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x+1],cave[i+1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif i == 0 and x == (len(cave[i]) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i+1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif i == (len(cave) - 1) and x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x+1],cave[i-1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif i == (len(cave) - 1) and x == (len(cave[i])-1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i-1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        #borders
        elif i == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i][x+1],cave[i+1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif i == (len(cave) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i][x+1],cave[i-1][x]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x+1]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        elif x == (len(cave[i]) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x-1]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        #middle value
        else:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x+1],cave[i][x-1]]
            if get_minimum(value=value,compare_values=compare_values) != None:
                found_low_point = True
        
        if found_low_point:
            create_basin_search(cave,x,i)

basin_counter.sort()

print(basin_counter[-1] * basin_counter[-2] * basin_counter[-3])




