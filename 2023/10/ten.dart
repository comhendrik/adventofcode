import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<List<String>> map = [];
  List<(int,int)?> borders = [];
  var filePath = p.join(Directory.current.path, '2023/10/ten_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split('');
    map.add([]);
    borders.add(null);
    for (String char in data) {
      if (char == 'S') {
      }
      map.last.add(char);
    }
  }
  Map<String, (int, int)> instructionsOptionOne = {
    '|' : (1,0),
    '-' : (0,1),
    'L' : (0,1),
    'J' : (-1,0),
    '7' : (0,-1),
    'F' : (1,0),
  };
  Map<String, (int, int)> instructionsOptionTwo = {
    '|' : (-1,0),
    '-' : (0,-1),
    'L' : (-1,0),
    'J' : (0,-1),
    '7' : (1,0),
    'F' : (0,1),
  };


  //these startings points for searched in the file without parsing it
  (int,int) startingPoint = (49,95);
  (int,int) endPoint = (50,96);
  (int,int) prevStartingPoint = (49,96);
  (int,int) prevEndPoint = (49,96);
  int count = 1;
  print("Part one:");
  while(true) {
    if (startingPoint == endPoint) break;
    String startingInstruction = map[startingPoint.$1][startingPoint.$2];
    final coorsStartingOptionOne = instructionsOptionOne[startingInstruction]!;
    final coorsStartingOptionTwo = instructionsOptionTwo[startingInstruction]!;
    final newStartingPointOptionOne = (startingPoint.$1 + coorsStartingOptionOne.$1, startingPoint.$2 + coorsStartingOptionOne.$2);
    final newStartingPointOptionTwo = (startingPoint.$1 + coorsStartingOptionTwo.$1, startingPoint.$2 + coorsStartingOptionTwo.$2);
    if (newStartingPointOptionOne == prevStartingPoint) {
      prevStartingPoint = startingPoint;
      startingPoint = newStartingPointOptionTwo;
    } else {
      prevStartingPoint = startingPoint;
      startingPoint = newStartingPointOptionOne;
    }

      String endInstruction = map[endPoint.$1][endPoint.$2];
      final coorsEndOptionOne = instructionsOptionOne[endInstruction]!;
      final coorsEndOptionTwo = instructionsOptionTwo[endInstruction]!;
      final newEndPointOptionOne = (endPoint.$1 + coorsEndOptionOne.$1, endPoint.$2 + coorsEndOptionOne.$2);
      final newEndPointOptionTwo = (endPoint.$1 + coorsEndOptionTwo.$1, endPoint.$2 + coorsEndOptionTwo.$2);
    if (newEndPointOptionOne == prevEndPoint) {
      prevEndPoint = endPoint;
      endPoint = newEndPointOptionTwo;
    } else {
      prevEndPoint = endPoint;
      endPoint = newEndPointOptionOne;
    }

    count += 1;

  }
  print(count);

  //these startings points for searched in the file without parsing it
  (int,int) startLine = (49,95);
  (int,int) prevStartLine = (49,96);
  (int,int) start = (49,96);
  Set<(int, int)> points = {
    start,
    startLine
  };
  print("Part two:");
  while(true) {
    if (startLine == start) break;
    if(borders[startLine.$1] == null) {
      borders[startLine.$1] = (startLine.$2, startLine.$2);
    } else {
      int min = borders[startLine.$1]!.$2;
      int max = borders[startLine.$1]!.$2;
      if (min > startLine.$2) {
        min = startLine.$2;
      }
      if (max < startLine.$2) {
        max = startLine.$2;
      }
      borders[startLine.$1] = (min, max);
    }
    String startingInstruction = map[startLine.$1][startLine.$2];
    final coorsStartingOptionOne = instructionsOptionOne[startingInstruction]!;
    final coorsStartingOptionTwo = instructionsOptionTwo[startingInstruction]!;
    final newStartingPointOptionOne = (startLine.$1 + coorsStartingOptionOne.$1, startLine.$2 + coorsStartingOptionOne.$2);
    final newStartingPointOptionTwo = (startLine.$1 + coorsStartingOptionTwo.$1, startLine.$2 + coorsStartingOptionTwo.$2);
    if (newStartingPointOptionOne == prevStartLine) {
      prevStartLine = startLine;
      startLine = newStartingPointOptionTwo;
    } else {
      prevStartLine = startLine;
      startLine = newStartingPointOptionOne;
    }
    points.add(startLine);

  }

  count = 0;
  for (int i = 0; i<map.length; i++) {
    for (int j = 0; j<map[i].length; j++) {
      if (borders[i] != null && !points.contains((i,j))) {
        if (j > borders[i]!.$1 && j < borders[i]!.$2) {
          count += 1;
        }
      }
    }
  }
  print(count);
}