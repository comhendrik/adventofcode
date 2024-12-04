

dirs = [
    (0, 1),  # Right
    (0, -1), # Left
    (1, 0),  # Down
    (-1, 0), # Up
    (1, 1),  # Down-Right
    (1, -1), # Down-Left
    (-1, 1), # Up-Right
    (-1, -1) # Up-Left
]

chars = [
    "X",
    "M",
    "A",
    "S"
]

# Define the file path
file_path = "input.txt"  # Replace with your file path

# Initialize the lists
levels = []

# Open and read the file
with open(file_path, 'r') as file:
    levels = [list(line.rstrip('\n')) for line in file]

def check_if_word_is_at_position_in_dir(x,y,dx,dy,index):
    char = levels[y][x]
    if char != chars[index]:
        return False
    if index == 3:
        return True

    new_y = y + dy
    new_x = x + dx

    if (new_y < 0 or new_y >= len(levels)) or (new_x < 0 or new_x >= len(levels[y])):
        return False

    return check_if_word_is_at_position_in_dir(new_x, new_y, dx, dy, index+1)

res = 0



for y in range(len(levels)):
    for x in range(len(levels[y])):
        if levels[y][x] == "X":
            for dy,dx in dirs:
                if check_if_word_is_at_position_in_dir(x,y,dx,dy, 0):
                    res += 1

print("part two")
print(res)




dirs = [
    (1, 1),  # Down-Right
    (1, -1), # Down-Left
    (-1, 1), # Up-Right
    (-1, -1) # Up-Left
]



def check_if_is_X(y,x):

    if (y <= 0 or y >= len(levels) - 1) or (x <= 0 or x >= len(levels[y]) - 1): return False
    s_count = 0
    m_count = 0

    up_right = levels[y-1][x+1]
    if up_right == "X" or up_right == "A": return False

    down_left = levels[y+1][x-1]
    if down_left == "X" or down_left == "A": return False

    if up_right == down_left: return False


    up_left = levels[y-1][x-1]
    if up_left == "X" or up_left == "A": return False

    down_right = levels[y+1][x+1]
    if down_right == "X" or down_right == "A": return False

    if up_left == down_right: return False

    return True



res = 0


for y in range(len(levels)):
    for x in range(len(levels[y])):
        if levels[y][x] == "A":
            if check_if_is_X(y,x):
                res += 1

print("part two")
print(res)







