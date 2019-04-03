
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
    String un=request.getParameter("t1");
    String pw=request.getParameter("t2");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/portal", "root", ""); 
    PreparedStatement ps,front;
    ResultSet rs,rs2;
    Thread t;
    
    if(request.getParameter("b1")!=null)
    {
     ps = c.prepareStatement("select TID,UserPass from UserLogin where TID=? and UserPass=? and Type='admin'");
	ps.setString(1, un);
	ps.setString(2, pw);
 
	rs = ps.executeQuery();
        
        if (rs.next()) {
            
            out.println("You r successfully logged in");  
            session.setAttribute("tid",un);
            session.setAttribute("pass", pw);
            request.setAttribute("tid", un);
            response.sendRedirect("admin.jsp?tid="+un);
            
        }
        else
        {
             %> 
                <script type="text/javascript"> 
                if(request.getParameter("b1")!=null)    
                alert("Check Input"); 
                </script> 
            <% 
        }
    }
    
    
%>




<html>
<head>
<title>Login Page</title>
</head>
<body>
    <img src="Images/Banner.jpg" width="100%"><hr><br>
    <form name="loginForm" method="post" action="admin_login.jsp">
    <table width="50%" height="50%" bgcolor="#E6E6FA" align="center">

    <tr>
    <td colspan=2><center><font size=4><b>Admin Login Page</b></font></center></td>
    </tr>
    
    <h3><tr>
    <td><center>Admin ID:</td>
    <td><input type="text" size=25 name="t1"></td></center>
    </tr>

    <tr>
    <td><center>Password:</td>
    <td><input type="Password" size=25 name="t2"></td></center>
    </tr>
    
    <tr>
    <td ><input type="Reset"></td>
    <td><input type="Submit" value="Login" name="b1"></td>
    </h3>
    </tr>
    
    </table>
    </form>


</body>
</html>