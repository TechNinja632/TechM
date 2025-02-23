import java.io.*;

public class EmptyFileDetector {
    public static void main(String[] args) {
        try {
            File f = new File("empty.txt");
            if (f.length() == 0) {
                throw new IOException("File's empty mate");
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
}