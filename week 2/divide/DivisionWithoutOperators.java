import java.util.Scanner;

public class DivisionWithoutOperators {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the dividend: ");
        int dividend = scanner.nextInt();

        System.out.print("Enter the divisor: ");
        int divisor = scanner.nextInt();

        if (divisor == 0) {
            System.out.println("Cannot divide by zero.");
            return; 
        }

        int quotient = 0;
        int remainder = dividend;

        while (remainder >= divisor) {
            remainder = remainder - divisor;
            quotient = quotient + 1;
        }

        System.out.println("Quotient: " + quotient);
        System.out.println("Remainder: " + remainder);

        scanner.close();
    }
}
