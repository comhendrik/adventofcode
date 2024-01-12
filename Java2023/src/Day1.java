import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Day1 {
    public static void main(String[] args) {
        String path = "Java2023/inputs/day_1.txt";

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String zeile;
            while ((zeile = br.readLine()) != null) {
                System.out.println(zeile);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
