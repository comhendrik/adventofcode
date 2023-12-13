import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  List<(List<int>, List<String>)> damagedRecords = [];
  var filePath = p.join(Directory.current.path, '2023/12/twelve_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split(' ');
    damagedRecords.add(([], []));
    for (String char in data[0].split('')) {
      damagedRecords.last.$2.add(char);
    }
    for (String number in data[1].split(',')) {
      damagedRecords.last.$1.add(int.parse(number));
    }
  }
  print(damagedRecords);

  String inputString = "???.###";
  int n = 2;
  List<String> options = generateOptions(inputString, n);
  print(options);
}



List<String> generateOptions(String inputStr, int n) {
  List<String> result = [];

  void backtrack(int index, int remaining, List<String> current) {
    if (index == inputStr.length) {
      if (remaining == 0) {
        result.add(current.join());
      }
      return;
    }

    if (inputStr[index] == '?' && remaining > 0) {
      current[index] = '#';
      backtrack(index + 1, remaining - 1, List.from(current));
    }

    current[index] = inputStr[index];
    backtrack(index + 1, remaining, List.from(current));
  }

  backtrack(0, n, List.filled(inputStr.length, ''));

  for (int i=0; i<result.length; i++) {
    List<String> chars = result[i].split('');
    for (int j=0; j<chars.length; j++) {
      if (chars[j] == '?') {
        chars[j] = '.';
      }
    }
    result[i] = chars.join();
  }
  return result;
}