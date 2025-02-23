import javax.servlet.*;  
import javax.servlet.http.*;  
import java.io.*;  

@WebServlet("/show")  
public class ShowHtml extends HttpServlet {  
    protected void doGet(HttpRequest req, HttpResponse res) throws ServletException, IOException {  
        PrintWriter out = res.getWriter();  
        res.setContentType("text/html");  

        try(BufferedReader br = new BufferedReader(new FileReader("/page.html"))) {  
            String line;  
            while((line = br.readLine()) != null) out.println(line);  
        } catch(Exception e) {  
            out.println("Error loading page");  
        }  
    }  
}  