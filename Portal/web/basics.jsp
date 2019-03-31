<%-- 
    Document   : index
    Created on : Jun 30, 2018, 9:24:54 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"  %>
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
        
        stmt = con.prepareStatement("Select * from Teacher where tid='"+tid+"'");
        rs = stmt.executeQuery();
        
        if(request.getParameter("b2")!=null)
        {
            response.sendRedirect("teacher.jsp?tid="+tid);
        }
        
        else if(request.getParameter("b1")!=null)
        {
            stmt=con.prepareStatement("Update Teacher set Name = ? , Email = ?, Mobile = ?, Designation = ?, PermAddress = ?, CorrAddress = ?, DOB = ? where tid='"
                    +request.getParameter("t0")+"'");
            
            stmt.setString(1,request.getParameter("t4"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t6"));
            stmt.setString(4,request.getParameter("t7"));
            stmt.setString(5,request.getParameter("t8"));
            stmt.setString(6,request.getParameter("t9"));
            stmt.setString(7,request.getParameter("t5"));
            stmt.executeUpdate();
            
            msg="Basic Details Update";
            
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
                s=document.getElementById("t1").value;
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
                tt4=document.getElementById("t4");
                tt5=document.getElementById("t5");
                tt6=document.getElementById("t6");
                tt7=document.getElementById("t7");
                tt8=document.getElementById("t8");
                tt9=document.getElementById("t9");
                if(tt1.value=="")
                {
                    alert("User name is Compulsory!!");
                    tt1.focus();
                    return false;
                }
                if(tt11.value!=tt10.value)
                {
                    alert("Invalid Captch Text!!!");
                    tt10.focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <img src="Images/Banner.jpg" width="100%"><hr>
        <div id="d1" style="width:100%;height:350px;">
            <form method="post" action=basics.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">Basic Details Form</th>
                    </tr>
                    <% while(rs.next()) { %>
                    <br>
                    <tr>
                        <td>Teacher ID:</td><td><input type="tid" name="t0" id="t0" value="<%= rs.getString(1) %>" readonly="true"></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                    <tr>
                        <td>Email:</td><td><input type="email" name="t1" id="t1" onBlur="checkUser()" value="<%= rs.getString(3)%>"></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                    
                    <tr>
                        <td>Name:</td><td><input type="text" name="t4" id="t4"  value="<%= rs.getString(2)%>"></td><td></td>
                    </tr>
                    <tr>
                         <td>Date of Birth:</td><td><input type="date" id="t5" name="t5"value="<%= rs.getString(8)%>" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Mobile:</td><td><input type="bigint" name="t6" id="t6" value="<%= rs.getString(4)%>"></td><td></td>
                    </tr>
                    <tr>
                         <td>Designation:</td><td><input type="text" id="t7" name="t7" value="<%= rs.getString(5)%>"></td><td></td>
                    </tr>
                    <tr>
                         <td>Permanent Addr.:</td><td><input type="text" id="t8" name="t8" value="<%= rs.getString(6)%>" ></td><td></td>
                    </tr>
                    <tr>
                         <td>Correspondence Addr.:</td><td><input type="text" id="t9" name="t9" value="<%= rs.getString(7)%>"></td><td></td>
                    </tr>
                    
                    <tr>
                        <td></td><td><input type="submit" value="Update Changes" name="b1" id="b1" onClick="return verifyData()"></td><td></td>
                    </tr>
                    <tr>
                        <td></td><td><input type="submit" value="Cancel" name="b2" id="b2" ></td><td></td>
                    </tr>
                </table>
            </form>
        </div>
        <% } %>
        <br>
        <hr>
        <div>
            <center>All Rights Reserved</center>
            <center><address>Copyright 2019</address></center>
        </div>
    </body>
</html>

