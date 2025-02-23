import java.io.*;

public class SizeChecker {
    public static void main(String[] args) {
        File video = new File("movie.mp4");
        long bytes = video.length();
        System.out.printf("Size: %d B | %.2f KB | %.2f MB",
                bytes, bytes/1024.0, bytes/(1024.0*1024));
    }
}