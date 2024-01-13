import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

class Day2 {
    public static void main(String[] args) {
        ArrayList<ArrayList<HashMap<String, Integer>>> games = new ArrayList<>();
        final String path = "Java2023/inputs/t_day_2.txt";
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            int i = 0;
            while ((line = br.readLine()) != null) {
                games.add(new ArrayList<>());
                games.get(games.size() - 1).add(new HashMap<>());
                //get arraylist from
                ArrayList<String> split = new ArrayList<>(Arrays.asList(line.split("\\s+")));

                for (int j=2; j<split.size(); j++) {
                    String key = "";
                    if (split.get(j).matches("\\d+")) { //check if string is digit
                        if (j+1 == split.size() - 1) {

                            key = split.get(j+1);
                        } else {

                            key = split.get(j+1).substring(0, split.get(j+1).length() - 1);
                        }
                        games.get(i).get(games.get(i).size() - 1).put(key, Integer.parseInt(split.get(j)));
                    } else if (split.get(j).endsWith(";")) {
                        games.get(games.size() - 1).add(new HashMap<>());
                    }

                }
                i++;
            }

            System.out.println(games);
        } catch (IOException e) {
            System.out.println(e.getLocalizedMessage());
        }

    }
}
