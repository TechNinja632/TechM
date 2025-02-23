import java.util.Arrays;

public class AltArrayCopy {
    public static void main(String[] args) {
        int[] arr = {5, 3, 8, 1, 9, 4, 6};
        int[] newarr = new int[(arr.length + 1) / 2];
        int pos = 0;
        for (int i = 0; i < arr.length; i += 2) {
            newarr[pos] = arr[i];
            pos++;
        }
        System.out.println("Original: " + Arrays.toString(arr));
        System.out.println("Alternate: " + Arrays.toString(newarr));
    }
}