import 'dart:io';
import 'package:path/path.dart' as p;


final List<String> tInput = [
  '1abc2',
  'pqr3stu8vwx',
  'a1b2c3d4e5f',
  'treb7uchet'
];


void main() async {
  //part One
  var filePath = p.join(Directory.current.path, '2023/1/one_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  print("Part one:");
  int sum = 0;
  for (String line in fileContent) {
    String number = "";
    for(int i=0; i<line.length; i++) {
      if (int.tryParse(line[i]) != null) {
        number = line[i];
        break;
      }
    }
    for(int i=line.length-1; i>-1; i--) {
      if (int.tryParse(line[i]) != null) {
        number = "$number${line[i]}";
        break;
      }
    }
    sum += int.parse(number);
  }
  print(sum);

  print("Part two:");
  Map<String, int> replacementStrings = {
    "one" : 0,
    "two" : 0,
    "three" : 0,
    "four" : 0,
    "five" : 0,
    "six" : 0,
    "seven" : 0,
    "eight" : 0,
    "nine" : 0
  };
  Map<String, String> numberReplacementStrings = {
    "one" : "1",
    "two" : "2",
    "three" : "3",
    "four" : "4",
    "five" : "5",
    "six" : "6",
    "seven" : "7",
    "eight" : "8",
    "nine" : "9"
  };
  sum = 0;
  for (String line in fileContent) {
    for(String key in replacementStrings.keys) {
      replacementStrings[key] = line.indexOf(key);
    }
    int indexFirstNormalNumber = -1;
    String firstNormalNumber = "";
    for(int i=0; i<line.length; i++) {
      if (int.tryParse(line[i]) != null) {
        indexFirstNormalNumber = i;
        firstNormalNumber = line[i];
        break;
      }
    }
    int indexLastNormalNumber = -1;
    String lastNormalNumber = "";
    for(int i=line.length-1; i>-1; i--) {
      if (int.tryParse(line[i]) != null) {
        indexLastNormalNumber = i;
        lastNormalNumber = line[i];
        break;
      }
    }
    String minKey = '';
    int minValue = -1;
    String maxKey = '';
    int maxValue = -1;

    replacementStrings.forEach((key, value) {
      if ((value < minValue || minValue == -1) && value != -1) {
        minKey = key;
        minValue = value;
      }
    });
    replacementStrings.forEach((key, value) {
      if (value > maxValue && value != -1) {
        maxKey = key;
        maxValue = value;
      }
    });
    String firstStringNumber = "";
    if ((minValue != -1 && minValue < indexFirstNormalNumber) || indexFirstNormalNumber == -1) {
      firstStringNumber = numberReplacementStrings[minKey]!;
    }

    String lastStringNumber = "";
    if ((maxValue != -1 && maxValue > indexLastNormalNumber) || indexLastNormalNumber == -1) {
      lastStringNumber = numberReplacementStrings[maxKey]!;
    }
    String number = "";
    if (firstStringNumber == "") {
      number = firstNormalNumber;
    } else {
      number = firstStringNumber;
    }
    if (lastStringNumber == "") {
      number = number + lastNormalNumber;
    } else {
      number = number + lastStringNumber;
    }
    sum += int.parse(number);
  }
  print(sum);
}
