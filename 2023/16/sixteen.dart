import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<List<String>> map = [];
  var filePath = p.join(Directory.current.path, '2023/16/sixteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split('');
    map.add([]);
    for (String char in data) {
      map.last.add(char);
    }
  }
  print("Part one:");
  //first one is the current coordination of beam, second is the current movement direction
  List<((int, int), (int, int))> beams = [((0,-1),(0,1))];
  //Set to check which points of the map where visited;
  Set<((int, int), (int, int))> visited = {};
  while (!beams.isEmpty) {
    final beam = beams.first;
    beams.removeAt(0);
    (int, int) newCoors = (beam.$1.$1 + beam.$2.$1, beam.$1.$2 + beam.$2.$2);
    if(newCoors.$1 < 0 || newCoors.$2 < 0) continue;
    if(newCoors.$1 >= map.length || newCoors.$2 >= map.first.length) continue;
    ((int, int),(int, int)?) newDirection = checkNewDirection(beam.$2, map[newCoors.$1][newCoors.$2]);
    if (!visited.contains((newCoors, newDirection.$1))) {
      visited.add((newCoors, newDirection.$1));
      beams.add((newCoors, newDirection.$1));
    }
    if (newDirection.$2 != null) {
      if (!visited.contains((newCoors, newDirection.$2!))) {
        visited.add((newCoors, newDirection.$2!));
        beams.add((newCoors, newDirection.$2!));
      }
    }
  }

  Set<(int, int)> countVisited = {};
  for (((int, int), (int, int)) visit in visited) {
    countVisited.add(visit.$1);
  }
  print(countVisited.length);
}

((int, int), (int, int)?) checkNewDirection((int,int) currentDirection, String char) {
  final y = currentDirection.$1;
  final x = currentDirection.$2;
  //only four options:
  //y=0 x=1
  //y=0 x=-1
  //y=1 x=0
  //y=-1 x=0
  //based on the char and currentDirection, the new direction is created
  if(y == 0) {
    if(x==1) {
      //y=0 x=1
      switch (char) {
        case '|': return ((-1,0),(1,0));
        case '-': return ((0,1), null);
        case '.': return ((0,1),null);
        case '/': return ((-1,0), null);
        case '\\': return ((1,0), null);
      }
    } else {
      //y=0 x=-1
      switch (char) {
        case '|': return ((-1,0),(1,0));
        case '-': return ((0,-1), null);
        case '.': return ((0,-1),null);
        case '/': return ((1,0), null);
        case '\\': return ((-1,0), null);
      }
    }
  } else if(x==0){
    if(y==1) {
      //y=1 x=0
      switch (char) {
        case '|': return ((1,0),null);
        case '-': return ((0,-1), (0,1));
        case '.': return ((1,0),null);
        case '/': return ((0,-1), null);
        case '\\': return ((0,1), null);
      }
    } else {
      //y=-1 x=0
      switch (char) {
        case '|': return ((-1,0),null);
        case '-': return ((0,1), (0,-1));
        case '.': return ((-1,0),null);
        case '/': return ((0,1), null);
        case '\\': return ((0,-1), null);
      }
    }
  }
  return ((0,0),null);
}