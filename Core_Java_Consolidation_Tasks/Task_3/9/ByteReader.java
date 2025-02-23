import java.nio.file.*;
import java.io.*;

public class ByteReader {
    public static void main(String[] args) {
        try {
            byte[] data = Files.readAllBytes(Paths.get("secret.dat"));
            System.out.println("Read " + data.length + " bytes");
        } catch (IOException e) {
            System.out.println("File oopsie");
        }
    }
}