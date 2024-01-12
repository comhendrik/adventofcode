import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;

class Day1 {
    public static void main(String[] args) {
        String path = "Java2023/inputs/day_1.txt";

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            System.out.println("Part one:");
            int sum = 0;
            while ((line = br.readLine()) != null) {
                String number = "";
                for(int i=0; i<line.length(); i++) {
                    if (Character.isDigit(line.charAt(i))) {
                        number = "" + line.charAt(i);
                        break;
                    }
                }

                for(int i=line.length()-1; i>-1; i--) {
                    if (Character.isDigit(line.charAt(i))) {
                        number = number + line.charAt(i);
                        break;
                    }
                }
                sum += Integer.parseInt(number);


            }
            System.out.println(sum);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String pathP2 = "Java2023/inputs/day_1.txt";
        System.out.println("Part Two:");
        try (BufferedReader br = new BufferedReader(new FileReader(pathP2))) {
            String line;
            int sum = 0;
            HashMap<String, String> numberReplacementStrings = new HashMap<>();
            numberReplacementStrings.put("one", "1");
            numberReplacementStrings.put("two", "2");
            numberReplacementStrings.put("three", "3");
            numberReplacementStrings.put("four", "4");
            numberReplacementStrings.put("five", "5");
            numberReplacementStrings.put("six", "6");
            numberReplacementStrings.put("seven", "7");
            numberReplacementStrings.put("eight", "8");
            numberReplacementStrings.put("nine", "9");

            while ((line = br.readLine()) != null) {
                String first = "";
                String last = "";
                for (int i=0; i<line.length(); i++) {
                    String curr = "";
                    if (Character.isDigit(line.charAt(i))) {
                        curr = Character.toString(line.charAt(i));
                    } else {
                        for (HashMap.Entry<String, String> entry : numberReplacementStrings.entrySet()) {
                            String key = entry.getKey();
                            String value = entry.getValue();
                            if (i + key.length() > line.length()) continue;
                            if(line.substring(i, i + key.length()).equals(key)) {
                                curr = numberReplacementStrings.get(key);
                                break;
                            }
                        }
                    }
                    if(curr != "") {
                        if (first == "") {
                            first = curr;
                        }
                        last = curr;
                    }
                }
                sum += Integer.parseInt(first+last);
            }
            System.out.println(sum);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
