import java.util.*;

public class StartFrom {
    public static void main(String[] args) {
        LinkedList<String> birds = new LinkedList<>(List.of("Eagle", "Sparrow", "Owl"));
        ListIterator<String> it = birds.listIterator(1);
        while (it.hasNext()) {
            System.out.println(it.next());
        }
    }
}