import java.util.Arrays;

public class MatrixThreads {
    static int[][] a = {{1,2}, {3,4}};
    static int[][] b = {{5,6}, {7,8}};
    static int[][] res = new int[2][2];

    public static void main(String[] args) throws Exception {
        Thread t1 = new Thread(() -> {
            res[0][0] = a[0][0]*b[0][0] + a[0][1]*b[1][0];
            res[0][1] = a[0][0]*b[0][1] + a[0][1]*b[1][1];
        });

        Thread t2 = new Thread(() -> {
            res[1][0] = a[1][0]*b[0][0] + a[1][1]*b[1][0];
            res[1][1] = a[1][0]*b[0][1] + a[1][1]*b[1][1];
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        for (int[] r : res) System.out.println(Arrays.toString(r));
    }
}