import 'package:collection/collection.dart';

import 'package:path/path.dart' as p;
import 'dart:io';

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
  // Creating a priority queue with a custom comparator
  PriorityQueue<(int,(int,int),(int,int),int,Set<(int,int)>, int)> priorityQueue =
  PriorityQueue<(int,(int,int),(int,int),int,Set<(int,int)>, int)>((a, b) => a.$1.compareTo(b.$1) && a.$5.compareTo(b.$5));

  // Adding elements to the priority queue
  priorityQueue.add((0,(0,0),(0,0),0,{}));

  // Printing the elements in descending order (custom priority order)
  List<(int,int)> movements = [
    (0,1),
    (0,-1),
    (1,0),
    (-1,0),
  ];


  final maxY = map.length - 1;
  final maxX = map.first.length - 1;

  while (priorityQueue.isNotEmpty) {
    bool foundEnd = false;
    (int,(int,int),(int,int),int, Set<(int,int)>) block = priorityQueue.removeFirst();
    print(block);
    final value = block.$1;
    final currentCoors = block.$2;
    final currentMovement = block.$3;
    final numberOfSteps = block.$4;
    Set<(int,int)> seen = block.$5;
    if (seen.contains(currentCoors)) continue;
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