abstract class Component {
  bool? computeInput(bool input);
}

class FlipFlop extends Component{
  bool state;
  List<String> names;

  // Updated constructor with field initialization
  FlipFlop(List<String> names)
      : state = false,
        names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool? computeInput(bool input) {
    if (input) return null;
    state = !state;
    return state;
  }
}

class Conjunction implements Component{
  bool state;
  List<String> names;

  // Updated constructor with field initialization
  Conjunction(List<String> names)
      : state = false,
        names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  //input needs to be a value from a list and if it contains false or not
  bool? computeInput(bool input) {
    state = true;
    return state;
  }
}

class BroadcastModule implements Component {
  bool state;
  List<String> names;

  // Updated constructor with field initialization
  BroadcastModule(List<String> names)
      : state = false,
        names = names;

  //true is a high pulse
  //false is a low pulse
  @override
  bool computeInput(bool input) {
    state = input;
    return state;
  }
}

Map<String,Component> map = {
  'broadcaster' : BroadcastModule(['a','b','c']),
  'a' : FlipFlop(['b']),
  'b' : FlipFlop(['c']),
  'c' : FlipFlop(['inv']),
  'inv' : Conjunction(['a']),
};