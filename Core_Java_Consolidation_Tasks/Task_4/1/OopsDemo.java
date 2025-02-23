public class OopsDemo {
    public static void main(String[] args) {
        try {
            int num = 10;
            int div = 0;
            System.out.println(num / div);
        } catch (ArithmeticException e) {
            System.out.println("Cant do that math");
        }
    }
}