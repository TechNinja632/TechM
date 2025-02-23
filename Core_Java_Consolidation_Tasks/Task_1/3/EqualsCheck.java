import java.util.Arrays;

public class EqualsCheck {
    public static void main(String[] args) {
        Object[] arr1 = { new int[] {1, 2}, new int[] {3} };
        Object[] arr2 = { new int[] {1, 2}, new int[] {3} };
        System.out.println("equals(): " + Arrays.equals(arr1, arr2));
        System.out.println("deepEquals(): " + Arrays.deepEquals(arr1, arr2));
    }
}