import re

data = ""
with open("input.txt", "r") as file:

    for line in file:
        # Split the line into numbers
        data += line


reg = r"mul\((\d+),(\d+)\)"

matches = re.findall(reg, data)

total = 0
for mult in matches:
    x,y = map(int, mult)
    total += x * y


print(total)