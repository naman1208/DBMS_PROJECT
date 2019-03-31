<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
            stmt=con.prepareStatement("Insert into Chapters values(?,?,?,?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            stmt.setString(7,request.getParameter("t6"));
            stmt.setString(8,request.getParameter("t7"));
            stmt.setString(9,request.getParameter("t8"));
            
            
            stmt.executeUpdate();
            msg="Expert form Complete";
            
            response.sendRedirect("chapters.jsp?tid="+tid);
        }
        else if(request.getParameter("b1")!=null)
        {
            stmt=con.prepareStatement("Insert into Chapters values(?,?,?,?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            stmt.setString(7,request.getParameter("t6"));
            stmt.setString(8,request.getParameter("t7"));
            stmt.setString(9,request.getParameter("t8"));
            
            
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
            <form method="post" action=chapters.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">Books Chapters Form</th>
                    </tr>
                    
                    <br>
                    <tr>
                        <td>Teacher ID:</td><td><input type="text" name="t0" value="<%= tid %>" id="t0" readonly="true"></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                     <tr>
                        <td>Book Title:</td><td><input type="text" name="t1" id="t1" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Chapters:</td><td><input type="text" name="t2" id="t2" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Co-Authors:</td><td><input type="text" name="t3" id="t3" ></td><td></td>
                    </tr>
                    <tr>
                        <td>ISBN No.:</td><td><input type="text" name="t4" id="t4" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Publisher:</td><td><input type="text" name="t5" id="t4" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Page Start:</td><td><input type="text" name="t6" id="t4" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Page End:</td><td><input type="text" name="t7" id="t4" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Year:</td><td><input type="number" name="t8" id="t5" ></td><td></td>
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

