import java.io.*;

public class NegativityCheck {
    public static void main(String[] args) {
        try {
            BufferedReader br = new BufferedReader(new FileReader("numbers.txt"));
            String line;
            while ((line = br.readLine()) != null) {
                int val = Integer.parseInt(line);
                if (val > 0) throw new Exception("Positive value: " + val);
            }
            br.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}