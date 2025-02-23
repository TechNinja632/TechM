import java.util.*;

public class LinkAddEnd {
    public static void main(String[] args) {
        LinkedList<String> items = new LinkedList<>();
        items.add("Book");
        items.add("Pen");
        items.addLast("Ruler");
        System.out.println(items);
    }
}