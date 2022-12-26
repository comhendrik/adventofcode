def snafu_to_int(number):
    calculation = 0
    place = 1
    for sign in number:
        if sign == '=':
            calculation -= place * 2
        elif sign == '-':
            calculation -= place
        else:
            calculation += place * int(sign)
        place = place * 5
    return calculation

snafu_numbers = []
for line in open('2022/25/input.txt'):
    snafu_numbers.append(line.strip())

sum = 0
for number in snafu_numbers:
    sum += snafu_to_int(number[::-1])
print(sum)

#Help from the internet

s2d = {
    "0": 0,
    "1": 1,
    "2": 2,
    "-": -1,
    "=": -2
}

d2s = {d: s for s, d in s2d.items()}

def int_to_snafu(n):
    res = ""
    while n > 0:
        d = ((n + 2) % 5) - 2
        res += d2s[d]
        n -= d
        n //= 5
    return res[::-1]


print("Part one:")
print(int_to_snafu(sum))