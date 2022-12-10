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

scenic_score = 0

def get_scenic_score(i,j):
        top_numbers = 0
        for y in range(i-1,-1,-1):
            top_numbers += 1
            if grid[y][j] >= grid[i][j]:
                break

        bottom_numbers = 0
        for y in range(i+1,m):
            bottom_numbers += 1
            if grid[y][j] >= grid[i][j]:
                break


        left_numbers = 0
        for x in range(j-1,-1,-1):
            left_numbers += 1
            if grid[i][x] >= grid[i][j]:
                break

        right_numbers = 0
        for x in range(j+1,n):
            right_numbers += 1
            if grid[i][x] >= grid[i][j]:
                break

        return top_numbers * bottom_numbers * left_numbers * right_numbers

for i in range(n):
    for j in range(m):
        new_scenic_score = get_scenic_score(i,j)
        if new_scenic_score > scenic_score:
            scenic_score = new_scenic_score

print("Part two:")
print(scenic_score)
   