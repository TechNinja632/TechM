import java.util.*;

public class Backwards {
    public static void main(String[] args) {
        LinkedList<String> lst = new LinkedList<>(List.of("First", "Second", "Third"));
        Iterator<String> it = lst.descendingIterator();
        while (it.hasNext()) {
            System.out.println(it.next());
        }
    }
}