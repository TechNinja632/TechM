public class PrimitiveRefDemo {

    public static void modifyValues(int number, int[] array) {
        number = number + 10;
        array[0] = 100;
        System.out.println("Inside method - Number: " + number);
        System.out.println("Inside method - Array: " + java.util.Arrays.toString(array));
    }

    public static void main(String[] args) {
        int number = 5;
        int[] array = {1, 2, 3};

        System.out.println("Before method call - Number: " + number);
        System.out.println("Before method call - Array: " + java.util.Arrays.toString(array));

        modifyValues(number, array);

        System.out.println("After method call - Number: " + number);
        System.out.println("After method call - Array: " + java.util.Arrays.toString(array));
    }
}
