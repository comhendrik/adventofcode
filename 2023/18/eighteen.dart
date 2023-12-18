import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<(String, int, String)> directions = [];
  var filePath = p.join(Directory.current.path, '2023/18/eighteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split(' ');
    directions.add((data[0], int.parse(data[1]), data[2]));
  }
  List<(int,int)> coordinates = [(0,0)];

  Map<String, (int,int)> allMovingCoors = {
    'U' : (-1,0),
    'D' : (1,0),
    'L' : (0,-1),
    'R' : (0,1)
  };

  (int, int) currentCoordinates = (0,0);
  for ((String, int, String) direction in directions) {
    (int, int) movingCoors = allMovingCoors[direction.$1]!;
    for (int i=0; i<direction.$2; i++) {
      currentCoordinates = (currentCoordinates.$1 + movingCoors.$1,currentCoordinates.$2 + movingCoors.$2);
      coordinates.add(currentCoordinates);
    }
  }
  int minY = 0;
  int maxY = 0;
  int minX = 0;
  int maxX = 0;

  for ((int,int) coors in coordinates) {
    if (minY > coors.$1) minY = coors.$1;
    else if (maxY < coors.$1) maxY = coors.$1;
    if (minX > coors.$2) minX = coors.$2;
    else if (maxX < coors.$2) maxX = coors.$2;
  }

  int addingY = minY * (-1);
  int addingX = minX * (-1);

  List<List<String>> map = List.generate(maxY + addingY + 1, (index) => List<String>.filled(maxX + addingX + 1, '.'));

  for ((int,int) coors in coordinates) {
    map[coors.$1 + addingY][coors.$2 +addingX] = '#';
  }



  List<(int,int)> coordinatesToAdd = [];

  for (int i=0; i<map.length; i++) {
    for (int j=0; j<map.first.length; j++) {
      if (map[i][j] == '#') continue;
      int crossings = 0;
      bool isInLine = false;
      for(int z=j-1; z>=0; z--) {
        if (map[i][z] == '#' && isInLine == false) {
          crossings += 1;
          isInLine = true;
        } else if (map[i][z] != '#' && isInLine == true) {
          isInLine = false;
        }
      }

      if (crossings % 2 == 1) {
        coordinatesToAdd.add((i,j));
      }
    }
  }

  for ((int,int) coors in coordinatesToAdd) {
    map[coors.$1][coors.$2] = '#';
  }

  int sum = 0;
  for (int i=0; i<map.length; i++) {
    for (int j=0; j<map.first.length; j++) {
      if (map[i][j] == '#') sum++;
    }
  }
  print(sum);
}