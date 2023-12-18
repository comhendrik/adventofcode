import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<List<String>> map = [];
  List<List<String>> start_map = [];
  var filePath = p.join(Directory.current.path, '2023/14/fourteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split('');
    start_map.add([]);
    for (String char in data) {
      start_map.last.add(char);
    }
  }
  map = start_map;
  print("Part one:");

  //tilting to north
  for(int i=0; i<map.length; i++) {
    for(int j=0; j<map[i].length; j++) {
      if (map[i][j] == 'O') {
        map[i][j] = '.';
        final newCoords = generateNewCoordsForRock(-1, false, i, j, map);
        map[newCoords.$1][newCoords.$2] = 'O';
      }
    }
  }
  //computing load
  int sum = 0;
  for(int i=0; i<map.length; i++) {
    for(int j=0; j<map[i].length; j++) {
      if (map[i][j] == 'O') {
        sum += map.length - i;
      }
    }
  }
  print(sum);


  print("Part two:");

  //reloading map
  map = start_map;
  Map<String, int> seen = {};
  sum = 0;
  for (int count = 0; count < 1000000000; count++) {
    //tilting to north
    for(int i=0; i<map.length; i++) {
      for(int j=0; j<map[i].length; j++) {
        if (map[i][j] == 'O') {
          map[i][j] = '.';
          final newCoords = generateNewCoordsForRock(-1, false, i, j, map);
          map[newCoords.$1][newCoords.$2] = 'O';
        }
      }
    }
    //tilting to west
    for(int i=0; i<map.length; i++) {
      for(int j=0; j<map[i].length; j++) {
        if (map[i][j] == 'O') {
          map[i][j] = '.';
          final newCoords = generateNewCoordsForRock(-1, true, i, j, map);
          map[newCoords.$1][newCoords.$2] = 'O';
        }
      }
    }
    //tilting to south
    for(int i=map.length-1; i>=0; i--) {
      for(int j=map[i].length-1; j>=0; j--) {
        if (map[i][j] == 'O') {
          map[i][j] = '.';
          final newCoords = generateNewCoordsForRock(1, false, i, j, map);
          map[newCoords.$1][newCoords.$2] = 'O';
        }
      }
    }
    //tilting to east
    for(int i=map.length-1; i>=0; i--) {
      for(int j=map[i].length-1; j>=0; j--) {
        if (map[i][j] == 'O') {
          map[i][j] = '.';
          final newCoords = generateNewCoordsForRock(1, true, i, j, map);
          map[newCoords.$1][newCoords.$2] = 'O';
        }
      }
    }
    if (seen.containsKey(getHashOfMap(map))) {

      //find how long a cycle is until the same state appears again
      final lengthOfCycle = count - seen[getHashOfMap(map)]!;
      //found out how many cycles fit in the range of the number of the first cycle and 1000000000
      //-1 is done because of 0 based counting
      int restOfCycle = (1000000000 - 1 - seen[getHashOfMap(map)]!) % lengthOfCycle;
      for (int rest=0; rest < restOfCycle; rest++) {
        //Maybe add a function for cycling
        //tilting to north
        for(int i=0; i<map.length; i++) {
          for(int j=0; j<map[i].length; j++) {
            if (map[i][j] == 'O') {
              map[i][j] = '.';
              final newCoords = generateNewCoordsForRock(-1, false, i, j, map);
              map[newCoords.$1][newCoords.$2] = 'O';
            }
          }
        }
        //tilting to west
        for(int i=0; i<map.length; i++) {
          for(int j=0; j<map[i].length; j++) {
            if (map[i][j] == 'O') {
              map[i][j] = '.';
              final newCoords = generateNewCoordsForRock(-1, true, i, j, map);
              map[newCoords.$1][newCoords.$2] = 'O';
            }
          }
        }
        //tilting to south
        for(int i=map.length-1; i>=0; i--) {
          for(int j=map[i].length-1; j>=0; j--) {
            if (map[i][j] == 'O') {
              map[i][j] = '.';
              final newCoords = generateNewCoordsForRock(1, false, i, j, map);
              map[newCoords.$1][newCoords.$2] = 'O';
            }
          }
        }
        //tilting to east
        for(int i=map.length-1; i>=0; i--) {
          for(int j=map[i].length-1; j>=0; j--) {
            if (map[i][j] == 'O') {
              map[i][j] = '.';
              final newCoords = generateNewCoordsForRock(1, true, i, j, map);
              map[newCoords.$1][newCoords.$2] = 'O';
            }
          }
        }
      }
      //computing load
      sum = 0;
      for(int i=0; i<map.length; i++) {
        for(int j=0; j<map[i].length; j++) {
          if (map[i][j] == 'O') {
            sum += map.length - i;
          }
        }
      }
      print(sum);
      break;
    }
    seen[getHashOfMap(map)] = count;
  }
}

(int, int) generateNewCoordsForRock(int direction, bool horizontal, int y, int x, List<List<String>> map) {
  if (horizontal) {
    int currentX = x;
    if (direction == -1) {
      //west
      while (currentX >= 0) {
        if (map[y][currentX] != '.') {
          return (y,currentX+1);
        } else {
          currentX -= 1;
        }
      }
      return (y,currentX+1);
    } else {
      //east
      while (currentX < map.first.length) {
        if (map[y][currentX] != '.') {
          return (y,currentX-1);
        } else {
          currentX += 1;
        }
      }
      return (y,currentX - 1);
    }
  } else {
    int currentY = y;
    if (direction == -1) {
      //north
      while (currentY >= 0) {
        if (map[currentY][x] != '.') {
          return (currentY+1,x);
        } else {
          currentY -= 1;
        }
      }
      return (currentY + 1,x);
    } else {
      //south
      while (currentY < map.length) {
        if (map[currentY][x] != '.') {
          return (currentY-1,x);
        } else {
          currentY += 1;
        }
      }
      return (currentY - 1,x);
    }
  }
}

String getHashOfMap(List<List<String>> map) {
  String hash = "";
  for (List<String> row in map) {
    for (String char in row) {
      hash = hash + char;
    }
  }
  return hash;
}

