import java.util.Scanner;

public class ConsoleReader {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Say something: ");
        String input = sc.nextLine();
        System.out.println("You said: " + input);
    }
}