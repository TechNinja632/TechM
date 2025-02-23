import java.util.*;

public class ChangeElement {
    public static void main(String[] args) {
        ArrayList<String> drinks = new ArrayList<>(List.of("Coffee", "Tea"));
        drinks.set(1, "Matcha");
        System.out.println(drinks);
    }
}