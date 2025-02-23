import java.util.*;

class StudentData {
    String name;
    int[] grades;
    int total;
    double avg;

    StudentData(String n, int[] g) {
        name = n;
        grades = g;
        for (int x : g) total += x;
        avg = (double) total / g.length;
    }
}

public class StudentMarks {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        ArrayList<StudentData> students = new ArrayList<>();
        System.out.print("Number of students? ");
        int num = sc.nextInt();
        for (int i = 0; i < num; i++) {
            System.out.print("Name: ");
            String n = sc.next();
            System.out.print("How many subjects? ");
            int subs = sc.nextInt();
            int[] g = new int[subs];
            for (int j = 0; j < subs; j++) {
                System.out.print("Mark " + (j + 1) + ": ");
                g[j] = sc.nextInt();
            }
            students.add(new StudentData(n, g));
        }
        students.sort((a, b) -> Integer.compare(b.total, a.total));
        System.out.println("Sorted Students:");
        for (StudentData s : students) {
            System.out.println(s.name + " Total: " + s.total + " Avg: " + s.avg);
        }
    }
}