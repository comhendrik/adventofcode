with open("18/eighteen.txt") as fin:
    raw_data = fin.read().strip().split("\n")
data = [eval(line) for line in raw_data]


# We're representing data as a tree


class Node:
    def __init__(self, val=None):
        self.val = val
        self.left = None
        self.right = None
        self.par = None


def parse(fish_num):
    root = Node()
    if isinstance(fish_num, int):
        root.val = fish_num
        return root

    root.left = parse(fish_num[0])
    root.right = parse(fish_num[1])
    root.left.par = root
    root.right.par = root

    reduce(root)

    return root


def add(a, b):
    root = Node()
    root.left = a
    root.right = b
    root.left.par = root
    root.right.par = root
    reduce(root)
    return root


def magnitude(root):
    if isinstance(root.val, int):
        return root.val

    return 3 * magnitude(root.left) + 2 * magnitude(root.right)


def reduce(root):
    done = True
    stack = [(root, 0)]

    while len(stack) > 0:
        node, depth = stack.pop()

        if node == None:
            continue

        condition = (node.left == None and node.right == None) or (
            node.left.val != None and node.right.val != None)

        if depth >= 4 and node.val == None and condition:
            prev = node.left
            cur = node
            while cur != None and (cur.left == prev or cur.left == None):
                prev = cur
                cur = cur.par

            if cur != None:

                cur = cur.left
                while cur.val == None:
                    if cur.right != None:
                        cur = cur.right
                    else:
                        cur = cur.left

                cur.val += node.left.val

            prev = node.right
            cur = node
            while cur != None and (cur.right == prev or cur.right == None):
                prev = cur
                cur = cur.par

            if cur != None:

                cur = cur.right
                while cur.val == None:
                    if cur.left != None:
                        cur = cur.left
                    else:
                        cur = cur.right

                cur.val += node.right.val

            node.val = 0
            node.left = None
            node.right = None

            done = False
            break

        stack.append((node.right, depth + 1))
        stack.append((node.left, depth + 1))

    if not done:
        reduce(root)
        return

    stack = [root]
    while len(stack) > 0:
        node = stack.pop()
        if node == None:
            continue

        if node.val != None:
            assert node.left == None and node.right == None
            if node.val >= 10:
                node.left = Node(node.val//2)
                node.right = Node(node.val - (node.val//2))
                node.left.par = node
                node.right.par = node
                node.val = None

                done = False
                break

        stack.append(node.right)
        stack.append(node.left)

    if not done:
        reduce(root)


root = parse(data[0])

i = 1
while i < len(data):
    root = add(root, parse(data[i]))
    i += 1

ans = magnitude(root)
print(ans)

