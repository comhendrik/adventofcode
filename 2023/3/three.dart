import 'package:path/path.dart' as p;
import 'dart:io';


void main() async {

  //encoding txt file
  List<List<String>> map = [];
  var filePath = p.join(Directory.current.path, '2023/3/three_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    map.add([]);
    for (String char in line.split('')) {
      map.last.add(char);
    }
  }

  List<(int, List<(int, int)>)> allNumbers = [];
  //creating lists for all numbers
  for (int y = 0; y<map.length; y++) {
    for (int x = 0; x < map[y].length; x++) {
      String number = "";
      int foundNumberX = 0;
      if (int.tryParse(map[y][x]) != null) {
        List<(int, int)> numberCoors = [];
        number = number + map[y][x];
        numberCoors.add((x, y));
        foundNumberX = x + 1;
        while (foundNumberX < map[y].length && int.tryParse(map[y][foundNumberX]) != null) {
          number = number + map[y][foundNumberX];
          numberCoors.add((foundNumberX, y));
          foundNumberX += 1;
        }
        x = foundNumberX;
        allNumbers.add((int.parse(number), numberCoors));
      }
    }
  }

  //plan for every coordinate of a number check if there is a neighbour if there is a neighbour the whole number has a neighbour
  //x = first, y = second
  final verticaltop = (-1,0);
  final verticalbottom = (1,0);
  final horizontalright = (0,1);
  final horizontalleft = (0,-1);
  final topleft = (-1,-1);
  final topRight = (-1,1);
  final bottomLeft = (1,-1);
  final bottomRight = (1,1);

  final List<(int,int)> commands = [topleft,verticaltop,topRight,horizontalleft,horizontalright, bottomLeft, verticalbottom, bottomRight];


  //part one
  print("part one:");
  int sum = 0;
  for ((int, List<(int, int)>) number in allNumbers) {
    bool foundNumber = false;
    for ((int,int) coor in number.$2) {
      final checkers = generateCheckers(coor.$1, coor.$2, map[coor.$1].length - 1, map.length - 1, commands);
      for ((int, int) checker in checkers) {
        if (map[checker.$2][checker.$1] != '.' && int.tryParse(map[checker.$2][checker.$1]) == null) {
          foundNumber = true;
        }
      }

    }
    if (foundNumber) {
      sum += number.$1;
    }
  }
  print(sum);

  //part two
  Map<String, List<int>> gears = {};
  print("part two:");

  for ((int, List<(int, int)>) number in allNumbers) {
    int gearX = 0;
    int gearY = 0;
    bool foundNumber = false;
    for ((int,int) coor in number.$2) {
      final checkers = generateCheckers(coor.$1, coor.$2, map[coor.$1].length - 1, map.length - 1, commands);
      for ((int, int) checker in checkers) {
        if (map[checker.$2][checker.$1] == '*') {
          foundNumber = true;
          gearX = checker.$1;
          gearY = checker.$2;
        }
      }

    }
    if (foundNumber) {
      if (gears["$gearX$gearY"] == null) {
        gears["$gearX$gearY"] = [number.$1];
      } else {
        gears["$gearX$gearY"]!.add(number.$1);
      }

    }
  }
  sum = 0;
  for (String key in gears.keys) {
    if (gears[key]!.length == 2) {
      sum += gears[key]![0] * gears[key]![1];
    }
  }
  print(sum);
}



List<(int,int)> generateCheckers(int x, int y, int maxX, int maxY, List<(int, int)> commands) {
  List<(int, int)> checkers = [];
  for ((int, int) command in commands) {
    int newX = x;
    int newY = y;

    newX += command.$1;
    if (newX < 0) continue;
    else if (newX > maxX) continue;
    newY += command.$2;
    if (newY < 0) continue;
    else if(newY > maxY) continue;
    checkers.add((newX,newY));
  }

  return checkers;
}