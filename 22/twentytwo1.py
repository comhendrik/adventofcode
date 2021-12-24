with open("22/twentytwo.txt") as fin:
    raw_data = fin.read().strip().split("\n")
steps = []

for line in raw_data:
    parts = line.split(" ")
    switch = parts[0] == "on"
    bounds = []
    for axis in parts[1].split(","):
        axis = axis.split("..")
        bounds.append((int(axis[0][2:]) + 50, int(axis[1]) + 50))

    steps.append((switch, bounds))
steps = steps[:20]

on_positons = set()
for value, bounds in steps:
    min_x,max_x = bounds[0]
    min_y,max_y = bounds[1]
    min_z,max_z = bounds[2]
    for x in range(min_x,max_x+1):
        for y in range(min_y,max_y+1):
            for z in range(min_z,max_z+1):
                if value == True:
                    on_positons.add((x,y,z))
                else:
                    on_positons.discard((x,y,z))

print(len(on_positons))