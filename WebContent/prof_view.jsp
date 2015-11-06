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
		<noscript>
			<link rel="stylesheet" href="css/skel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-desktop.css" />
		</noscript>
	</head>
	<body class="homepage">

			<div id="header-wrapper">
				<div id="logoseperator">
				<div id="header" class="container">
						<h2 style="float: left"><strong><font size="6em">Welcome</font></strong></h2>
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
								<li><a class="icon fa-home" href="prof_view.jsp"><span><strong>View Projects</strong></span></a></li>
								<li><a class="icon fa-institution" href="prof_float.jsp"><span>Float Projects</span></a></li>
								<li><a class="icon fa-institution" href="prof_final.jsp"><span>Finalise List</span></a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			
			<div id="main-wrapper">
				<div id="main" class="container">
					<div id="content">

						<!-- Post -->
							<article class="box post">
								<!-- Needs to have which project are published and their corresponding SOP -->
								<%
								ResultSet rs=ViewProjectServlet.getProjects(userName);
								while (rs.next()){
									String student_id=rs.getString(1);
									String depatment =rs.getString(2);
									String cpi =rs.getString(3);
									String student_name =rs.getString(4);
									String project_id =rs.getString(7);
									String status  =rs.getString(8);
									String project_name =rs.getString(10);
									String description =rs.getString(11);
									String vacancies =rs.getString(12);
									String  total_slots =rs.getString(13);
									String  interval =rs.getString(13);
									String year =rs.getString(14);
									String apply_by  =rs.getString(15);
									boolean hard=ViewProjectServlet.checkHard(project_id, student_id);
									boolean soft=ViewProjectServlet.checkSoft(project_id, student_id);
									
								}
								%>
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
