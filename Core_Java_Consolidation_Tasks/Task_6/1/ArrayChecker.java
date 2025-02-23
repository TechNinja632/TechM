public class ArrayChecker {
    public static <T> boolean checkOrder(T[] a, T[] b) {
        if (a.length != b.length) return false;
        for (int i=0; i<a.length; i++) {
            if (!a[i].equals(b[i])) return false;
        }
        return true;
    }

    public static void main(String[] args) {
        Integer[] nums1 = {1,2,3};
        Integer[] nums2 = {1,2,3};
        System.out.println(checkOrder(nums1, nums2));
    }
}