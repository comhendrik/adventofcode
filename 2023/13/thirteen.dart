import 'package:path/path.dart' as p;
import 'dart:io';

void main() async {
  //Everything for testing purposes
  List<List<String>> t_map = [];
  var filePath = p.join(Directory.current.path, '2023/13/thirteen_input.txt');
  File file = File(filePath);
  var fileContent = await file.readAsLines();
  for (String line in fileContent) {
    final data = line.split('');
    t_map.add([]);
    for (String char in data) {
      t_map.last.add(char);
    }
  }
  final yLen = t_map.length;
  final xLen = t_map.first.length;

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
      if(t_map[i][current_left_column] != t_map[i][current_right_column]) {
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
            if(t_map[i][curr_left] != t_map[i][curr_right]) {
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
    while (current_row<xLen) {
      bool foundHorizontalLine = true;
      int current_top_row = current_row - 1;
      int current_bottom_row = current_row;
      if(current_top_row < 0) break;
      if(current_bottom_row >= yLen) break;
      for(int i=0;i<xLen;i++) {
        if(t_map[current_top_row][i] != t_map[current_bottom_row][i]) {
          foundHorizontalLine = false;
        }
      }
      if(foundHorizontalLine) {
        print(current_top_row);
        print(current_bottom_row);
        int curr_top = current_top_row - 1;
        int curr_bottom = current_bottom_row + 1;
        bool stop = false;
        bool stillMirrored = true;
        while (!stop) {
          if (curr_top < 0) stop = true;
          else if (curr_bottom >= yLen) stop = true;
          else {
            for(int i=0;i<yLen;i++) {
              if(t_map[curr_top][i] != t_map[curr_bottom][i]) {
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
          foundHorizontal = true;
          break;
        }
      }
      current_row += 1;
    }
    print(foundHorizontal);
  }
}