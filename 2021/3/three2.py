with open('3/three.txt', 'r') as f:
    lines = f.readlines()

def calculate(lines, x, rating):
    if len(lines) == 1:
        return lines

    zeros, ones = [], []
    for line in lines:
        if line[x] == "0":
            zeros.append(line)
        else:
            ones.append(line)

    if len(zeros) == len(ones):
        return calculate(ones if rating == "oxygen" else zeros, x + 1, rating)
    else:
        if len(zeros) > len(ones):
            return calculate(zeros if rating == "oxygen" else ones, x + 1, rating)
        else:
            return calculate(ones if rating == "oxygen" else zeros, x + 1, rating)

oxygen = int(calculate(lines, 0, "oxygen")[0], 2)
co2 = int(calculate(lines, 0, "co2")[0], 2)
print(oxygen * co2)



