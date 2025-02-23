import java.util.*;

public class FrontAdd {
    public static void main(String[] args) {
        LinkedList<Integer> nums = new LinkedList<>(List.of(2, 3));
        nums.offerFirst(1);
        System.out.println(nums);
    }
}