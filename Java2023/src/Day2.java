import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

class Day2 {
    public static void main(String[] args) {
        ArrayList<ArrayList<HashMap<String, Integer>>> games = new ArrayList<>();
        final String path = "Java2023/inputs/day_2.txt";
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            int i = 0;
            while ((line = br.readLine()) != null) {
                games.add(new ArrayList<>());
                games.get(games.size() - 1).add(new HashMap<>());
                //get arraylist from
                ArrayList<String> split = new ArrayList<>(Arrays.asList(line.split("\\s+")));

                for (int j=2; j<split.size(); j++) {
                    String key;
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

            HashMap<String, Integer> available = new HashMap<>();
            available.put("red",12);
            available.put("green",13);
            available.put("blue", 14);

            System.out.println("Part one:");

            int sum = 0;
            int sumAdder = 1;
            for (int j=0; j<games.size(); j++) {
                boolean addToSum = true;
                for (int y=0; y<games.get(j).size(); y++) {
                    for (String key : games.get(j).get(y).keySet()) {
                        if (available.containsKey(key)) {
                            if (available.get(key) < games.get(j).get(y).get(key)) {
                                addToSum = false;
                            }
                        } else {
                            addToSum = true;
                        }
                    }
                }
                if (addToSum) sum += sumAdder;
                sumAdder++;
            }
            System.out.println(sum);
        } catch (IOException e) {
            System.out.println(e.getLocalizedMessage());
        }

    }
}
