import java.util.*;

public class InsertBatch {
    public static void main(String[] args) {
        LinkedList<String> base = new LinkedList<>(List.of("X", "Z"));
        base.addAll(1, List.of("Y1", "Y2"));
        System.out.println(base);
    }
}