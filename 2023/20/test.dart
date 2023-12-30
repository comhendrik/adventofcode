abstract class Component {
  bool? computeInput(List<bool> input);
  List<String> get names;
  bool get state;
}

class FlipFlop extends Component{
  bool _state;
  List<String> _names;

  // Updated constructor with field initialization
  FlipFlop(List<String> names)
      : _state = false,
        _names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool? computeInput(List<bool> input) {
    if (input[0]) return null;
    _state = !state;
    return state;
  }

  @override
  bool get state => _state;

  @override
  List<String> get names => _names;
}

class Conjunction implements Component{
  bool _state;
  List<String> _names;
  Map<String,bool> states;

  // Updated constructor with field initialization
  Conjunction(List<String> names, Map<String,bool> states)
      : _state = false,
        _names = names,
        states = states;

  //true is a high pulse
  //false is a low pulse
  @override
  //input needs to be a value from a list and if it contains false or not
  bool computeInput(List<bool> input) {
    if (input.contains(false)) {
      _state = true;
    } else {
      _state = false;
    }
    return _state;
  }

  @override
  bool get state => _state;

  @override
  List<String> get names => _names;
}

class BroadcastModule implements Component {
  bool _state;
  List<String> _names;

  // Updated constructor with field initialization
  BroadcastModule(List<String> names)
      : _state = false,
        _names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool computeInput(List<bool> input) {
    _state = input[0];
    return state;
  }

  @override
  bool get state => _state;

  @override
  List<String> get names => _names;
}

void main() {

  Map<String,Component> map = {
    'broadcaster' : BroadcastModule(['a','b','c']),
    'a' : FlipFlop(['b']),
    'b' : FlipFlop(['c']),
    'c' : FlipFlop(['inv']),
    'inv' : Conjunction(['a'], {'c':false}),
  };


  for (int i=0; i<1; i++) {
    Map<String,List<bool>> inputs = {
      'broadcaster' : [false],
      'a' : [],
      'b' : [],
      'c' : [],
      'inv' : [],
    };
    List<String> inputList = ['broadcaster'];
    while (!inputList.isEmpty) {
      String currInputName = inputList.first;
      inputList.removeAt(0);
      List<bool> currentInputValues = inputs[currInputName]!;
      inputs[currInputName] = [];
      Component currComponent = map[currInputName]!;

      for (String componentName in currComponent.names) {
        if (currentInputValues.length == 0) continue;
        bool? pulse = currComponent.computeInput(currentInputValues);
        if (pulse == null) continue;
        inputList.add(componentName);
        List<bool> newInputList = inputs[componentName]!;
        newInputList.add(pulse);
        inputs[componentName] = newInputList;
      }
      print(inputList);
    }
    print("----");
    for (String key in map.keys) {
      print(map[key]!.state);
    }
  }
}