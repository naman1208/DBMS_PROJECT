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
    ResultSet rs,rs2,rs6,rs3=null,rs4=null,rs5=null;
    String msg="";
    int no=0,count=0,p=0,k=0,i=0,m=0,l=0;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="";
    String syear="";
    String eyear="";
    
    int[] a = new int[10];
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    stmt = con.prepareStatement("select Name from Teacher order by Name asc");
    rs = stmt.executeQuery();
    stmt = con.prepareStatement("select distinct YearEnd from MtechThesis order by YearEnd desc");
    rs6 = stmt.executeQuery();
    stmt = con.prepareStatement("select distinct YearEnd from MtechThesis order by YearEnd desc");
    rs2 = stmt.executeQuery();
    
    
    
    
    while(rs2.next())
    {
            a[k++] = rs2.getInt(1);
    }
        
    rs2 = stmt.executeQuery();
    
    
    stmt = con.prepareStatement("select count(distinct EnrollmentNo) from MtechThesis group by YearEnd desc");
    rs4 = stmt.executeQuery();
    

    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        syear = request.getParameter("syear");
        eyear = request.getParameter("eyear");
        
        if(tname.equalsIgnoreCase("All"))
        {
            stmt=con.prepareStatement("select * from MtechThesis where "
                + "YearEnd >= ? and YearEnd <= ? order by YearEnd desc");
            stmt.setString(1, syear);
            stmt.setString(2, eyear);
            l=1;
        }
        else if(syear.equalsIgnoreCase("All") && eyear.equalsIgnoreCase("All"))
        {
            stmt=con.prepareStatement("select * from MtechThesis where "
                    + "TID=(select TID from Teacher where Name = ?) "
                    + "order by YearEnd desc");
            stmt.setString(1, tname);
            m=1;
        }
        else{
        stmt=con.prepareStatement("select * from MtechThesis where TID=(select TID from Teacher where Name = ?) and "
                + "YearEnd>=? and YearEnd<=? order by YearEnd desc");
        stmt.setString(1, tname);
        stmt.setString(2, syear);
        stmt.setString(3, eyear);
        m=1;
        l=2;}
        rs3 = stmt.executeQuery();
        p=1;
        
        
        while(rs3.next()){
            count++;}
        
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
        <h3> Total number of M.Tech year-wise</h3>
            <table style="width: 50%;"> 
                    <caption>Sorted by End Year</caption>
                    <tr>
                        <th>Year</th>
                        <th>No of M.Tech Completed</th> 
                        
                    </tr>
                    <% while(rs4.next()){ %>
                    
                    <tr>
                        <td><%= a[i++] %></td> 
                        <td><%= rs4.getInt(1) %></td>
                    </tr>
                    
                    <% }%>       
            </table>
            
            <hr style="height:3px;border:none;color:#333;background-color:#333;" />
            <br>    
        <form method="post" action=mtech_info.jsp?tid=<%=tid%>>    
            <label>Select Teacher :</label>
            <select name="teacher">
                <option >All</option>
        <% while(rs.next()){   %> 
        
        <option > <%=rs.getString(1)%></option>
        <% } %>
        </select>
        <br>
        <label>Select Start Year :</label>
        <select name="syear">
            <option >All</option>
        <% while(rs2.next()){   %> 
        
        <option > <%= rs2.getString(1)%></option>
        <% } %>
            </select>
        <label>Select End Year :</label>
        <select name="eyear">
            <option >All</option>
        <% while(rs6.next()){   %> 
        
        <option > <%= rs6.getString(1)%></option>
        <% } %>
            </select>    <br>
            
        
        <button type="submit" name="b1" id="b1" >Show</button>
        </form><br>
        
        <% if(p==1) { %>
        <h2>MTech Thesis Supervised</h2>
            <% if (rs3.next() == false) { %>
            <h5>No M.Tech Entries for <%= tname %> completed in year <%= syear %> to <%= eyear %></h5> <%} 
        else { if(m==1 && l!=2) {%>
        <h4>by <%= tname %> completed till now</h4> <% } else if(l==1 || l==2) { %>
            <h4>by <%= tname %> completed in year <%= syear%> to <%= eyear %></h4><% } %>
            <h3>Count = <%=count%> </h3><br> 
            <table style="width: 98%;"> 
                <caption>Sorted by End Year</caption>
            <tr>
                <th>S.No.</th>
                <th>Registration no.</th> 
                <th>Name</th>
                <th>Title</th><% if(m!=1) {%>
                <th>Teacher name</th><% } %>
                <th>Start Year</th>
            </tr>
            <% do{ no++; %>

            <tr>
                <td><%= no %></td>
                <td><%= rs3.getString(2) %></td> 
                <td><%= rs3.getString(3) %></td>
                <td><%= rs3.getString(4) %></td><% if(m!=1)  {
                stmt = con.prepareStatement("select Name from Teacher where TID='"+rs3.getString(1)+"'");
                rs6=stmt.executeQuery();
                while(rs6.next()){
                %>
                <td><%= rs6.getString(1) %></td><% }} %>
                <td><%= rs3.getInt(5) %></td>
            </tr>

            <% }while(rs3.next()); }%>       
            </table> 
            <% }  %>
            <hr style="height:3px;border:none;color:#333;background-color:#333;" />
            
            <table>
                <h3>MTech Thesis Supervised</h3>
                <tr>
                    <th>S.no </th>
                    <th>Student Name</th>
                    <th>Thesis Title</th>
                    <th>Supervisors</th>
                    <th>Completion Year</th>
                    
                </tr>   
            <% 
                stmt = con.prepareStatement("select distinct EnrollmentNo,Title,Name,YearEnd from MtechThesis order by YearEnd");
                rs4 = stmt.executeQuery();
                no=0;
                while(rs4.next()) {
            %>
            <tr>
                <td><%=++no%></td>
                <td><%=rs4.getString(3)%></td>
                <td><%=rs4.getString(2)%></td>
                <% stmt = con.prepareStatement("select Teacher.Name from Teacher inner join MtechThesis on MtechThesis.TID=Teacher.TID "
                        + "where EnrollmentNo='"+
                        rs4.getString(1)+"' and Title='"+ rs4.getString(2)+"'");
                   rs5 = stmt.executeQuery();
                   String name = "";
                   while(rs5.next()) {
                       
                        name += rs5.getString(1);
                        name += ",";
                    } name=name.substring(0, name.length() - 1);%>
                    <td><%= name %></td>
                    <td><%=rs4.getString(4)%></td>
            </tr>
            <% } %>
            </table>
            
        </div>
    </body>
</html>
