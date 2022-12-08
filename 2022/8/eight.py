data = open("2022/8/input.txt", 'r')
lines = data.read().strip().split()

grid = [list(map(int, list(line))) for line in lines]

n = len(grid)
m = len(grid[0])

times = 0

def get_top_numbers(x,y):
    numbers = []
    for i in range(y-1,-1,-1):
        numbers.append(grid[i][x])
    return numbers

def get_bottom_numbers(x,y):
    numbers = []
    for i in range(y+1,m):
        numbers.append(grid[i][x])
    return numbers

for i in range(n):
    for j in range(m):
        if j == 0:
            times += 1
            continue
        elif j == m - 1 :
            times += 1
            continue
        elif i == 0:
            times += 1
            continue
        elif i == n - 1:
            times += 1
            continue
        number = grid[i][j]
        left_numbers = grid[i][:j]
        right_numbers = grid[i][j+1:]
        top_numbers = get_top_numbers(j,i)
        bottom_numbers = get_bottom_numbers(j,i)
        if number > max(left_numbers):
            times += 1
        elif number > max(right_numbers):
            times += 1
        elif number > max(top_numbers):
            times += 1
        elif number > max(bottom_numbers):
            times += 1  

print("Part one:")
print(times)


   