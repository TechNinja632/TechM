import java.io.*;
import java.util.Scanner;

public class FileOpener {
    static void readFile() throws FileNotFoundException {
        File f = new File("ghostfile.txt");
        Scanner sc = new Scanner(f);
        sc.close();
    }

    public static void main(String[] args) {
        try {
            readFile();
        } catch (FileNotFoundException e) {
            System.out.println("File vanished");
        }
    }
}