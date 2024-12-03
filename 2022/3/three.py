point_for_char = {
    'a' : 1,
    'b' : 2,
    'c' : 3,
    'd' : 4,
    'e' : 5,
    'f' : 6,
    'g' : 7,
    'h' : 8,
    'i' : 9,
    'j' : 10,
    'k' : 11,
    'l' : 12,
    'm' : 13,
    'n' : 14,
    'o' : 15,
    'p' : 16,
    'q' : 17,
    'r' : 18,
    's' : 19,
    't' : 20,
    'u' : 21,
    'v' : 22,
    'w' : 23,
    'x' : 24,
    'y' : 25,
    'z' : 26,
    'A' : 27,
    'B' : 28,
    'C' : 29,
    'D' : 30,
    'E' : 31,
    'F' : 32,
    'G' : 33,
    'H' : 34,
    'I' : 35,
    'J' : 36,
    'K' : 37,
    'L' : 38,
    'M' : 39,
    'N' : 40,
    'O' : 41,
    'P' : 42,
    'Q' : 43,
    'R' : 44,
    'S' : 45,
    'T' : 46,
    'U' : 47,
    'V' : 48,
    'W' : 49,
    'X' : 50,
    'Y' : 51,
    'Z' : 52
}

backpacks = []
for line in open('2022/3/input.txt.txt'):
    full_string = line.strip()
    first_compartment = full_string[:len(full_string)//2]
    second_compartment = full_string[len(full_string)//2:]
    backpacks.append([first_compartment,second_compartment])

double_occurences = []

for backpack in backpacks:
    for char in set(backpack[0]).intersection(backpack[1]):
        double_occurences.append(char)

sum_for_double_occurences = 0

for char in double_occurences:
    sum_for_double_occurences += point_for_char.get(char)

print("Part One:")
print(sum_for_double_occurences)

groups = [[]]

group_chars = []

i = 1

index_of_groups = 0

for line in open('2022/3/input.txt.txt'):
    if i == 4: 
        groups.append([])
        index_of_groups += 1
        i = 1
    full_string = line.strip()
    groups[index_of_groups].append(full_string)

    i += 1

for group in groups:
    for char in set(group[0]).intersection(group[1],group[2]):
        group_chars.append(char)

sum_for_group_chars = 0

for char in group_chars:
    sum_for_group_chars += point_for_char.get(char)

print("Part two:")
print(sum_for_group_chars)