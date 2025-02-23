public class NumPrinter {
    public static void main(String[] a) {
        new Thread(() -> {
            for (int i=1; i<=20; i+=2) System.out.println("Odd: " + i);
        }).start();

        new Thread(() -> {
            for (int i=2; i<=20; i+=2) System.out.println("Even: " + i);
        }).start();
    }
}