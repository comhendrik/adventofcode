class Player:
    def __init__(self, pos):
        self.points = 0
        self.position = pos

    def move(self, dice):
        self.position += dice.roll()
        self.position = (self.position - 1) % 10 + 1
        self.points += self.position
        if self.points >= 1000: return True

class Dice:
    def __init__(self):
        self.value = 1
        self.rolls = 0

    def roll(self):
        new_pos = 0
        for _ in range(3):
            new_pos += self.value
            self.value += 1
        self.rolls += 3
        return new_pos

p1 = Player(7)
p2 = Player(10)
dice = Dice()
while True:
    if p1.move(dice):
        print(p2.points * dice.rolls)
        break
    if p2.move(dice):
        print(p1.points * dice.rolls)
        break
    

    