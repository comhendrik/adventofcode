import statistics
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
                return 
    return stack
characters = []
for line in open('10/ten.txt'):
    characters.append(line.strip())
points = {'(':1,'[':2,'{':3,'<':4}
scores = []
for line in characters:
    incomplete_line = parse(line)
    if incomplete_line != None:
        print(incomplete_line)
        total_score = 0
        for char in list(reversed(incomplete_line)):
            total_score = total_score * 5 + points[char]
        scores.append(total_score)
scores.sort()
print(scores)
ans = scores[len(scores) // 2]
print(ans)
