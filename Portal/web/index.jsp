
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
//    session.removeAttribute("tid");
//    session.removeAttribute("pass");
//    session.invalidate();
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/portal", "root", ""); 
    PreparedStatement ps,front;
    ResultSet rs,rs2;
    Thread t;
    
    if(request.getParameter("b1")!=null)
    {
     ps = c.prepareStatement("select TID,UserPass from UserLogin where TID=? and UserPass=? and Type='Teacher'");
	ps.setString(1, un);
	ps.setString(2, pw);
 
	rs = ps.executeQuery();
        
        if (rs.next()) {
            
            out.println("You r successfully logged in");  
            session.setAttribute("tid",un);
            session.setAttribute("pass", pw);
            response.sendRedirect("teacher.jsp?tid="+un);
            
        }
    }
    
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <img src="Images/Banner.jpg" width="100%"><hr>
        <div id="d1" style="width:100%;height:350px;">
        <table>
            <tr>
                <td><img src="Images/I1.jpg"></td><td>
                    <form method="post" action="index.jsp">
                    <table>
                        <tr>
                            <td>Login ID</td><td><input type="text" name="t1" id="t1"></td><td></td>
                        </tr>
                        <tr>
                            <td>Password:</td><td><input type="password" id="t2" name="t2"></td><td></td>
                        </tr>
                        <tr>
                            <td></td><td><input type="submit" id="b1" name="b1" value="Login"> 
                            <a href="admin_login.jsp">Admin Login</a></td><td></td>
                        </tr>
                    </table></form>
                </td>
                <td><img src="Images/I3.jpg"></td>
                <td><h2>First Login with correct TID and Password</h2></td>
            </tr>
        </table>
        </div><hr>
    <div>
        <center>All Rights Reserved</center>
        <center><address>Copyright 2019</address></center>
    </div>
    
        <script>
        (function (global) {

            if(typeof (global) === "undefined")
            {
                    throw new Error("window is undefined");
            }

            var _hash = "!";
            var noBackPlease = function () {
                global.location.href += "#";

                        // making sure we have the fruit available for juice....
                        // 50 milliseconds for just once do not cost much (^__^)
                global.setTimeout(function () {
                    global.location.href += "!";
                }, 50);
            };

                // Earlier we had setInerval here....
            global.onhashchange = function () {
                if (global.location.hash !== _hash) {
                    global.location.hash = _hash;
                }
            };

            global.onload = function () {

                    noBackPlease();

                    // disables backspace on page except on input fields and textarea..
                    document.body.onkeydown = function (e) {
                var elm = e.target.nodeName.toLowerCase();
                if (e.which === 8 && (elm !== 'input' && elm  !== 'textarea')) {
                    e.preventDefault();
                }
                // stopping event bubbling up the DOM tree..
                e.stopPropagation();
            };

            };

        })(window);
        </script>
    

</body>

        
</html>
