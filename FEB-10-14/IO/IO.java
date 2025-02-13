import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class IO {
    public static void main(String[] args) {
        IO instance = new IO();

        try {
            instance.readText();
        } catch (IOException e) {
            System.err.println("Something went wrong while reading input: " + e.getMessage());
        }

        instance.collectUserInput();
        instance.displayMessages();
    }

    void readText() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Type something: ");
        String input = reader.readLine();
        System.out.println("You wrote: " + input);
    }

    void collectUserInput() {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter a word: ");
        String text = scanner.nextLine();
        System.out.println("Got it: " + text);

        System.out.print("Enter a whole number: ");
        int number = scanner.nextInt();
        System.out.println("Number noted: " + number);

        System.out.print("Enter a decimal value: ");
        float decimal = scanner.nextFloat();
        System.out.println("Decimal recorded: " + decimal);

        scanner.close();
    }

    void displayMessages() {
        System.out.println("You ever just sit and wonder? Like, why do we remember the most random things? But forget what we walked into a room for?");
        System.err.println("Anyway... life’s weird.");
    }
}
