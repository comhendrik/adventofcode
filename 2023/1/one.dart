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
  var filePath = p.join(Directory.current.path, 'one_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
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
}
