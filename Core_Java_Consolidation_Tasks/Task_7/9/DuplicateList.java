import java.util.*;

public class DuplicateList {
    public static void main(String[] args) {
        ArrayList<String> orig = new ArrayList<>(List.of("A", "B", "C"));
        ArrayList<String> copy = new ArrayList<>(orig);
        System.out.println(copy);
    }
}