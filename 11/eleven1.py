octopus = []
for line in open('11/eleven.txt'):
    line = line.strip()
    octopus.append(list(map(int,line)))
print(octopus)

already_flashed = set()
max_y = len(octopus) - 1
max_x = len(octopus[0]) - 1
answer = 0
        
def increase(octopus):
    for y in range(len(octopus)):
        for x in range(len(octopus[y])):
            octopus[y][x] += 1
    ans = increase_multiple_neighbours()
    already_flashed.clear()
    return ans

                    
def increase_multiple_neighbours():
    all_normal = False
    ans = 0
    while True:
        all_normal = True
        for y in range(len(octopus)):
            for x in range(len(octopus[y])):
                if octopus[y][x] > 9 and (y,x) not in already_flashed:
                    already_flashed.add((y,x))
                    increase_neighbour(y-1,x-1)
                    increase_neighbour(y-1,x)
                    increase_neighbour(y-1,x+1)
                    increase_neighbour(y,x+1)
                    increase_neighbour(y+1,x+1)
                    increase_neighbour(y+1,x)
                    increase_neighbour(y+1,x-1)
                    increase_neighbour(y,x-1)
        for y in range(len(octopus)):
            for x in range(len(octopus[y])):
                if octopus[y][x] > 9 and (y,x) not in already_flashed:
                    all_normal = False
        if all_normal == True:
            break
    for y in range(len(octopus)):
        for x in range(len(octopus[y])):
            if octopus[y][x] > 9:
                ans += 1
                octopus[y][x] = 0

    return ans
    

def increase_neighbour(y,x):
    if y > max_y or x > max_x or y < 0 or x < 0:
        return
    octopus[y][x] += 1

ans = 0
for i in range(100):
    ans += increase(octopus=octopus)

print(ans)
