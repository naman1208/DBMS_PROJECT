<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="logout.jsp"%>

<%@page import="java.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
        Class.forName("com.mysql.jdbc.Driver");
        Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/portal", "root", "");
        PreparedStatement stmt;
        ResultSet rs;
        String tid = session.getAttribute("tid").toString();
        String para = request.getParameter("tid");
        if(!((tid).equalsIgnoreCase(para)))
        {
            response.sendError(404,"Session logged in as "+tid);
        }
        if(request.getParameter("b1")!=null)
        {
            stmt = c.prepareStatement("Insert into MtechThesis values(?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            
            stmt.executeUpdate();
           
            response.sendRedirect("teacher.jsp?tid="+tid);
            
        }
        else if(request.getParameter("b2")!=null)
        {
            stmt = c.prepareStatement("Insert into MtechThesis values(?,?,?,?,?,?)");
            stmt.setString(1,request.getParameter("t0"));
            stmt.setString(2,request.getParameter("t1"));
            stmt.setString(3,request.getParameter("t2"));
            stmt.setString(4,request.getParameter("t3"));
            stmt.setString(5,request.getParameter("t4"));
            stmt.setString(6,request.getParameter("t5"));
            
            stmt.executeUpdate();
           
            response.sendRedirect("mtech.jsp?tid="+tid);
            
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
        <title>M.Tech Form</title>
        
    </head>
    <body>
        <img src="Images/Banner.jpg" width="100%"><hr>
        <div id="d1" style="width:100%;height:350px;">
            <form method="post" action=mtech.jsp?tid=<%=tid%>>
                <table align="center">
                    <tr>
                        <th colspan="3">M.Tech Students Form</th>
                    </tr>
                    
                    <br>
                    <tr>
                        <td>Supervisor ID:</td><td><input type="text" name="t0" id="t0" value = "<%=tid%>" readonly="true"></td><td></td>
                    </tr>
                     <tr>
                        <td>Enrollment No.:</td><td><input type="text" name="t1" id="t1" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Name:</td><td><input type="text" name="t2" id="t2" ></td><td></td>
                    </tr>
                    
                    <tr>
                        <td>Title:</td><td><input type="text" name="t3" id="t3" ></td><td></td>
                    </tr>
                    <tr>
                        <td>Start Year:</td><td><input type="number" name="t4" id="t4" ></td><td></td>
                    </tr>
                    <tr>
                        <td>End Year:</td><td><input type="number" name="t5" id="t5" ></td><td></td>
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
    