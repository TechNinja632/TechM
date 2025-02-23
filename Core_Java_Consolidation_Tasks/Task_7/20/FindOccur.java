import java.util.*;

public class FindOccur {
    public static void main(String[] args) {
        LinkedList<String> data = new LinkedList<>(List.of("A", "B", "A", "C"));
        System.out.println("First A: " + data.indexOf("A"));
        System.out.println("Last A: " + data.lastIndexOf("A"));
    }
}