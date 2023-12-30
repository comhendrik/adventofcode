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
  ConjunctionModule(List<String> names)
      : _state = false,
        _names = names,
        _states = {};

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

  Map<String,Module> maptest1 = {
    'broadcaster' : BroadcastModule(['a','b','c']),
    'a' : FlipFlopModule(['b']),
    'b' : FlipFlopModule(['c']),
    'c' : FlipFlopModule(['inv']),
    'inv' : ConjunctionModule(['a']),
  };

  Map<String,Module> map = {
    'broadcaster' : BroadcastModule(['a']),
    'a' : FlipFlopModule(['inv','con']),
    'inv' : ConjunctionModule(['b']),
    'b' : FlipFlopModule(['con']),
    'con' : ConjunctionModule(['output']),
  };


  int i = 0;
  while(true) {
    i += 1;
    List<(String,bool,String)> inputList = [('broadcaster',false,'button')];
    while (!inputList.isEmpty) {
      (String,bool,String) currInput = inputList.first;
      inputList.removeAt(0);
      if (!map.containsKey(currInput.$1)) {
        print(currInput.$2);
        continue;
      }
      Module currComponent = map[currInput.$1]!;
      for (String componentName in currComponent.names) {
        bool? pulse = currComponent.computeInput(currInput.$2,currInput.$3);
        if (pulse == null) continue;
        print("$componentName,$pulse");
        inputList.add((componentName,pulse,currInput.$1));
      }
    }
    bool isNotInitState = false;
    for (String key in map.keys) {
      Map<String,bool> states = map[key]!.states;
      for (bool value in states.values) {
        isNotInitState = value;
      }
    }
    if (!isNotInitState) {
      print(i);
      break;
    }
  }
}



