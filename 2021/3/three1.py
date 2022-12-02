results = [
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},
    {'1':0,'0':0},] 
for line in open('3/three.txt'):
    line = line.strip()
    print(line)
    for i in range(len(line)):
        results[i][line[i]] += 1
        
for e in range(len(results)):
    print('1:',results[e]['1'], '0:',results[e]['0'])

#the code above give us these rates
#gamma rate   101000010000 = 2576
#                             *
#epsilon rate 010111101111 = 1519
#                            3912944
