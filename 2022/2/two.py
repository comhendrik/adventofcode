def playGamePartOne(elf: str, you: str):
    if elf == "A":
        #Rock
        if you == "X":
            #Rock
            return 1 + 3
        elif you == "Y":
            #Paper
            return 2 + 6
        else:
            #Scissors
            return 3 + 0
    elif elf == "B":
        #Paper
        if you == "X":
            #Rock
            return 1 + 0
        elif you == "Y":
            #Paper
            return 2 + 3
        else:
            #Scissors
            return 3 + 6
    else:
        #Scissors
        if you == "X":
            #Rock
            return 1 + 6
        elif you == "Y":
            #Paper
            return 2 + 0
        else:
            #Scissors
            return 3 + 3
def playGamePartTwo(elf: str, you: str):
    if elf == "A":
        #Rock
        if you == "X":
            #Lose -> Scissor
            return 3 + 0
        elif you == "Y":
            #Draw -> Rock
            return 1 + 3
        else:
            #Win -> Paper
            return 2 + 6
    elif elf == "B":
        #Paper
        if you == "X":
            #Lose -> Rock
            return 1 + 0
        elif you == "Y":
            #Draw -> Paper
            return 2 + 3
        else:
            #Win -> Scissors
            return 3 + 6
    else:
        #Scissors
        if you == "X":
            #Lose -> Paper
            return 2 + 0
        elif you == "Y":
            #Draw Scissors
            return 3 + 3
        else:
            #Win -> Rock
            return 1 + 6
scorePartOne = 0
scorePartTwo = 0
for line in open('2022/2/input.txt'):
    elf, you = line.split(' ')
    scorePartOne += playGamePartOne(elf, you.strip())
    scorePartTwo += playGamePartTwo(elf,you.strip())

print("Part one:")
print(scorePartOne)
print("Part two:")
print(scorePartTwo)