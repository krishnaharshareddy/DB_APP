package loginprof;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

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
        String user = request.getParameter("username");
        String pwd = request.getParameter("password");
        String profid = "";
        boolean auth = false;
        
        Connection connection = null;
        try{
			connection=getConnection();
			PreparedStatement pstmt1= connection.prepareStatement("select prof_id from professor where username = ? and password = ? ");
			pstmt1.setString(1, user);
			pstmt1.setString(2, pwd);
			ResultSet rs = pstmt1.executeQuery();
			while(rs.next()){
				profid = rs.getString(1);
				auth = true;
			}
        } catch(SQLException sqle){
			System.out.println("SQL exception when inserting project");
		}
        finally{
			closeConnection(connection);
		}
 
        if (auth) {
            Cookie cookie = new Cookie("User", profid);
            // setting cookie to expiry in 60 mins
            cookie.setMaxAge(60 * 60);
            response.addCookie(cookie);
            response.sendRedirect("profafterlogin.jsp");
        } else {
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/prof.html");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Please make sure you enter UserID/Pass .</font>\n");
            rd.include(request, response);
        }
 
    }
    
    static Connection getConnection() {
		String dbURL = "jdbc:postgresql://10.105.1.12/cs387";
        String dbUser = "db130050076";
        String dbPass = "db130050076";
        Connection connection=null;
        try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(dbURL, dbUser, dbPass);
        } catch(ClassNotFoundException cnfe){
        	System.out.println("JDBC Driver not found");
        } catch(SQLException sqle){
        	System.out.println("Error in getting connetcion from the database");
        }
        return connection;
	}
	
	static void closeConnection(Connection connection) {
		try{
			connection.close();
		} catch(SQLException sqle) {
			System.out.println("Error in close database connetcion");
		}
	}
}
