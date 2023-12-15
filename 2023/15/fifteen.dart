import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  //Everything for testing purposes
  List<String> codes = [];
  var filePath = p.join(Directory.current.path, '2023/15/fifteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  final data = fileContent[0].split(',');
  for (String code in data) {
    codes.add(code);
  }
  print("part one:");
  int sum = 0;
  for (String code in codes) {
    sum += computeValue(code);
  }
  print(sum);

  print("part two");
  List<List<(String, int)>> boxes = [];
  for (int i=0; i<256; i++) {
    boxes.add([]);
  }
  //arrange boxes
  for (String code in codes) {
    if (code.contains('=')) {
      final label = code.substring(0, code.length - 2);
      final boxIndex = computeValue(label);
      final focalLength = int.parse(code[code.length - 1]);
      bool foundLens = false;
      for (int i = 0; i<boxes[boxIndex].length; i++) {
        if (boxes[boxIndex][i].$1 == label) {
          boxes[boxIndex][i] = (label, focalLength);
          foundLens = true;
          break;
        }
      }
      if (!foundLens) boxes[boxIndex].add((label, focalLength));
      
    } else {
      final label = code.substring(0, code.length - 1);
      final boxIndex = computeValue(label);
      for (int i = 0; i<boxes[boxIndex].length; i++) {
        if (boxes[boxIndex][i].$1 == label) {
          boxes[boxIndex].removeAt(i);
        }
      }
    }
  }
  //compute focusing power
  int focusingPower = 0;
  for (int i=0; i<boxes.length; i++) {
    focusingPower += computeFocusingPower(boxes[0], i+1);
  }
  print(focusingPower);
}

int computeValue(String code) {
  int value = 0;
  for (String char in code.split('')) {
    value += char.codeUnitAt(0);
    value *= 17;
    value %= 256;
  }
  return value;
}

int computeFocusingPower(List<(String, int)> box, int box_number) {
  int boxFocusingPower = 0;
  if(box.isEmpty) return 0;
  for(int i=0; i<box.length; i++) {

  }
  return 0;
}