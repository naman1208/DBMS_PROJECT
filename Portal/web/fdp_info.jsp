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
    ResultSet rs,rs2=null,rs3=null,rs4,rs5=null;
    String msg="";
    int no=0,count=0,p=0,m=0,b=0,l=0,flag=0,all=0,i=0,syear=0,eyear=0,n;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="",s="",e="",start="",end="";
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    
    stmt = con.prepareStatement("select distinct name from Teacher order by name");
    rs = stmt.executeQuery();
    
    stmt = con.prepareStatement("select distinct year(Start) from WorkshopSeminarOrganised order by year(Start)");
    rs4 = stmt.executeQuery();
    stmt = con.prepareStatement("select distinct year(Start) from WorkshopSeminarOrganised order by year(Start)");
    rs5= stmt.executeQuery();
    
    
    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        
        s = request.getParameter("sfdp");
        e = request.getParameter("efdp");
        
        
        if(tname.equalsIgnoreCase("All"))
        {
           if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
            {
                stmt = con.prepareStatement("select * from WorkshopSeminarOrganised order by Start");
                rs2 = stmt.executeQuery();
                m=1;

            }
           else{
            stmt = con.prepareStatement("select * from WorkshopSeminarOrganised where "
                    + "year(Start) >= ? and year(Start)<= ? order by Start");
            stmt.setString(1,s);
            stmt.setString(2, e);
            rs2 = stmt.executeQuery();
            b=1;
           
           }
        }
        
        else if(s.equalsIgnoreCase("All")&& e.equalsIgnoreCase("All"))
        {
            stmt = con.prepareStatement("select * from WorkshopSeminarOrganised where TID=(select TID from Teacher where Name = ?) order by Start");
            stmt.setString(1,tname);
            rs2 = stmt.executeQuery();
            l=1;
            
        }
        
        else
        {

            stmt = con.prepareStatement("select * from WorkshopSeminarOrganised where TID=(select TID from Teacher where Name = ?) and"
                    + " year(Start) >= ? and year(Start)<= ? order by Start");
            stmt.setString(1,tname);
            stmt.setString(2,s);
            stmt.setString(3, e);
            rs2 = stmt.executeQuery();
            l=1;
            b=1;
        }
        p=1;
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
            table, th, td ,tr {
                    border: 1px solid black;
                    padding: 15px;
                    text-align: center;
                    
                }
                
                table {
                    width:80%;
                    background-color: #f1f1c1;
                    border-spacing: 5px;
                    overflow: auto;
                }
        </style>
        
    </head>
    <body>
        <jsp:include page="admin.jsp" />
        <div class="main">
            
            
                <h3>Faculty Development Program/ STTPs Organized</h3>
                <form method="post" action=fdp_info.jsp?tid=<%=tid%>>
                    <label>Select Teacher :</label>
                        <select name="teacher">
                            <option >All</option>
                    <% while(rs.next()){   %> 

                    <option > <%=rs.getString(1)%></option>
                    <% } %>
                        </select><br>
                    <label>Start Year: </label>
                <select name="sfdp">
                    
                    <option>All</option>
                    <%
                        while(rs4.next())
                        {
                    %>
                    <option><%= rs4.getString(1) %></option>
                    <% } %>
                </select> <%  n=8;
                while(n--!=0) { %>
                &nbsp; <% } %>
                <label>End Year: </label>
                <select name="efdp">
                    
                    <option>All</option>
                    <%
                        while(rs5.next())
                        {
                    %>
                    <option><%= rs5.getString(1) %></option>
                    <% } %>
                </select><br>
                <button type="submit" name="b1">Submit</button>
                </form>
                <hr>
                
                
                <% if(p==1){
                    if(m==1){ 
                %>
                <h3>Total FDPs and STTPs</h3> <% } else if(b==1) { %>
                <h3>FDP in year(<%=s %> - <%=e %>)</h3><% }if(l==1) { %>
                <h3>by <%= tname %></h3> <% } %>
                <table>
                <tr>
                    <th>S.no</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Duration</th><% if(l!=1) {%>
                    <th>Resource Persons</th><% } %>
                </tr>
                <% while(rs2.next()) {
                    start = rs2.getDate(4).toLocaleString();
                    start = start.substring(0, start.length()-11);
                    end = rs2.getDate(5).toLocaleString();
                    end = end.substring(0, end.length()-11);
                    stmt = con.prepareStatement("Select Name from Teacher where TID='"+rs2.getString(1)+"'");
                    rs3 = stmt.executeQuery();
                    while(rs3.next()){
                %>
                <tr>
                    <td><%=++no%></td>
                    <td><%= rs2.getString(3) %></td>
                    <td><%= rs2.getString(8) %></td>
                    <td><%=start%> to <%=end%></td><% if(l!=1) {%>
                    <td><%= rs3.getString(1) %></td><% }%>
                </tr>
                <% } }%>
            </table>
            <hr>
            <% } %>
        </div>
        
    </body>
</html>
