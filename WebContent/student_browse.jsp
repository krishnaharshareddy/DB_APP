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
			<script>
				var myElem = document.getElementById('USEFORSWAL');
				if (myElem !== null) swal('Applied Successfully!','Apply to more if you would like to!','success');
			</script><script>
				var myElem = document.getElementById('USEFORSWAL_ERR');
				if (myElem !== null) swal('Choose a Project!','Click on the circle next to a project to select it','error');
			</script>
			<div id="header-wrapper">
				<div id="logoseperator">
				<div id="header" class="container">
						<h2 style="float: left"><strong><font size="6em">Browse Projects</font></strong></h2>
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
								<li><a class="icon fa-home" href="student_browse.jsp"><span><strong>View Projects</strong></span></a></li>
								<li><a class="icon fa-institution" href="student_status.jsp"><span>Check Status</span></a></li>
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
								  <%
								  ResultSet rs = StudentStatusServlet.allProjects(userName);
								  out.println("<form action=\"ApplyToProject\" id=\"usrform\" method=\"post\">");
								  out.println("<table border='1'>");
								  out.println("<tr><td> <strong>Choice</strong> </td><td> <strong>Project ID</strong> </td> <td> <strong>Project Name</strong> </td><td> <strong>Soft Prerequisites</strong> </td> <td> <strong>Interval</strong> </td> <td> <strong>Year</strong> </td> <td> <strong>Apply By</strong> </td> <td> <strong>Under guidance of</strong> </td> <td> <strong> Department </strong> </td> <td> <strong>Vacancies</strong> </td></tr>");
								 
								  while(rs.next()) {
									  String project_id = rs.getString(1);
									  String project_name = rs.getString(2);
									  String project_desc = rs.getString(3);
									  String project_vacancies = rs.getString(4);
									  String project_interval = rs.getString(7);
									  String project_year = rs.getString(8);
									  java.sql.Date applydate=rs.getDate(9);
									  String prof_name = rs.getString(11);
									  String prof_dept = rs.getString(12);
									  java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
									  boolean allowed = StudentStatusServlet.checkPrerequisites(userName, project_id,"Hard");
									  boolean finalised = StudentStatusServlet.checkFinalized(project_id);
									  if(Integer.parseInt(project_vacancies)>0 && !finalised)
									  {
										if(allowed)
									  		out.println("<tr><td><input type='radio' name='project_selected' value='"+project_id+"'></td>");
										else
											out.println("<tr><td></td>");
										out.println("<td>"+project_id+"</td>");
									  	out.println("<td><a href=\"javascript:swal('"+project_name+"','"+project_desc+"')\">"+project_name+"</td>");
									  	if(StudentStatusServlet.checkPrerequisites(userName, project_id,"Soft"))
									  		out.println("<td>&#10004</td>");
									  	else
									  		out.println("<td>&#10008</td>");
									  	out.println("<td>"+project_interval+"</td>");
									  	out.println("<td>"+project_year+"</td>");
									  	out.println("<td>"+applydate+"</td>");
									  	out.println("<td>"+prof_name+"</td>");
									  	out.println("<td>"+prof_dept+"</td>");
									  	out.println("<td>"+project_vacancies+"</td></tr>");
									  }
								  }
								  out.println("</table>");
								  out.println("Please Fill your Statement of Purpose:<br>");
								  out.println("<textarea rows=\"4\" cols=\"50\" name=\"SOP\" form=\"usrform\" value=\"\"></textarea><br>");
								  out.println("<input type='hidden' value='"+userName+"' name='student_id'>");
								  out.println("<input type='submit' value='Apply to Project'>");
								  %>
								</form>
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
