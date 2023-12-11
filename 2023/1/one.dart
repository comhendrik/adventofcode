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
    String? first = null;
    String? last = null;
    for (int i=0; i<line.length; i++) {
      String curr = "";
      if (int.tryParse(line[i]) != null) {
        curr = line[i];
      } else {
        for(String key in numberReplacementStrings.keys) {
          if (i + key.length > line.length) continue;
          if(line.substring(i, i + key.length) == key) {
            curr = numberReplacementStrings[key]!;
            break;
          }
        }
      }
      if(curr != "") {
        if (first == null) {
          first = curr;
        }
        last = curr;
      }
    }
    sum += int.parse("$first$last");
  }
  print(sum);
}
