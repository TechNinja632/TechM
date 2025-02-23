import java.util.*;

public class MixUp {
    public static void main(String[] args) {
        ArrayList<Integer> nums = new ArrayList<>(List.of(1, 2, 3, 4, 5));
        Collections.shuffle(nums);
        System.out.println(nums);
    }
}