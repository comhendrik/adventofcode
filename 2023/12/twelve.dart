import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  print("Part one:");
  List<(List<int>, String)> damagedRecords = [];
  var filePath = p.join(Directory.current.path, '2023/12/twelve_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split(' ');
    List<int> numbers = [];
    for (String number in data[1].split(',')) {
      numbers.add(int.parse(number));
    }
    damagedRecords.add((numbers, data[0]));

  }
  int sum = 0;
  for((List<int>, String) record in damagedRecords) {
    int arrangements = 0;
    final numberOfHashes = generateNumberOfHashesToBePlaced(record);
    List<String> options = generateOptions(record.$2.toString(), numberOfHashes);
    for (String option in options) {
      int currentIndexOfNumber = 0;
      bool increaseArrangements = true;
      final data = option.split('');
      for (int i=0; i<data.length; i++) {
        if (currentIndexOfNumber == record.$1.length) break;
        int current = record.$1[currentIndexOfNumber];
        if (data[i] == '#') {
          bool isValid = true;
          for (int j=0; j<current; j++) {
            if (data[i+j] != '#') isValid = false;
          }
          if(i+current != data.length) {
            if (data[i+current] != '.') isValid = false;
          }
          if (!isValid) {
            increaseArrangements = false;
            break;
          }
          i = i + current;
          currentIndexOfNumber += 1;
        }
      }

      if (increaseArrangements) {
        arrangements += 1;
      }
    }
    sum += arrangements;
  }
  print(sum);


  print("Part two:");
  damagedRecords = [];
  for (String line in fileContent) {
    List<int> numbers = [];
    String damagedRecordString = '';
    for (int i=0; i<5; i++) {
      final data = line.split(' ');
      for (String number in data[1].split(',')) {
        numbers.add(int.parse(number));
      }
      damagedRecordString = damagedRecordString + data[0];
    }
    damagedRecords.add((numbers, damagedRecordString));

  }
  sum = 0;
  //TODO: Part two
}

int generateNumberOfHashesToBePlaced((List<int>, String) record) {
  final sumOfHashes = record.$1.fold(0, (previous, current) => previous + current);

  final chars = record.$2.split('');

  List<String> filteredChars = chars.where((char) => char == '#').toList();

  return sumOfHashes - filteredChars.length;
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