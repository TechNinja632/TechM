import java.util.*;

public class ListMixer {
    public static <T> List<T> alternateMerge(List<T> listA, List<T> listB) {
        List<T> mixed = new ArrayList<>();
        int i = 0, j = 0;
        while (i < listA.size() || j < listB.size()) {
            if (i < listA.size()) mixed.add(listA.get(i++));
            if (j < listB.size()) mixed.add(listB.get(j++));
        }
        return mixed;
    }

    public static void main(String[] args) {
        List<String> fruits = List.of("apple", "banana");
        List<String> colors = List.of("red", "yellow");
        System.out.println(alternateMerge(fruits, colors));
    }
}