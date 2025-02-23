import java.util.*;

public class FindInList {
    public static void main(String[] args) {
        ArrayList<String> tools = new ArrayList<>(List.of("Hammer", "Wrench", "Screwdriver"));
        System.out.println(tools.contains("Wrench") ? "Found" : "Nope");
    }
}