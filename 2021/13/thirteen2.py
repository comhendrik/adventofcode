x = []
y = []
coordinates = []
fold_instructions = []
def do_y_fold(fold):
    for i in range(len(paper[fold])):
        paper[fold][i] = 9
    fold_along_y(fold-1,fold+1)
    for i in range(fold,len(paper)):
        del paper[-1]


def do_x_fold(fold):
    for i in range(len(paper)):
        paper[i][fold] = 9
    fold_along_x(fold-1,fold+1)
    for row in paper:
        for _ in range(fold,len(row)):
            del row[-1]


def fold_along_y(newaxis,oldaxis):
    if newaxis >= 0 and oldaxis < len(paper):
        for pos in range(len(paper[oldaxis])):
            if paper[oldaxis][pos] == 1:
                paper[newaxis][pos] = paper[oldaxis][pos]
        fold_along_y(newaxis=newaxis-1,oldaxis=oldaxis+1)


def fold_along_x(newaxis,oldaxis):
    if newaxis >= 0 and oldaxis < len(paper[0]):
        for pos in range(len(paper)):
            if paper[pos][oldaxis] == 1:
                paper[pos][newaxis] = paper[pos][oldaxis]
        fold_along_x(newaxis=newaxis-1,oldaxis=oldaxis+1)

for line in open('13/thirteen.txt'):
    if line != '\n' and line.startswith('fold') == False:
        x_axis,y_axis = line.strip().split(',')
        x.append(int(x_axis))
        y.append(int(y_axis))
        coordinates.append((int(x_axis),int(y_axis)))
    else:
        line = line.strip().split(' ')
        if len(line) > 1:
            line = line[2].split('=')
            fold_instructions.append((line[0],line[1]))
print(fold_instructions)
#create transparent paper(2d array)
paper = list_of_lists = [[0 for row in range(max(x)+1)] for col in range(max(y)+1)]
#fill transparent paper with values
for value in coordinates:
    x,y = value
    paper[y][x] = 1
#Do some folding
for key,value in fold_instructions:
    if key == 'y':
        do_y_fold(int(value))
    else:
        do_x_fold(int(value))
    

for line in paper:
    print(line)

#The transparent shows letters with the ones in our 2d array. This is solution

