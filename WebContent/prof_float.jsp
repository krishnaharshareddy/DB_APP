<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
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
		<title>Floating Form</title>
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
				var myElem = document.getElementById('USEFORSWAL');
				if (myElem !== null) swal('Added Successfully!','You can see the added project in the View Projects Section','success');
			</script>
			<script>
				var myElem = document.getElementById('USEFORSWAL_YEAR');
				if (myElem !== null) swal('Year error','The project\'s deadline is after the year of the project','error');
			</script>
			<div id="header-wrapper">
				<div id="logoseperator">
				<div id="header" class="container">
						<h2 style="float: left"><strong><font size="6em">Project Floating Form</font></strong></h2>
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
								<li><a class="icon fa-institution" href="prof_float.jsp"><span><strong>Float Projects</strong></span></a></li>
								<li><a class="icon fa-institution" href="prof_final.jsp"><span>Finalise List</span></a></li>
								
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
								<form action="AddProjectServlet" id="usrform" method="post">
								  Project Name:<br>
								  <input type="text" name="ProjectName" value="">
								  <br>
								  Project Description:<br>
								  <textarea rows="4" cols="50" name="ProjectDescription" form="usrform" value=""></textarea>
								  <br>
								  Add Hard Prerequisite: (Use ; to add more) <br>
								  <input type="text" name="HardPrerequisite" value="">
								  <br>
								  Add Soft Prerequisite: (Use ; to add more) <br>
								  <input type="text" name="SoftPrerequisite" value="">
								  <br>
								  Interval:<br>
								  <select name="Interval">
								  <option value="Spring">Spring</option>
								  <option value="Fall">Fall</option>
								  <option value="Winter">Winter</option>
								  <option value="Summer">Summer</option>
								  </select>
								  <br>
								  Year:<br>
								  <input type="number" name="Year" value="" min="2014" max="2020">
								  <br>
								 Maximum Applications to consider:<br>
								  <input type="number" name="OpenPositions" value="" min="1" max="100">
								  <br>
								  Apply by date:<br>
								  <input type="date" name="Date">
								  <br><br>
								  <input type="submit" value="Submit">
								  
								  
								</form>
							</article>
					
					</div>
				</div>
			</div>

	</body>
</html>
