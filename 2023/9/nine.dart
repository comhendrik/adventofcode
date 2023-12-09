import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  var filePath = p.join(Directory.current.path, '2023/9/nine_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  List<List<List<int>>> sequences = [];
  for (String line in fileContent) {
    final data = line.split(' ');
    sequences.add([[]]);
    for (String number in data) {
      sequences.last.last.add(int.parse(number));
    }
  }


  print("Part one:");
  int sumOne = 0;
  int sumTwo = 0;
  for(int i=0;i<sequences.length; i++) {
    bool even = false;
    while (!even) {
      even = true;
      sequences[i].add([]);
      for(int j=0;j<sequences[i][sequences[i].length - 2].length - 1; j++) {
        final newValue = sequences[i][sequences[i].length - 2][j + 1] - sequences[i][sequences[i].length - 2][j];
        sequences[i].last.add(newValue);
        if (newValue != 0) even = false;
      }

    }
    int value = 0;
    for(int j=sequences[i].length-2;j>=0;j--) {
      value += sequences[i][j].last;
    }
    sumOne += value;

    value = 0;
    for(int j=sequences[i].length-2;j>=0;j--) {
      value = sequences[i][j].first - value;
    }
    sumTwo += value;
  }

  print(sumOne);
  print("part two");
  print(sumTwo);
}