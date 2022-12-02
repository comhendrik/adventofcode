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


cave = []
min_values = []
for line in open('9/nine.txt'):
    line = line.strip()
    cave.append(list(map(int, line)))

for i in range(len(cave)):
    for x in range(len(cave[i])):
        #edges
        if i == 0 and x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x+1],cave[i+1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif i == 0 and x == (len(cave[i]) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i+1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif i == (len(cave) - 1) and x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x+1],cave[i-1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif i == (len(cave) - 1) and x == (len(cave[i])-1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i-1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        #borders
        elif i == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i][x+1],cave[i+1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif i == (len(cave) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i][x-1],cave[i][x+1],cave[i-1][x]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif x == 0:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x+1]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        elif x == (len(cave[i]) - 1):
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x-1]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))
        #middle value
        else:
            value = cave[i][x]
            compare_values = [cave[i][x],cave[i-1][x],cave[i+1][x],cave[i][x+1],cave[i][x-1]]
            min_values.append(get_minimum(value=value,compare_values=compare_values))

risk_level = 0
for value in min_values:
    if value != None:
        risk_level += value + 1

print(risk_level)
