class Node:
    def __init__(self, n):
        self.n = n
        self.left = None
        self.right = None

x = [Node(int(x)) for x in open('2022/20/t.txt')]

for i in range(len(x)):
    x[i].right = x[(i + 1) % len(x)]
    x[i].left = x[(i - 1) % len(x)]

for k in x:
    if k.n == 0:
        #Setting the start node for later use
        z = k
        continue
    p = k
    if k.n > 0:
        for _ in range(k.n):
            p = p.right 
        if k == p:
            continue
        #delete node
        print(len(x))
        k.right.left = k.left
        k.left.right = k.right
        print(len)
        #add node
        p.right.left = k
        k.right = p.right
        p.right = k
        k.left = p
    else:
        for _ in range(k.n):

            p = p.left
        if k == p:
            continue
        k.left.right = k.right
        k.right.left = k.left
        p.left.right = k
        k.left = p.left
        p.left = k
        k.right = p
    break

for k in x:
    print(k.n)


