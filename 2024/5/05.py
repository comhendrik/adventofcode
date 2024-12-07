

# corresponding number of list must before key number
# Initialize an empty dictionary
page_number_rules = {}

with open('rules-input.txt', 'r') as file:
    for line in file:
        # Split the line into the left and right numbers
        left, right = map(int, line.strip().split('|'))

        # Add the left number to the list for the key (right number)
        if right not in page_number_rules:
            page_number_rules[right] = []
        page_number_rules[right].append(left)

page_number_list = []

# Read the file and process its lines
with open('data-input.txt', 'r') as file:
    for line in file:
        # Split the line by commas and convert each part to an integer
        number_list = list(map(int, line.strip().split(',')))

        # Append the list to the main list
        page_number_list.append(number_list)



def checkIfUpdateIsCorrect(page_numbers):
    #go through numbers and check if there is a number
    for i in range(len(page_numbers)-1):

        number = page_numbers[i]
        if number not in page_number_rules:
            continue

        number_to_check = page_numbers[i+1]


        number_rule = page_number_rules[number]

        if number_to_check in number_rule:
            return False

    return True

print("part one")

total = 0

incorrect_page_numbers = []

for page_numbers in page_number_list:
    if checkIfUpdateIsCorrect(page_numbers): total += page_numbers[len(page_numbers) // 2]
    else: incorrect_page_numbers.append(page_numbers)

print(total)

print("part two")

def sortUpdateBased(page_numbers):

    #use bubble sort for sorting
    n = len(page_numbers)

    # Traverse through all elements of the array
    for i in range(n):
        # Last i elements are already sorted, no need to check them
        swapped = False  # Flag to check if any elements were swapped

        for j in range(0, n-i-1):
            number = page_numbers[j]



            if number not in page_number_rules:
                continue

            number_to_check = page_numbers[j+1]

            number_rule = page_number_rules[number]

            if number_to_check in number_rule:
                #swap if number_to_check is not allowed to come after number
                page_numbers[j], page_numbers[j+1] = page_numbers[j+1], page_numbers[j]
                swapped = True  # Set flag to True if swap occurs

        # If no elements were swapped in the inner loop, the array is sorted
        if not swapped:
            break

    return page_numbers


total = 0

for page_numbers in incorrect_page_numbers:
    sorted = sortUpdateBased(page_numbers)
    total += sorted[len(sorted) // 2]

print(total)
