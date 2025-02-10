public class StringProcessorDemo {
    public static void main(String[] args) {
        String testString = "hello world this is java";
        String subString = "is";

        System.out.println("Reversed String: " + StringProcessor.reverseString(testString));
        System.out.println("Occurrences of '" + subString + "': " + StringProcessor.countOccurrences(testString, subString));
        System.out.println("Capitalized String: " + StringProcessor.splitAndCapitalize(testString));
    }
}
