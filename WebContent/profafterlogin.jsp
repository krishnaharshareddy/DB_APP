<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Crunchify - Login Successful - Session management by
    Cookies</title>
<style type="text/css">
body {
    background-image: url('http://crunchify.com/bg.png');
}
</style>
</head>
 
<body>
    <div align="center">
        <br> <br>
 
        <%
            String userName = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("crunchifyUser"))
                        userName = cookie.getValue();
                }
            }
            if (userName == null)
                response.sendRedirect("crunchify-login.html");
        %>
        <h3>
            Hi
            <%=userName%>, Login successful.
        </h3>
        <br>
 
        <form action="CrunchifyLogoutServlet" method="post">
            <input type="submit" value="Logout">
        </form>
    </div>
</body>
</html>