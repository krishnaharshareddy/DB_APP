package loginprof;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/ProfLoginServlet")
public class ProfLoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
    private final String userID = "test";
    private final String password = "test";
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        // get request parameters for userID and password
        String crunchifyUser = request.getParameter("username");
        String pwd = request.getParameter("password");
 
        if (userID.equals(crunchifyUser) && password.equals(pwd)) {
            Cookie cookie = new Cookie("crunchifyUser", crunchifyUser);
            // setting cookie to expiry in 60 mins
            cookie.setMaxAge(60 * 60);
            response.addCookie(cookie);
            response.sendRedirect("proflogin.jsp");
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/prof.html");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Please make sure you enter UserID/Pass .</font>\n");
            rd.include(request, response);
        }
 
    }
}
