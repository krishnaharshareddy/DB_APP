<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="loginprof.StudentStatusServlet" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Welcome</title>
		<link rel="shortcut icon" href="images/iitblogo.jpg">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.dropotron.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-layers.min.js"></script>
		<script src="js/init.js"></script>
		<script src="sweetalert-master/dist/sweetalert.min.js"></script> 
  		<script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
		<link rel="stylesheet" type="text/css" href="sweetalert-master/dist/sweetalert.css">
		<noscript>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-desktop.css" />
		</noscript>
	</head>
	<%
            String userName = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("StudentUser"))
                        userName = cookie.getValue();
                }
            }
            if (userName == null)
                response.sendRedirect("student.html");
        %>
	<body class="homepage">

			<div id="header-wrapper">
				<div id="logoseperator">
				<div id="header" class="container">
						<h2 style="float: left"><strong><font size="6em">Project Status</font></strong></h2>
						<form style="float: right" action="StudentLogoutServlet" method="post">
			            <input type="submit" value="Logout">
			        	</form>
					</div>
				</div>
			</div>
			
			
			<div id="header-wrapper">
				
						<div id="seperator">		
				<div id="header" class="container">
						
					<!-- Nav -->
						<nav id="nav">
							<ul>
								<li><a class="icon fa-home" href="student_browse.jsp"><span>View Projects</span></a></li>
								<li><a class="icon fa-institution" href="student_status.jsp"><span><strong>Check Status</strong></span></a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			
			
			
		<!-- Main -->
			<div id="main-wrapper">
				<div id="main" class="container">
					<div id="content">

						<!-- Post -->
							<article class="box post">
								<form action="action_page.php">
								   <%
								  ResultSet rs = StudentStatusServlet.getStatus(userName);
								   out.println("<table border='1'>");
								   out.println("<td> <strong>Project ID</strong> </td> <td> <strong>Project Name</strong> </td> <td> <strong>Status</strong> </td> <td> <strong>Interval</strong> </td> <td> <strong>Year</strong> </td> <td> <strong>Under guidance of</strong> </td> ");
								  while(rs.next()) {
									  String project_id = rs.getString(1);
									  String project_name = rs.getString(5);
									  String status = rs.getString(3);
									  String interval = rs.getString(10);
									  String year = rs.getString(11);
									  String prof_name = rs.getString(14);
									  out.println("<tr> <td> <strong>"+project_id+"</strong></td> <td> "+project_name+"</td> <td> "+status+"</td> <td>"+interval+"</td> <td>"+year+"</td> <td> "+prof_name+"</td> </tr> <br>");
								  }
								  out.println("</table>");
								  %>
								</form>
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
