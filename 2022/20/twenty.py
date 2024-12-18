class Node:
    def __init__(self, n):
        self.n = n
        self.left = None
        self.right = None

x = [Node(int(x)) for x in open('2022/20/input.txt.txt')]

for i in range(len(x)):
    x[i].right = x[(i + 1) % len(x)]
    x[i].left = x[(i - 1) % len(x)]


m = len(x) - 1

for k in x:
    if k.n == 0:
        #Setting the start node for later use
        z = k
        continue
    p = k
    if k.n > 0:
        for _ in range(k.n % m):
            p = p.right
        if k == p:
            continue
        k.right.left = k.left
        k.left.right = k.right
        p.right.left = k
        k.right = p.right
        p.right = k
        k.left = p
    else:
        for _ in range(-k.n % m):

            p = p.left
        if k == p:
            continue
        k.left.right = k.right
        k.right.left = k.left
        p.left.right = k
        k.left = p.left
        p.left = k
        k.right = p
ans = 0

for _ in range(3):
    for _ in range(1000):
        z = z.right
    ans += z.n

print("part one")
print(ans)

x = [Node(int(x) * 811589153) for x in open('2022/20/input.txt.txt')]

for i in range(len(x)):
    x[i].right = x[(i + 1) % len(x)]
    x[i].left = x[(i - 1) % len(x)]


m = len(x) - 1

for _ in range(10):
    for k in x:
        if k.n == 0:
            #Setting the start node for later use
            z = k
            continue
        p = k
        if k.n > 0:
            for _ in range(k.n % m):
                p = p.right
            if k == p:
                continue
            k.right.left = k.left
            k.left.right = k.right
            p.right.left = k
            k.right = p.right
            p.right = k
            k.left = p
        else:
            for _ in range(-k.n % m):

                p = p.left
            if k == p:
                continue
            k.left.right = k.right
            k.right.left = k.left
            p.left.right = k
            k.left = p.left
            p.left = k
            k.right = p
ans = 0

for _ in range(3):
    for _ in range(1000):
        z = z.right
    ans += z.n

print("part two")
print(ans)