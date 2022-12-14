data = open("2022/13/input.txt", 'r')
packets = data.read().strip().split("\n\n")




def compare(a, b):
    if isinstance(a, list) and isinstance(b, int):
        b = [b]

    if isinstance(a, int) and isinstance(b, list):
        a = [a]

    if isinstance(a, int) and isinstance(b, int):
        if a < b:
            return 1
        if a == b:
            return 0
        return -1

    if isinstance(a, list) and isinstance(b, list):
        i = 0

        while i < len(a) and i < len(b):
            to_compare = compare(a[i],b[i])

            if to_compare != 0: #check if object is in right order or not or do nothing when its undefined
                return to_compare

            i += 1


        if i == len(a):
            if len(a) == len(b):
                return 0 #both lists are equal
            return 1  # a ended first

        #if i his not length of a b ended first which means that they are not in order
        return -1

sum_of_indices = 0
for i, block in enumerate(packets):
    a, b = map(eval, block.split("\n")) #eval makes python lists out of strings because those strings are describing real python lists
    if compare(a, b) == 1:
        sum_of_indices += i + 1 #add index of pair that is in the right order

print(sum_of_indices)