# Initialize an empty list to store the map as a 2D array
map_2d_array = []

s_row, s_col = 0, 0

# Read the file and process each line
with open('input.txt', 'r') as file:
    for row_index, line in enumerate(file):
        # Strip the line of newline characters and iterate over each character
        current_row = []
        for col_index, char in enumerate(line.strip()):
            # If the character is an arrow '^', handle it
            if char == '^':
                s_row = row_index
                s_col = col_index

            # Append the character (or modify it if necessary) to the current row
            current_row.append(char)

        # Append the row to the map_2d_array
        map_2d_array.append(current_row)

c_row, c_col = s_row, s_col
def next_position_is_exit(c_row, c_col, d_row, d_col):
    new_row = c_row + d_row
    new_col = c_col + d_col

    return (new_col < 0 or new_col >= len(map_2d_array)) or (new_row < 0 or new_row >= len(map_2d_array[0]))


def check_for_sharp(map, c_row, c_col, d_row, d_col):
    new_row = c_row + d_row
    new_col = c_col + d_col
    return map[new_row][new_col] == "#"


print("part one")
movements = [
    [-1, 0],  # north
    [0, 1],  # east
    [1, 0],  # south
    [0, -1]  # west
]

distinct_positions = {
    (c_row, c_col)
}

move_i = 0

while True:
    d_row, d_col = movements[move_i]
    if next_position_is_exit(c_row, c_col, d_row, d_col): break;
    if check_for_sharp(map_2d_array, c_row, c_col, d_row, d_col):
        move_i += 1
        if move_i == 4: move_i = 0
    d_row, d_col = movements[move_i]

    c_row += d_row
    c_col += d_col

    distinct_positions.add((c_row,c_col))

print(len(distinct_positions))


total = 0
counter = 0


for row, col in distinct_positions:
    # Skip the guard's starting position
    if (row, col) == (s_row, s_col):
        continue

    new_map = [list(row) for row in map_2d_array]
    new_map[row][col] = "#"

    # Reset guard's starting position and direction
    c_row, c_col = s_row, s_col
    move_i = 0  # Index for direction (starting facing up)
    seen_states = set()  # Track states (position + direction)

    while True:
        if next_position_is_exit(c_row, c_col, *movements[move_i]):
            break

        if check_for_sharp(new_map, c_row, c_col, *movements[move_i]):
            move_i = (move_i + 1) % 4
        else:
            # Move forward
            d_row, d_col = movements[move_i]
            c_row += d_row
            c_col += d_col

        # Check for loop
        current_state = (c_row, c_col, move_i)
        if current_state in seen_states:
            total += 1
            break
        seen_states.add(current_state)

print(total)



print(total)