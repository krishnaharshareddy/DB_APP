<%@page import="loginprof.FinalizeProjectServlet"%>
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
		<script type = "text/javascript">
		function displaysop(s) {
			document.getElementById("sop_section").innerHTML=s;
		}
		

		</script>
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
				var myElem = document.getElementById('USEFORSWAL_DEL');
				if (myElem !== null) swal('Deleted Successfully!','Deleted the project from database','success');
			</script>
			<script>
				var myElem = document.getElementById('USEFORSWAL_FAIL');
				if (myElem !== null) swal('Cannot finalize a list with no one','Please delete the project if you wish to','error');
			</script>
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
								<div style="width: 100%; float: left">
								<!-- Needs to have which project are published and their corresponding SOP -->
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
									
									if(!finalized)
									{
										out.println("<hr> <h1>Project ID: "+project_id+"</h1>  "+"<strong>Project Name: </strong>"+project_name+"<br>"+"<strong>Project Description: </strong>"+project_desc+"<br>");
										out.println("<strong>Vacancies: </strong>"+project_vacancies+"  "+"<strong>Total Slots: </strong>"+project_total_slots+"  "+"<strong>Interval: </strong>"+project_interval+"  ");
										out.println("<strong>Year: </strong>"+project_year+"  "+"<strong>Apply by Date: </strong>"+project_apply_by+"  " +"<br> <br>");
										ResultSet students = ViewProjectServlet.getStudentList(project_id);
										int student_count=0;
										out.println("<form action=\"FinalizeProjectServlet\" id=\"usrform\" method=\"post\">");
										out.println("<input type='hidden' value='"+project_id+"' name='project_id'>");
										out.println("<table><tr><td><strong>Check</td><td><strong>Name</td><td><strong>Dept.</td><td><strong>CPI</td><td><strong>Status</td><td><strong>Hard Prerequisites</td><td><strong>Soft Prerequisites</td><td><strong>Statement of purpose</td></tr>");
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
											if(student_count<Integer.parseInt(project_total_slots))
											{
												out.println("<input type='hidden'  value='"+student_id+"' name='"+project_id+"_student_id_"+student_counts+"' />");
												out.println("<tr><td><input type='checkbox'  value=\"false\" onchange='if(this.checked) this.value=\"true\"; else this.value=\"false\";' name='"+project_id+"_student_marked_"+student_counts+"' />");
												out.println("<td>"+student_name+"</td><td>"+student_department);
												out.println("</td><td>"+student_cpi+"</td><td>"+student_status);
												if(hard) out.println("</td><td>&#10004");
												else out.println("</td><td>&#10008");
												if(soft) out.println("</td><td>&#10004");
												else out.println("</td><td>"+"&#10008");
												//out.println("<a href= ><input class='myButton' type='myButton'  value='See SOP' onClick=\"displaysop('"+student_sop+"')\"></a> <br> <br>");
												out.println("</td><td><a href=\"javascript:swal('"+student_name+"','"+student_sop+"')\"><input class='myButton' type='myButton' value='See SOP'></input></a></td></tr>");
											}
											else
											{
												out.println("<input type='hidden'  value='"+student_id+"' name='"+project_id+"_student_id_"+student_counts+"' />");
												out.println("<input style='visibility: hidden;' type='checkbox'  value=\"false\" onchange='if(this.checked) this.value=\"true\"; else this.value=\"false\";' name='"+project_id+"_student_marked_"+student_counts+"' />");
											}
												student_count++;
										}
										out.println("</table>");
										out.println("<div style='float: left'>");
										out.println("<input type='hidden' value='"+student_count+"' name='student_number'>");
										if(applydate.compareTo(date)<0)
										{
											out.println("<input type='submit' value='Finalize Project'>");
										}
										out.println("</form>");
										out.println("</div>");
										out.println("<div style='float: right'>");
										out.println("<form action=\"DeleteProjectServlet\" id=\"usrform\" method=\"post\">");
										out.println("<input type='hidden' value='"+project_id+"' name='project_id'>");
										out.println("<input type='submit' value='Delete Project'>");
										out.println("</form>");
										out.println("</div>");
										out.println("<br><br>");
									}
									
									
									
								}
								
								%>
								</div>
								
								
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
