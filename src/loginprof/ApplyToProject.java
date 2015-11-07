package loginprof;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ApplyToProject
 */
@WebServlet("/ApplyToProject")
public class ApplyToProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApplyToProject() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		{
	        Connection connection = null;
	        try{
				connection=getConnection();
				
				String student_id = request.getParameter("student_id");
				String sop = request.getParameter("SOP");
				System.out.println(sop);
				String project_id = request.getParameter("project_selected");
				if(project_id==null)
				{
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/student_browse.jsp");
		            PrintWriter out = response.getWriter();
		            out.println("<font id= \"USEFORSWAL_ERR\" color=red>Choose a Project! .</font>\n");
		            rd.include(request, response);
				}
				else
				{
					PreparedStatement pstmt1= connection.prepareStatement("insert into applied values(?,?,'Waiting',?);");
					pstmt1.setString(1,project_id);
					pstmt1.setString(2,student_id);
					pstmt1.setString(3,sop);
					pstmt1.executeUpdate();
					RequestDispatcher rd = getServletContext().getRequestDispatcher("/student_browse.jsp");
		            PrintWriter out = response.getWriter();
		            out.println("<font id= \"USEFORSWAL\" color=red>Finalized Succesfully! .</font>\n");
		            rd.include(request, response);
				}
	        } catch(SQLException sqle){
				System.out.println("SQL exception when inserting project");
			}
	        finally{
				closeConnection(connection);
			}
	        
	 
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
