import 'package:path/path.dart' as p;
import 'dart:io';


void main() async {
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
  final checkers = generateCheckers(3, 3, 5,5, commands);
  print(checkers);
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