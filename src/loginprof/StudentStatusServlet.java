package loginprof;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StudentStatusServlet
 */
@WebServlet("/StudentStatusServlet")
public class StudentStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentStatusServlet() {
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public static boolean checkFinalized(String project_id)
	{
		Connection connection=null;
		boolean res = false;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement("select * from applied where project_id=? and status!='Waiting';");
			pstmt.setString(1, project_id);
			ResultSet rs= pstmt.executeQuery();
			while (rs.next()){
				res=true;
			}
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when finalizing");
		} finally{
			closeConnection(connection);
		}
		return res;
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
	
	public static ResultSet allProjects(String studentId)
	{
		System.out.println("Getting Allowed Projects");
		Connection connection=null;
		ResultSet rs=null;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement(" select * from project natural join floats,professor where floats.prof_id=professor.prof_id and not exists(select * from applied where applied.project_id=project.project_id and applied.student_id=?);");
			pstmt.setString(1, studentId);
			rs= pstmt.executeQuery();
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting project list");
		} finally{
			closeConnection(connection);
		}
		return rs;
	}
	
	public static boolean checkPrerequisites(String studentId,String projectID,String prereqtype)
	{
		System.out.println("Checking Prerequisites");
		Connection connection=null;
		ResultSet rs=null;
		boolean test=true;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement(" select * from prerequisite where prerequisite.project_id=? and prerequisite.type=? and not exists(select * from takes where prerequisite.course_id=takes.course_id and takes.student_id=?);");
			pstmt.setString(1, projectID);
			pstmt.setString(2, prereqtype);
			pstmt.setString(3, studentId);
			rs= pstmt.executeQuery();
			while(rs.next())
			{
				test=false;
				break;
			}
			
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting project list");
		} finally{
			closeConnection(connection);
		}
		return test;
	}
	
	public static ResultSet getStatus(String studentId)
	{
		System.out.println("Getting Projects");
		Connection connection=null;
		ResultSet rs=null;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement(" select * from applied natural join project natural join floats,professor where professor.prof_id=floats.prof_id and applied.student_id=?;");
			pstmt.setString(1, studentId);
			rs= pstmt.executeQuery();
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting project list");
		} finally{
			closeConnection(connection);
		}
		return rs;
	}
	

}
