import java.util.*;

public class TailAdd {
    public static void main(String[] args) {
        LinkedList<String> lst = new LinkedList<>();
        lst.add("Hello");
        lst.offerLast("World");
        System.out.println(lst);
    }
}