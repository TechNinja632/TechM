import java.sql.*;
import java.util.Scanner;

public class JdbcUpdate {
    public static void main(String[] args) throws SQLException {
        Scanner sc = new Scanner(System.in);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "idkpass1212");
        
        System.out.print("Enter product ID to update: ");
        int id = sc.nextInt();
        System.out.print("New price: ");
        double newPr = sc.nextDouble();
        
        PreparedStatement p = con.prepareStatement("UPDATE products SET price=? WHERE id=?");
        p.setDouble(1, newPr);
        p.setInt(2, id);
        p.executeUpdate();
        
        p.close();
        con.close();
    }
}