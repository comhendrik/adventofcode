import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  var filePath = p.join(Directory.current.path, '2023/11/eleven_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  List<List<String>> map = [];
  List<(int, int)> galaxies = [];
  for (int i=0; i<fileContent.length; i++) {
    final data = fileContent[i].split('');
    map.add([]);
    for (int j=0; j<data.length; j++) {
      map.last.add(data[j]);
      if (data[j] == '#') {
        galaxies.add((i,j));
      }
    }
  }
  List<(int,int)> movement = [
    (0,1),
    (1,0),
    (-1,0),
    (0,-1)
  ];


  print("Part one:");
  for ((int,int) galaxy in galaxies) {
    final ans = moving((galaxy.$1, galaxy.$2), movement);
  }

}

int moving((int, int) coors, List<(int,int)> movement) {
  return 0;
}
