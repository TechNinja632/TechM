import java.util.*;

public class ListFlipper {
    public static <T> List<T> reverseList(List<T> original) {
        List<T> flipped = new ArrayList<>();
        for (int i=original.size()-1; i>=0; i--) {
            flipped.add(original.get(i));
        }
        return flipped;
    }

    public static void main(String[] args) {
        List<Double> temps = List.of(3.14, 2.71, 1.618);
        System.out.println(reverseList(temps));
    }
}