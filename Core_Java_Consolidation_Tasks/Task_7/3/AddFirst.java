import java.util.*;

public class AddFirst {
    public static void main(String[] args) {
        ArrayList<String> cities = new ArrayList<>(Arrays.asList("Paris", "London"));
        cities.add(0, "Tokyo");
        System.out.println(cities);
    }
}