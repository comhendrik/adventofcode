sum_of_fully_containment = 0
sum_of_not_overlapping = 0
line_counter = 0
for line in open('2022/4/input.txt'):
    line_counter += 1
    numbers = line.strip()
    parts = numbers.split(',')
    ids = []
    for numbers in parts:
        id_pair = numbers.split('-')
        for iD in id_pair:
            ids.append(int(iD))
    #Part one 
    if ids[0] <= ids[2] and ids[1] >= ids[3]: sum_of_fully_containment += 1
    elif ids[2] <= ids[0] and ids[1] <= ids[3]: sum_of_fully_containment += 1

    #Part two
    if  (ids[0] > ids[3]) : sum_of_not_overlapping += 1
    elif (ids[1] < ids[2]) : sum_of_not_overlapping += 1


print("Part one:")
print(sum_of_fully_containment)

print("Part two:")
print(line_counter - sum_of_not_overlapping)



