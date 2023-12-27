import 'dart:math';

import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  var filePath = p.join(Directory.current.path, '2023/11/eleven_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  List<List<String>> map = [];
  List<(int, int)> galaxies = [];
  List<int> emptyRows = [];
  for (int i=0; i<fileContent.length; i++) {
    bool isRowEmpty = true;
    final data = fileContent[i].split('');
    map.add([]);
    for (int j=0; j<data.length; j++) {
      map.last.add(data[j]);
      if (data[j] == '#') {
        galaxies.add((i,j));
        isRowEmpty = false;
      }
    }
    //checking if row is empty or not
    if (isRowEmpty) emptyRows.add(i);
  }


  //checking if column is empty or not
  List<int> emptyColumns = [];

  for (int i=0; i<map.last.length; i++) {
    bool isEmptyColumn = true;
    for (List<String> row in map) {
      if (row[i] == '#') {
        isEmptyColumn = false;
        break;
      }
    }
    if(isEmptyColumn) emptyColumns.add(i);
  }

  Set<((int,int),(int,int))> seen = {};

  print("Part one/two  /var stepsToAdd needs to be 1 for part one and 1000000-1 for part two:");
  int sum = 0;
  final stepsToAdd = 1000000-1;
  //do it for every pair
  for(int i=0; i<galaxies.length; i++) {
    for (int j=0; j<galaxies.length; j++) {
      //check if pair is valid, two options when it is not valid 1. pair is two times the same galaxies 2. pair already computed
      if (j == i) continue;
      if (seen.contains((galaxies[i], galaxies[j])) || seen.contains((galaxies[j], galaxies[i]))) continue;
      seen.add((galaxies[i], galaxies[j]));
      int steps = 0;

      //calculating columns
      for (int z=min(galaxies[i].$2, galaxies[j].$2); z<max(galaxies[i].$2, galaxies[j].$2); z++) {
        steps += 1;
        if (!emptyColumns.contains(z)) continue;
        steps += stepsToAdd;
      }
      //calculating rows
      for (int z=min(galaxies[i].$1, galaxies[j].$1); z<max(galaxies[i].$1, galaxies[j].$1); z++) {
        steps += 1;
        if (!emptyRows.contains(z)) continue;
        steps += stepsToAdd;
      }
      sum += steps;
    }
  }

  print(sum);
}
