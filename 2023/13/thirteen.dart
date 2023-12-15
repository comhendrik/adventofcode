import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  //Everything for testing purposes
  List<List<List<String>>> maps = [];
  var filePath = p.join(Directory.current.path, '2023/13/thirteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  maps.add([]);
  for (String line in fileContent) {
    if (line == '') maps.add([]);
    else maps.last.add([]);
    final data = line.split('');
    for (String char in data) {
      maps.last.last.add(char);
    }
  }
  print("Part one:");
  int sum = 0;
  for (List<List<String>> map in maps) {
    final yLen = map.length;
    final xLen = map.first.length;


    //vertical checking
    int current_column = 1;

    bool foundVertical = false;
    while (current_column<xLen) {
      bool foundVerticalLine = true;
      int current_left_column = current_column - 1;
      int current_right_column = current_column;
      if(current_left_column < 0) break;
      if(current_right_column >= xLen) break;
      for(int i=0;i<yLen;i++) {
        if(map[i][current_left_column] != map[i][current_right_column]) {
          foundVerticalLine = false;
        }
      }
      if(foundVerticalLine) {
        int curr_left = current_left_column - 1;
        int curr_right = current_right_column + 1;
        bool stop = false;
        bool stillMirrored = true;
        while (!stop) {
          if (curr_left < 0) stop = true;
          else if (curr_right >= xLen) stop = true;
          else {
            for(int i=0;i<yLen;i++) {
              if(map[i][curr_left] != map[i][curr_right]) {
                stop = true;
                stillMirrored = false;
                break;
              }
            }
            curr_left -= 1;
            curr_right += 1;
          }
        }
        if (stillMirrored) {
          sum += (current_left_column + 1);
          foundVertical = true;
          break;
        }
      }
      current_column += 1;
    }
    if (!foundVertical) {
      //horizontal checking
      int current_row = 1;
      bool foundHorizontal = false;
      while (current_row<yLen) {
        bool foundHorizontalLine = true;
        int current_top_row = current_row - 1;
        int current_bottom_row = current_row;
        if(current_top_row < 0) break;
        if(current_bottom_row >= yLen) break;
        for(int i=0;i<xLen;i++) {
          if(map[current_top_row][i] != map[current_bottom_row][i]) {
            foundHorizontalLine = false;
            break;
          }
        }
        if(foundHorizontalLine) {
          int curr_top = current_top_row - 1;
          int curr_bottom = current_bottom_row + 1;
          bool stop = false;
          bool stillMirrored = true;
          while (!stop) {
            if (curr_top < 0) stop = true;
            else if (curr_bottom >= yLen) stop = true;
            else {
              for(int i=0;i<xLen;i++) {
                if(map[curr_top][i] != map[curr_bottom][i]) {
                  stop = true;
                  stillMirrored = false;
                  break;
                }
              }
              curr_top -= 1;
              curr_bottom += 1;
            }
          }
          if (stillMirrored) {
            sum += (current_top_row + 1) * 100;
            foundHorizontal = true;
            break;
          }
        }
        current_row += 1;
      }
    }
  }

  print(sum);
}