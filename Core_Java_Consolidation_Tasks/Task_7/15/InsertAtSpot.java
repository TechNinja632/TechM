import java.util.*;

public class InsertAtSpot {
    public static void main(String[] args) {
        LinkedList<String> items = new LinkedList<>(List.of("A", "C"));
        items.add(1, "B");
        System.out.println(items);
    }
}