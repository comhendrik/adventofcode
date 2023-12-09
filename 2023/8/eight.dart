import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<int> instructions = [];
  Map<String, List<String>> nodes = {};
  final instructionString = 'LLRLLRLRLRRRLLRRRLRRLRLRLRLRLRLRRLRRRLRLLRRLRRLRRRLLRLLRRLLRRRLLLRLRRRLLLLRRRLLRRRLRRLRLLRLRLRRRLRRRLRRLRRLRRLRLLRRRLRRLRRRLLRRRLRLRRLLRRLLRLRLRRLRRLLRLLRRLRLLRRRLLRRRLRRLLRRLRRRLRLRRRLRRLLLRLLRLLRRRLRLRLRLRRLRRRLLLRRRLRRRLRRRLRRLRLRLRLRRRLRRLLRLRRRLRLRLRRLLLRRRR';
  for (String char in instructionString.split('')) {
    if (char == 'L') instructions.add(0);
    else instructions.add(1);
  }

  var filePath = p.join(Directory.current.path, '2023/8/eight_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split(' ');
    nodes[data[0]] = [data[2].substring(1, data[2].length - 1), data[3].substring(0, data[3].length - 1)];
  }

  print("part one:");
  String currentNode = 'AAA';
  int steps = 0;
  bool found = false;
  while (!found) {
    for(int instruction in instructions) {
      currentNode = nodes[currentNode]![instruction];
      steps += 1;
      if (currentNode == 'ZZZ') {
        print(steps);
        found = true;
        break;
      }
    }
  }

  print("part two:");
  List<String> allCurrentNodes = [];
  for (String key in nodes.keys) {
    if (key.endsWith('A')) allCurrentNodes.add(key);
  }
  Map<String, int> cycleCount = {};
  for(String node in allCurrentNodes) {
    currentNode = node;
    steps = 0;
    found = false;
    while (!found) {
      for(int instruction in instructions) {
        currentNode = nodes[currentNode]![instruction];
        steps += 1;
        if (currentNode.endsWith('Z')) {
          cycleCount[node] = steps;
          found = true;
          break;
        }
      }
    }
  }
  print(findLCMOfList(cycleCount.values));
}


//Helper function from internet
int findLCMOfList(Iterable<int> numbers) {
  // Function to find the greatest common divisor (GCD) of two numbers
  int findGCD(int x, int y) {
    while (y != 0) {
      var temp = y;
      y = x % y;
      x = temp;
    }
    return x;
  }

  // Function to find the LCM of two numbers
  int findLCM(int a, int b) {
    return (a * b) ~/ findGCD(a, b);
  }

  // Calculate LCM for the entire list
  int lcm = 1;
  for (int number in numbers) {
    lcm = findLCM(lcm, number);
  }

  return lcm;
}