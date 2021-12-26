w = 0
x = 0
y = 0
z = 0

def inp(var,value):
    global w,x,y,z
    if var == 'w':
        w = value
    elif var == 'x':
        x = value
    elif var == 'y':
        y = value
    else:
        z = value
def add(var1,var2):
    global w,x,y,z
    if var1 == 'w':
        if var2 == 'w':
            w = w+w
print(z)
inp('z',5)
print(z)