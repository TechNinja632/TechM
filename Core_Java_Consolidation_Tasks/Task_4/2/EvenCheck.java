public class EvenCheck {
    static void verifyEven(int x) throws Exception {
        if (x % 2 != 0) {
            throw new Exception("Odd number alert");
        }
    }

    public static void main(String[] args) {
        try {
            verifyEven(7);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}