import 'package:path/path.dart' as p;
import 'dart:io';


void main() async {

  List<int> seeds = [];
  List<int> seedsP2 = [];
  List<List<(int,int,int)>> maps = [];
  var filePath = p.join(Directory.current.path, '2023/5/five_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    if(line.contains('seeds:')) {
      final data = line.split(' ');
      for(int i=1; i<data.length; i++) {
        final value = int.parse(data[i]);
        seeds.add(value);
        if(i%2!=0) {
          for(int j=0; j<int.parse(data[i+1]); j++) {
            seedsP2.add(value+j);
          }
        }
      }
    } else if(line.contains(':')) {
      maps.add([]);
    } else if(line != ''){
      final data = line.split(' ');
      maps.last.add((int.parse(data[0]),int.parse(data[1]),int.parse(data[2])));
    }

  }

  print(seedsP2.length);

  print("Part one:");
  List<int> finalSeeds = [];


  for (int seed in seeds) {
    int currentSeedNumber = seed;
    for(List<(int,int,int)> map in maps) {
      for ((int,int,int) line in map) {
        int destinationRangeStart = line.$1;
        int sourceRangeStart = line.$2;
        int rangeLength = line.$3;

        //check if seed needs to be computed here, need to be computed when its in source range
        if (sourceRangeStart <= currentSeedNumber && currentSeedNumber <= sourceRangeStart + rangeLength) {
          final differenceToAdd = currentSeedNumber - sourceRangeStart;
          currentSeedNumber = destinationRangeStart + differenceToAdd;
          break;
        }
      }
    }
    finalSeeds.add(currentSeedNumber);
  }

  finalSeeds.sort();
  print(finalSeeds.first);


  print("part two, works but not for large inputs");
  List<int> finalSeedsP2 = [];


  for (int seed in seedsP2) {
    int currentSeedNumber = seed;
    for(List<(int,int,int)> map in maps) {
      for ((int,int,int) line in map) {
        int destinationRangeStart = line.$1;
        int sourceRangeStart = line.$2;
        int rangeLength = line.$3;

        //check if seed needs to be computed here, need to be computed when its in source range
        if (sourceRangeStart <= currentSeedNumber && currentSeedNumber <= sourceRangeStart + rangeLength) {
          final differenceToAdd = currentSeedNumber - sourceRangeStart;
          currentSeedNumber = destinationRangeStart + differenceToAdd;
          break;
        }
      }
    }
    finalSeedsP2.add(currentSeedNumber);
  }

  finalSeedsP2.sort();
  print(finalSeedsP2.first);
}
