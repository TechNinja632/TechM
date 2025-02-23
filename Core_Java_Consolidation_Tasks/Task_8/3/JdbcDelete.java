import java.sql.*;
import java.util.Scanner;

public class JdbcDelete {
    public static void main(String[] args) throws SQLException {
        Scanner sc = new Scanner(System.in);
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "idkpass1212");
        
        System.out.print("Enter ID to delete: ");
        int delId = sc.nextInt();
        
        PreparedStatement p = con.prepareStatement("DELETE FROM products WHERE id=?");
        p.setInt(1, delId);
        p.executeUpdate();
        
        p.close();
        con.close();
    }
}