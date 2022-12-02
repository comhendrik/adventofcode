numbers = [int(x) for x in open('1/one.txt')]
windows = []
for i in range(len(numbers)):
    windows.append(0)
    windows[i] = numbers[i] + numbers[i+1] + numbers[i+2]
    print(windows)
    if len(numbers) - 3 == i:
        break
p1 = 0
prev = None
for e in range(len(windows)):
    if prev and windows[e] > prev:
        p1 += 1
    prev = windows[e]

print(p1)
