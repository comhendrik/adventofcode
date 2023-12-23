import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  var filePath = p.join(Directory.current.path, '2023/21/twentyone_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  List<List<String>> map = [];
  Set<(int,int)> points = {};
  (int,int) startingPoint = (0,0);
  //read map
  for (String line in fileContent) {
    map.add([]);
    for (String char in line.split('')) {
      map.last.add(char);
      if (char == 'S') {
        startingPoint = (map.length-1, map.last.length-1);
      }
    }
  }

  points.add(startingPoint);
  print("Part one");
  //for n amount of steps two the movement
  for(int i=0; i<64; i++) {
    Set<(int,int)> newPoints = {};
    for((int,int) point in points) {
      //calculating for every point, new points
      final north = generateNewPoints(point, (-1,0), map);
      final east = generateNewPoints(point, (0,1), map);
      final south = generateNewPoints(point, (1,0), map);
      final west = generateNewPoints(point, (0,-1), map);
      if (north != null) newPoints.add(north);
      if (east != null) newPoints.add(east);
      if (south != null) newPoints.add(south);
      if (west != null) newPoints.add(west);
    }
    points = newPoints;
  }
  //after doing all steps you can count the number of positions
  print(points.length);


  //reloading everything
  points = {};
  points.add(startingPoint);

  print("Part two");
  //for n amount of steps two the movement
  for(int i=0; i<10; i++) {
    Set<(int,int)> newPoints = {};
    for((int,int) point in points) {
      final north = generateNewPointsP2(point, (-1,0), map);
      final east = generateNewPointsP2(point, (0,1), map);
      final south = generateNewPointsP2(point, (1,0), map);
      final west = generateNewPointsP2(point, (0,-1), map);
      if (north != null) newPoints.add(north);
      if (east != null) newPoints.add(east);
      if (south != null) newPoints.add(south);
      if (west != null) newPoints.add(west);
    }
    points = newPoints;
  }
  //after doing all steps you can count the number of positions
  print(points.length);

}

(int,int)? generateNewPoints((int,int) currentPoint, (int,int) direction, List<List<String>> map) {
  final y = currentPoint.$1 + direction.$1;
  final x = currentPoint.$2 + direction.$2;
  final maxY = map.length - 1;
  final maxX = map.first.length - 1;
  if (y<0 || y > maxY) return null;
  if (x<0 || x > maxX) return null;
  if (map[y][x] == '#') return null;
  return (y,x);
}

(int,int)? generateNewPointsP2((int,int) currentPoint, (int,int) direction, List<List<String>> map) {
  int y = currentPoint.$1 + direction.$1;
  int x = currentPoint.$2 + direction.$2;
  final maxY = map.length - 1;
  final maxX = map.first.length - 1;
  if (y > maxY) y = 0;
  if (y < 0) y = maxY;
  if (x > maxX) x = 0;
  if (x < 0) x = maxX;
  if (map[y][x] == '#') return null;
  return (y,x);
}