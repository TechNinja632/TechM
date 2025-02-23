import java.util.*;

public class LinkLoop {
    public static void main(String[] args) {
        LinkedList<String> cars = new LinkedList<>(List.of("Sedan", "SUV", "Truck"));
        for (String c : cars) {
            System.out.println(c);
        }
    }
}