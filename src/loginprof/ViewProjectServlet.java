package loginprof;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ViewProjectServlet
 */
@WebServlet("/ViewProjectServlet")
public class ViewProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewProjectServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static ResultSet getProjects(String userName)
	{
		Connection connection=null;
		ResultSet rs=null;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement("select * from student natural join applied,project natural join floats where applied.project_id=project.project_id and prof_id=? order by project.project_id;");
			pstmt.setString(1, userName);
			rs= pstmt.executeQuery();
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting top 5 list");
		} finally{
			closeConnection(connection);
		}
		return rs;
	}
	public static boolean checkHard(String project_id,String student_id)
	{
		Connection connection=null;
		boolean res = false;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement("select course_id as C from prerequisite where prerequisite.project_id=? and not exists ( select * from takes where takes.student_id=? and takes.course_id=prerequisite.course_id);");
			pstmt.setString(1, project_id);
			pstmt.setString(2, student_id);
			ResultSet rs= pstmt.executeQuery();
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting hard");
		} finally{
			closeConnection(connection);
		}
		return res;
	}
	public static boolean checkSoft(String project_id,String student_id)
	{
		Connection connection=null;
		boolean res = false;
		try{
			connection=getConnection();
			PreparedStatement pstmt= connection.prepareStatement("select * from student natural join applied,project natural join floats where applied.project_id=project.project_id and prof_id=? order by project.project_id;");
			pstmt.setString(1, userName);
			rs= pstmt.executeQuery();
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting top 5 list");
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

}
