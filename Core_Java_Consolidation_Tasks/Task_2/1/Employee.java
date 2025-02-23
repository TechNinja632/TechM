import java.util.Scanner;

public class Employee {
    private int id;
    private String name;
    private double salary;
    private int yrs;

    public void setEmployeeDetails(int i, String n, double s, int y) {
        id = i;
        name = n;
        salary = s;
        yrs = y;
    }

    public String getEmployeeDetails() {
        return "ID: " + id + ", Name: " + name + ", Salary (LPA): " + salary + ", Years: " + yrs;
    }

    public double getLoanEligibility() {
        if (yrs <= 5) return 0.0;

        if (salary >= 15) {
            return 7.0;
        } else if (salary >= 10) {
            return 5.0;
        } else if (salary >= 6) {
            return 2.0;
        } else {
            return 0.0;
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Employee e = new Employee();

        System.out.print("Enter employee ID: ");
        int i = sc.nextInt();
        sc.nextLine();
        System.out.print("Enter name: ");
        String n = sc.nextLine();
        System.out.print("Annual salary (in lakhs): ");
        double s = sc.nextDouble();
        System.out.print("Years worked: ");
        int y = sc.nextInt();

        e.setEmployeeDetails(i, n, s, y);
        System.out.println(e.getEmployeeDetails());

        double loan = e.getLoanEligibility();
        System.out.println("Eligible loan: " + (loan > 0 ? loan + " lakhs" : "Not eligible"));
    }
}