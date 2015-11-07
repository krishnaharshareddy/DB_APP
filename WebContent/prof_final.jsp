<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="loginprof.ViewProjectServlet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<%
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
        %>
		<title>STUDENT LOGIN FORM</title>
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
	<body class="homepage">
			<script>
				var myElem = document.getElementById('USEFORSWAL_ADD');
				if (myElem !== null) swal('Finalized Successfully!','You can look at the status here','success');
			</script>
			<div id="header-wrapper">
				<div id="logoseperator">
				<div id="header" class="container">
						<h2 style="float: left"><strong><font size="6em">Project Application Form</font></strong></h2>
						<form style="float: right" action="ProfLogoutServlet" method="post">
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
								<li><a class="icon fa-home" href="prof_view.jsp"><span>View Projects</span></a></li>
								<li><a class="icon fa-institution" href="prof_float.jsp"><span>Float Projects</span></a></li>
								<li><a class="icon fa-institution" href="prof_final.jsp"><span><strong>Finalise List</strong></span></a></li>
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
								ResultSet rs=ViewProjectServlet.getProjects(userName);
								while (rs.next()){
									String project_id=rs.getString(1);
									String project_name=rs.getString(2);
									String project_desc=rs.getString(3);
									String project_vacancies=rs.getString(4);
									String project_total_slots=rs.getString(5);
									String project_interval=rs.getString(7);
									String project_year=rs.getString(8);
									String project_apply_by=rs.getString(9);
									java.sql.Date applydate=rs.getDate(9);
									java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
									boolean finalized = ViewProjectServlet.checkFinalized(project_id);
									if(finalized)
									{
										out.println("<hr> <h1>Project ID: "+project_id+"</h1>  "+"<strong>Project Name: </strong>"+project_name+"<br>"+"<strong>Project Description: </strong>"+project_desc+"<br>");
										out.println("<strong>Vacancies: </strong>"+project_vacancies+"  "+"<strong>Total Slots: </strong>"+project_total_slots+"  "+"<strong>Interval: </strong>"+project_interval+"  ");
										out.println("<strong>Year: </strong>"+project_year+"  "+"<br> <br>");
										ResultSet students = ViewProjectServlet.getStudentList(project_id);
										int student_count=0;
										while(students.next())
										{
											String student_id=students.getString(1);
											String student_department=students.getString(2);
											String student_cpi=students.getString(3);
											String student_name=students.getString(4);
											String student_status=students.getString(8);
											String student_sop=students.getString(9);
											boolean hard=ViewProjectServlet.checkHard(project_id, student_id);
											boolean soft=ViewProjectServlet.checkSoft(project_id, student_id);
											String student_counts=""+student_count;
											out.println("<strong>Name: </strong>"+student_name+"   "+"<strong>Department: </strong>"+student_department);
											out.println("<strong>   CPI: </strong>"+student_cpi+"   "+"<strong>Status: </strong>"+student_status);
											out.println("<br>");
											student_count++;
										}
										
									}
									
									
									
								}
								
								%>
								</form>
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
