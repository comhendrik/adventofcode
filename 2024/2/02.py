# Define the file path
file_path = "input.txt"  # Replace with your file path

# Initialize the lists
levels = []

# Open and read the file
with open(file_path, "r") as file:
    for line in file:
        # Split the line into numbers
        parts = line.strip().split()
        levels.append([int(num) for num in parts])
def is_safe(report):
    diffs = [report[i + 1] - report[i] for i in range(len(report) - 1)]
    increasing = all(1 <= diff <= 3 for diff in diffs)
    decreasing = all(-3 <= diff <= -1 for diff in diffs)
    return increasing or decreasing

sum_safe_levels = 0
for level in levels:
    if is_safe(level): sum_safe_levels += 1

print("Part one")
print(sum_safe_levels)


sum_safe_levels = 0
for level in levels:
    if is_safe(level): sum_safe_levels += 1
    else:
        for i in range(len(level)):
            modified_level = level[:i] + level[i + 1:]  # Remove one level
            if is_safe(modified_level):
                sum_safe_levels += 1
                break



print(sum_safe_levels)


