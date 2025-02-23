import java.io.*;

public class PathCheck {
    public static void main(String[] args) {
        File checkMe = new File("test.txt");
        System.out.println(checkMe.exists() ? "Exists" : "Ghost file");
    }
}