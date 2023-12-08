import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  final List<Hand> hands = [];

  var filePath = p.join(Directory.current.path, '2023/7/seven_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split(' ');
    hands.add(Hand(hand: data[0], bid: int.parse(data[1])));
  }



  final gameIndex = [
    'A',
    'K',
    'Q',
    'J',
    'T',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2'
  ];

  //high card has index 0
  //one pair has index 1
  //two pair has index 2
  //three of a kind has index 3
  //full house has index 4
  //four of a kind has index 5
  //five of a kind has index 6
  List<List<Hand>> sortedHands = [
    [],
    [],
    [],
    [],
    [],
    [],
    []
  ];

  print("Part one:");
  for (Hand hand in hands) {
    final index = checkHandType(hand.hand);
    int insertIndex = 0;
    if (sortedHands[index].length != 0) {
      for (int i=0; i<sortedHands[index].length; i++) {
        if (!checkIfHandIsHigherThanComparingHand(hand.hand, sortedHands[index][i].hand, gameIndex)) {
          insertIndex = i;
          break;
        } else {
          //needed when its higher than the last hand in the list
          insertIndex = i+1;
        }
      }
    }
    sortedHands[index].insert(insertIndex, hand);
  }
  int sum = 0;
  int rank = 1;
  for(List<Hand> list in sortedHands) {
    for (Hand hand in list) {
      sum += hand.bid * rank;
      rank += 1;
    }
  }
  print(sum);
}

//helper

bool checkIfHandIsHigherThanComparingHand(String newHand, String comparingHand, List<String> indexList) {
  for (int i=0; i<5; i++) {
    if (indexList.indexOf(newHand[i]) < indexList.indexOf(comparingHand[i])) return true;
    if (indexList.indexOf(newHand[i]) > indexList.indexOf(comparingHand[i])) return false;
  }
  print("yeas");
  return false;
}

int checkHandType(String hand) {
  Map<String, int> cards = {};
  for (String char in hand.split('')) {
    if (cards[char] == null) {
      cards[char] = 1;
    } else {
      cards[char] = cards[char]! + 1;
    }
  }
  if (cards.length == 5) return 0;
  if (cards.length == 4) return 1;
  if(cards.length == 3) {
    for (String key in cards.keys) {
      if(cards[key]! == 3) {
        return 3;
      }
    }
    return 2;
  }
  if (cards.length == 2) {
    for (String key in cards.keys) {
      if(cards[key]! == 4) {
        return 5;
      }
    }
    return 4;
  }
  return 6;
}

class Hand {
  final String hand;
  final int bid;
  
  const Hand({
    required this.hand,
    required this.bid
  });
}