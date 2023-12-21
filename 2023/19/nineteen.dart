import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  var filePath = p.join(Directory.current.path, '2023/19/nineteen_input.txt');
  List<Part> parts = [];
  Map<String, List<String>> workflows = {};
  bool addToParts = true;
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    if (line == "") {
      addToParts = false;
      continue;
    }
    if(addToParts) {
      final data = line.split('{');
      final rules = data[1].substring(0,data[1].length -1).split(',');
      workflows[data[0]] = rules;
    } else {
      final data = line.split(',');
      final x = int.parse(data[0].substring(3, data[0].length));
      final m = int.parse(data[1].substring(2, data[1].length));
      final a = int.parse(data[2].substring(2, data[2].length));
      final s = int.parse(data[3].substring(2, data[3].length-1));
      parts.add(Part(x, m, a, s));
    }
  }

  print("Part one:");

  for(Part part in parts) {
    bool ended = false;
    List<String> currentWorkflow = workflows['in']!;
    while (!ended) {
      for (String rule in currentWorkflow) {
        if (rule == 'A') {
          ended = true;
          break;
        } else if (rule == 'R') {
          part.rejected = true;
          ended = true;
          break;
        } else if (!rule.contains(':')) {
          currentWorkflow = workflows[rule]!;
          break;
        }
        final splittedRule = rule.split(':');
        final comparisonValueOfPart = part.accessMap[splittedRule[0][0]]!;
        final comparisonValue = int.parse(splittedRule[0].substring(2, splittedRule[0].length));
        final action = splittedRule[1];
        final operator = splittedRule[0][1];
        bool successful = false;
        if (operator == '>') {
          if (comparisonValueOfPart > comparisonValue)  successful = true;
        } else {
          if (comparisonValueOfPart < comparisonValue)  successful = true;
        }
        if(!successful) continue;

        switch (action) {
          case 'A':
            ended = true;
          case 'R' :
            part.rejected = true;
            ended = true;
          default:
            currentWorkflow = workflows[action]!;
        }
        break;
      }
    }
  }

  int sum = 0;
  for (Part part in parts) {
    if (part.rejected) continue;
    sum += (part.x + part.m + part.a + part.s);
  }
  print(sum);
}

class Part {
  final int x;
  final int m;
  final int a;
  final int s;
  bool rejected = false;
  Map<String, int> accessMap;

  Part(this.x, this.m, this.a, this.s) : accessMap = {'x' : x, 'm' : m, 'a': a, 's' : s};
}