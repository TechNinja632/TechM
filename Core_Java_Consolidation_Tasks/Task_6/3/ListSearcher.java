import java.util.*;

public class ListSearcher {
    public static <T> int findFirst(List<T> list, T target) {
        for (int i=0; i<list.size(); i++) {
            if (list.get(i).equals(target)) return i;
        }
        return -1;
    }

    public static void main(String[] args) {
        List<String> words = List.of("apple", "banana", "cherry");
        System.out.println(findFirst(words, "banana"));
    }
}