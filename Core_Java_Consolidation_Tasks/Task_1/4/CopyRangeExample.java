import java.util.Arrays;

public class CopyRangeExample {
    public static void main(String[] args) {
        String[] words = {"apple", "banana", "cherry", "date", "fig"};
        String[] part = Arrays.copyOfRange(words, 1, 4);
        System.out.println("Original: " + Arrays.toString(words));
        System.out.println("Copied: " + Arrays.toString(part));
    }
}