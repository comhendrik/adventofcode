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
}