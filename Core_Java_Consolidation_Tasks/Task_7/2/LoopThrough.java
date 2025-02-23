import java.util.*;

public class LoopThrough {
    public static void main(String[] args) {
        ArrayList<String> pets = new ArrayList<>(List.of("Dog", "Cat", "Fish"));
        for (String p : pets) {
            System.out.println(p);
        }
    }
}