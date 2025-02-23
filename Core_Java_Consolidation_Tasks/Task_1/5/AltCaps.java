public class AltCaps {
    public static void main(String[] args) {
        String input = "anurag";
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (i % 2 == 0) {
                result.append(Character.toUpperCase(c));
            } else {
                result.append(Character.toLowerCase(c));
            }
        }
        System.out.println("Output: " + result.toString());
    }
}