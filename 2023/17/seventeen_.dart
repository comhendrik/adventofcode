import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'dart:io';


class CustomElement implements Comparable<CustomElement> {
  int heatLoss;
  (int,int) coors;
  (int,int) movingCoors;
  int moves;

  CustomElement(this.heatLoss,this.coors,this.movingCoors, this.moves);

  @override
  int compareTo(CustomElement other) {
    // Compare elements based on priority
    if (moves != other.moves) {
      return moves.compareTo(other.moves);
    }
    // If priorities are equal, compare based on name
    return heatLoss.compareTo(other.heatLoss);
  }
}

void main() async {
  List<List<int>> map = [];
  var filePath = p.join(Directory.current.path, '2023/17/seventeen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split('');
    map.add([]);
    for (String number in data) {
      map.last.add(int.parse(number));
    }
  }

  HeapPriorityQueue<CustomElement> priorityQueue =
  HeapPriorityQueue<CustomElement>((a, b) => a.compareTo(b));

  priorityQueue.add(CustomElement(0, (0,0), (0,0), 0));

  // Printing the elements in descending order (custom priority order)
  List<(int,int)> movements = [
    (0,1),
    (0,-1),
    (1,0),
    (-1,0),
  ];

  Set<CustomElement> seen = {};

  final maxY = map.length - 1;
  final maxX = map.first.length - 1;

  while (priorityQueue.isNotEmpty) {
    bool foundEnd = false;
    CustomElement block = priorityQueue.removeFirst();
    final hl = block.heatLoss;
    final currentCoors = block.coors;
    final currentMovement = block.movingCoors;
    final numberOfSteps = block.moves;

    if(currentCoors.$1 ==maxY && currentCoors.$2 == maxX) {
      foundEnd = true;
      print(hl);
      break;
    }

    if (currentCoors.$1 < 0 || currentCoors.$1 > maxY) continue;
    if (currentCoors.$2 < 0 || currentCoors.$2 > maxX) continue;


    for((int,int) move in movements) {
      final y = currentCoors.$1 + move.$1;
      final x = currentCoors.$2 + move.$2;

      //TODO Error handling when out of bounds

      if (y < 0 || y > maxY) continue;
      if (x < 0 || x > maxX) continue;
      final newHeatLoss = value + map[y][x];
      if(y==maxY && x == maxX) {
        foundEnd = true;
        print(newHeatLoss);
        break;
      }

      seen.add(currentCoors);
      if (move == currentMovement) {
        if (numberOfSteps == 3) continue;
        priorityQueue.add((newHeatLoss,(y,x),move, numberOfSteps + 1, seen));
        continue;
      }
      priorityQueue.add((newHeatLoss, (y,x) ,move, 1, seen));
    }

    seen.add(currentCoors);
    if (foundEnd) break;
  }

}