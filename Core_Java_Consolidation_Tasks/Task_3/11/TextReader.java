import java.io.*;
import java.util.*;

public class TextReader {
    public static void main(String[] args) {
        try {
            Scanner fileScan = new Scanner(new File("notes.txt"));
            while (fileScan.hasNextLine()) {
                System.out.println(fileScan.nextLine());
            }
        } catch (FileNotFoundException e) {
            System.out.println("File ghosted us");
        }
    }
}