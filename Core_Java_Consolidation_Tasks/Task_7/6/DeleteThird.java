import java.util.*;

public class DeleteThird {
    public static void main(String[] args) {
        ArrayList<String> fruits = new ArrayList<>(List.of("Apple", "Banana", "Cherry", "Date"));
        fruits.remove(2);
        System.out.println(fruits);
    }
}