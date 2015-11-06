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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * Servlet implementation class AddProjectServlet
 */
@WebServlet("/AddProjectServlet")
public class AddProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userName = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("User"))
                    userName = cookie.getValue();
            }
        }
        if (userName == null)
            response.sendRedirect("prof.html");
        else
        {
        	String ProjectName = request.getParameter("ProjectName");
            String ProjectDescription = request.getParameter("ProjectDescription");
        	String HardPrerequisite = request.getParameter("HardPrerequisite");
            String SoftPrerequisite = request.getParameter("SoftPrerequisite");
        	String Interval = request.getParameter("Interval");
            String OpenPositions = request.getParameter("OpenPositions");
            String Dates = request.getParameter("Date");
            String Year = request.getParameter("Year");
            String ProjectID="225342";
			Connection connection=null;
			try{
				connection=getConnection();
				PreparedStatement pstmt1= connection.prepareStatement("select project_id from project order by project_id desc limit 1");
				ResultSet rs = pstmt1.executeQuery();
				String lastProjId="100100";
				while(rs.next()){
					lastProjId=rs.getString(1);
				}
				lastProjId=lastProjId.substring(3, 8);
				int tmp = Integer.parseInt(lastProjId);
				tmp++;
				ProjectID="pid"+tmp;
				PreparedStatement pstmt2= connection.prepareStatement("insert into project values(?,?,?,?,?);");
				pstmt2.setString(1, ProjectID);
				pstmt2.setString(2, ProjectName);
				pstmt2.setString(3, ProjectDescription);
				pstmt2.setInt(4, Integer.parseInt(OpenPositions));
				pstmt2.setInt(5, Integer.parseInt(OpenPositions));
				pstmt2.executeUpdate();
				System.out.println(pstmt2);
				
				PreparedStatement pstmt= connection.prepareStatement("insert into floats values(?,?,?,?,?);");
				pstmt.setString(1, ProjectID);
				pstmt.setString(2, userName);
				pstmt.setString(3, Interval);
				pstmt.setInt(4,Integer.parseInt(Year));
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
				Date myDate = formatter.parse(Dates);
				java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
				pstmt.setDate(5, sqlDate);
				pstmt.executeUpdate();
				System.out.println(pstmt);
				String[] Hard=HardPrerequisite.split(";");
				String[] Soft=SoftPrerequisite.split(";"); 
				for(int i=0;i<Hard.length;i++)
				{
					PreparedStatement pstmt3= connection.prepareStatement("insert into prerequisite values(?,?,?);");
					pstmt3.setString(1, ProjectID);
					pstmt3.setString(2, Hard[i]);
					pstmt3.setString(3, "Hard");
					pstmt3.executeUpdate();
					System.out.println(pstmt3);
				}
				for(int i=0;i<Soft.length;i++)
				{
					PreparedStatement pstmt3= connection.prepareStatement("insert into prerequisite values(?,?,?);");
					pstmt3.setString(1, ProjectID);
					pstmt3.setString(2, Soft[i]);
					pstmt3.setString(3, "Soft");
					pstmt3.executeUpdate();
					System.out.println(pstmt3);
				}
				
			} catch(SQLException sqle){
				System.out.println("SQL exception when inserting project");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally{
				closeConnection(connection);
			}
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/prof_float.jsp");
            PrintWriter out = response.getWriter();
            out.println("<font color=red>Successfully Added .</font>\n");
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
