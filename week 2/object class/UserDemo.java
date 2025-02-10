public class UserDemo {
    public static void main(String[] args) {
        User user1 = new User("Alice", 25);
        User user2 = new User("Alice", 25);
        SecondUser secondUser1 = new SecondUser("Alice", 25);
        SecondUser secondUser2 = new SecondUser("Alice", 25);

        System.out.println("User objects with overridden methods:");
        System.out.println(user1);
        System.out.println("Are user1 and user2 equal? " + user1.equals(user2));

        System.out.println("\nSecondUser objects without overridden methods:");
        System.out.println(secondUser1);
        System.out.println("Are secondUser1 and secondUser2 equal? " + secondUser1.equals(secondUser2));
    }
}
