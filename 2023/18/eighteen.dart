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

  print("Part one:");

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

  List<(int,int)> edgePoints = getCornerPoints(map, coordinates, addingY, addingX);
  edgePoints.insert(0, edgePoints[edgePoints.length - 2]);

  double area = 0;
  //calculating area by using shoelace formula and picks theorem
  for(int i=1; i<edgePoints.length-1; i++) {
    final x = edgePoints[i].$2;
    final y = edgePoints[i].$1;
    final laterX = edgePoints[i+1].$2;
    final laterY = edgePoints[i+1].$1;
    area += (y + laterY) * (x-laterX);
  }

  if (area < 0) area * -1;
  area = area / 2;
  //starting of picks theorem
  int b = coordinates.length - 1;
  double i = area - (b / 2) + 1;
  // b are interior points and i outside of the polygon
  print(i+b);

  print("Part two");

  currentCoordinates = (0,0);


  Map<String, String> convertNumberToDirection = {
    '0' : 'R',
    '1' : 'D',
    '2' : 'L',
    '3' : 'U'
  };


  //new approach for getting edge points, because old approach is too slow for it

  List<(int,int)> edgePointsP2 = [(0,0)];


  b = 0;

  for ((String, int, String) direction in directions) {
    String code = direction.$3.substring(1, direction.$3.length-1);
    final realDirection = code[code.length-1];
    final distance = code.substring(1,code.length-1);
    final realDistance = int.parse(distance, radix: 16);
    (int, int) movingCoors = allMovingCoors[convertNumberToDirection[realDirection]!]!;
    b += realDistance;
    (int, int) newCoors = (currentCoordinates.$1 + (movingCoors.$1 * realDistance), currentCoordinates.$2 + (movingCoors.$2 * realDistance));
    edgePointsP2.add(newCoors);
    currentCoordinates = newCoors;
  }

  edgePointsP2.insert(0, edgePointsP2[edgePointsP2.length - 2]);

  area = 0;
  //calculating area by using shoelace formula and picks theorem
  for(int i=1; i<edgePointsP2.length-1; i++) {
    final x = edgePointsP2[i].$2;
    final y = edgePointsP2[i].$1;
    final laterX = edgePointsP2[i+1].$2;
    final laterY = edgePointsP2[i+1].$1;
    area += (y + laterY) * (x-laterX);
  }

  if (area < 0) area * -1;
  area = area / 2;
  //starting of picks theorem
  i = area - (b / 2) + 1;
  // b are interior points and i outside of the polygon
  print(i+b);



}

List<(int,int)> getCornerPoints(List<List<String>> polygon, List<(int,int)> coordinates, int addingY, int addingX) {
  List<(int,int)> cornerPoints = [];

  for((int,int) coordinate in coordinates) {
    int i = coordinate.$1 + addingY;
    int j = coordinate.$2 + addingX;
    if (polygon[i][j] == "#") {
      // Check if the current point is a corner by checking for adjacent '#' characters
      bool isCorner = false;
      if (i > 0 && j > 0 && polygon[i - 1][j] == "#" && polygon[i][j - 1] == "#") {
        isCorner = true;
      }
      if (i > 0 && j < polygon[i].length - 1 && polygon[i - 1][j] == "#" && polygon[i][j + 1] == "#") {
        isCorner = true;
      }
      if (i < polygon.length - 1 && j > 0 && polygon[i + 1][j] == "#" && polygon[i][j - 1] == "#") {
        isCorner = true;
      }
      if (i < polygon.length - 1 && j < polygon[i].length - 1 && polygon[i + 1][j] == "#" && polygon[i][j + 1] == "#") {
        isCorner = true;
      }

      if (isCorner) {
        cornerPoints.add((i, j)); // Tuple2 from the 'tuple' package
      }
    }
  }

  return cornerPoints;
}