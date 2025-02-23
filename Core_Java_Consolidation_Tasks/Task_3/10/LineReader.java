import java.io.*;

public class LineReader {
    public static void main(String[] args) {
        try (BufferedReader br = new BufferedReader(new FileReader("log.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            System.out.println("Cant read that");
        }
    }
}