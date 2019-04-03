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
    ResultSet rs,rs2,rs3=null;
    String msg="";
    int no=0,count=0,p=0,m=0,b=0,l=0;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="";
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    stmt = con.prepareStatement("select Name from Teacher order by Name asc");
    rs = stmt.executeQuery();
 
    

    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        
        
        stmt=con.prepareStatement("select * from Education where TID=(select TID from Teacher where Name = ?)");
        stmt.setString(1, tname);
        rs3 = stmt.executeQuery();
        l=1;
        
        if(rs3.next()){
            if(!(rs3.getString(6).equalsIgnoreCase("")))
            {
                p=1;
            }
            else if(!(rs3.getString(4).equalsIgnoreCase("")))
            {
                m=1;
            }
            else
            {
                b=1;
            }
        }
        
        rs3 = stmt.executeQuery();
    }
    
    
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style>
            .main{
                margin-left: 200px;
                size: 100px;
            }
        </style>
        
    </head>
    <body>
        <jsp:include page="admin.jsp" />
        <div class="main">
        <h3>Highest Qualification</h3>    
        <form method="post" action=details.jsp?tid=<%=tid%>>    
            <label>Select Teacher :</label>
            <select name="teacher">    
        <% while(rs.next()){  %> 
       
        <option > <%=rs.getString(1)%></option>
        <%}  %>
        </select><br>
        
        <button type="submit" name="b1" id="b1" >Show</button>
        </form><br>
        
        
        <% if(l==1) {%>
        <h3>Highest Qualification of <%=tname%></h3>
        <% while(rs3.next())
        {  
            if(p==1)
            { %>
            <h4>Ph.D - <%=rs3.getString(6)%><% if(rs3.getInt(7)!=0){%> in year <%=rs3.getInt(7)%><%}%></h4>
            <% }
            else if(m==1) {%>
            <h4>PostGraduate - <%=rs3.getString(4)%><% if(rs3.getInt(5)!=0){%> in year <%=rs3.getInt(5)%><%}%></h4>
            <% }
            else {%>
            <h4>UnderGraduate - <%=rs3.getString(2)%><% if(rs3.getInt(1)!=0){%> in year <%=rs3.getInt(1)%><%}%></h4>
            <% }
        }
        } %>
        </div>
        <hr>
    </body>
</html>
