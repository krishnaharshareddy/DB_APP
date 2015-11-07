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
 * Servlet implementation class FinalizeProjectServlet
 */
@WebServlet("/FinalizeProjectServlet")
public class FinalizeProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FinalizeProjectServlet() {
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
	        String project_id = request.getParameter("project_id");
	        String xstudent_number = request.getParameter("student_number");
	        int student_number = Integer.parseInt(xstudent_number);
	        if(student_number==0)
	        {
	        	 RequestDispatcher rd = getServletContext().getRequestDispatcher("/prof_view.jsp");
	             PrintWriter out = response.getWriter();
	             out.println("<font id='USEFORSWAL_FAIL' color=red>Cannot finalize empty project! .</font>\n");
	             rd.include(request, response);
	        }
	        else
	        {
		        Connection connection = null;
		        try{
					connection=getConnection();
					for(int i=0;i<student_number;i++)
					{
						String stud=i+"";
						String student_id = request.getParameter(project_id+"_student_id_"+stud);
						String student_marked = request.getParameter(project_id+"_student_marked_"+stud);
						System.out.println(student_marked);
						if(student_marked!=null)
						{
							PreparedStatement pstmt1= connection.prepareStatement("update applied set status = 'Accepted' where project_id=? and student_id=?;");
							pstmt1.setString(1,project_id);
							pstmt1.setString(2,student_id);
							pstmt1.executeUpdate();
						}
						else
						{
							PreparedStatement pstmt1= connection.prepareStatement("update applied set status = 'Rejected' where project_id=? and student_id=?;");
							pstmt1.setString(1,project_id);
							pstmt1.setString(2,student_id);
							pstmt1.executeUpdate();
						}
					}
		        } catch(SQLException sqle){
					System.out.println("SQL exception when inserting project");
				}
		        finally{
					closeConnection(connection);
				}
		        RequestDispatcher rd = getServletContext().getRequestDispatcher("/prof_final.jsp");
	            PrintWriter out = response.getWriter();
	            out.println("<font id='USEFORSWAL_ADD' color=red>Finalized Succesfully! .</font>\n");
	            rd.include(request, response);
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
