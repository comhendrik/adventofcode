#with help from "W.Y.Feng"
def calculate(operation, x):
    left, right, op = operation

    assert left == "old"

    if op == "+":
        return x + int(right)
    else:
        if right == "old":
            return x * x
        else:
            return x * int(right)

class Monkey:
    def __init__(self, operation, test):
        self.items = []
        self.operation = operation
        self.test = test
        self.throw_to_when_true = 0
        self.throw_to_when_false = 0
        self.inspections = 0
    def __str__(self):
        return f"{self.items}, {self.operation}, {self.test}, {self.throw_to_when_true}, {self.throw_to_when_false}"

monkeys = []
#get data from monkeys into array of objects
i = -1

for line in open('2022/11/input.txt.txt'):
    line = line.strip().split()
    if len(line) == 0:
        continue
    if line[0] == 'Monkey':
        i += 1
        monkeys.append(Monkey([],0))
        continue
    elif line[0] == 'Starting':
        for j in range (2,len(line)):
            number = line[j][0] + line[j][1] #Just need two digits numbers because input.txt doesnt uses three digit numbers
            monkeys[i].items.append(int(number))
    elif line[0] == 'Operation:':
        monkeys[i].operation = [line[3],line[5], line[4]]
    elif line[0] == 'Test:':
        monkeys[i].test = int(line[3])
    elif line[0] == 'If':
        if line[1] == 'true:':
            monkeys[i].throw_to_when_true = int(line[5]) 
        else:
            monkeys[i].throw_to_when_false = int(line[5]) 
            

for _ in range(20):
    for i in range(len(monkeys)):
        for item in monkeys[i].items:
            number_to_throw = calculate(monkeys[i].operation, item)
            number_to_throw = int(number_to_throw/3)
            test = monkeys[i].test
            if number_to_throw % test == 0:

                monkeys[monkeys[i].throw_to_when_true].items.append(number_to_throw)
            else:
                monkeys[monkeys[i].throw_to_when_false].items.append(number_to_throw)

            monkeys[i].inspections += 1
        monkeys[i].items = []







print("Part one:")
#with help from "W.Y.Feng"
inspections = [m.inspections for m in monkeys]
sorted_inspections = sorted(inspections)
print(sorted_inspections[-1] * sorted_inspections[-2])

    



