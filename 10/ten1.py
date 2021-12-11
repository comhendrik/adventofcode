def check_if_value_is_front(bracket):
    if bracket == '(' or bracket == '[' or bracket == '<' or bracket == '{':
        return True
    return False
def get_reversed_value(bracket):
    switcher = {
        '}':'{',
        ')':'(',
        ']':'[',
        '>':'<'
    }
    return switcher.get(bracket, 'Nothing')
def parse(line):
    stack = []
    for value in line:
        if check_if_value_is_front(value) == True:
            stack.append(value)
        else:
            if stack[-1] == get_reversed_value(value):
                stack.pop()
            else: 
                points[value] += 1
                return




characters = []
for line in open('10/ten.txt'):
    characters.append(line.strip())

points = {')':0,']':0,'}':0,'>':0}
points_to_get = {')':3,']':57,'}':1197,'>':25137}

for line in characters:
    parse(line)
ans = 0
for point in points:
    ans += points[point] * points_to_get[point]
print(ans)
