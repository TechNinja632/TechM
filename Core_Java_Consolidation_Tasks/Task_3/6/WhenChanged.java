import java.io.*;
import java.util.Date;

public class WhenChanged {
    public static void main(String[] args) {
        File logFile = new File("error.log");
        long modTime = logFile.lastModified();
        System.out.println("Last touched: " + new Date(modTime));
    }
}