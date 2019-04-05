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
    String tname="",start="",end="";
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    
    
    stmt = con.prepareStatement("select distinct YearStart from ExpertLecture order by YearStart");
    rs4 = stmt.executeQuery();
    stmt = con.prepareStatement("select distinct YearStart from ExpertLecture order by YearStart");
    rs5= stmt.executeQuery();
    
    
    if(request.getParameter("b1")!=null)
    {
        String s = request.getParameter("sfdp");
        String e = request.getParameter("efdp");
        if(s.equalsIgnoreCase("All"))
        {
            stmt = con.prepareStatement("select * from ExpertLecture order by YearStart");
            rs2 = stmt.executeQuery();
            m=1;
            
        }
        
        else
        {
            syear = Integer.parseInt(request.getParameter("sfdp"));
            eyear = Integer.parseInt(request.getParameter("efdp"));

            stmt = con.prepareStatement("select * from ExpertLecture where "
                    + "YearStart >= ? and YearStart<= ? order by YearStart");
            stmt.setInt(1,syear);
            stmt.setInt(2, eyear);
            rs2 = stmt.executeQuery();
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
            
            
                <h3>Faculty Development Program/ STTPs Participation</h3>
                <form method="post" action=fdp_train_info.jsp?tid=<%=tid%>>
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
                <h3>Total participation in  FDPs and STTPs</h3> <% } else { %>
                <h3>Participation in FDP in year(<%=syear %> - <%=eyear %>)</h3> <% } %>
                <table>
                <tr>
                    <th>S.no</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Duration</th>
                    <th>Resource Persons</th>
                </tr>
                <% while(rs2.next()) {
                    
                    stmt = con.prepareStatement("Select Name from Teacher where TID='"+rs2.getString(1)+"'");
                    rs3 = stmt.executeQuery();
                    while(rs3.next()){
                %>
                <tr>
                    <td><%=++no%></td>
                    <td><%= rs2.getString(3) %></td>
                    <td>Invited lecture - <%= rs2.getString(2) %> at <%= rs2.getString(4) %></td>
                    <td><%= rs2.getString(5) %> to <%=rs2.getString(6) %></td>
                    <td><%= rs3.getString(1) %></td>
                </tr>
                <% } }%>
            </table>
            <hr>
            <% } %>
        </div>
        
    </body>
</html>
