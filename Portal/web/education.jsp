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
        PreparedStatement stmt,select,delete;
        ResultSet rs,rs2,rs3;
        int p,q,r;
        String tid = session.getAttribute("tid").toString();
        select = con.prepareStatement("Select * from Education where TID = '"+tid+"'");
        rs2 = select.executeQuery();
        String para = request.getParameter("tid");
        if(!((tid).equalsIgnoreCase(para)))
        {
            response.sendError(404,"Session logged in as "+tid);
        }
        if(request.getParameter("b2")!=null)
        response.sendRedirect("teacher.jsp?tid="+tid);
        
        else if(request.getParameter("b1")!=null)
        {
            
            delete = con.prepareStatement("Delete from Education where TID='"+tid+"';");
            int i = delete.executeUpdate();
            
            
            String t2 =request.getParameter("t2");
            String t4 =request.getParameter("t4");
            String t6 =request.getParameter("t6");
            if(t2.equalsIgnoreCase(""))
                p=0;
            else
                p = Integer.parseInt(t2);
            if(t4.equalsIgnoreCase(""))
                q=0;
            else
                q= Integer.parseInt(t4);
            if(t6.equalsIgnoreCase(""))
                r=0;
            else
                r= Integer.parseInt(t6);
        
            stmt=con.prepareStatement("Insert into Education values(?,?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setInt(3, p);
            stmt.setString(4,request.getParameter("t3"));
            stmt.setInt(5, q);
            stmt.setString(6,request.getParameter("t5"));
            stmt.setInt(7, r);
            
            
            stmt.executeUpdate();
            
            response.sendRedirect("teacher.jsp?tid="+request.getParameter("t0"));
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
        <title>Education Form</title>
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
            <form method="post" action=education.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">Education Form</th>
                    </tr>
                    <%while(rs2.next()){%>
                    <br>
                    <tr>
                        <td>Teacher ID:</td><td><input type="texts" name="t0" id="t0" style="width: 420px;" value=<%=tid%> readonly=""></td><td style="width:150px"><div id="d1"></div></td>
                    </tr>
                    <tr>
                        <td>Undergraduate:</td><td><textarea rows="3" cols="50" name="t1" id="t1" ><%=rs2.getString(2)%></textarea></td><td></td>
                    </tr>
                    <tr>
                        <td>Year:</td><td><input type="integer" value="<%=rs2.getString(3)%>" style="width: 420px;" name="t2" id="t2" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Post Graduate:</td><td><textarea rows="3" cols="50" name="t3" id="t3"><%=rs2.getString(4)%></textarea></td><td></td>
                    </tr>
                    <tr>
                        <td>Year:</td><td><input type="integer" name="t4" value="<%=rs2.getString(5)%>" style="width: 420px;" id="t4" nullable="true"></td><td></td>
                    </tr>
                     <tr>
                         <td>Phd:</td><td><textarea rows="3" cols="50" name="t5" id="t5"><%=rs2.getString(6)%></textarea></td><td></td>
                    </tr>
                    <tr>
                        <td>Year:</td><td><input type="integer" value="<%=rs2.getString(7)%>" style="width: 420px;" name="t6" id="t6" ></td><td></td>
                    </tr>

                    <tr>
                        <td></td><td><input type="submit" value="Submit" name="b1" id="b1" ></td><td></td>
                    </tr>
                    <tr>
                        <td></td><td><input type="submit" value="Cancel/Skip" name="b2" id="b2" ></td><td></td>
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
        <% } %>
    </body>
</html>

