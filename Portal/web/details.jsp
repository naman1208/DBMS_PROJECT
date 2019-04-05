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
    int no=0,count=0,p=0,m=0,b=0,l=0,flag=0,all=0,i=0;
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
    
    stmt = con.prepareStatement("select count(*) from Teacher");
    rs2 = stmt.executeQuery();
 
    while(rs2.next())
    {
        count = rs2.getInt(1);
        
    }
    String [][] s = new String[22][2];

    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        
        if(tname.equalsIgnoreCase("All"))
        {
            all=1;
            stmt=con.prepareStatement("select * from Education ");
            
            rs3 = stmt.executeQuery();
            

            while(rs3.next()){
                if(!(rs3.getString(6).equalsIgnoreCase("")))
                {
                    p=1;
                    s[i][0] = rs3.getString(1);
                    s[i][1] =  "Ph.D -: " +rs3.getString(6);
                }
                else if(!(rs3.getString(4).equalsIgnoreCase("")))
                {
                    m=1;
                    s[i][0] = rs3.getString(1);
                    s[i][1] =  "PostGraduate -: "+rs3.getString(4);
                }
                else if(!(rs3.getString(2).equalsIgnoreCase("")))
                {
                    b=1;
                    s[i][0] = rs3.getString(1);
                    s[i][1] =  "UnderGraduate -: "+rs3.getString(2);
                }
                else
                {
                    s[i][0] = rs3.getString(1);
                    s[i][1] =  "--------";
                }
                i++;
                count++;
            }
        }
        
        
        else
        {
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
                else if(!(rs3.getString(2).equalsIgnoreCase("")))
                {
                    b=1;
                }
                
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
            
            <h2>Total number of of Regular Faculty in the Department:  <%=count %>   <h2>
            
        <h3>Highest Qualification</h3>    
        <form method="post" action=details.jsp?tid=<%=tid%>>    
            <label>Select Teacher :</label>
            <select name="teacher">
                
        <% 
            while(rs.next()){
                if(flag==0)
                {
        %> 
        <option>All</option>
        <option><%=rs.getString(1)%></option>
        <% flag=1; } else { %>   
        <option ><%=rs.getString(1)%></option>
        <%}  }%>
        </select><br>
        
        <button type="submit" name="b1" id="b1" >Show</button>
        </form><br>
        
        <% if(all==1) { i=0; %>
        <h3>Highest Qualification of all the faculties</h3>
        
        <table>
            <tr>
                <th>TID</th>
                <th>Highest Qual.</th>
            </tr>
            <% while(i!=count)
            {  stmt = con.prepareStatement("Select Name from Teacher where TID='"+s[i][0]+"'");
               rs3 = stmt.executeQuery();
               while(rs3.next()){
            
            %>
            <tr>
                <td><%=rs3.getString(1) %></td>
                <td><%=s[i][1]%></td>
            </tr>
        
        <% } i++;}
        } %>
        </table>
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
            else if(b==1){%>
            <h4>UnderGraduate - <%=rs3.getString(2)%><% if(rs3.getInt(1)!=0){%> in year <%=rs3.getInt(1)%><%}%></h4>
            <% }
            else {%>
                <h4>Not Filled Yet</h4>
            <% }
            
        }
        } %>
        </div>
        <hr>
    </body>
</html>
