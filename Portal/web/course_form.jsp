<%-- 
    Document   : index
    Created on : Jun 30, 2018, 9:24:54 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="logout.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>


<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
        DriverManager.registerDriver(new com.mysql.jdbc.Driver());
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost/portal","root","");
        PreparedStatement stmt;
        ResultSet rs;
        String tid = session.getAttribute("tid").toString();
        
        String para = request.getParameter("tid");
        
        if(request.getParameter("b2")!=null)
        {
            String msg=request.getParameter("t1");
            String[] s = msg.split(",");
            int i=0;
            while(i!=s.length){
            stmt=con.prepareStatement("Insert into Courses values(?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,s[i++]);
            stmt.executeUpdate();
            }
            
            response.sendRedirect("course_form.jsp?tid="+session.getAttribute("tid"));
            return;
        }
        else if(request.getParameter("b1")!=null)
        {
            String msg=request.getParameter("t1");
            String[] s = msg.split(",");
            int i=0;
            while(i!=s.length){
            stmt=con.prepareStatement("Insert into Courses values(?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,s[i++]);
            stmt.executeUpdate();
            }
            
            response.sendRedirect("teacher.jsp?tid="+session.getAttribute("tid"));
            return;
           //request.getRequestDispatcher("teacher.jsp?tid="+tid).forward(request,response); 
        }
        HttpSession hs=request.getSession(false);
        String ss="<a href='login'>Login</a>";
        if(hs!=null)
        {
            ss="<a href='logout'>Logout</a>";
        }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            var xmlhttp;
            function checkUser()
            {
                s=document.getElementById("t0").value;
                xmlhttp=new XMLHttpRequest();
                xmlhttp.onreadystatechange=showUserStatus;
                xmlhttp.open("GET","userstatus.jsp?ulogin="+s,true);
                xmlhttp.send(null);
            }
            function showUserStatus()
            {
                if(xmlhttp.readyState==4 && xmlhttp.status==200)
                {
                    reply=xmlhttp.responseText.trim();
                    if(reply=="Y")
                    {
                        document.getElementById("d1").innerHTML="This id Already Exists!!!";
                    }
                    else
                    {
                        document.getElementById("d1").innerHTML="";
                    }
                }
            }
            function verifyData()
            {
                tt0=document.getElementById("t0");
                tt1=document.getElementById("t1");
                tt2=document.getElementById("t2");
                tt3=document.getElementById("t3");
                
                
                return true;
            }
        </script>
    </head>
    <body>
        <img src="Images/Banner.jpg" width="100%"><hr>
        <div id="d1" style="width:100%;height:350px;">
            <form method="post" action=course_form.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">Courses Taught Form </th>
                    </tr>
                    
                    <br>
                    <tr>
                        <td>Teacher ID:</td><td><input type="text" name="t0" value="<%= tid %>" id="t0" readonly="true"></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                     <tr>
                         <td>Course Names: </td><td><textarea rows="3" cols="50" name="t1" id="t1"></textarea></td> 
                    </tr>
                    <tr>
                        <td>(separate by comma)</td>
                    </tr>
                    
                    
                    

                    <tr>
                        <td></td><td><input type="submit" value="Submit" name="b1" id="b1" onClick="return verifyData()"></td><td></td>
                    </tr>
                    <tr>
                        <td></td><td><input type="submit" value="Save and Add more" name="b2" id="b2" onClick="return verifyData()"></td><td></td>
                    </tr>
                </table>
            </form>
        </div>
        
        <br>
        <hr>
        <div>
            <center>All Rights Reserved</center>
            <center><address>Copyright 2019</address></center>
        </div>
    </body>
</html>

