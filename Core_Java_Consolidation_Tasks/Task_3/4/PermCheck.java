import java.io.*;

public class PermCheck {
    public static void main(String[] args) {
        File target = new File("data.bin");
        System.out.println("Readable: " + target.canRead());
        System.out.println("Writable: " + target.canWrite());
    }
}