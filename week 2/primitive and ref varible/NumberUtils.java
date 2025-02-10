package utility;

public class NumberUtils {
 
    public static int getLength(int number) {
        return String.valueOf(Math.abs(number)).length();
    }
}

import java.util.Scanner;

public class UtilityDemo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a number: ");
        int num = scanner.nextInt();
        scanner.close();
        
        System.out.println("Length of " + num + " is: " + utility.NumberUtils.getLength(num));
    }
}
