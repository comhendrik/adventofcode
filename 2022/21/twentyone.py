data = open("2022/21/input.txt")
lines = data.read().strip().split("\n")


monkeys = {}


def solve(name):
    #can return integer when monkey is already yelling an integer
    if isinstance(monkeys[name], int):
        return monkeys[name]

    #if required monkeys haven't yelled to this point the equation is needed
    parts = monkeys[name]


    #start recursively for every monkey in the equation
    left = solve(parts[0])
    right = solve(parts[2])

    #return expression for the monkey
    return eval(f"{left}{parts[1]}{right}")

#parsing the input into the dict
for line in lines:
    parts = line.split(" ")

    monkey = parts[0][:-1]

    if len(parts) == 2:
        monkeys[monkey] = int(parts[1])
    else:
        monkeys[monkey] = parts[1:]



ans = solve("root")
print("Part one:")
print(ans)