void main() {
  //Time:      7  15   30
  //Distance:  9  40  200
  List<(int, int)> tRaces= [
    (7,9),
    (15,40),
    (30, 200)
  ];
  //Time:        46     85     75     82
  //Distance:   208   1412   1257   1410
  List<(int, int)> rRaces= [
    (46,208),
    (85,1412),
    (75, 1257),
    (82, 1410)
  ];

  List<(int, int)> partTwoRaces= [
    (46857582, 208141212571410),
  ];

  print("part one:");
  int values = 0;
  for((int, int) race in rRaces) {
    int options = 0;
    int speed = 0;
    int raceTime = 0;
    for(int i=1; i<race.$1; i++) {
      speed = i;
      raceTime = race.$1 - i;
      if (race.$2 < raceTime * speed) {
        options += 1;
      }
    }
    if (values == 0) values = options;
    else values = values * options;
  };

  print(values);

  print("part two:");
  values = 0;
  for((int, int) race in partTwoRaces) {
    int options = 0;
    int speed = 0;
    int raceTime = 0;
    for(int i=1; i<race.$1; i++) {
      speed = i;
      raceTime = race.$1 - i;
      if (race.$2 < raceTime * speed) {
        options += 1;
      }
    }
    if (values == 0) values = options;
    else values = values * options;
  };

  print(values);
}