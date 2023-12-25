import 'package:path/path.dart' as p;
import 'dart:io';


void main() async {

  List<int> seeds = [];
  List<List<(int,int,int)>> maps = [];
  var filePath = p.join(Directory.current.path, '2023/5/five_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    if(line.contains('seeds:')) {
      final data = line.split(' ');
      for(int i=1; i<data.length; i++) {
        seeds.add(int.parse(data[i]));
      }
    } else if(line.contains(':')) {
      maps.add([]);
    } else if(line != ''){
      final data = line.split(' ');
      maps.last.add((int.parse(data[0]),int.parse(data[1]),int.parse(data[2])));
    }

  }



  print("Part one:");
  List<int> finalSeeds = [];


  for (int seed in seeds) {
    int currentSeedNumber = seed;
    for(List<(int,int,int)> map in maps) {
      bool foundNewValue = false;
      for ((int,int,int) line in map) {
        int destinationRangeStart = line.$1;
        int sourceRangeStart = line.$2;
        int rangeLength = line.$3;

        //check if seed needs to be computed here, need to be computed when its in source range
        if (sourceRangeStart <= currentSeedNumber && currentSeedNumber <= sourceRangeStart + rangeLength) {
          final differenceToAdd = currentSeedNumber - sourceRangeStart;
          currentSeedNumber = destinationRangeStart + differenceToAdd;
          foundNewValue = true;
          break;
        }
      }
      if (foundNewValue) continue;
    }
    finalSeeds.add(currentSeedNumber);
  }

  finalSeeds.sort();
  print(finalSeeds.first);
}
