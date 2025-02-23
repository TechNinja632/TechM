import java.util.Arrays;

public class SortThreads {
    static int[] nums = {5,9,1,3,8};

    public static void main(String[] args) throws Exception {
        int half = nums.length/2;
        int[] part1 = Arrays.copyOfRange(nums, 0, half);
        int[] part2 = Arrays.copyOfRange(nums, half, nums.length);

        Thread t1 = new Thread(() -> Arrays.sort(part1));
        Thread t2 = new Thread(() -> Arrays.sort(part2));

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        System.arraycopy(part1, 0, nums, 0, part1.length);
        System.arraycopy(part2, 0, nums, part1.length, part2.length);
        Arrays.sort(nums);
        System.out.println(Arrays.toString(nums));
    }
}