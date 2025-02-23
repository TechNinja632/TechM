import java.sql.*;
import java.util.Scanner;

public class JdbcMenu {
    public static void main(String[] args) throws SQLException {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "idkpass1212");
        Scanner sc = new Scanner(System.in);
        int choice;
        
        do {
            System.out.println("1. Add 2. Edit 3. Remove 4. View 5. Exit");
            choice = sc.nextInt();
            
            switch(choice) {
                case 1:
                    PreparedStatement ins = con.prepareStatement("INSERT INTO products (name, price) VALUES (?,?)");
                    System.out.print("Name: ");
                    ins.setString(1, sc.next());
                    System.out.print("Price: ");
                    ins.setDouble(2, sc.nextDouble());
                    ins.executeUpdate();
                    break;
                    
                case 2:
                    PreparedStatement upd = con.prepareStatement("UPDATE products SET price=? WHERE id=?");
                    System.out.print("New price: ");
                    upd.setDouble(1, sc.nextDouble());
                    System.out.print("ID: ");
                    upd.setInt(2, sc.nextInt());
                    upd.executeUpdate();
                    break;
                    
                case 3:
                    PreparedStatement del = con.prepareStatement("DELETE FROM products WHERE id=?");
                    System.out.print("Delete ID: ");
                    del.setInt(1, sc.nextInt());
                    del.executeUpdate();
                    break;
                    
                case 4:
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM products");
                    while(rs.next()) {
                        System.out.println(rs.getInt("id") + " " + rs.getString("name"));
                    }
                    break;
            }
        } while(choice != 5);
        
        con.close();
    }
}