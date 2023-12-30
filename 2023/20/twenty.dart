abstract class Module {
  bool? computeInput(bool input, String componentName);
  List<String> get names;
  Map<String, bool> get states;
}

class FlipFlopModule extends Module{
  Map<String,bool> _states;
  List<String> _names;

  // Updated constructor with field initialization
  FlipFlopModule(List<String> names)
      : _states = {'normal' : false},
        _names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool? computeInput(bool input, String componentName) {
    if (input) return null;
    _states['normal'] = !_states['normal']!;
    return _states['normal'];
  }

  @override
  Map<String, bool> get states => _states;

  @override
  List<String> get names => _names;
}

class ConjunctionModule implements Module{
  bool _state;
  List<String> _names;
  Map<String,bool> _states;

  // Updated constructor with field initialization
  ConjunctionModule(List<String> names, Map<String,bool> _states)
      : _state = false,
        _names = names,
        _states = _states;

  //true is a high pulse
  //false is a low pulse
  @override
  //input needs to be a value from a list and if it contains false or not
  bool computeInput(bool input, String componentName) {
    _states[componentName] = input;
    if (_states.containsValue(false)) {
      _state = true;
    } else {
      _state = false;
    }
    return _state;
  }

  @override
  Map<String, bool> get states => _states;

  @override
  List<String> get names => _names;
}

class BroadcastModule implements Module {
  Map<String,bool> _states;
  List<String> _names;

  // Updated constructor with field initialization
  BroadcastModule(List<String> names)
      : _states = {'normal' : false},
        _names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool computeInput(bool input, String componentName) {
    _states['normal'] = input;
    return _states['normal']!;
  }

  @override
  Map<String, bool> get states => _states;

  @override
  List<String> get names => _names;
}

void main() {

  Map<String,Module> _ = {
    'broadcaster' : BroadcastModule(['a','b','c']),
    'a' : FlipFlopModule(['b']),
    'b' : FlipFlopModule(['c']),
    'c' : FlipFlopModule(['inv']),
    'inv' : ConjunctionModule(['a'], {'c':false}),
  };

  Map<String,Module> map = {
    'broadcaster' : BroadcastModule(['a']),
    'a' : FlipFlopModule(['inv','con']),
    'inv' : ConjunctionModule(['b'],{'a':false}),
    'b' : FlipFlopModule(['con']),
    'con' : ConjunctionModule(['output'],{'a':false,'b':false}),
  };


  int i = 0;
  int countHighPulse = 0;
  int countLowPulse = 0;
  while(true) {
    i += 1;
    countLowPulse += 1;
    List<(String,bool,String)> inputList = [('broadcaster',false,'button')];
    while (!inputList.isEmpty) {
      (String,bool,String) currInput = inputList.first;
      inputList.removeAt(0);
      if (!map.containsKey(currInput.$1)) {
        print(currInput.$2);
        continue;
      }
      Module currComponent = map[currInput.$1]!;
      bool? pulse = currComponent.computeInput(currInput.$2,currInput.$3);
      if (pulse == null) continue;
      for (String componentName in currComponent.names) {
        print("${currInput.$1} --> $pulse, $componentName,");
        if (pulse) countHighPulse += 1;
        else countLowPulse += 1;
        inputList.add((componentName,pulse,currInput.$1));
      }
    }
    print("________");
    bool isNotInitState = false;
    for (String key in map.keys) {
      Map<String,bool> states = map[key]!.states;
      print(states);
      for (bool value in states.values) {
        isNotInitState = value;
        if (value == true) break;
      }
      if(isNotInitState) break;
    }
    if (!isNotInitState) {
      print(i);
      break;
    }
  }

  final multiplicationValue = 1000 / i;
  final finalCountLowPulse = countLowPulse * multiplicationValue;
  final finalCountHighPulse = countHighPulse * multiplicationValue;
  print(finalCountLowPulse);
  print(finalCountHighPulse);
  print("Part one: ${finalCountHighPulse * finalCountLowPulse}");
}



