# Define the file path
file_path = "input.txt"  # Replace with your file path

# Initialize the lists
left_numbers = []
right_numbers = []

# Open and read the file
with open(file_path, "r") as file:
    for line in file:
        # Split the line into numbers
        parts = line.strip().split()
        if len(parts) == 2:  # Ensure there are exactly two numbers
            left, right = map(int, parts)  # Convert to integers
            left_numbers.append(left)
            right_numbers.append(right)

left_numbers.sort()
right_numbers.sort()

print("Part 1:")
sum = 0

for i in range(len(left_numbers)):
    sum += abs(left_numbers[i]-right_numbers[i])

print(sum)

print("Part 2:")
sum = 0

for i in range(len(left_numbers)):
    sum += right_numbers.count(left_numbers[i]) * left_numbers[i]

print(sum)




