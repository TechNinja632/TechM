import java.sql.*;  
import java.util.Scanner;  

public class TableManager {  
    public static void main(String[] args) throws SQLException {  
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/mydb", "root", "pass123");  
        Statement st = con.createStatement();  
        st.execute("CREATE TABLE IF NOT EXISTS stuff(id INT PRIMARY KEY, name VARCHAR(20))");  

        // Insert  
        PreparedStatement ins = con.prepareStatement("INSERT INTO stuff VALUES(?, ?)");  
        ins.setInt(1, 101);  
        ins.setString(2, "Box");  
        ins.executeUpdate();  

        // Read  
        ResultSet rs = st.executeQuery("SELECT * FROM stuff");  
        while(rs.next()) System.out.println(rs.getInt(1) + " " + rs.getString(2));  

        // Update  
        PreparedStatement upd = con.prepareStatement("UPDATE stuff SET name=? WHERE id=?");  
        upd.setString(1, "NewBox");  
        upd.setInt(2, 101);  
        upd.executeUpdate();  

        // Delete  
        PreparedStatement del = con.prepareStatement("DELETE FROM stuff WHERE id=?");  
        del.setInt(1, 101);  
        del.executeUpdate();  

        con.close();  
    }  
}  