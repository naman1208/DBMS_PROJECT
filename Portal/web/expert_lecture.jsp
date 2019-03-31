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
        String msg="";
        String tid = session.getAttribute("tid").toString();
        String para = request.getParameter("tid");
        if(!((tid).equalsIgnoreCase(para)))
        {
            response.sendError(404,"Session logged in as "+tid);
        }
        if(request.getParameter("b2")!=null)
        {
            stmt=con.prepareStatement("Insert into ExpertLecture values(?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            
            
            stmt.executeUpdate();
            msg="Expert form Complete";
            
            response.sendRedirect("expert_lecture.jsp?tid="+tid);
        }
        else if(request.getParameter("b1")!=null)
        {
            stmt=con.prepareStatement("Insert into ExpertLecture values(?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            
            
            stmt.executeUpdate();
            msg="Expert form Complete";
            
            response.sendRedirect("teacher.jsp?tid="+tid);
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
            <form method="post" action=expert_lecture.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">Expert Lecture Form</th>
                    </tr>
                    
                    <br>
                    <tr>
                        <td>Teacher ID:</td><td><input type="text" name="t0" value="<%= tid %>" id="t0" readonly="true"></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                     <tr>
                        <td>Role:</td><td><input type="text" name="t1" id="t1" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Topic:</td><td><input type="text" name="t2" id="t2" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Location:</td><td><input type="text" name="t3" id="t3" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Starting Year:</td><td><input type="integer" name="t4" id="t4" ></td><td></td>
                    </tr><tr>
                        <td>Ending Year:</td><td><input type="integer" name="t5" id="t5" ></td><td></td>
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

