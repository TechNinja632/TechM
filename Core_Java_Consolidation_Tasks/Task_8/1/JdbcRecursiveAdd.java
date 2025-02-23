import java.sql.*;
import java.util.Scanner;

public class JdbcRecursiveAdd {
    public static void main(String[] args) throws SQLException {
        Scanner sc = new Scanner(System.in);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "idkpass1212");
        String sql = "INSERT INTO products (name, price) VALUES (?, ?)";
        
        while(true) {
            System.out.print("Enter name (or 'exit'): ");
            String nm = sc.next();
            if(nm.equals("exit")) break;
            
            System.out.print("Enter price: ");
            double pr = sc.nextDouble();
            
            PreparedStatement p = con.prepareStatement(sql);
            p.setString(1, nm);
            p.setDouble(2, pr);
            p.executeUpdate();
            p.close();
        }
        con.close();
    }
}