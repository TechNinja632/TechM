import java.util.*;

public class SortDemo {
    public static void main(String[] args) {
        ArrayList<String> words = new ArrayList<>(List.of("Zebra", "Apple", "Mango"));
        Collections.sort(words);
        System.out.println(words);
    }
}