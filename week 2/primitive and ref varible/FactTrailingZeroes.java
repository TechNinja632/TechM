import java.util.Scanner;

public class FactTrailingZeroes {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a number: ");
        int num = scanner.nextInt();
        scanner.close();
        
        System.out.println("Trailing zeroes in " + num + "! : " + countTrailingZeroes(num));
    }

    public static int countTrailingZeroes(int n) {
        int count = 0;
        for (int i = 5; n / i >= 1; i *= 5) {
            count += n / i;
        }
        return count;
    }
}
