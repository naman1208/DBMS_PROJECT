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
    ResultSet rs,rs2,rs3,rs4,rs5,rs6,rs7,rs8=null;
    String msg="";
    int no=0,count=0,p=0,k=0,i=0,l=0,b=0,m=0,n=0;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="",year="",s="",e="";
    
    
    Set<Integer> a = new HashSet<Integer>();
    
    
    
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    stmt = con.prepareStatement("select Name from Teacher order by Name ");
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
    

    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        
        s = request.getParameter("syear");
        e = request.getParameter("eyear");
        
        
        if(tname.equalsIgnoreCase("All"))
        {
           if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
            {
                stmt = con.prepareStatement("select * from Journals order by Year");
                
                m=1;

            }
           else{
            stmt = con.prepareStatement("select * from Journals where "
                    + "Year >= ? and Year<= ? order by Year");
            stmt.setString(1,s);
            stmt.setString(2, e);
            
            b=1;
           
           }
        }
        
        else if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
        {
            stmt = con.prepareStatement("select * from Journals where TID=(select TID from Teacher where Name = ?) order by Year");
            stmt.setString(1,tname);
            
            l=1;
            
        }
        
        else
        {

            stmt = con.prepareStatement("select * from Journals where TID=(select TID from Teacher where Name = ?) and"
                    + " Year >= ? and Year<= ? order by Year");
            stmt.setString(1,tname);
            stmt.setString(2,s);
            stmt.setString(3, e);
            
            l=1;
            b=1;
        }
        rs8 = stmt.executeQuery();
        p=1;
    }
    

    if(request.getParameter("b2")!=null)
    {
        tname = request.getParameter("tname");
        
        s = request.getParameter("styear");
        e = request.getParameter("enyear");
        
        
        if(tname.equalsIgnoreCase("All"))
        {
           if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
            {
                stmt = con.prepareStatement("select * from Conferences order by Year(Start_date)");
                
                m=1;

            }
           else{
            stmt = con.prepareStatement("select * from Conferences where "
                    + "Year(Start_date) >= ? and Year(Start_date)<= ? order by Year(Start_date)");
            stmt.setString(1,s);
            stmt.setString(2, e);
            
            b=1;
           
           }
        }
        
        else if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
        {
            stmt = con.prepareStatement("select * from Conferences where TID=(select TID from Teacher where Name = ?) order by Year(Start_date)");
            stmt.setString(1,tname);
            
            l=1;
            
        }
        
        else
        {

            stmt = con.prepareStatement("select * from Conferences where TID=(select TID from Teacher where Name = ?) and"
                    + " Year(Start_date) >= ? and Year(Start_date)<= ? order by Year(Start_date)");
            stmt.setString(1,tname);
            stmt.setString(2,s);
            stmt.setString(3, e);
            
            l=1;
            b=1;
        }
        rs8 = stmt.executeQuery();
        n=1;
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style type="text/css">
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
                    <hr style="height:3px;border:none;color:#333;background-color:#333;" />
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
                    </table> <br> 
                        <form method="post" action=publications_info.jsp?tid=<%=tid%>>    
                        <label>Select Teacher :</label>
                        <select name="tname"> 
                            <option> All</option>
                    <%while(rs.next()){   %> 

                    <option> <%=rs.getString(1)%></option>
                    <% } %>
                    </select>
                    <br>
                    <label>Select Start Year :</label>
                    <select name="styear">    
                        <option>All</option>
                    <%stmt = con.prepareStatement("select distinct Year(Start_date) from  Conferences");
                        rs4 = stmt.executeQuery(); while(rs4.next()){   %> 

                    <option> <%=rs4.getString(1)%></option>
                    <% }
                    stmt = con.prepareStatement("select distinct Year(Start_date) from Conferences order by Year(Start_date) desc");
                    rs4 = stmt.executeQuery();   
                    %>
                        </select>
                    <label>Select End Year :</label>
                    <select name="enyear">    
                        <option>All</option>
                    <% while(rs4.next()){   %> 

                    <option> <%=rs4.getString(1)%></option>
                    <% }  %>
                        </select><br>



                    <button type="submit" name="b2" id="b2" >Show</button>
                    </form><br>
                    
                    <%      
                     if(n==1){
                     if(rs8.next()) {
                    if(m==1){ 
                %>
                <h3>Total Conferences published </h3> <% } else if(b==1 && l!=1) { %>
                <h3>Conferences published in year(<%=s %> - <%=e %>)</h3> <% }if(l==1) { %>
                <h3>Conferences published in year(<%=s %> - <%=e %>) of <%= tname %></h3> <% } %>
                <table style="width: 90%;">
                <tr>
                    <th>S.no</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>ISBN</th>
                    <th>Publisher</th><% if(l!=1) {%>
                    <th>Teacher Name</th><% } %>
                    <th>Duration</th>
                </tr>
                <% do {
                    
                    stmt = con.prepareStatement("Select Name from Teacher where TID='"+rs8.getString(1)+"'");
                    rs3 = stmt.executeQuery();
                    while(rs3.next()){
                %>
                <tr>
                    <td><%=++no%></td>
                    <td><%= rs8.getString(2) %></td>
                    <td><%= rs8.getString(4) %></td>
                    <td><%= rs8.getString(8) %></td>
                    <td><%= rs8.getString(9) %></td><% if(l!=1) {%>
                    <td><%= rs3.getString(1) %></td><% } %>
                    <td><%= rs8.getString(5) %> to <%= rs8.getString(6) %></td>
                </tr>
                <% } }while(rs8.next());%>
            </table>
                <hr>
                <% }  else { %>
                <h3>No Conference published of <%= tname %>
                    <% if(b==1 | l==1){ %>in year <%= s %> - <%= e%></h3><%} } }%>
                    <hr style="height:3px;border:none;color:#333;background-color:#333;" />
                    <br>
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
                    
                    <br>
                    <form method="post" action=publications_info.jsp?tid=<%=tid%>>    
                        <label>Select Teacher :</label>
                        <select name="teacher"> 
                            <option> All</option>
                    <%stmt = con.prepareStatement("select Name from Teacher order by Name ");
                        rs = stmt.executeQuery();
                        while(rs.next()){   %> 

                    <option> <%=rs.getString(1)%></option>
                    <% } %>
                    </select>
                    <br>
                    <label>Select Start Year :</label>
                    <select name="syear">    
                        <option>All</option>
                    <%stmt = con.prepareStatement("select distinct Year from  Journals");
                        rs4 = stmt.executeQuery(); while(rs4.next()){   %> 

                    <option> <%=rs4.getString(1)%></option>
                    <% }
                    stmt = con.prepareStatement("select distinct Year from Journals order by Year desc");
                    rs4 = stmt.executeQuery();   
                    %>
                        </select>
                    <label>Select End Year :</label>
                    <select name="eyear">    
                        <option>All</option>
                    <% while(rs4.next()){   %> 

                    <option> <%=rs4.getString(1)%></option>
                    <% }  %>
                        </select><br>



                    <button type="submit" name="b1" id="b1" >Show</button>
                    </form><br>
                <%      
                     if(p==1){
                     if(rs8.next()) {
                    if(m==1){ 
                %>
                <h3>Total Journals published </h3> <% } else if(b==1 && l!=1) { %>
                <h3>Journals published in year(<%=s %> - <%=e %>)</h3> <% }if(l==1) { %>
                <h3>Journals published in year(<%=s %> - <%=e %>) of <%= tname %></h3> <% } %>
                <table style="width: 90%;">
                <tr>
                    <th>S.no</th>
                    <th>Title</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>ISBN</th>
                    <th>Publisher</th><% if(l!=1) {%>
                    <th>Teacher Name</th><% } %>
                    <th>Year</th>
                </tr>
                <% do {
                    
                    stmt = con.prepareStatement("Select Name from Teacher where TID='"+rs8.getString(1)+"'");
                    rs3 = stmt.executeQuery();
                    while(rs3.next()){
                %>
                <tr>
                    <td><%=++no%></td>
                    <td><%= rs8.getString(2) %></td>
                    <td><%= rs8.getString(3) %></td>
                    <td><%= rs8.getString(4) %></td>
                    <td><%= rs8.getString(6) %></td>
                    <td><%= rs8.getString(7) %></td><% if(l!=1) {%>
                    <td><%= rs3.getString(1) %></td><% } %>
                    <td><%= rs8.getString(10) %></td>
                </tr>
                <% } }while(rs8.next());%>
            </table>
            <hr>
            <% }  else { %>
            <h3>No Journals published of <%= tname %>
                <% if(b==1 | l==1){ %>in year <%= s %> - <%= e%></h3><%} } }%>
                    
                    
                    <hr style="height:3px;border:none;color:#333;background-color:#333;" />
                    
                    
                    <h3>Total number of books published</h3> 
                    <%
                        stmt = con.prepareStatement("Select * from Books where ISBN in (select distinct ISBN from Books)"
                                + "group by ISBN");
                        rs4 = stmt.executeQuery();
                        no=0;
                    %>
                    <table>
                    <tr>
                        <th>S.no</th>
                        <th>Title</th>
                        <th>ISBN</th>
                        <th>Publisher</th>
                        <th>Teacher Name</th>
                        <th>Year</th>
                    </tr>
                    <%if(rs4.next()){ do{
                        
                    stmt = con.prepareStatement("select Name from Teacher where TID = '"+rs4.getString(1)+"'");
                    rs = stmt.executeQuery();
                    while(rs.next()){
                        %>
                    <tr>
                        <td><%=++no%></td>
                        <td><%=rs4.getString(2)%></td>
                        <td><%=rs4.getString(5)%></td>
                        <td><%=rs4.getString(6)%></td>
                        <td><%=rs.getString(1)%></td> <% } %>
                        <td><%=rs4.getString(4)%></td>
                    </tr>
                    <% }while(rs4.next());} %>
                    </table>
                    <hr>
                    
        </div>
    </body>
    
</html>




                         