def calculate(a,b,operator):
    if operator == '*':
        return a*b
    else:
        return a+b


class Monkey:
    def __init__(self, operation, a, b, test):
        self.items = []
        self.operation = operation
        self.a = a
        self.b = b
        self.test = test
        self.throw_to_when_true = 0
        self.throw_to_when_false = 0

monkeys = []
#get data from monkeys into array of objects
i = -1

for line in open('2022/11/t.txt'):
    line = line.strip().split()
    if len(line) == 0:
        continue
    if line[0] == 'Monkey':
        i += 1
        monkeys.append(Monkey('*','old','old',0))
        continue
    elif line[0] == 'Starting':
        for j in range (2,len(line)):
            number = line[j][0] + line[j][1] #Just need two digits numbers because input doesnt uses three digit numbers
            monkeys[i].items.append(int(number))
    elif line[0] == 'Operation:':
        monkeys[i].a = line[3]
        monkeys[i].operation = line[4]
        monkeys[i].b = line[5]
    elif line[0] == 'Test:':
        monkeys[i].test = int(line[3])
    elif line[0] == 'If':
        if line[1] == 'true:':
            monkeys[i].throw_to_when_true = int(line[5]) 
        else:
            monkeys[i].throw_to_when_false = int(line[5]) 

def go_trough_monkeys():
    for monkey in monkeys:
        print(monkey.items)
        for i in range(len(monkey.items)):
            if monkey.a == 'old' and monkey.b == 'old':
                a,b = int(monkey.items[i]), int(monkey.items[i])
            elif monkey.a == 'old':
                a,b = int(monkey.items[i]), int(monkey.b)
            elif monkey.b == 'old':
                a,b = int(monkey.a), int(monkey.items[i])
            new = calculate(a,b,monkey.operation)
            monkey.items[i] = int(new)
            number_to_throw = int(monkey.items[i]/3)
            if monkey.items[i] % monkey.test == 0:

                monkeys[monkey.throw_to_when_true].items.append(number_to_throw)
            else:
                monkeys[monkey.throw_to_when_false].items.append(number_to_throw)
        monkey.items = []

for i in range(2):
    go_trough_monkeys()
    print(monkeys[0].items,monkeys[1].items,monkeys[2].items,monkeys[3].items)


    



