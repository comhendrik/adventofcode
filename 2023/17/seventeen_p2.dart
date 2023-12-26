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
  PriorityQueue<(int,int,int,int,int,int)> priorityQueue =
  PriorityQueue<(int,int,int,int,int,int)>((a, b) => a.$1.compareTo(b.$1));

  // Adding elements to the priority queue
  priorityQueue.add((0,0,0,0,0,0));

  // Printing the elements in descending order (custom priority order)
  List<(int,int)> movements = [
    (0,1),
    (0,-1),
    (1,0),
    (-1,0),
  ];


  Set<(int,int,int,int,int,int)> seen = {};

  final maxY = map.length - 1;
  final maxX = map.first.length - 1;


  print("Part two");

  while (priorityQueue.isNotEmpty) {

    (int,int,int,int,int,int) block = priorityQueue.removeFirst();
    final heatLoss = block.$1;
    final y = block.$2;
    final x = block.$3;
    final moveY = block.$4;
    final moveX = block.$5;
    final steps = block.$6;


    if (y == maxY && x == maxX && steps >= 4) {
      print(heatLoss);
      break;
    }

    if (seen.contains(block)) continue;

    seen.add(block);

    //movement in same direction
    if (steps < 10 && (moveY,moveX) != (0,0)) {
      final newY = y + moveY;
      final newX = x + moveX;
      if ((newX >= 0 && newX <= maxX) && (newY >= 0 && newY <= maxY)) {
        priorityQueue.add((heatLoss+map[newY][newX], newY, newX, moveY, moveX, steps+1));
      }
    }

    //movement for all different directions
    if (steps >= 4 || (moveY,moveX) == (0,0)) {
      for((int,int) move in movements) {
        //except the same direction and opposite direction
        if (move != (moveY,moveX) && move != (-moveY, -moveX)) {
          final newY = y + move.$1;
          final newX = x + move.$2;
          if ((newX >= 0 && newX <= maxX) && (newY >= 0 && newY <= maxY)) {
            priorityQueue.add((heatLoss+map[newY][newX], newY, newX, move.$1, move.$2, 1));
          }
        }
      }
    }
  }
}