<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>

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
    ResultSet rs,rs2,rs3,rs4,rs5,rs6,rs7;
    String msg="";
    int no=0,count=0,p=0,k=0,i=0;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="",year="";
    
    
    Set<Integer> a = new HashSet<Integer>();
    
    
    
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    stmt = con.prepareStatement("select Name from Teacher order by Name asc");
    rs = stmt.executeQuery();
    
    stmt = con.prepareStatement("select distinct Year from  Books");
    rs2 = stmt.executeQuery();

    while(rs2.next())
    {
            a.add(rs2.getInt(1));
    }
        
    
    
    stmt = con.prepareStatement("select distinct Year from  Chapters");
    rs3 = stmt.executeQuery();

    while(rs3.next())
    {
            a.add(rs3.getInt(1));
    }
        
    
    
    stmt = con.prepareStatement("select distinct Year from  Journals");
    rs4 = stmt.executeQuery();

    while(rs4.next())
    {
            a.add(rs4.getInt(1));
    }
      
    rs4 = stmt.executeQuery();
    
    stmt = con.prepareStatement("select distinct Type from  Journals");
    rs5 = stmt.executeQuery();
    
    stmt = con.prepareStatement("select distinct year(Start_date) from  Conferences order by "
            + "year(Start_date) asc");
    rs7 = stmt.executeQuery();
    
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
        
  
            table, th, td {
                border: 1px solid black;
                padding: 15px;
                text-align: center;
            }

            table {
                background-color: #f1f1c1;
                border-spacing: 5px;
            }
                
            </style>
        
    </head>
    <body>
        <jsp:include page="admin.jsp" />
        <div class="main">
            <h3> Publications</h3>
            <table style="width: 40%;"> 
                    
                    <tr>
                        <th>Year</th>
                        <th>No of Books </th> 
                        <th>No of Book Chapters</th>
                        <th>No of Journals </th>
                    </tr>
                    
                    <% Iterator iter = a.iterator();
                    while (iter.hasNext()) { String q = iter.next().toString();%>
                        
                    
                    <tr>
                        <td><%=q %></td>
                        <%stmt = con.prepareStatement("select count(distinct ISBN) from Books where Year = ?");
                            stmt.setString(1, q);
                            rs4 = stmt.executeQuery();
                          if(rs4.next()){ 
                          do{%>
                            
                        <td><%= rs4.getString(1) %></td><% }while(rs4.next()); } else {%>
                        <td>Nil</td>
                        <% }
                        stmt = con.prepareStatement("select count(distinct ISBN) from Chapters where Year = ?");
                            stmt.setString(1, q);
                            rs4 = stmt.executeQuery();
                          if(rs4.next()){ 
                          do{%>
                            
                        <td><%= rs4.getString(1) %></td><% }while(rs4.next()); } else {%>
                        <td>Nil</td>
                        <% } 
                        
                         stmt = con.prepareStatement("select count(distinct ISBN) from Journals where Year = ?");
                            stmt.setString(1, q);
                            rs4 = stmt.executeQuery();
                          if(rs4.next()){ 
                          do{%>
                            
                        <td><%= rs4.getString(1) %></td><% }while(rs4.next()); } else {%>
                        <td>Nil</td>
                        <% } %>
                    </tr>
                    <% } %>
                    
                    </br>
                           
            </table>
                    <hr>
                    <br>
                    <table  style="width: 40%">
                        <caption>Conferences Type-wise</caption>
                        <tr>
                            <th>Year</th>
                            <th>No. of International Conferences</th>
                            <th>No. of National Conferences</th>
                            
                        </tr>
                        <% 
                        while (rs7.next()) { %>
                        <tr>
                            <td><%=rs7.getString(1) %></td>
                            <% stmt = con.prepareStatement("select distinct Type from  Conferences order  by Type");
                            rs5 = stmt.executeQuery();
                            while(rs5.next()){
                             stmt = con.prepareStatement("select count(distinct ISBN) from  Conferences where Type=? and year(Start_date)= ?");
                             stmt.setString(1, rs5.getString(1));
                             stmt.setString(2, rs7.getString(1));
                             rs6 = stmt.executeQuery();
                             while(rs6.next()){ %>
                             <td><%=rs6.getString(1)%></td><% } } %>
                            
                        </tr>
                        
                        <% } %>
                    </table>  
                    <hr><br>
                    <table  style="width: 40%">
                        <caption>Journals Type-wise</caption>
                        <tr>
                            <th>Year</th>
                            <% stmt = con.prepareStatement("select distinct Type from  Journals");
                            rs5 = stmt.executeQuery();
                            while(rs5.next()) {%>
                            <th>No. of <%=rs5.getString(1)%> Journals</th>
                            <% }  %>
                        </tr>
                        <% stmt = con.prepareStatement("select distinct Year from  Journals order by Year asc");
                            rs4 = stmt.executeQuery();
                        while (rs4.next()) { %>
                        <tr>
                            <td><%=rs4.getString(1) %></td>
                            <% stmt = con.prepareStatement("select distinct Type from  Journals");
                            rs5 = stmt.executeQuery();
                            while(rs5.next()){
                             stmt = con.prepareStatement("select count(distinct ISBN) from  Journals where Type=? and Year= ?");
                             stmt.setString(1, rs5.getString(1));
                             stmt.setString(2, rs4.getString(1));
                             rs6 = stmt.executeQuery();
                             while(rs6.next()){ %>
                             <td><%=rs6.getString(1)%></td><% } } %>
                            
                        </tr>
                        
                        <% } %>
                    </table>
                    <hr><br>
        </div>
    </body>
    
</html>




                         