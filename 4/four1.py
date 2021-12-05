import re

input_list = []

f = open("4/four.txt", "r")
input_list = f.read().split("\n")

drawn_numbers = input_list[0].split(',')
drawn_numbers = list(map(int, drawn_numbers))
input_list.pop(0)
input_list.pop(0)

board_item = []
board_list = []
final_score = 0

# create list of lists containing numbers from board rows
def boardToIntList(board):
    possible_list = board.copy()
    for i in range(len(board)):
        possible_list[i] = re.split('\s+', possible_list[i])
        if '' in possible_list[i]:
            possible_list[i].remove('')
        possible_list[i] = list(map(int, possible_list[i]))
    return possible_list

def getBoardSum(board_list):
    sum = 0
    for i in range(len(board_list)):
        for j in range(len(board_list[i])):
            sum += board_list[i][j]
    return sum

# find all possible rows or columns and return them in an int list
def convertToAllPossibleList(board):
    possible_list = boardToIntList(board.copy())
    
    for i in range(len(possible_list[0])):
        item = []
        for j in range(len(board)):
            num_list = re.split('\s+', board[j])
            if '' in num_list:
                num_list.remove('')
            item.append(int(num_list[i]))
        possible_list.append(item)
    return possible_list

# check through and find index and final score when board achieves bingo
def findBoardFinalScoreIndex(drawn_numbers, possible_list, board_sum):
    for i in range(len(drawn_numbers)):
        has_drawn_number = False
        for j in range(len(possible_list)):
            drawn_value = drawn_numbers[i]
            if drawn_value in possible_list[j]:
                possible_list[j].remove(drawn_value)
                if has_drawn_number == False:
                    has_drawn_number = True
            if not possible_list[j]:
                board_sum -= drawn_value
                index = i
                score = board_sum * drawn_value
                return index, score
        if has_drawn_number == True:
            board_sum -= drawn_value
    
for i in range(len(input_list)):
    if input_list[i] == '' or i == len(input_list)-1:
        board_list.append(board_item)
        board_item = []
    else:
        board_item.append(input_list[i])

def fastest_win_score(board_list):
    complete_index = len(drawn_numbers)
    final_score = None
    for i in range(len(board_list)):
        board_int_list = boardToIntList(board_list[i])
        board_sum = getBoardSum(board_int_list)
        board_item_list = convertToAllPossibleList(board_list[i])
        index, score = findBoardFinalScoreIndex(drawn_numbers, board_item_list, board_sum)
        if index < complete_index:
            complete_index = index
            final_score = score
        if index == len(board_int_list[0]):
            break
    return final_score
part1 = fastest_win_score(board_list)
print(part1)

def slowest_win_score(board_list):
    complete_index = 0
    final_score = None
    for i in range(len(board_list)):
        board_int_list = boardToIntList(board_list[i])
        board_sum = getBoardSum(board_int_list)
        board_item_list = convertToAllPossibleList(board_list[i])
        index, score = findBoardFinalScoreIndex(drawn_numbers, board_item_list, board_sum)
        if index > complete_index:
            complete_index = index
            final_score = score
        if index == len(board_int_list[0]):
            break
    return final_score

part2 = slowest_win_score(board_list)
print(part2)




