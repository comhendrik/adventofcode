import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  //part One
  var filePath = p.join(Directory.current.path, '2023/4/four_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();

  final List<List<int>> wNumbers = [];

  final List<Set<int>> numbers = [];

  for (int i=0; i<fileContent.length; i++) {
    final split = fileContent[i].split(' ');
    wNumbers.add([]);
    numbers.add({});
    bool isAlreadyNumbers = false;
    for (int j = 0; j<split.length; j++) {
      if (!isAlreadyNumbers) {
        if (split[j] == '|') {
          isAlreadyNumbers = true;
        } else if (int.tryParse(split[j]) != null) {
          wNumbers[i].add(int.parse(split[j]));
        }
      } else if (int.tryParse(split[j]) != null) {
        numbers[i].add(int.parse(split[j]));
      }
    }
  }



  print("part one:");
  int sum = 0;
  for(int i=0; i<wNumbers.length; i++) {
    int point_value = 0;
    for(int j=0; j<wNumbers[i].length; j++) {
      if (numbers[i].contains(wNumbers[i][j])) {
        if (point_value == 0) {
          point_value += 1;
        } else {
          point_value = point_value * 2;
        }
      }
    }
    sum += point_value;
  }
  print(sum);

  print("part two:");

  final List<int> copies = [];
  for(int i=0; i<wNumbers.length; i++) {
    copies.add(1);
  }
  for(int i=0; i<wNumbers.length; i++) {

    for(int h=0; h<copies[i]; h++) {
      int matchingPoints = 0;
      for(int j=0; j<wNumbers[i].length; j++) {
        if (numbers[i].contains(wNumbers[i][j])) {
          matchingPoints += 1;
        }
      }

      for(int z=i+1; z<i+1+matchingPoints; z++) {
        copies[z] += 1;
      }
    }



  }
  print(copies.reduce((a, b) => a + b));
}