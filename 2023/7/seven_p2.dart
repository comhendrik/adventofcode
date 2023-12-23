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
  //change order
  final gameIndex = [
    'A',
    'K',
    'Q',
    'T',
    '9',
    '8',
    '7',
    '6',
    '5',
    '4',
    '3',
    '2',
    'J',
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

  print("Part two:");
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
//stays the same
bool checkIfHandIsHigherThanComparingHand(String newHand, String comparingHand, List<String> indexList) {
  for (int i=0; i<5; i++) {
    if (indexList.indexOf(newHand[i]) < indexList.indexOf(comparingHand[i])) return true;
    if (indexList.indexOf(newHand[i]) > indexList.indexOf(comparingHand[i])) return false;
  }
  return false;
}


//only need to change this one
//there are some options when j occurs
/*
	- High Card
		○ J  == 1 - > One Pair
	- One Pair
		○ J == 1 -> three of a kind
		○ J == 2 -> three of kind
	- Two pair
		○  j == 1 -> full house
		○ J == 2 -> four of a kind
	- Three of a kind
		○ J = 1 -> four of a kind
		○ J = 3 -> four of a kind
	- Full house
		○ J = 2 -> five of a kind
		○ J = 3 -> five of a kind
	- Four of a kind
		○ J = 1 -> five of a kind
		○ J = 4 -> five of a kind
	- Five of a kind
    ○ J = 5 -> five of a kind
 */
int checkHandType(String hand) {
  Map<String, int> cards = {};
  for (String char in hand.split('')) {
    if (cards[char] == null) {
      cards[char] = 1;
    } else {
      cards[char] = cards[char]! + 1;
    }
  }
  bool containsJ = false;
  if (cards.containsKey('J')) containsJ = true;

  if (cards.length == 5) {
    if (containsJ) return 1;
    return 0;
  }
  if (cards.length == 4) {
    if (containsJ) return 3;
    return 1;
  }
  if(cards.length == 3) {
    for (String key in cards.keys) {
      if(cards[key]! == 3) {
        //three of a kind
        if (containsJ) return 5;
        return 3;
      }
    }
      //two pair
    if (containsJ) {
      final numberOfJ = cards['J']!;
      if (numberOfJ == 2) {

        return 5;
      }
      return 4;
    }
    return 2;
  }
  if (cards.length == 2) {
    for (String key in cards.keys) {
      if(cards[key]! == 4) {
        //four of a kind
        if (containsJ) return 6;
        return 5;
      }
    }
    //full house
    if (containsJ) return 6;
    return 4;
  }
    //five of a kind
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