import 'package:path/path.dart' as p;
import 'dart:io';


void main() async {
  List<List<Map<String, int>>> games = [
  ];


  Map<String, int> available = {
      'red' : 12,
      'green' : 13,
      'blue' : 14,
  };
  var filePath = p.join(Directory.current.path, '2023/2/two_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (int i=0; i<fileContent.length; i++) {

    games.add([]);
    final split = fileContent[i].split(' ');
    games.last.add({});

    for (int j=2; j<split.length; j++) {
      String key = '';
      if (int.tryParse(split[j]) != null) {
        if (j+1 == split.length - 1) {

          key = split[j+1];
        } else {

          key = split[j+1].substring(0, split[j+1].length - 1);
        }
        games[i].last[key] = int.parse(split[j]);
      } else if (split[j].endsWith(';')) {
        games.last.add({});
      }

    }


  }
  
  //part one
  int sum = 0;
  int sumAdder = 1;
  for(int i=0; i<games.length; i++) {
    bool addToSum = true;
    for(int j=0; j<games[i].length; j++) {
      for (String key in games[i][j].keys) {
        if (available.containsKey(key)) {
          if (available[key]! < games[i][j][key]!) {
            addToSum = false;
          }
        } else {
          addToSum = false;
        }
      }
    }
    if (addToSum) {
      sum += sumAdder;

    }
    sumAdder += 1;
  }
  print(sum);
}