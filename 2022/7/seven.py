class Dir:
    def __init__(self, name, subdir, docs, prev):
        self.name = name
        self.subdir = subdir
        self.docs = docs
        self.prev = prev

class Doc:
    def __init__(self, name, size):
        self.name = name
        self.size = size



directory = Dir('/', subdir=[], docs=[], prev=None)

#build directory

current = directory

for line in open('2022/7/input.txt.txt'):
    command = line.strip().split(' ')
    if 'cd' in set(command):
        if command[2] == '..':
            current = current.prev
        elif command[2] == '/':
            current = directory
        else:
            for subdir in current.subdir:
                if subdir.name == command[2]:
                    current = subdir
                    break
    elif 'dir' in set(command):
        current.subdir.append(Dir(command[1], subdir=[], docs=[], prev=current))

    elif command[0] != '$':
        current.docs.append(Doc(command[1], command[0]))


sum_of_size_of_dirs_under_100000 = 0

def dfs(directory):
    global sum_of_size_of_dirs_under_100000
    sum = 0
    for doc in directory.docs:
        sum += int(doc.size)
    for subdir in directory.subdir:
        sum += dfs(subdir)
    if sum <= 100000:
        sum_of_size_of_dirs_under_100000 += sum
    return sum

total_sum = dfs(directory)
print("Part one")
print(sum_of_size_of_dirs_under_100000)

unused_space = 70000000 - total_sum
smallest_dir_to_install_update = 70000000
def find_smallest_dir(directory):
    global smallest_dir_to_install_update
    sum = 0
    for doc in directory.docs:
        sum += int(doc.size)
    for subdir in directory.subdir:
        sum += find_smallest_dir(subdir)
    if  (unused_space + sum >= 30000000) and smallest_dir_to_install_update >= sum:
        smallest_dir_to_install_update = sum
        
        
        
    return sum

find_smallest_dir(directory)
print("Part two")
print(smallest_dir_to_install_update)