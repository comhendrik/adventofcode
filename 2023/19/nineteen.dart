void main() {

  List<Part> parts = [
    Part(787,2655,1222,2876),
    Part(1679,44,2067,496),
    Part(2036,264,79,2244),
    Part(2461,1339,466,291),
    Part(2127,1623,2188,1013),
  ];

  Map<String, List<String>> workflows = {
    'px' : ['a<2006:qkq','m>2090:A','rfg'],
    'pv' : ['a>1716:R','A'],
    'lnx' : ['m>1548:A','A'],
    'rfg' : ['s<537:gd','x>2440:R','A'],
    'qs' : ['s>3448:A','lnx'],
    'qkq' : ['x<1416:A','crn'],
    'crn' : ['x>2662:A','R'],
    'in' : ['s<1351:px','qqz'],
    'qqz' : ['s>2770:qs','m<1801:hdj','R'],
    'gd' : ['a>3333:R','R'],
    'hdj' : ['m>838:A','pv']
  };

  for(Part part in parts) {
    bool ended = false;
    List<String> currentWorkflow = workflows['in']!;
    while (!ended) {
      for (String rule in currentWorkflow) {
        if (rule == 'A') {
          ended = true;
          break;
        } else if (rule == 'R') {
          print("yeah2");
          part.rejected = true;
          ended = true;
          break;
        } else if (!rule.contains(':')) {
          currentWorkflow = workflows[rule]!;
          break;
        }
        final splittedRule = rule.split(':');
        final comparisonValueOfPart = part.accessMap[splittedRule[0][0]]!;
        final comparisonValue = int.parse(splittedRule[0].substring(2, splittedRule[0].length-1));
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
            print("yeah1");
            ended = true;
          default:
            currentWorkflow = workflows[action]!;
        }
        break;
      }
    }
  }

  for (Part part in parts) {
    print(part.rejected);
  }
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