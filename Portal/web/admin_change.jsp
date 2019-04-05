
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
    String new_un=request.getParameter("user");
    String old_pw = request.getParameter("pswd");
    String new_pw=request.getParameter("t2");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/portal", "root", ""); 
    PreparedStatement ps,front;
    ResultSet rs,rs2;
    Thread t;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    if(request.getParameter("b1")!=null && old.equalsIgnoreCase(old_pw))
    {
     ps = c.prepareStatement("update UserLogin set TID=? , UserPass=? where Type='admin'");
	ps.setString(1, new_un);
	ps.setString(2, new_pw);
 
	ps.executeUpdate();
            
            out.println("You r successfully logged in");  
            session.setAttribute("tid",new_un);
            session.setAttribute("pass", new_pw);
            
            response.sendRedirect("admin.jsp?tid="+new_un);
    }
    else{
             %> 
                <script type="text/javascript"> 
                if(request.getParameter("b1")!=null)    
                alert("Check Input"); 
                </script> 
            <% 
        } 
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    
    

    </head>
    <body>
        <jsp:include page="admin.jsp" />
        <div class="container">
        <div class="row"><div class='logo col-xs-12 img-responsive'></div></div>
        <div class="row">
            
            <div class='col-xs-2'></div>
            <div class='form col-xs-8'>
                <h2>Change Admin</h2><br>
                <form method="post" action=admin_change.jsp?tid=<%=tid%> id="form" autocomplete="off">

                    <p>
                        <label class="greyText">New Admin Name</label><br/> 
                        <input type="text" name="user" id="user" value="" class="textboxWidth">
                    </p>


                    <p>
                        <label class="greyText">Old Password</label><br/> 
                        <input type="password" name="pswd" id="pswd">
                    </p>

                    <p>
                        <label class="greyText">Enter New Password</label><br/>
                        <input type="password" name="t2" id="t2" class="textboxWidth">
                    </p>


                    <p>
                         <button type="submit" name="b1" id="b1" >SAVE</button>'
                         <button type="reset" name="b2" id="b2" >Reset</button>
                    </p> 
                    

                </form>
            </div>
            
        </div>

    </div>
    

    </body>
</html>
